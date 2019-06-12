;;
;;  jis (include iso-2022-jp-2004) encode
;;
(in-package #:strjis)

;;
;;  list jis
;;
(defclass charout-jis (charout)
  ((mode :initform nil)))

(defun charout-jis-mode (inst check list)
  (with-slots (mode) inst
    (unless (eq mode check)
      (pushlist list inst)
      (setq mode check))))

;; 1B 28 42           (B   20-7e         ascii ASCII
(defmethod charout-ascii ((inst charout-jis) c)
  (charout-jis-mode inst 'ascii '(#x1B #x28 #x42))
  (pushchar c inst))

;; 1B 28 49           (I   21-5f         kana  Kana
(defmethod charout-kana ((inst charout-jis) c)
  (charout-jis-mode inst 'kana '(#x1B #x28 #x49))
  (pushchar c inst))

;; 1B 24 28 51        $B   21-7e  21-7e  jis1  JIS2004-1
(defmethod charout-jis1 ((inst charout-jis) c)
  (charout-jis-mode inst 'jis1 '(#x1B #x24 #x28 #x51))
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar a inst)
    (pushchar b inst)))

;; 1B 24 28 50        $B   21-7e  21-7e  jis2  JIS2000-2
(defmethod charout-jis2 ((inst charout-jis) c)
  (charout-jis-mode inst 'jis2 '(#x1B #x24 #x28 #x50))
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar a inst)
    (pushchar b inst)))

;; 1B 24 28 44        $D   21-7e  21-7e  jis2  JIS0212sub
(defmethod charout-sub ((inst charout-jis) c)
  (charout-jis-mode inst 'sub '(#x1B #x24 #x28 #x44))
  (multiple-value-bind (a b) (split2-byte c)
    (pushchar a inst)
    (pushchar b inst)))

(defun charout-pushchar0a-jis (inst)
  (ecase *eol-0a*
    ((nil) (charout-ascii inst #x0A))
    (#x0A (charout-ascii inst #x0A))
    (#x0D (charout-ascii inst #x0D))
    (eol2 (charout-ascii inst #x0D)
          (charout-ascii inst #x0A))))

(defun charout-pushchar0d-jis (inst)
  (ecase *eol-0d*
    ((nil) (charout-ascii inst #x0D))
    (#x0A (charout-ascii inst #x0A))
    (#x0D (charout-ascii inst #x0D))
    (eol2 (charout-ascii inst #x0D)
          (charout-ascii inst #x0A))))

(defun charout-pushchar0d0a-jis (inst)
  (ecase *eol-0d0a*
    ((nil) (charout-ascii inst #x0D)
           (charout-ascii inst #x0A))
    (#x0A (charout-ascii inst #x0A))
    (#x0D (charout-ascii inst #x0D))
    (eol2 (charout-ascii inst #x0D)
          (charout-ascii inst #x0A))))

(defmethod charout-control ((inst charout-jis) c)
  (cond ((eq c 'eol2)
         (charout-ascii inst #x0D)
         (charout-ascii inst #x0A))
        ((eq c 'bom) nil)
        ((eq c 'eol2) (charout-pushchar0d0a-jis inst))
        ((eql c #x0A) (charout-pushchar0a-jis inst))
        ((eql c #x0D) (charout-pushchar0d-jis inst))
        ((and (integerp c) (or (<= #x00 c #x1F) (= c #x7F)))
         (charout-ascii inst c))
        (t (charout-error inst c))))

(defmethod charout-error ((inst charout-jis) c)
  (if *recovery*
    (progn
      (pusherror *recovery-jis* inst)
      (setf (slot-value inst 'mode) nil))
    (error "Invalid jis value ~x." c)))


;;
;;  list jis
;;
(defclass list-jisj (list-pushchar charout-list charout-jis) ())
(defclass list-jisu (charout-unijis list-jisj) ())

(defun list-jis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'list-jisu 'list-jisj))))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector jis
;;
(defclass vector-jisj (vector-pushchar charout-vector1 charout-jis) ())
(defclass vector-jisu (charout-unijis vector-jisj) ())

(defun vector-jis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'vector-jisu 'vector-jisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string jis
;;
(defclass string-jisj (charout-string vector-jisj) ())
(defclass string-jisu (charout-unijis string-jisj) ())

(defun string-jis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-instance (if unicode 'string-jisu 'string-jisj))))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream jis
;;
(defclass stream-jisj (lambda-pushchar charout-stream charout-jis) ())
(defclass stream-jisu (charout-unijis stream-jisj) ())

(defun make-stream-jis (unicode)
  (make-charout-stream
    (if unicode 'stream-jisu 'stream-jisj)))

(defun stream-jis (x call unicode)
  (let ((input (make-inbyte x))
        (output (make-stream-jis unicode)))
    (funcall call input output)
    (charout-result output)))

