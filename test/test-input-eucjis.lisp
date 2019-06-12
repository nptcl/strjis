(in-package #:strjis)

(deftest input-eucjis-convert.1
  (input-eucjis-convert #xA1 #xA2)
  #x2122)

(defun test-eucjis (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-eucjis input output)
    (charout-result output)))

(deftest input-eucjis.1
  (test-eucjis "")
  nil)

(deftest input-eucjis.2
  (test-eucjis "Hello")
  ((ascii #x48 #x65 #x6C #x6C #x6F)))

(deftest input-eucjis.3
  (test-eucjis #(#x0D #x41 #x42))
  ((control #x0D) (ascii #x41 #x42)))

(deftest input-eucjis.4
  (test-eucjis #(#x41 #x0D #x42 #x43))
  ((ascii #x41) (control #x0D) (ascii #x42 #x43)))

(deftest input-eucjis.5
  (test-eucjis #(#x41 #x0A #x42 #x43))
  ((ascii #x41) (control #x0A) (ascii #x42 #x43)))

(deftest input-eucjis.6
  (test-eucjis #(#x41 #x0A #x0D #x42 #x43))
  ((ascii #x41) (control #x0A #x0D) (ascii #x42 #x43)))

(deftest input-eucjis.7
  (test-eucjis #(#x41 #x0D #x0A #x42 #x43))
  ((ascii #x41) (control eol2) (ascii #x42 #x43)))

(deftest input-eucjis.8
  (test-eucjis #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((ascii #x41) (control #x0D eol2 #x0A) (ascii #x42 #x43)))

(deftest input-eucjis.9
  (test-eucjis #(#x41 #x0D #x1F #x42 #x43))
  ((ascii #x41) (control #x0D #x1F) (ascii #x42 #x43)))

(deftest input-eucjis.10
  (test-eucjis #(#x20 #x42 #x43))
  ((ascii #x20 #x42 #x43)))

(deftest input-eucjis.11
  (test-eucjis #(#x20 #x42 #x43 #x7E #x7F #x30))
  ((ascii #x20 #x42 #x43 #x7E) (control #x7F) (ascii #x30)))

(deftest-error input-eucjis.12
  (test-eucjis #(#x20 #x42 #x43 #x7E #x80 #x30)))

(deftest input-eucjis.13
  (test-eucjis #(#x20 #x42 #x43 #x7E #x80 #x30) :recovery)
  ((ascii #x20 #x42 #x43 #x7E) (error error) (ascii #x30)))

(deftest input-eucjis.14
  (test-eucjis #(#x20 #x42 #x43 #x7E #xA1 #xA1 #x30))
  ((ascii #x20 #x42 #x43 #x7E) (jis1 #x2121) (ascii #x30)))

(deftest input-eucjis.15
  (test-eucjis #(#xA1 #xA2 #x8F #xB1 #xB2))
  ((jis1 #x2122) (sub  #x3132)))

(deftest input-eucjis.16
  (test-eucjis #(#xA1 #xA2 #xFE #xFE #x8E #xA1 #x8E #xB1 #x0A #x40))
  ((jis1 #x2122 #x7E7E) (kana #x21 #x31) (control #x0A) (ascii #x40)))

(deftest input-eucjis.17
  (test-eucjis #(#xA1 #xA1 #xA1 #xFE #x8F #xA1 #xA2))
  ((jis1 #x2121 #x217E) (jis2 #x2122)))

(deftest-error input-eucjis.18
  (test-eucjis #(#xA1 #xA2 #x80 #xB1 #xB2 #x40)))

(deftest input-eucjis.19
  (test-eucjis #(#xA1 #xA1 #x80 #xB1 #xB2 #x40) :recovery)
  ((jis1 #x2121) (error error) (jis1 #x3132) (ascii #x40)))

(deftest-error input-eucjis.20
  (test-eucjis #(#xA1 #xA1 #xB1)))

(deftest input-eucjis.21
  (test-eucjis #(#xA1 #xA1 #xB1) :recovery)
  ((jis1 #x2121) (error error)))

(deftest-error input-eucjis.22
  (test-eucjis #(#xA1 #xA1 #x8F #xB1 #x10 #x30)))

(deftest input-eucjis.23
  (test-eucjis #(#xA1 #xA1 #x8F #xB1 #x10 #x30) :recovery)
  ((jis1 #x2121) (error error) (ascii #x30)))

;; kana
(deftest-error input-eucjis.24
  (test-eucjis #(#xA1 #xA1 #x8E)))

(deftest input-eucjis.25
  (test-eucjis #(#xA1 #xA1 #x8E) :recovery)
  ((jis1 #x2121) (error error)))

(deftest-error input-eucjis.26
  (test-eucjis #(#xA1 #xA1 #x8E #x9F)))

(deftest input-eucjis.27
  (test-eucjis #(#xA1 #xA1 #x8E #x9F) :recovery)
  ((jis1 #x2121) (error error)))

(deftest-error input-eucjis.28
  (test-eucjis #(#xA1 #xA1 #x8E #xE0)))

(deftest input-eucjis.29
  (test-eucjis #(#xA1 #xA1 #x8E #xE0) :recovery)
  ((jis1 #x2121) (error error)))

(deftest input-eucjis.30
  (test-eucjis #(#xA1 #xA1 #x8E #xA1 #x8E #xA2))
  ((jis1 #x2121) (kana #x21 #x22)))

(deftest input-eucjis.31
  (test-eucjis #(#xA1 #xA1 #x8E #xA0))
  ((jis1 #x2121) (kana #x20)))

(deftest input-eucjis.32
  (test-eucjis #(#xA1 #xA1 #x8E #xDF))
  ((jis1 #x2121) (kana #x5F)))

;; jis2
(deftest input-eucjis.33
  (test-eucjis #(#x8F #xA1 #xA2 #xA3 #xA4))
  ((jis2 #x2122) (jis1 #x2324)))

(deftest-error input-eucjis.34
  (test-eucjis #(#xA1 #xA2 #x8F #xA0 #xA4)))

(deftest input-eucjis.35
  (test-eucjis #(#xA1 #xA2 #x8F #xA0 #xA4) :recovery)
  ((jis1 #x2122) (error error error)))

(deftest-error input-eucjis.36
  (test-eucjis #(#xA1 #xA2 #x8F #xFF #xA4)))

(deftest input-eucjis.37
  (test-eucjis #(#xA1 #xA2 #x8F #xFF #xA4) :recovery)
  ((jis1 #x2122) (error error error)))

(deftest-error input-eucjis.38
  (test-eucjis #(#xA1 #xA2 #x8F #xA3 #xA0)))

(deftest input-eucjis.39
  (test-eucjis #(#xA1 #xA2 #x8F #xA3 #xA0) :recovery)
  ((jis1 #x2122) (error error)))

(deftest-error input-eucjis.40
  (test-eucjis #(#xA1 #xA2 #x8F #xA3 #xFF)))

(deftest input-eucjis.41
  (test-eucjis #(#xA1 #xA2 #x8F #xA3 #xFF) :recovery)
  ((jis1 #x2122) (error error)))

(deftest input-eucjis.42
  (test-eucjis #(#xA1 #xA2 #x8F #xA3 #xFE #x8F #xFE #xA1))
  ((jis1 #x2122) (jis2 #x237E #x7E21)))

(deftest input-eucjis.43
  (test-eucjis #(#x42 #x43 #x0A))
  ((ascii #x42 #x43) (control #x0A)))

(deftest input-eucjis.44
  (test-eucjis #(#x42 #x43 #x0D))
  ((ascii #x42 #x43) (control #x0D)))

(deftest input-eucjis.45
  (test-eucjis #(#x42 #x43 #x0D #x0A))
  ((ascii #x42 #x43) (control eol2)))

