(in-package #:strjis)

;;
;;  utils
;;
(defmacro return2 (x y)
  `(return (values ,x ,y)))

(defun highlow (a b)
  (declare (type (integer #x00 #xFF) a b))
  (logior (ash a 8) b))

(defun highlow4 (a b c d)
  (declare (type (integer #x00 #xFF) a b c d))
  (logior (ash a 24) (ash b 16) (ash c 8) d))

(defun split2-byte (v)
  (values
    (logand (ash v -8) #xFF)
    (logand v #xFF)))

(defun split4-byte (v)
  (values
    (logand (ash v -24) #xFF)
    (logand (ash v -16) #xFF)
    (logand (ash v -8) #xFF)
    (logand v #xFF)))

(defmacro pushdolist (list place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g))
          (x (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (dolist (,x ,list)
             (push ,x ,v))
           ,w ,v)))))


;;
;;  On Lisp
;;
(defmacro aif2 (test &optional then else)
  (let ((win (gensym)))
    `(multiple-value-bind (it ,win) ,test
       (if (or it ,win) ,then ,else))))

(defmacro acond2 (&rest clauses)
  (if (null clauses)
    nil
    (let ((cl1 (car clauses))
          (val (gensym))
          (win (gensym)))
      `(multiple-value-bind (,val ,win) ,(car cl1)
         (if (or ,val ,win)
           (let ((it ,val))
             (declare (ignorable it))
             ,@(cdr cl1))
           (acond2 ,@(cdr clauses)))))))

;;
;;  utils3-echo
;;
(defvar *echo-stream* t)

(defun echocall (call rest &aux ret)
  (fresh-line *echo-stream*)
  (if rest
    (dolist (x rest ret)
      (setq ret x)
      (funcall call x *echo-stream*)
      (fresh-line *echo-stream*))
    (progn
      (terpri *echo-stream*)
      (values))))

(defun echo (&rest rest)
  (echocall #'princ rest))

(defun echoa (&rest rest)
  (echocall #'princ rest))

(defun echos (&rest rest)
  (echocall #'prin1 rest))

(defun mechocall (call body)
  `(values-list
     (,call ,@(mapcar
                (lambda (x) `(multiple-value-list ,x))
                body))))

(defmacro mechoa (&body body)
  (mechocall 'echoa body))

(defmacro mechos (&body body)
  (mechocall 'echos body))

(defun printcall (call rest)
  (fresh-line *echo-stream*)
  (if rest
    (let (ret fst)
      (dolist (x rest)
        (setq ret x)
        (if fst
          (princ " " *echo-stream*)
          (setq fst t))
        (funcall call x *echo-stream*))
      (fresh-line *echo-stream*)
      ret)
    (progn
      (terpri *echo-stream*)
      (values))))

(defun printa (&rest rest)
  (printcall #'princ rest))

(defun prints (&rest rest)
  (printcall #'prin1 rest))

(defmacro mprinta (&body body)
  (mechocall 'printa body))

(defmacro mprints (&body body)
  (mechocall 'prints body))

