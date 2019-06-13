(in-package #:strjis)

;;
;;  charout
;;
(defclass charout (strjis) ())
(defgeneric charout-result (inst))
(defgeneric charout-close (inst))
(defgeneric pushchar (c inst))
(defgeneric pushlist (list inst))

(defgeneric charout-ascii (inst c))
(defgeneric charout-kana (inst c))
(defgeneric charout-control (inst c))
(defgeneric charout-jis1 (inst c))
(defgeneric charout-jis2 (inst c))
(defgeneric charout-sub (inst c))
(defgeneric charout-unicode (inst c))
(defgeneric charout-error (inst c))

(defun pushdata (x inst)
  (etypecase x
    (integer (pushchar x inst))
    (character (pushchar (char-code x) inst))
    (list (pushlist x inst))
    (vector (dotimes (i (length x))
              (pushchar (elt x i) inst)))))

(defun pushchar0a (inst)
  (ecase *eol-0a*
    ((nil) (pushchar #x0A inst))
    (#x0A (pushchar #x0A inst))
    (#x0D (pushchar #x0D inst))
    (eol2 (pushlist '(#x0D #x0A) inst))))

(defun pushchar0d (inst)
  (ecase *eol-0d*
    ((nil) (pushchar #x0D inst))
    (#x0A (pushchar #x0A inst))
    (#x0D (pushchar #x0D inst))
    (eol2 (pushlist '(#x0D #x0A) inst))))

(defun pushchar0d0a (inst)
  (ecase *eol-0d0a*
    ((nil) (pushlist '(#x0D #x0A) inst))
    (#x0A (pushchar #x0A inst))
    (#x0D (pushchar #x0D inst))
    (eol2 (pushlist '(#x0D #x0A) inst))))


;;
;;  charout-list
;;
(defclass charout-list (charout)
  ((list :initform nil)
   (finish :initform nil)
   result))

(defmethod charout-close ((inst charout-list))
  (with-slots (list finish result) inst
    (unless finish
      (setq finish t)
      (setq result (nreverse list) list nil))))

(defmethod charout-result ((inst charout-list))
  (charout-close inst)
  (slot-value inst 'result))

;;  list-pushchar
(defclass list-pushchar (charout) ())

(defmethod pushchar (c (inst list-pushchar))
  (with-slots (list) inst
    (push c list)))

(defmethod pushlist (x (inst list-pushchar))
  (with-slots (list) inst
    (pushdolist x list)))


;;
;;  charout-vector
;;
(defclass charout-vector (charout)
  ((queue :initform nil)
   (finish :initform nil)
   result))

(defgeneric make-charout-vector (inst size))

(defmethod charout-close ((inst charout-vector))
  (with-slots (queue finish result) inst
    (unless finish
      (setq finish t)
      (setq result (result-charqueue queue))
      (clear-charqueue queue))))

(defmethod charout-result ((inst charout-vector))
  (charout-close inst)
  (slot-value inst 'result))

;;  charout-vector1
(defclass charout-vector1 (charout-vector) ())

(defmethod make-charout-vector ((inst charout-vector1) size)
  (with-slots (queue) inst
    (setq queue (make-charqueue-byte size))
    inst))

;;  charout-vector2
(defclass charout-vector2 (charout-vector) ())

(defmethod make-charout-vector ((inst charout-vector2) size)
  (with-slots (queue) inst
    (setq queue (make-charqueue-jiscode size))
    inst))

;;  charout-vector4
(defclass charout-vector4 (charout-vector) ())

(defmethod make-charout-vector ((inst charout-vector4) size)
  (with-slots (queue) inst
    (setq queue (make-charqueue-unicode size))
    inst))

;;  vector-pushchar
(defclass vector-pushchar (charout) ())

(defmethod pushchar (c (inst vector-pushchar))
  (with-slots (queue) inst
    (push-charqueue queue c)))

(defmethod pushlist (x (inst vector-pushchar))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue queue c))))


;;
;;  charout-string
;;
(defclass charout-string (charout) ())

(defmethod charout-close ((inst charout-string))
  (with-slots (queue finish result) inst
    (unless finish
      (setq finish t)
      (setq result (string-charqueue queue))
      (clear-charqueue queue))))


;;
;;  charout-lambda
;;
(defclass charout-lambda (charout)
  ((lambda :initarg :lambda)))

;;  lambda-pushchar
(defclass lambda-pushchar (charout) ())

(defmethod pushchar (c (inst lambda-pushchar))
  (with-slots (lambda) inst
    (funcall lambda c)))

(defmethod pushlist (x (inst lambda-pushchar))
  (with-slots (lambda) inst
    (dolist (c x)
      (funcall lambda c))))


;;
;;  charout-stream
;;
(defclass charout-stream (charout-lambda) ())

(defmethod charout-result ((inst charout-stream))
  (when (next-method-p)
    (call-next-method)))

(defun charout-stream-binary-lambda (stream)
  (lambda (c)
    (write-byte c stream)))

(defun charout-stream-character-lambda (stream)
  (lambda (c)
    (write-char (code-char c) stream)))

(defun make-charout-stream-lambda (stream type)
  (cond ((null type)
         (if (subtypep (stream-element-type stream) 'character)
           (charout-stream-character-lambda stream)
           (charout-stream-binary-lambda stream)))
        ((eq type 'binary)
         (charout-stream-binary-lambda stream))
        ((eq type 'character)
         (charout-stream-character-lambda stream))
        (t (error "Invalid stream-output-type ~S." type))))

(defun make-charout-stream (symbol)
  (make-instance
    symbol
    :lambda (make-charout-stream-lambda *stream-output* *stream-output-type*)))


;;
;;  charout-group
;;
(defclass charout-group (list-pushchar charout-list)
  ((mode :initform nil)
   (now :initform nil)
   (error :initarg :error :initform t)))

(defun charout-group-flush (inst)
  (with-slots (mode now) inst
    (when now
      (pushchar (cons mode (nreverse now)) inst)
      (setq now nil mode nil))))

(defmethod charout-close ((inst charout-group))
  (charout-group-flush inst)
  (call-next-method))

(defun charout-group-push (inst type c)
  (with-slots (mode now) inst
    (unless (eq mode type)
      (charout-group-flush inst)
      (setq mode type))
    (push c now)))

(defmethod charout-ascii ((inst charout-group) c)
  (charout-group-push inst 'ascii c))

(defmethod charout-kana ((inst charout-group) c)
  (charout-group-push inst 'kana c))

(defmethod charout-control ((inst charout-group) c)
  (charout-group-push inst 'control c))

(defmethod charout-jis1 ((inst charout-group) c)
  (charout-group-push inst 'jis1 c))

(defmethod charout-jis2 ((inst charout-group) c)
  (charout-group-push inst 'jis2 c))

(defmethod charout-sub ((inst charout-group) c)
  (charout-group-push inst 'sub c))

(defmethod charout-unicode ((inst charout-group) c)
  (charout-group-push inst 'unicode c))

(defmethod charout-error ((inst charout-group) c)
  (with-slots (error) inst
    (charout-group-push inst 'error (if error 'error c))))

(defun pusherror (x inst)
  (setq *recovery-check* t)
  (pushdata x inst))


;;
;;  charout-unicode
;;
(defclass charout-unicode (charout)
  ((first :initform t)))

(defmethod pushchar (c (inst charout-unicode))
  (declare (ignore c))
  (setf (slot-value inst 'first) nil))

(defmethod pushlist (x (inst charout-unicode))
  (declare (ignore x))
  (setf (slot-value inst 'first) nil))

(defun charout-unicode-table (inst c table)
  (aif2 (gethash c table)
    (pushchar it inst)
    (charout-error inst c)))

(defmethod charout-ascii ((inst charout-unicode) c)
  (charout-unicode-table inst c *forward-ascii*))

(defmethod charout-kana ((inst charout-unicode) c)
  (charout-unicode-table inst c *forward-kana*))

(defmethod charout-jis1 ((inst charout-unicode) c)
  (acond2 ((gethash c *forward-twice*)
           (pushlist it inst))
          ((gethash c *forward-iso3*)
           (pushchar it inst))
          ((gethash c *forward-jis1*)
           (pushchar it inst))
          (t (charout-error inst c))))

(defmethod charout-jis2 ((inst charout-unicode) c)
  (charout-unicode-table inst c *forward-iso4*))

(defmethod charout-sub ((inst charout-unicode) c)
  (charout-unicode-table inst c *forward-jis2*))

(defmethod charout-unicode ((inst charout-unicode) c)
  (pushchar c inst))

(defun charout-bom-control (inst)
  (when (and (slot-value inst 'first)
             (null *bom-control*))
    (pushchar #xFEFF inst)))

(defmethod charout-control ((inst charout-unicode) c)
  (cond ((eq c 'bom) (charout-bom-control inst))
        ((eq c 'eol2) (pushchar0d0a inst))
        ((eql c #x0A) (pushchar0a inst))
        ((eql c #x0D) (pushchar0d inst))
        ((and (integerp c) (or (<= #x00 c #x1F) (= c #x7F)))
         (pushchar c inst))
        (t (charout-error inst c))))

(defmethod charout-error ((inst charout-unicode) c)
  (if *recovery*
    (pusherror *recovery-unicode* inst)
    (error "Invalid unicode value ~x." c)))

;;  list
(defclass charout-unicode-list (charout-unicode charout-list) ())
;;  vector1
(defclass charout-unicode-vector1 (charout-unicode charout-vector1) ())
;;  vector2
(defclass charout-unicode-vector2 (charout-unicode charout-vector2) ())
;;  vector4
(defclass charout-unicode-vector4 (charout-unicode charout-vector4) ())
;;  stream
(defclass charout-unicode-stream (charout-unicode charout-stream) ())


;;
;;  charout-unijis
;;
(defclass charout-unijis (charout)
  ((prev :initform nil)))

(defmethod charout-result ((inst charout-unijis))
  (charout-unijis-flush inst)
  (call-next-method))

(defun charout-unijis-send (inst c)
  (acond2 ((gethash c *reverse-ascii*)
           (charout-ascii inst it))
          ((gethash c *reverse-kana*)
           (charout-kana inst it))
          ((gethash c *reverse-iso3*)
           (charout-jis1 inst it))
          ((gethash c *reverse-iso4*)
           (charout-jis2 inst it))
          ((gethash c *reverse-jis2*)
           (charout-sub inst it))
          ((gethash c *reverse-jis1*)
           (charout-jis1 inst it))
          (t (setf (slot-value inst 'prev) nil)
             (charout-error inst c))))

(defun charout-unijis-flush (inst)
  (with-slots (prev) inst
    (when prev
      (charout-unijis-send inst prev)
      (setq prev nil))))

(defun charout-unijis-send2 (inst c x y)
  (with-slots (prev) inst
    (if (= c x)
      (progn
        (charout-jis1 inst y)
        (setq prev nil))
      (progn
        (charout-unijis-send inst prev)
        (setq prev c)))))

(defun charout-unijis2 (inst c)
  (with-slots (prev) inst
    (aif2 (gethash prev *reverse-twice*)
      (destructuring-bind (x y) it
        (charout-unijis-send2 inst c x y))
      (with-slots (prev) inst
        (charout-unijis-send inst prev)
        (setq prev c)))))

(defmethod charout-unicode ((inst charout-unijis) c)
  (with-slots (prev) inst
    (if prev
      (charout-unijis2 inst c)
      (setq prev c))))

(defmethod charout-control ((inst charout-unijis) c)
  (declare (ignore c))
  (charout-unijis-flush inst)
  (call-next-method))

(defmethod charout-error ((inst charout-unijis) c)
  (declare (ignore c))
  (charout-unijis-flush inst)
  (call-next-method))

