;;
;;  utf32 encoding
;;
(in-package #:strjis)

;;
;;  list utf32v
;;
(defclass list-utf32v (charout-unicode-list) ())

(defmethod pushchar (c (inst list-utf32v))
  (with-slots (list) inst
    (push c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf32v))
  (with-slots (list) inst
    (pushdolist x list))
  (call-next-method))

(defun list-utf32v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32v))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))


;;
;;  list utf32be
;;
(defclass list-utf32be (charout-unicode-list) ())

(defmacro push-utf32be (c place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (x (gensym)) (y (gensym)) (z (gensym)) (zz (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,x ,y ,z ,zz) (split4-byte ,c)
             (push ,x ,v)
             (push ,y ,v)
             (push ,z ,v)
             (push ,zz ,v))
           ,w ,v)))))

(defmethod pushchar (c (inst list-utf32be))
  (with-slots (list) inst
    (push-utf32be c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf32be))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf32be c list)))
  (call-next-method))

(defun list-utf32 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32be))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun list-utf32be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32be))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun list-utf32bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32be))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  list utf32le
;;
(defclass list-utf32le (charout-unicode-list) ())

(defmacro push-utf32le (c place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (x (gensym)) (y (gensym)) (z (gensym)) (zz (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,x ,y ,z ,zz) (split4-byte ,c)
             (push ,zz ,v)
             (push ,z ,v)
             (push ,y ,v)
             (push ,x ,v))
           ,w ,v)))))

(defmethod pushchar (c (inst list-utf32le))
  (with-slots (list) inst
    (push-utf32le c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf32le))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf32le c list)))
  (call-next-method))

(defun list-utf32le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32le))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun list-utf32lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf32le))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf32v
;;
(defclass vector-utf32v (charout-unicode-vector4) ())

(defmethod pushchar (c (inst vector-utf32v))
  (with-slots (queue) inst
    (push-charqueue queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf32v))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue queue c)))
  (call-next-method))

(defun vector-utf32v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32v))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf32be
;;
(defclass vector-utf32be (charout-unicode-vector1) ())

(defun push-charqueue-utf32be (inst c)
  (multiple-value-bind (x y z w) (split4-byte c)
    (push-charqueue inst x)
    (push-charqueue inst y)
    (push-charqueue inst z)
    (push-charqueue inst w)))

(defmethod pushchar (c (inst vector-utf32be))
  (with-slots (queue) inst
    (push-charqueue-utf32be queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf32be))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf32be queue c)))
  (call-next-method))

(defun vector-utf32 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32be))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf32be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf32bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf32le
;;
(defclass vector-utf32le (charout-unicode-vector1) ())

(defun push-charqueue-utf32le (inst c)
  (multiple-value-bind (x y z w) (split4-byte c)
    (push-charqueue inst w)
    (push-charqueue inst z)
    (push-charqueue inst y)
    (push-charqueue inst x)))

(defmethod pushchar (c (inst vector-utf32le))
  (with-slots (queue) inst
    (push-charqueue-utf32le queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf32le))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf32le queue c)))
  (call-next-method))

(defun vector-utf32le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf32lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf32le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf32v
;;
(defclass string-utf32v (charout-string vector-utf32v) ())

(defun string-utf32v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32v))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf32be
;;
(defclass string-utf32be (charout-string vector-utf32be) ())

(defun string-utf32 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32be))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf32be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf32bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf32le
;;
(defclass string-utf32le (charout-string vector-utf32le) ())

(defun string-utf32le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf32lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf32le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf32v
;;
(defclass stream-utf32v (charout-unicode-stream) ())

(defmethod pushchar (c (inst stream-utf32v))
  (with-slots (lambda) inst
    (funcall lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf32v))
  (with-slots (lambda) inst
    (dolist (c x)
      (funcall lambda c)))
  (call-next-method))

(defun stream-utf32v (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32v))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf32be
;;
(defclass stream-utf32be (charout-unicode-stream) ())

(defun stream-pushchar-utf32be (call c)
  (multiple-value-bind (x y z w) (split4-byte c)
    (funcall call x)
    (funcall call y)
    (funcall call z)
    (funcall call w)))

(defmethod pushchar (c (inst stream-utf32be))
  (with-slots (lambda) inst
    (stream-pushchar-utf32be lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf32be))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf32be lambda c)))
  (call-next-method))

(defun stream-utf32 (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32be))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf32be (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32be))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf32bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32be))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf32le
;;
(defclass stream-utf32le (charout-unicode-stream) ())

(defun stream-pushchar-utf32le (call c)
  (multiple-value-bind (x y z w) (split4-byte c)
    (funcall call w)
    (funcall call z)
    (funcall call y)
    (funcall call x)))

(defmethod pushchar (c (inst stream-utf32le))
  (with-slots (lambda) inst
    (stream-pushchar-utf32le lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf32le))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf32le lambda c)))
  (call-next-method))

(defun stream-utf32le (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32le))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf32lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf32le))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

