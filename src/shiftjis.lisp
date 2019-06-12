;;
;;  shift-jis-2004 encode
;;
(in-package #:strjis)

;;
;;  list shiftjis
;;
(defclass charout-shiftjis (charout) ())

(defmethod charout-ascii ((inst charout-shiftjis) c)
  (pushchar c inst))

(defmethod charout-kana ((inst charout-shiftjis) c)
  (pushchar (logior #x80 c) inst))

(defun shiftjis-jis1 (x)
  (multiple-value-bind (a b) (split2-byte x)
    (if (zerop (mod a 2))
      (setq a (+ (floor a 2) #x70)
            b (+ b #x7D))
      (setq a (+ (floor a 2) #x70 1)
            b (+ b #x1F)))
    (when (<= #xA0 a)
      (incf a #x40))
    (when (<= #x7F b)
      (incf b 1))
    (values a b)))

(defmethod charout-jis1 ((inst charout-shiftjis) c)
  (multiple-value-bind (a b) (shiftjis-jis1 c)
    (pushchar a inst)
    (pushchar b inst)))

(defun shiftjis-jis2-first (a)
  (let ((a (- a #x20)))
    (or (= a 1) (<= 3 a 5) (= a 8) (<= 12 a 15) (<= 78 a 94))))

(defun shiftjis-jis2 (x)
  (multiple-value-bind (a b) (split2-byte x)
    (when (shiftjis-jis2-first a)
      (if (zerop (mod a 2))
        (incf b #x7E)
        (incf b (if (<= b #x5F) #x1F #x20)))
      (decf a #x20)
      (if (< a #x4E)
        (setq a (- (floor (+ a #x01DF) 2) (* (floor a 8) 3)))
        (setq a (floor (+ a #x019B) 2)))
      (values a b))))

(defmethod charout-jis2 ((inst charout-shiftjis) c)
  (multiple-value-bind (a b) (shiftjis-jis2 c)
    (if (null a)
      (charout-error inst c)
      (progn
        (pushchar a inst)
        (pushchar b inst)))))

(defun charout-sub-shiftjis (inst c)
  (acond2 ((gethash c *reverse-iso3*)
           (charout-jis1 inst it) t)
          ((gethash c *reverse-jis1*)
           (charout-jis1 inst it) t)
          ((gethash c *reverse-iso4*)
           (charout-jis2 inst it) t)))

(defmethod charout-sub ((inst charout-shiftjis) c)
  (or (aif2 (gethash c *forward-jis2*)
        (charout-sub-shiftjis inst it))
      (aif2 (gethash c *forward-iso4*)
        (charout-sub-shiftjis inst it))
      (charout-error inst c)))

(defmethod charout-control ((inst charout-shiftjis) c)
  (cond ((eq c 'bom) nil)
        ((eq c 'eol2) (pushchar0d0a inst))
        ((eql c #x0A) (pushchar0a inst))
        ((eql c #x0D) (pushchar0d inst))
        ((and (integerp c) (or (<= #x00 c #x1F) (= c #x7F)))
         (pushchar c inst))
        (t (charout-error inst c))))

(defmethod charout-error ((inst charout-shiftjis) c)
  (if *recovery*
    (pusherror *recovery-shiftjis* inst)
    (error "Invalid shift-jis value ~x." c)))


;;
;;  list shiftjis
;;
(defclass list-shiftjisj (list-pushchar charout-list charout-shiftjis) ())
(defclass list-shiftjisu (charout-unijis list-shiftjisj) ())

(defun list-shiftjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'list-shiftjisu 'list-shiftjisj))))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector shiftjis
;;
(defclass vector-shiftjisj (vector-pushchar charout-vector1 charout-shiftjis) ())
(defclass vector-shiftjisu (charout-unijis vector-shiftjisj) ())

(defun vector-shiftjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'vector-shiftjisu 'vector-shiftjisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string shiftjis
;;
(defclass string-shiftjisj (charout-string vector-shiftjisj) ())
(defclass string-shiftjisu (charout-unijis string-shiftjisj) ())

(defun string-shiftjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'string-shiftjisu 'string-shiftjisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream shiftjis
;;
(defclass stream-shiftjisj (lambda-pushchar charout-stream charout-shiftjis) ())
(defclass stream-shiftjisu (charout-unijis stream-shiftjisj) ())

(defun make-stream-shiftjis (unicode)
  (make-charout-stream
    (if unicode 'stream-shiftjisu 'stream-shiftjisj)))

(defun stream-shiftjis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-stream-shiftjis unicode)))
    (funcall call input output)
    (charout-result output)))

