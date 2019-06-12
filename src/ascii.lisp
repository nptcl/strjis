;;
;;  ascii encode
;;
(in-package #:strjis)

;;
;;  charout-ascii
;;
(defclass charout-ascii (charout) ())

(defmethod charout-ascii ((inst charout-ascii) c)
  (pushchar c inst))

(defmethod charout-kana ((inst charout-ascii) c)
  (charout-error inst c))

(defmethod charout-jis1 ((inst charout-ascii) c)
  (charout-error inst c))

(defmethod charout-jis2 ((inst charout-ascii) c)
  (charout-error inst c))

(defmethod charout-sub ((inst charout-ascii) c)
  (charout-error inst c))

(defmethod charout-unicode ((inst charout-ascii) c)
  (aif2 (gethash c *reverse-ascii*)
    (charout-ascii inst it)
    (charout-error inst c)))

(defmethod charout-control ((inst charout-ascii) c)
  (cond ((eq c 'bom) nil)
        ((eq c 'eol2) (pushchar0d0a inst))
        ((eql c #x0A) (pushchar0a inst))
        ((eql c #x0D) (pushchar0d inst))
        ((and (integerp c) (or (<= #x00 c #x1F) (= c #x7F)))
         (pushchar c inst))
        (t (charout-error inst c))))

(defmethod charout-error ((inst charout-ascii) c)
  (if *recovery*
    (pusherror *recovery-ascii* inst)
    (error "Invalid ascii ~x." c)))


;;
;;  list ascii
;;
(defclass list-ascii (list-pushchar charout-list charout-ascii) ())

(defun list-ascii (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-ascii)))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector ascii
;;
(defclass vector-ascii (vector-pushchar charout-vector1 charout-ascii) ())

(defun vector-ascii (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-ascii)))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string ascii
;;
(defclass string-ascii (charout-string vector-ascii) ())

(defun string-ascii (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-ascii)))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream ascii
;;
(defclass stream-ascii (lambda-pushchar charout-stream charout-ascii) ())

(defun stream-ascii (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-ascii)))
    (funcall call input output)
    (charout-result output)))

