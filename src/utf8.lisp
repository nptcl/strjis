;;
;;  utf8 encoding
;;
(in-package #:strjis)

;;
;;  encode
;;
(defun encode-utf8 (c)
  (declare (type unicode c))
  (cond ((<= c #x7F)
         (values c))
        ((<= c #x07FF)
         (values (logior #xC0 (ash c -6))
                 (logior #x80 (logand c #xBF))))
        ((<= c #xFFFF)
         (values (logior #xE0 (ash c -12))
                 (logior #x80 (logand (ash c -6) #xBF))
                 (logior #x80 (logand c #xBF))))
        ((<= c #x10FFFF)
         (values (logior #xF0 (ash c -18))
                 (logior #x80 (logand (ash c -12) #xBF))
                 (logior #x80 (logand (ash c -6) #xBF))
                 (logior #x80 (logand c #xBF))))
        (t (error "Too large character code ~A." c))))

(defmacro push-utf8 (x place &optional (push 'push))
  (multiple-value-bind (a b g w r) (get-setf-expansion place)
    (let ((v (car g)) (u1 (gensym)) (u2 (gensym)) (u3 (gensym)) (u4 (gensym)))
      `(let (,@(mapcar #'list a b) ,@g)
         (declare (ignorable ,@a ,@g))
         (let ((,v ,r))
           (multiple-value-bind (,u1 ,u2 ,u3 ,u4) (encode-utf8 ,x)
             (,push ,u1 ,v)
             (when ,u2
               (,push ,u2 ,v)
               (when ,u3
                 (,push ,u3 ,v)
                 (when ,u4
                   (,push ,u4 ,v)))))
           ,w ,v)))))


;;
;;  list utf8
;;
(defclass list-utf8 (charout-unicode-list) ())

(defmethod pushchar (c (inst list-utf8))
  (with-slots (list) inst
    (push-utf8 c list))
  (call-next-method))

(defmethod pushlist (x (inst list-utf8))
  (with-slots (list) inst
    (dolist (c x)
      (push-utf8 c list)))
  (call-next-method))

(defun list-utf8 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf8))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun list-utf8bom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf8))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

(defun list-utf8no (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'list-utf8))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))


;;
;;  vector utf8
;;
(defclass vector-utf8 (charout-unicode-vector1) ())

(defun push-charqueue-utf8 (inst c)
  (multiple-value-bind (x y z w) (encode-utf8 c)
    (push-charqueue inst x)
    (when y
      (push-charqueue inst y)
      (when z
        (push-charqueue inst z)
        (when w
          (push-charqueue inst w))))))

(defmethod pushchar (c (inst vector-utf8))
  (with-slots (queue) inst
    (push-charqueue-utf8 queue c))
  (call-next-method))

(defmethod pushlist (x (inst vector-utf8))
  (with-slots (queue) inst
    (dolist (c x)
      (push-charqueue-utf8 queue c)))
  (call-next-method))

(defun vector-utf8 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf8))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf8bom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf8))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

(defun vector-utf8no (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'vector-utf8))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  string utf8
;;
(defclass string-utf8 (charout-string vector-utf8) ())

(defun string-utf8 (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf8))
        (*bom-control* nil))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))

(defun string-utf8bom (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf8))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

(defun string-utf8no (x call)
  (let ((input (make-inbyte x))
        (output (make-instance 'string-utf8))
        (*bom-control* 'reject))
    (make-charout-vector output *vector-size*)
    (funcall call input output)
    (charout-result output)))


;;
;;  stream utf8
;;
(defclass stream-utf8 (charout-unicode-stream) ())

(defun stream-pushchar-utf8 (call c)
  (multiple-value-bind (x y z w) (encode-utf8 c)
    (funcall call x)
    (when y
      (funcall call y)
      (when z
        (funcall call z)
        (when w
          (funcall call w))))))

(defmethod pushchar (c (inst stream-utf8))
  (with-slots (lambda) inst
    (stream-pushchar-utf8 lambda c))
  (call-next-method))

(defmethod pushlist (x (inst stream-utf8))
  (with-slots (lambda) inst
    (dolist (c x)
      (stream-pushchar-utf8 lambda c)))
  (call-next-method))

(defun stream-utf8 (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf8))
        (*bom-control* nil))
    (funcall call input output)
    (charout-result output)))

(defun stream-utf8bom (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf8))
        (*bom-control* 'reject))
    (pushchar #xFEFF output)
    (funcall call input output)
    (charout-result output)))

(defun stream-utf8no (x call)
  (let ((input (make-inbyte x))
        (output (make-charout-stream 'stream-utf8))
        (*bom-control* 'reject))
    (funcall call input output)
    (charout-result output)))

