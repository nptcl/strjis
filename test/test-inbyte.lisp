(in-package #:strjis)

;;
;;  inbyte
;;
(deftest inbyte-now.1
  (let ((inst (make-instance 'inbyte)))
    (inbyte-now inst))
  nil)

(deftest inbyte-now.2
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10))
    (inbyte-now inst))
  10)

(deftest inbyte-now.3
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10 ungetc 20))
    (inbyte-now inst))
  20)

(deftest inbyte-ungetc.1
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10)
      (inbyte-ungetc inst)
      (values now ungetc)))
  nil 10)

(deftest inbyte-ungetc.2
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10 ungetc 20)
      (inbyte-now inst)))
  20)

(deftest inbyte-next.1
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10 ungetc 20)
      (values
        (inbyte-next inst) now ungetc)))
  20 20 nil)

(deftest inbyte-next.2
  (let ((inst (make-instance 'inbyte)))
    (with-slots (now ungetc) inst
      (setq now 10 ungetc nil)
      (values
        (inbyte-next inst) now ungetc)))
  nil nil nil)


;;
;;  vector
;;
(deftest inbyte-vector.1
  (let ((inst (make-inbyte-vector #())))
    (values
      (inbyte-now inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  nil nil nil nil)

(deftest inbyte-vector.2
  (let ((inst (make-inbyte-vector #(10 20 30))))
    (inbyte-now inst))
  nil)

(deftest inbyte-vector.3
  (let ((inst (make-inbyte-vector #(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-now inst)))
  10 10)

(deftest inbyte-vector.4
  (let ((inst (make-inbyte-vector #(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  10 20 30 nil nil nil)

(deftest inbyte-vector.5
  (let ((inst (make-inbyte-vector #(10 20 30))))
    (values
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  nil 10 20)

(deftest inbyte-vector.6
  (let ((inst (make-inbyte-vector #(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  10 20 20 20 30 nil)


;;
;;  string
;;
(deftest inbyte-string.1
  (let ((inst (make-inbyte-string "")))
    (values
      (inbyte-now inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  nil nil nil nil)

(deftest inbyte-string.2
  (let ((inst (make-inbyte-string "ABC")))
    (inbyte-now inst))
  nil)

(deftest inbyte-string.3
  (let ((inst (make-inbyte-string "ABC")))
    (values
      (inbyte-next inst)
      (inbyte-now inst)))
  65 65)

(deftest inbyte-string.4
  (let ((inst (make-inbyte-string "ABC")))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  65 66 67 nil nil nil)

(deftest inbyte-string.5
  (let ((inst (make-inbyte-string "ABC")))
    (values
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  nil 65 66)

(deftest inbyte-string.6
  (let ((inst (make-inbyte-string "ABC")))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  65 66 66 66 67 nil)


;;
;;  list
;;
(deftest inbyte-list.1
  (let ((inst (make-inbyte-list nil)))
    (values
      (inbyte-now inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  nil nil nil nil)

(deftest inbyte-list.2
  (let ((inst (make-inbyte-list '(10 20 30))))
    (inbyte-now inst))
  nil)

(deftest inbyte-list.3
  (let ((inst (make-inbyte-list '(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-now inst)))
  10 10)

(deftest inbyte-list.4
  (let ((inst (make-inbyte-list '(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  10 20 30 nil nil nil)

(deftest inbyte-list.5
  (let ((inst (make-inbyte-list '(10 20 30))))
    (values
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  nil 10 20)

(deftest inbyte-list.6
  (let ((inst (make-inbyte-list '(10 20 30))))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  10 20 20 20 30 nil)


;;
;;  stream
;;
(defmacro test-inbyte-stream ((inst value) &body body)
  (let ((stream (gensym)))
    `(progn
       (with-open-file (,stream +debug-file+ :direction :output
                                :if-exists :supersede
                                :if-does-not-exist :create
                                :element-type '(unsigned-byte 8))
         (write-sequence ,value ,stream))
       (with-open-file (,stream +debug-file+ :direction :input
                                :element-type '(unsigned-byte 8))
         (let ((,inst (make-inbyte-stream ,stream)))
           ,@body)))))

(deftest inbyte-stream.1
  (test-inbyte-stream
    (inst #())
    (values
      (inbyte-now inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  nil nil nil nil)

(deftest inbyte-stream.2
  (test-inbyte-stream
    (inst #(10 20 30))
    (inbyte-now inst))
  nil)

(deftest inbyte-stream.3
  (test-inbyte-stream
    (inst #(10 20 30))
    (values
      (inbyte-next inst)
      (inbyte-now inst)))
  10 10)

(deftest inbyte-stream.4
  (test-inbyte-stream
    (inst #(10 20 30))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-now inst)))
  10 20 30 nil nil nil)

(deftest inbyte-stream.5
  (test-inbyte-stream
    (inst #(10 20 30))
    (values
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  nil 10 20)

(deftest inbyte-stream.6
  (test-inbyte-stream
    (inst #(10 20 30))
    (values
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-ungetc inst)
      (inbyte-next inst)
      (inbyte-next inst)
      (inbyte-next inst)))
  10 20 20 20 30 nil)

