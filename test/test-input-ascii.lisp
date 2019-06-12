(in-package #:strjis)

(defun test-ascii (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-ascii input output)
    (charout-result output)))

(deftest input-ascii.1
  (test-ascii "")
  nil)

(deftest input-ascii.2
  (test-ascii "Hello")
  ((ascii #x48 #x65 #x6C #x6C #x6F)))

(deftest input-ascii.3
  (test-ascii #(#x0D #x41 #x42))
  ((control #x0D) (ascii #x41 #x42)))

(deftest input-ascii.4
  (test-ascii #(#x41 #x0D #x42 #x43))
  ((ascii #x41) (control #x0D) (ascii #x42 #x43)))

(deftest input-ascii.5
  (test-ascii #(#x41 #x0A #x42 #x43))
  ((ascii #x41) (control #x0A) (ascii #x42 #x43)))

(deftest input-ascii.6
  (test-ascii #(#x41 #x0A #x0D #x42 #x43))
  ((ascii #x41) (control #x0A #x0D) (ascii #x42 #x43)))

(deftest input-ascii.7
  (test-ascii #(#x41 #x0D #x0A #x42 #x43))
  ((ascii #x41) (control eol2) (ascii #x42 #x43)))

(deftest input-ascii.8
  (test-ascii #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((ascii #x41) (control #x0D eol2 #x0A) (ascii #x42 #x43)))

(deftest input-ascii.9
  (test-ascii #(#x41 #x0D #x1F #x42 #x43))
  ((ascii #x41) (control #x0D #x1F) (ascii #x42 #x43)))

(deftest input-ascii.10
  (test-ascii #(#x20 #x42 #x43))
  ((ascii #x20 #x42 #x43)))

(deftest input-ascii.11
  (test-ascii #(#x20 #x42 #x43 #x7E #x7F #x30))
  ((ascii #x20 #x42 #x43 #x7E) (control #x7F) (ascii #x30)))

(deftest-error input-ascii.12
  (test-ascii #(#x20 #x42 #x43 #x7E #x80 #x30)))

(deftest input-ascii.13
  (test-ascii #(#x20 #x42 #x43 #x7E #x80 #x30) :recovery)
  ((ascii #x20 #x42 #x43 #x7E) (error error) (ascii #x30)))

(deftest input-ascii.14
  (test-ascii #(#x20 #x42 #x43 #x7E #xA1 #xA1 #x30) :recovery)
  ((ascii #x20 #x42 #x43 #x7E) (error error error) (ascii #x30)))

(deftest input-ascii.15
  (test-ascii #(#x42 #x43 #x0A))
  ((ascii #x42 #x43) (control #x0A)))

(deftest input-ascii.16
  (test-ascii #(#x42 #x43 #x0D))
  ((ascii #x42 #x43) (control #x0D)))

(deftest input-ascii.17
  (test-ascii #(#x42 #x43 #x0D #x0A))
  ((ascii #x42 #x43) (control eol2)))

