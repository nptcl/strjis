(in-package #:strjis)

;;
;;  charqueue
;;
(deftest make-charqueue.1
  (let ((inst (make-charqueue 'charqueue-any '(unsigned-byte 8) 100)))
    (values
      (typep inst 'charqueue)
      (typep inst 'charqueue-any)
      (typep inst 'charqueue-byte)
      (slot-value inst 'element)
      (slot-value inst 'size)))
  t t nil (unsigned-byte 8) 100)

(deftest make-charqueue.2
  (let ((inst (make-charqueue 'charqueue-any '(unsigned-byte 8) 100)))
    (typep
      (funcall (slot-value inst 'call))
      '(array (unsigned-byte 8) (100))))
  t)

(deftest make-charqueue-any.1
  (let ((inst (make-charqueue-any 100)))
    (values
      (typep inst 'charqueue-any)
      (slot-value inst 'element)
      (slot-value inst 'size)
      (typep (funcall (slot-value inst 'call)) '(array t (100)))))
  t t 100 t)

(deftest make-charqueue-byte.1
  (let ((inst (make-charqueue-byte 100)))
    (values
      (typep inst 'charqueue-byte)
      (slot-value inst 'element)
      (slot-value inst 'size)
      (typep (funcall (slot-value inst 'call)) '(array bytecode (100)))))
  t bytecode 100 t)

(deftest make-charqueue-jiscode.1
  (let ((inst (make-charqueue-jiscode 100)))
    (values
      (typep inst 'charqueue-jiscode)
      (slot-value inst 'element)
      (slot-value inst 'size)
      (typep (funcall (slot-value inst 'call)) '(array jiscode (100)))))
  t jiscode 100 t)

(deftest make-charqueue-unicode.1
  (let ((inst (make-charqueue-unicode 100)))
    (values
      (typep inst 'charqueue-unicode)
      (slot-value inst 'element)
      (slot-value inst 'size)
      (typep (funcall (slot-value inst 'call)) '(array unicode (100)))))
  t unicode 100 t)

(deftest make-charbit.1
  (let* ((queue (make-charqueue-unicode 100))
         (inst (make-charbit queue)))
    (values
      (typep inst 'charbit)
      (typep (slot-value inst 'vector) '(array unicode (100)))))
  t t)

(deftest push-charbit.1
  (let* ((queue (make-charqueue-unicode 3))
         (inst (make-charbit queue)))
    (values
      (push-charbit inst 10)
      (push-charbit inst 20)
      (slot-value inst 'index)
      (push-charbit inst 30)
      (push-charbit inst 40)
      (slot-value inst 'vector)
      (slot-value inst 'index)))
  t t 2 t nil #(10 20 30) 3)

(deftest clear-charbit.1
  (let* ((queue (make-charqueue-unicode 3))
         (inst (make-charbit queue)))
    (push-charbit inst 10)
    (push-charbit inst 20)
    (clear-charbit inst)
    (slot-value inst 'index))
  0)

(deftest push-charqueue.1
  (let ((inst (make-charqueue-unicode 3)))
    (values
      (null (slot-value inst 'root))
      (null (slot-value inst 'tail))
      (push-charqueue inst 10)
      (null (slot-value inst 'root))
      (null (slot-value inst 'tail))
      (slot-value inst 'index)))
  t t 10 nil nil 1)

(deftest push-charqueue.2
  (let ((inst (make-charqueue-unicode 3)))
    (push-charqueue inst 10)
    (push-charqueue inst 20)
    (push-charqueue inst 30)
    (values
      (eq (slot-value inst 'root) (slot-value inst 'tail))
      (push-charqueue inst 40)
      (eq (slot-value inst 'root) (slot-value inst 'tail))))
  t 40 nil)

(deftest push-charqueue.3
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 30)
      (push-charqueue inst i))
    (clear-charqueue inst)
    (push-charqueue inst 10)
    (push-charqueue inst 20)
    (push-charqueue inst 30)
    (values
      (eq (slot-value inst 'root) (slot-value inst 'tail))
      (push-charqueue inst 40)
      (eq (slot-value inst 'root) (slot-value inst 'tail))))
  t 40 nil)

(deftest root-charqueue-p.1
  (root-charqueue-p nil)
  nil)

(deftest root-charqueue-p.2
  (let* ((queue (make-charqueue-unicode 100))
         (inst (make-charbit queue)))
    (setf (slot-value inst 'index) 0)
    (root-charqueue-p inst))
  nil)

(deftest root-charqueue-p.3
  (let* ((queue (make-charqueue-unicode 100))
         (inst (make-charbit queue)))
    (setf (slot-value inst 'index) 1)
    (root-charqueue-p inst))
  t)

(deftest result-charqueue.1
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 10 20)
    (result-charqueue inst))
  #(10 20))

(deftest result-charqueue.2
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 10 20 30)
    (result-charqueue inst))
  #(10 20 30))

(deftest result-charqueue.3
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 10 20 30 40 50)
    (result-charqueue inst))
  #(10 20 30 40 50))

(deftest result-charqueue.4
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 1 2 3 4 5 6 7 8 9 10 11)
    (result-charqueue inst))
  #(1 2 3 4 5 6 7 8 9 10 11))

(deftest result-charqueue.5
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst 10 20)
    (result-charqueue inst))
  #(10 20))

(deftest result-charqueue.6
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst 10 20 30)
    (result-charqueue inst))
  #(10 20 30))

(deftest result-charqueue.7
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst 10 20 30 40 50)
    (result-charqueue inst))
  #(10 20 30 40 50))

(deftest result-charqueue.8
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst 1 2 3 4 5 6 7 8 9 10 11)
    (result-charqueue inst))
  #(1 2 3 4 5 6 7 8 9 10 11))

(deftest string-charqueue.1
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst #x41 #x42)
    (string-charqueue inst))
  "AB")

(deftest string-charqueue.2
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst #x41 #x42 #x43)
    (string-charqueue inst))
  "ABC")

(deftest string-charqueue.3
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst #x41 #x42 #x43 #x44 #x45)
    (string-charqueue inst))
  "ABCDE")

(deftest string-charqueue.4
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue
      inst #x41 #x42 #x43 #x44 #x45 #x46 #x47 #x48 #x49 #x4A #x4B)
    (string-charqueue inst))
  "ABCDEFGHIJK")

(deftest string-charqueue.5
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst #x41 #x42)
    (string-charqueue inst))
  "AB")

(deftest string-charqueue.6
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst #x41 #x42 #x43)
    (string-charqueue inst))
  "ABC")

(deftest string-charqueue.7
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue inst #x41 #x42 #x43 #x44 #x45)
    (string-charqueue inst))
  "ABCDE")

(deftest string-charqueue.8
  (let ((inst (make-charqueue-unicode 3)))
    (dotimes (i 100) (push-charqueue inst i))
    (clear-charqueue inst)
    (pushrest-charqueue
      inst #x41 #x42 #x43 #x44 #x45 #x46 #x47 #x48 #x49 #x4A #x4B)
    (string-charqueue inst))
  "ABCDEFGHIJK")

(deftest clear-charqueue.1
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 1 2 3 4 5 6 7 8 9 10 11)
    (clear-charqueue inst)
    (result-charqueue inst))
  #())

(deftest free-charqueue.1
  (let ((inst (make-charqueue-unicode 3)))
    (pushrest-charqueue inst 1 2 3 4 5 6 7 8 9 10 11)
    (free-charqueue inst)
    (result-charqueue inst))
  #())

