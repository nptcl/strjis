;;
;;  iso-2022-jp-2004 encode
;;
(in-package #:strjis)

;;
;;  list jis
;;
(defclass charout-iso2022jp (charout-sub-disable charout-jis)
  ((mode :initform nil)))

;; 1B 28 49           (I   21-5f         kana  Kana
(defun charout-kana-zenkaku (inst c)
  (aif2 (gethash c *forward-zenkaku*)
    (charout-jis1 inst it)
    (charout-error inst it)))

(defmethod charout-kana ((inst charout-iso2022jp) c)
  (let ((type *kana-iso2022jp*))
    (cond ((eq type 'error)
           (charout-error inst c))
          ((eq type 'zenkaku)
           (charout-kana-zenkaku inst c))
          ((eq type 'force)
           (charout-jis-mode inst 'kana '(#x1B #x28 #x49))
           (pushchar c inst))
          ((eq type 'reject)) ;; reject
          (t (error "Invalid *kana-iso2022jp* value ~S." type)))))

;; 1B 24 28 51        $B   21-7e  21-7e  jis1  JIS2004-1
(defmethod charout-jis1 ((inst charout-iso2022jp) c)
  (charout-jis-mode inst 'jis1 '(#x1B #x24 #x28 #x51))
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar a inst)
    (pushchar b inst)))

;; 1B 24 28 50        $B   21-7e  21-7e  jis2  JIS2000-2
(defmethod charout-jis2 ((inst charout-iso2022jp) c)
  (charout-jis-mode inst 'jis2 '(#x1B #x24 #x28 #x50))
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar a inst)
    (pushchar b inst)))

(defmethod charout-error ((inst charout-iso2022jp) c)
  (if *recovery*
    (progn
      (pusherror *recovery-jis* inst)
      (setf (slot-value inst 'mode) nil))
    (error "Invalid iso-2022-jp value ~x." c)))


;;
;;  list iso2022jp
;;
(defclass list-iso2022jpj (list-pushchar charout-list charout-iso2022jp) ())
(defclass list-iso2022jpu (charout-unijis list-iso2022jpj) ())

(defun list-iso2022jp (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'list-iso2022jpu 'list-iso2022jpj))))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector iso2022jp
;;
(defclass vector-iso2022jpj (vector-pushchar charout-vector1 charout-iso2022jp) ())
(defclass vector-iso2022jpu (charout-unijis vector-iso2022jpj) ())

(defun vector-iso2022jp (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'vector-iso2022jpu 'vector-iso2022jpj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string iso2022jp
;;
(defclass string-iso2022jpj (charout-string vector-iso2022jpj) ())
(defclass string-iso2022jpu (charout-unijis string-iso2022jpj) ())

(defun string-iso2022jp (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'string-iso2022jpu 'string-iso2022jpj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream iso2022jp
;;
(defclass stream-iso2022jpj (lambda-pushchar charout-stream charout-iso2022jp) ())
(defclass stream-iso2022jpu (charout-unijis stream-iso2022jpj) ())

(defun make-stream-iso2022jp (unicode)
  (make-charout-stream
    (if unicode 'stream-iso2022jpu 'stream-iso2022jpj)))

(defun stream-iso2022jp (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-stream-iso2022jp unicode)))
    (funcall call input output)
    (charout-result output)))

