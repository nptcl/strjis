;;
;;  utf16 encoding
;;
(in-package #:strjis)

;;
;;  list utf16v
;;
(defclass list-utf16v (charout-unicode-list) ())

(defun encode-surrogate-utf16 (c)
  (values
    (logior #xD800
            (ash (1- (logand (ash c -16) #x1F)) 6)
            (logand (ash c -10) #x3F))
    (logior #xDC00
            (logand #x03FF c))))

(defun encode-utf16v (c)
  (declare (type unicode c))
  (cond ((< c #xD800)
         (values c))
        ((< c #xE000)
         (error "Invalid unicode ~x." c))
        ((< c #x010000)
         (values c))
        ((< c #x110000)
         (encode-surrogate-utf16 c))
        (t (error "Invalid unicode ~x." c))))

(defmacro push-utf16v (c place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (u1 (gensym)) (u2 (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,u1 ,u2) (encode-utf16v ,c)
             (push ,u1 ,v)
             (when ,u2
               (push ,u2 ,v)))
           ,w ,v)))))

(defmethod pushchar (c (inst list-utf16v))
  (with-slots (list) inst
    (push-utf16v c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf16v))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf16v c list)))
  (call-next-method))

(defun list-utf16v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16v))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))


;;
;;  list utf16be
;;
(defclass list-utf16be (charout-unicode-list) ())

(defmacro push-utf16be (c place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (u1 (gensym)) (u2 (gensym)) (x (gensym)) (y (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,u1 ,u2) (encode-utf16v ,c)
             (multiple-value-bind (,x ,y) (split2-byte ,u1)
               (push ,x ,v)
               (push ,y ,v)
               (when ,u2
                 (multiple-value-bind (,x ,y) (split2-byte ,u2)
                   (push ,x ,v)
                   (push ,y ,v)))))
           ,w ,v)))))

(defmethod pushchar (c (inst list-utf16be))
  (with-slots (list) inst
    (push-utf16be c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf16be))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf16be c list)))
  (call-next-method))

(defun list-utf16 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16be))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun list-utf16be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16be))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun list-utf16bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16be))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  list utf16le
;;
(defclass list-utf16le (charout-unicode-list) ())

(defmacro push-utf16le (c place)
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (u1 (gensym)) (u2 (gensym)) (x (gensym)) (y (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,u1 ,u2) (encode-utf16v ,c)
             (multiple-value-bind (,x ,y) (split2-byte ,u1)
               (push ,y ,v)
               (push ,x ,v)
               (when ,u2
                 (multiple-value-bind (,x ,y) (split2-byte ,u2)
                   (push ,y ,v)
                   (push ,x ,v)))))
           ,w ,v)))))

(defmethod pushchar (c (inst list-utf16le))
  (with-slots (list) inst
    (push-utf16le c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf16le))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf16le c list)))
  (call-next-method))

(defun list-utf16le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16le))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun list-utf16lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf16le))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf16v
;;
(defclass vector-utf16v (charout-unicode-vector2) ())

(defun push-charqueue-utf16v (inst c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (push-charqueue inst a)
    (when b
      (push-charqueue inst b))))

(defmethod pushchar (c (inst vector-utf16v))
  (with-slots (queue) inst
    (push-charqueue-utf16v queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf16v))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf16v queue c)))
  (call-next-method))

(defun vector-utf16v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16v))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf16be
;;
(defclass vector-utf16be (charout-unicode-vector1) ())

(defun push-charqueue-utf16be (inst c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (multiple-value-bind (x y) (split2-byte a)
      (push-charqueue inst x)
      (push-charqueue inst y)
      (when b
        (multiple-value-bind (x y) (split2-byte b)
          (push-charqueue inst x)
          (push-charqueue inst y))))))

(defmethod pushchar (c (inst vector-utf16be))
  (with-slots (queue) inst
    (push-charqueue-utf16be queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf16be))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf16be queue c)))
  (call-next-method))

(defun vector-utf16 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16be))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf16be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf16bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf16le
;;
(defclass vector-utf16le (charout-unicode-vector1) ())

(defun push-charqueue-utf16le (inst c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (multiple-value-bind (x y) (split2-byte a)
      (push-charqueue inst y)
      (push-charqueue inst x)
      (when b
        (multiple-value-bind (x y) (split2-byte b)
          (push-charqueue inst y)
          (push-charqueue inst x))))))

(defmethod pushchar (c (inst vector-utf16le))
  (with-slots (queue) inst
    (push-charqueue-utf16le queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf16le))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf16le queue c)))
  (call-next-method))

(defun vector-utf16le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf16lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf16le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf16v
;;
(defclass string-utf16v (charout-string vector-utf16v) ())

(defun string-utf16v (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16v))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf16be
;;
(defclass string-utf16be (charout-string vector-utf16be) ())

(defun string-utf16 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16be))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf16be (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf16bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16be))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  string-utf16le
;;
(defclass string-utf16le (charout-string vector-utf16le) ())

(defun string-utf16le (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf16lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf16le))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf16v
;;
(defclass stream-utf16v (charout-unicode-stream) ())

(defun stream-pushchar-utf16v (call c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (funcall call a)
    (when b
      (funcall call b))))

(defmethod pushchar (c (inst stream-utf16v))
  (with-slots (lambda) inst
    (stream-pushchar-utf16v lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf16v))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf16v lambda c)))
  (call-next-method))

(defun stream-utf16v (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16v))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf16be
;;
(defclass stream-utf16be (charout-unicode-stream) ())

(defun stream-pushchar-utf16be (call c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (multiple-value-bind (x y) (split2-byte a)
      (funcall call x)
      (funcall call y)
      (when b
        (multiple-value-bind (x y) (split2-byte b)
          (funcall call x)
          (funcall call y))))))

(defmethod pushchar (c (inst stream-utf16be))
  (with-slots (lambda) inst
    (stream-pushchar-utf16be lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf16be))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf16be lambda c)))
  (call-next-method))

(defun stream-utf16 (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16be))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf16be (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16be))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf16bebom (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16be))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf16le
;;
(defclass stream-utf16le (charout-unicode-stream) ())

(defun stream-pushchar-utf16le (call c)
  (multiple-value-bind (a b) (encode-utf16v c)
    (multiple-value-bind (x y) (split2-byte a)
      (funcall call y)
      (funcall call x)
      (when b
        (multiple-value-bind (x y) (split2-byte b)
          (funcall call y)
          (funcall call x))))))

(defmethod pushchar (c (inst stream-utf16le))
  (with-slots (lambda) inst
    (stream-pushchar-utf16le lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf16le))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf16le lambda c)))
  (call-next-method))

(defun stream-utf16le (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16le))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf16lebom (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf16le))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

