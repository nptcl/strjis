;;
;;  euc-jis-2004 (euc-jp included) encode
;;
(in-package #:strjis)

;;
;;  list eucjis
;;
(defclass charout-eucjis (charout) ())

(defmethod charout-ascii ((inst charout-eucjis) c)
  (pushchar c inst))

(defmethod charout-kana ((inst charout-eucjis) c)
  (pushchar #x8E inst)
  (pushchar (logior #x80 c) inst))

(defmethod charout-jis1 ((inst charout-eucjis) c)
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar (logior #x80 a) inst)
    (pushchar (logior #x80 b) inst)))

(defmethod charout-jis2 ((inst charout-eucjis) c)
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar #x8F inst)
    (pushchar (logior #x80 a) inst)
    (pushchar (logior #x80 b) inst)))

(defmethod charout-sub ((inst charout-eucjis) c)
  (charout-jis2 inst c))

(defmethod charout-control ((inst charout-eucjis) c)
  (cond ((eq c 'bom) nil)
        ((eq c 'eol2) (pushchar0d0a inst))
        ((eql c #x0A) (pushchar0a inst))
        ((eql c #x0D) (pushchar0d inst))
        ((and (integerp c) (or (<= #x00 c #x1F) (= c #x7F)))
         (pushchar c inst))
        (t (charout-error inst c))))

(defmethod charout-error ((inst charout-eucjis) c)
  (if *recovery*
    (pusherror *recovery-eucjis* inst)
    (error "Invalid euc-jis value ~x." c)))


;;
;;  list eucjis
;;
(defclass list-eucjisj (list-pushchar charout-list charout-eucjis) ())
(defclass list-eucjisu (charout-unijis list-eucjisj) ())

(defun list-eucjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'list-eucjisu 'list-eucjisj))))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector eucjis
;;
(defclass vector-eucjisj (vector-pushchar charout-vector1 charout-eucjis) ())
(defclass vector-eucjisu (charout-unijis vector-eucjisj) ())

(defun vector-eucjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'vector-eucjisu 'vector-eucjisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string eucjis
;;
(defclass string-eucjisj (charout-string vector-eucjisj) ())
(defclass string-eucjisu (charout-unijis string-eucjisj) ())

(defun string-eucjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'string-eucjisu 'string-eucjisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream eucjis
;;
(defclass stream-eucjisj (lambda-pushchar charout-stream charout-eucjis) ())
(defclass stream-eucjisu (charout-unijis stream-eucjisj) ())

(defun make-stream-eucjis (unicode)
  (make-charout-stream
    (if unicode 'stream-eucjisu 'stream-eucjisj)))

(defun stream-eucjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-stream-eucjis unicode)))
    (funcall call input output)
    (charout-result output)))

