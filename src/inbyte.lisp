(in-package #:strjis)

(defgeneric inbyte-now (inst))
(defgeneric inbyte-ungetc (inst))
(defgeneric inbyte-next (inst))

;; inbyte
(defclass inbyte ()
  ((now :initform nil)
   (ungetc :initform nil)))

(defmethod inbyte-now ((inst inbyte))
  (with-slots (now ungetc) inst
    (or ungetc now)))

(defmethod inbyte-ungetc ((inst inbyte))
  (with-slots (now ungetc) inst
    (prog1 now
      (setq ungetc now now nil))))

(defmethod inbyte-next ((inst inbyte))
  (with-slots (now ungetc) inst
    (setq now nil)
    (when ungetc
      (setq now ungetc ungetc nil)
      now)))

(defun inbyte-set (inst c)
  (setf (slot-value inst 'now) c))


;; vector
(defclass inbyte-vector (inbyte)
  ((vector :initarg :vector :type vector)
   (size :initarg :size)
   (index :initform 0)))

(defun make-inbyte-vector (vector)
  (declare (type vector vector))
  (make-instance 'inbyte-vector :vector vector :size (length vector)))

(defmethod inbyte-next ((inst inbyte-vector))
  (or (call-next-method inst)
      (with-slots (vector size index) inst
        (if (< index size)
          (prog1
            (inbyte-set inst (elt vector index))
            (incf index 1))
          (inbyte-set inst nil)))))


;; string
(defclass inbyte-string (inbyte-vector) ())

(defun make-inbyte-string (vector)
  (declare (type string vector))
  (make-instance 'inbyte-string :vector vector :size (length vector)))

(defun char-code-type (c)
  (if (characterp c)
    (char-code c)
    c))

(defmethod inbyte-now ((inst inbyte-string))
  (char-code-type
    (call-next-method inst)))

(defmethod inbyte-ungetc ((inst inbyte-string))
  (char-code-type
    (call-next-method inst)))

(defmethod inbyte-next ((inst inbyte-string))
  (char-code-type
    (call-next-method inst)))


;; list
(defclass inbyte-list (inbyte)
  ((list :initarg :list)))

(defun make-inbyte-list (list)
  (declare (type list list))
  (make-instance 'inbyte-list :list list))

(defmethod inbyte-next ((inst inbyte-list))
  (or (call-next-method inst)
      (with-slots (list) inst
        (if list
          (prog1
            (inbyte-set inst (car list))
            (setq list (cdr list)))
          (inbyte-set inst nil)))))


;; lambda
(defclass inbyte-lambda (inbyte)
  ((lambda :initarg :lambda)))

(defmethod inbyte-next ((inst inbyte-lambda))
  (or (call-next-method inst)
      (with-slots (lambda) inst
        (inbyte-set inst (funcall lambda)))))


;; stream
(defclass inbyte-stream (inbyte-lambda) ())

(defun inbyte-stream-binary-lambda (stream)
  (lambda ()
    (read-byte stream nil nil)))

(defun inbyte-stream-character-lambda (stream)
  (lambda ()
    (let ((c (read-char stream nil nil)))
      (when c
        (char-code c)))))

(defun make-inbyte-stream-lambda (stream type)
  (cond ((null type)
         (if (subtypep (stream-element-type stream) 'character)
           (inbyte-stream-character-lambda stream)
           (inbyte-stream-binary-lambda stream)))
        ((eq type 'binary)
         (inbyte-stream-binary-lambda stream))
        ((eq type 'character)
         (inbyte-stream-character-lambda stream))
        (t (error "Invalid stream-input-type ~S." type))))

(defun make-inbyte-stream (stream)
  (declare (type stream stream))
  (make-instance
    'inbyte-stream
    :lambda (make-inbyte-stream-lambda stream *stream-input-type*)))


;; type
(defun make-inbyte (input)
  (etypecase input
    (stream (make-inbyte-stream input))
    (string (make-inbyte-string input))
    (vector (make-inbyte-vector input))
    (list (make-inbyte-list input))))

