(require 'asdf)
(asdf:load-system 'cl-ppcre)

(defpackage strjis-code (:use cl cl-ppcre))
(in-package strjis-code)

(declaim (optimize safety))
(defconstant +file0201+ #p"JIS0201.TXT")
(defconstant +file0208+ #p"JIS0208.TXT")
(defconstant +file0212+ #p"JIS0212.TXT")
(defconstant +file2022+ #p"iso-2022-jp-2004-std.txt")
(defconstant +width+ #p"EastAsianWidth.txt")
(defconstant +code-header+ #p"code-header.lisp")
(defconstant +code-zenkaku+ #p"code-zenkaku.lisp")
(defconstant +code-footer+ #p"code-footer.lisp")
(defconstant +output+ #p"table.lisp")
(load +code-zenkaku+)

;;
;;  On Lisp
;;
(defun single (lst)
  (and (consp lst) (not (cdr lst))))

(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))

(defun filter (fn lst)
  (let ((acc nil))
    (dolist (x lst)
      (let ((val (funcall fn x)))
        (if val (push val acc))))
    (nreverse acc)))

(defun group (source n)
  (if (zerop n) (error "zero length"))
  (labels ((rec (source acc)
                (let ((rest (nthcdr n source)))
                  (if (consp rest)
                    (rec rest (cons (subseq source 0 n) acc))
                    (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))

(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))


;;
;;  make
;;
(defmacro pattern (name str)
  `(defparameter ,name (create-scanner ,str)))

(defun scan-strings (match str &key error)
  (multiple-value-bind (result group) (scan-to-strings match str)
    (if result
      (coerce group 'list)
      (when error
        (error "scan-strings error: ~A" str)))))

(defmacro deftable (name &key (test 'eql))
  `(defparameter ,name (make-hash-table :test ',test)))

(defun read-list-stream (stream)
  (do ((str (read-line stream nil nil)
            (read-line stream nil nil))
       list)
    ((null str)
     (nreverse list))
    (push str list)))

(defun read-list-pathname (name)
  (with-open-file (input name)
    (read-list-stream input)))

(defun read-list (stream)
  (etypecase stream
    (stream (read-list-stream stream))
    (pathname (read-list-pathname stream))
    (string (read-list-pathname (pathname stream)))))

(pattern space-comment "^\s*(:?#.*)?$")
(defun read-unicode (stream)
  (filter
    (lambda (str)
      (unless (scan-to-strings space-comment str)
        str))
    (read-list stream)))

(defmacro mapfn (args expr &body body)
  `(mapcar
     (lambda ,args ,@body)
     ,expr))

(defmacro dobind (bind expr &body body)
  (let ((g (gensym)))
    `(dolist (,g ,expr)
       (destructuring-bind ,bind ,g
         ,@body))))

(defmacro mapbind (bind expr &body body)
  (let ((g (gensym)))
    `(mapcar
       (lambda (,g)
         (destructuring-bind ,bind ,g
           ,@body))
       ,expr)))

(defun read-match (stream match)
  (mapfn (x) (read-unicode stream)
    (or (scan-strings match x)
        (error "Illegal string: ~S." x))))

(defvar *parse-radix* 16)
(defun parseint (x &key null)
  (when (or x (null null))
    (parse-integer x :radix *parse-radix*)))

(defun read-match-integer (stream match)
  (mapfn (x) (read-match stream match)
    (mapfn (y) x
      (parseint y))))


;;
;;  JIS0201
;;
(deftable *ascii*)  ;; 0x20 - 0x7E
(deftable *kana*)   ;; 0x21 - 0x5F

(defun setf-table (table x y)
  (when (gethash x table)
    (error "Character ~S already exists in the ~S." x table))
  (setf (gethash x table) y))

(pattern match0201 "^0x(\\w+)\\s+0x(\\w+)\\s+#?.*$")
(defun read-0201 (&optional (file +file0201+))
  (dobind (x y) (read-match-integer file match0201)
    (if (< x #x80)
      (setf-table *ascii* x y)
      (setf-table *kana* (- x #x80) y))))


;;
;;  JIS0208
;;
(deftable *jis1*)

(pattern match0208 "^0x\\w+\\s+0x(\\w+)\\s+0x(\\w+)\\s+#?.*$")
(defun read-0208 (&optional (file +file0208+))
  (dobind (x y) (read-match-integer file match0208)
    (setf-table *jis1* x y)))


;;
;;  JIS0212
;;
(deftable *jis2*)

(defun read-0212 (&optional (file +file0212+))
  (dobind (x y) (read-match-integer file match0201)
    (setf-table *jis2* x y)))


;;
;;  iso-2022-jp-2004
;;
(deftable *iso0*)
(deftable *iso3*)
(deftable *iso4*)
(deftable *iso3-twice*)

;; 0-20	U+0020	# SPACE
;; 3-2477	U+304B+309A	# 	[2000]
(pattern match2022 "^(\\w)-(\\w+)(?:\\s+U\\+(\\w+)(?:\\+(\\w+))?)?\\s*#?.*$")
(defun read-match-iso (stream &key (match match2022))
  (mapbind (a b c d) (read-match stream match)
    (list (parseint a)
          (parseint b)
          (parseint c :null t)
          (parseint d :null t))))

(defun read-2022-0 (c u p table)
  (when p
    (error "Invalid value: 0, ~S, ~S, ~S." c u p))
  (setf-table table c u))

(defun read-2022-3 (c u p)
  (if p
    (progn
      (setf-table *iso3-twice* c (cons u p))
      (setf-table *iso3* c t))
    (setf-table *iso3* c u)))

(defun read-2022 (&optional (file +file2022+))
  (dobind (a b c d) (read-match-iso file)
    (when c
      (case a
        (0 (read-2022-0 b c d *iso0*))
        (3 (read-2022-3 b c d))
        (4 (read-2022-0 b c d *iso4*))
        (otherwise
          (error "Invalid type ~S." a))))))


;;
;;  EastAsianWidth
;;
(defvar *width-table*)
(defvar *width-symbol*)

(pattern width-single "^([0-9A-F]+);(\\S+)\\s.*$")
(pattern width-range  "^([0-9A-F]+)\\.\\.([0-9A-F]+);(\\S+)\\s.*$")
(defun read-width-table (&aux list)
  (labels ((p (x y) (parseint (elt x y)))
           (k (x y) (intern (string-upcase (elt x y)))))
    (dolist (x (read-list +width+))
      (aif (scan-strings width-single x)
        (push (list (p it 0) (p it 0) (k it 1)) list))
      (aif (scan-strings width-range x)
        (push (list (p it 0) (p it 1) (k it 2)) list)))
    (sort list #'< :key #'car)))

(defun read-width ()
  (setq *width-table* (read-width-table))
  (setq *width-symbol* '((n . 1) (a . 2) (h . 1) (w . 2) (f . 2) (na . 1))))


;;
;;  output
;;
(defun write-redirect (file)
  (dolist (x (read-list file))
    (format t "~A~%" x)))

(defun char-table (table &aux list)
  (maphash
    (lambda (key value)
      (push (cons key value) list))
    table)
  (sort list #'< :key #'car))

(defun join-list (str list)
  (when list
    (destructuring-bind (car . cdr) list
      (if cdr
        (list* (mkstr car) str
               (when cdr
                 (join-list str cdr)))
        (list (mkstr car))))))

(defun join (str list)
  (declare (type string str))
  (apply #'concatenate 'string (join-list str list)))

(defun table-line (list)
  (join " " (mapbind (a . b) list
              (cond ((eql t b)
                     (format nil "(#x~4,'0X .      t)" a))
                    ((integerp b)
                     (format nil "(#x~4,'0X . #x~4,'0X)" a b))
                    (t (error "list error: ~S" b))))))

(defun write-table (table &optional (count 4))
  (let ((keys (char-table table)))
    (join (format nil "~%    ")
          (mapfn (list) (group keys count)
            (table-line list)))))

(defun write-defparameter (table name)
  (let ((table (write-table table)))
    (format t "(defparameter *input-~A*~%  '(~A))~2%" name table)))

(defun write-0201 ()
  (write-defparameter *ascii* "ascii")
  (write-defparameter *kana* "kana"))

(defun write-0208 ()
  (write-defparameter *jis1* "jis1"))

(defun write-0212 ()
  (write-defparameter *jis2* "jis2"))

(defun write-2022-3 ()
  (write-defparameter *iso3* "iso3"))

(defun write-2022-4 ()
  (write-defparameter *iso4* "iso4"))

(defun twice-line ()
  (mapbind (a . (b . c)) (char-table *iso3-twice*)
    (format nil "(#x~4,'0X #x~4,'0X #x~4,'0X)" a b c)))

(defun write-2022-t ()
  (format t "(defparameter *input-twice*~%  '(~A))~2%"
          (join (format nil "~%    ") (twice-line))))

(defun write-width-line (list)
  (join " " (mapbind (x y z) list
              (format nil "(#x~5,'0X #x~5,'0X ~(~2@S~))" x y z))))

(defun write-width-join ()
  (join (format nil "~%    ")
        (mapfn (x) (group *width-table* 3)
          (write-width-line x))))

(defun write-width ()
  (format t "(defparameter *east-asian-width*~%  #(~A))~2%" (write-width-join)))

(defun write-width-symbol ()
  (format t "(defparameter *east-asian-symbol*~%  ~('~S~))~2%" *width-symbol*))

(defun write-size-constant (name size)
  (format t "(defconstant +~(size-~A~)+ ~A)~%" name size))

(defun write-size-name (table name)
  (write-size-constant name (hash-table-count table)))

(defun write-size-list (list name)
  (write-size-constant name (length list)))

(defun write-size ()
  (write-size-name *ascii* "ascii")
  (write-size-name *kana* "kana")
  (write-size-name *jis1* "jis1")
  (write-size-name *jis2* "jis2")
  (write-size-name *iso3* "iso3")
  (write-size-name *iso4* "iso4")
  (write-size-list *input-zenkaku* "zenkaku")
  (write-size-name *iso3-twice* "twice")
  (terpri))


;;
;;  main
;;
(defun read-text ()
  (read-0201)
  (read-0208)
  (read-0212)
  (read-2022)
  (read-width))

(defun write-code ()
  (with-open-file (*standard-output*
                    +output+ :direction :output
                    :if-exists :supersede
                    :if-does-not-exist :create)
    (write-redirect +code-header+)
    (write-0201)
    (write-0208)
    (write-0212)
    (write-2022-3)
    (write-2022-4)
    (write-2022-t)
    (write-redirect +code-zenkaku+)
    (write-width)
    (write-width-symbol)
    (write-size)
    (write-redirect +code-footer+)))

(defun main ()
  (read-text)
  (write-code))
(main)

