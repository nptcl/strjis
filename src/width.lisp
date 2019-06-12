;;
;;  East Asian Width
;;
(in-package #:strjis)

(defun east-asian<= (a x b)
  (if b
    (<= a x b)
    (= a x)))

(defun east-asian-width-symbol (x table &optional ai bi)
  (let* ((ai (or ai 0))
         (bi (or bi (1- (length table))))
         (ci (floor (+ ai bi) 2))
         (a (elt table ai))
         (b (elt table bi))
         (c1 (car (elt table ci))))
    (destructuring-bind (a1 a2 a3) a
      (destructuring-bind (b1 b2 b3) b
        (cond ((east-asian<= a1 x a2) a3)
              ((east-asian<= b1 x b2) b3)
              ((<= bi ai) nil)
              (t (if (< x c1)
                   (east-asian-width-symbol x table (1+ ai) ci)
                   (east-asian-width-symbol x table ci (1- bi)))))))))

(defun east-asian-symbol (x)
  (east-asian-width-symbol x *east-asian-width*))

(defun east-asian-width (x)
  (cdr (assoc (east-asian-symbol x) *east-asian-symbol*)))

(defun east-asian-input (c)
  (if (characterp c)
    (char-code c)
    c))

(defun east-asian-length-list (x)
  (declare (type list x))
  (let ((result 0))
    (dolist (i x)
      (incf result (east-asian-width (east-asian-input i))))
    result))

(defun east-asian-length-vector (x)
  (declare (type vector x))
  (let ((result 0))
    (dotimes (i (length x))
      (incf result (east-asian-width (east-asian-input (elt x i)))))
    result))

(defun east-asian-length (x)
  (declare (type sequence x))
  (if (listp x)
    (east-asian-length-list x)
    (east-asian-length-vector x)))

