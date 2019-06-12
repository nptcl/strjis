(in-package #:strjis)
(use-package 'rt)

(defvar +debug-file+ #p"debug1.txt")
(defvar +debug-file2+ #p"debug2.txt")
(defvar +deftest-error+ (make-symbol "ERROR"))

(defmacro deftest-error (name expr &optional (error 'error))
  `(rt:deftest ,name
     (handler-case
       ,expr
       (,error () ',+deftest-error+))
     ,+deftest-error+))

(defun test-after ()
  (when (probe-file +debug-file+)
    (delete-file +debug-file+))
  (when (probe-file +debug-file2+)
    (delete-file +debug-file2+)))

(defun debug-file-list (v &optional (file +debug-file+))
  (with-open-file (input file :direction :input
                         :element-type `(unsigned-byte ,v))
    (do ((c (read-byte input nil nil)
            (read-byte input nil nil))
         list)
      ((null c) (nreverse list))
      (push c list))))

(defun coerce-stream-debug-value (x v args)
  (with-open-file (output +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :element-type `(unsigned-byte ,v))
    (apply #'coerce-stream x output args))
  (debug-file-list v))

(defun coerce-stream-debug (x &rest args)
  (coerce-stream-debug-value x 8 args))

(defun coerce-stream-debug16 (x &rest args)
  (coerce-stream-debug-value x 16 args))

(defun coerce-stream-debug32 (x &rest args)
  (coerce-stream-debug-value x 16 args))

