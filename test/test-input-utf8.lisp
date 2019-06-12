(in-package #:strjis)

;;
;;  input-utf8
;;
(defun test-utf8 (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf8 input output)
    (charout-result output)))

(deftest input-utf8.1
  (test-utf8 "")
  nil)

(deftest input-utf8.2
  (test-utf8 "Hello")
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf8.3
  (test-utf8 #(#x0D #x41 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf8.4
  (test-utf8 #(#x41 #x0D #x42 #x43))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf8.5
  (test-utf8 #(#x41 #x0A #x42 #x43))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf8.6
  (test-utf8 #(#x41 #x0A #x0D #x42 #x43))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf8.7
  (test-utf8 #(#x41 #x0D #x0A #x42 #x43))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf8.8
  (test-utf8 #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf8.9
  (test-utf8 #(#x41 #x0D #x1F #x42 #x43))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf8.10
  (test-utf8 #(#x42 #x43 #x0A))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf8.11
  (test-utf8 #(#x42 #x43 #x0D))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf8.12
  (test-utf8 #(#x42 #x43 #x0D #x0A))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf8.13
  (test-utf8 #(#x20 #x42 #x43))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf8.14
  (test-utf8 #(#xEF #xBB #xBF #x21))
  ((control bom) (unicode #x21)))

(deftest input-utf8.15
  (test-utf8 #(#x21 #xC2 #x80 #xDF #xBF))
  ((unicode #x21 #x80 #x07FF)))

(deftest input-utf8.16
  (test-utf8 #(#x21 #xE0 #xA0 #x80 #xEF #xBF #xBF))
  ((unicode #x21 #x0800 #xFFFF)))

(deftest input-utf8.17
  (test-utf8 #(#x21 #xF0 #x90 #x80 #x80 #xF4 #x8F #xBF #xBF))
  ((unicode #x21 #x010000 #x10FFFF)))

(deftest-error input-utf8.18
  (test-utf8 #(#x21 #xF0 #x90 #x80 #x80 #xF7 #xBF #xBF #xBF)))

(deftest-error input-utf8.19
  (test-utf8 #(#x21 #xF8 #x88 #x80 #x80 #x80 #xFB #xBF #xBF #xBF #xBF)))

(deftest input-utf8.20
  (test-utf8 #(#x21 #xF8 #x88 #x80 #x80 #x80 #xFB #xBF #xBF #xBF #xBF) :recovery)
  ((unicode #x21) (error error error)))

(deftest-error input-utf8.21
  (test-utf8 #(#x21 #xFC #x84 #x80 #x80 #x80 #x80 #xFD #xBF #xBF #xBF #xBF #xBF)))

(deftest input-utf8.22
  (test-utf8
    #(#x21 #xFC #x84 #x80 #x80 #x80 #x80 #xFD #xBF #xBF #xBF #xBF #xBF)
    :recovery)
  ((unicode #x21) (error error error))) ;(unicode #x04000000 #x7FFFFFFF)

(deftest-error input-utf8.23
  (test-utf8 #(#x21 #xC0 #xA1)))

(deftest input-utf8.24
  (test-utf8 #(#x21 #xC0 #xA1) :recovery)
  ((unicode #x21) (error error)))

(deftest input-utf8.25
  (test-utf8 #(#x21
               #xE0 #x80 #xA1
               #xF0 #x80 #x80 #xA1
               #xF8 #x80 #x80 #x80 #xA1
               #xFC #x80 #x80 #x80 #x80 #xA1) :recovery)
  ((unicode #x21) (error error error error error)))

(deftest-error input-utf8.26
  (test-utf8 #(#x21 #x80)))

(deftest input-utf8.27
  (test-utf8 #(#x21 #x80) :recovery)
  ((unicode #x21) (error error)))

(deftest input-utf8.28
  (test-utf8 #(#x21 #x80 #x22) :recovery)
  ((unicode #x21) (error error) (unicode #x22)))

(deftest input-utf8.29
  (test-utf8 #(#x21 #x80 #x81 #x22) :recovery)
  ((unicode #x21) (error error error) (unicode #x22)))

(deftest input-utf8.30
  (test-utf8 #(#x21 #x80 #x81) :recovery)
  ((unicode #x21) (error error error)))

