(in-package #:strjis)

(deftest input-jis1.1
  (input-jis1 #x21 #x22)
  #x2122)

(defun input-jis2-test (a b)
  (let ((inst (make-instance 'charout-group)))
    (input-jis2 inst a b)
    (car (charout-result inst))))

(deftest input-jis2.1
  (input-jis2-test #x21 #x22)
  (jis2 #x2122))

(deftest input-jis2.2
  (input-jis2-test #x22 #x21)
  (sub #x2221))

(deftest input-jis2.3
  (input-jis2-test #x23 #x50)
  (jis2 #x2350))

(deftest input-jis2.4
  (input-jis2-test #x2F #x7E)
  (jis2 #x2F7E))

(deftest input-jis2.5
  (input-jis2-test #x30 #x7E)
  (sub #x307E))

(deftest input-jis2.6
  (input-jis2-test #x6D #x7E)
  (sub #x6D7E))

(deftest input-jis2.7
  (input-jis2-test #x6E #x7E)
  (jis2 #x6E7E))

(defun test-jis (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-jis input output)
    (charout-result output)))

(deftest input-jis.1
  (test-jis "")
  nil)

(deftest input-jis.2
  (test-jis "Hello")
  ((ascii #x48 #x65 #x6C #x6C #x6F)))

(deftest input-jis.3
  (test-jis #(#x0D #x41 #x42))
  ((control #x0D) (ascii #x41 #x42)))

(deftest input-jis.4
  (test-jis #(#x41 #x0D #x42 #x43))
  ((ascii #x41) (control #x0D) (ascii #x42 #x43)))

(deftest input-jis.5
  (test-jis #(#x41 #x0A #x42 #x43))
  ((ascii #x41) (control #x0A) (ascii #x42 #x43)))

(deftest input-jis.6
  (test-jis #(#x41 #x0A #x0D #x42 #x43))
  ((ascii #x41) (control #x0A #x0D) (ascii #x42 #x43)))

(deftest input-jis.7
  (test-jis #(#x41 #x0D #x0A #x42 #x43))
  ((ascii #x41) (control eol2) (ascii #x42 #x43)))

(deftest input-jis.8
  (test-jis #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((ascii #x41) (control #x0D eol2 #x0A) (ascii #x42 #x43)))

(deftest input-jis.9
  (test-jis #(#x41 #x0D #x1F #x42 #x43))
  ((ascii #x41) (control #x0D #x1F) (ascii #x42 #x43)))

(deftest input-jis.10
  (test-jis #(#x20 #x42 #x43))
  ((ascii #x20 #x42 #x43)))

(deftest input-jis.11
  (test-jis #(#x20 #x42 #x43 #x7E #x7F #x30))
  ((ascii #x20 #x42 #x43 #x7E) (control #x7F) (ascii #x30)))

(deftest-error input-jis.12
  (test-jis #(#x20 #x42 #x43 #x7E #x80 #x30)))

(deftest input-jis.13
  (test-jis #(#x20 #x42 #x43 #x7E #x80 #x30) :recovery)
  ((ascii #x20 #x42 #x43 #x7E) (error error) (ascii #x30)))

(deftest input-jis.14
  (test-jis #(#x42 #x43 #x0A))
  ((ascii #x42 #x43) (control #x0A)))

(deftest input-jis.15
  (test-jis #(#x42 #x43 #x0D))
  ((ascii #x42 #x43) (control #x0D)))

(deftest input-jis.16
  (test-jis #(#x42 #x43 #x0D #x0A))
  ((ascii #x42 #x43) (control eol2)))

(deftest input-jis.17
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x40 #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis1 #x2122 #x7D7E)))

(deftest input-jis.18
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x42 #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis1 #x2122 #x7D7E)))

(deftest input-jis.19
  (test-jis
    #(#x42 #x43 #x0D #x0A #x1B #x26 #x40 #x1B #x24 #x42 #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis1 #x2122 #x7D7E)))

(deftest input-jis.20
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x28 #x4F #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis1 #x2122 #x7D7E)))

(deftest input-jis.21
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x28 #x51 #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis1 #x2122 #x7D7E)))

(deftest input-jis.22
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x28 #x50 #x21 #x22 #x7D #x7E))
  ((ascii #x42 #x43) (control eol2) (jis2 #x2122 #x7D7E)))

(deftest input-jis.23
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x28 #x50 #x21 #x22 #x30 #x7E))
  ((ascii #x42 #x43) (control eol2) (jis2 #x2122) (sub #x307E)))

(deftest input-jis.24
  (test-jis #(#x42 #x43 #x0D #x0A #x1B #x24 #x28 #x44 #x21 #x22 #x30 #x7E))
  ((ascii #x42 #x43) (control eol2) (jis2 #x2122) (sub #x307E)))

(deftest input-jis.25
  (test-jis #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x42 #x42 #x43))
  ((jis1 #x2122) (ascii #x42 #x43)))

(deftest input-jis.26
  (test-jis #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x49 #x21 #x5F))
  ((jis1 #x2122) (kana #x21 #x5F)))

(deftest input-jis.27
  (test-jis #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x42 #xA1 #xDF))
  ((jis1 #x2122) (kana #x21 #x5F)))

(deftest input-jis.28
  (test-jis #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x4A #xA1 #xDF))
  ((jis1 #x2122) (kana #x21 #x5F)))

(deftest input-jis.29
  (test-jis
    #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x42 #x42 #x0E #x21 #x5F #x0F #x43))
  ((jis1 #x2122) (ascii #x42) (kana #x21 #x5F) (ascii #x43)))

(deftest input-jis.30
  (test-jis #(#x1B #x24 #x28 #x50 #x21 #x22 #x31 #x32))
  ((jis2 #x2122) (sub #x3132)))

(deftest input-jis.31
  (test-jis #(#x1B #x24 #x28 #x44 #x21 #x22 #x31 #x32))
  ((jis2 #x2122) (sub #x3132)))

(deftest input-jis.32
  (let ((*kana-shift* nil))
    (test-jis
      #(#x1B #x24 #x40 #x21 #x22 #x1B #x28 #x42 #x42 #x0E #x21 #x5F #x0F #x43)))
  ((jis1 #x2122)
   (ascii #x42) (control #x0E) (ascii #x21 #x5F) (control #x0F) (ascii #x43)))

;; error
(deftest-error input-jis.33
  (test-jis #(#xFF #x41)))

(deftest input-jis.34
  (test-jis #(#xFF #x41) :recovery)
  ((error error) (ascii #x41)))

(deftest-error input-jis.35
  (test-jis #(#x1B #x28 #x42 #x41 #x7F #x80)))

(deftest input-jis.36
  (test-jis #(#x1B #x28 #x42 #x41 #x7F #x80) :recovery)
  ((ascii #x41) (control #x7F) (error error)))

(deftest-error input-jis.37
  (test-jis #(#x1B #x28 #x42 #x41 #x1B #xFF #xFC)))

(deftest input-jis.38
  (test-jis #(#x1B #x28 #x42 #x41 #x1B #xFF #xFC) :recovery)
  ((ascii #x41) (error error)))

(deftest input-jis.39
  (test-jis
    #(#x1B #x28 #x42 #x41 #x1B #xFF #xFC #x1B #x28 #x49 #x21) :recovery)
  ((ascii #x41) (error error) (kana #x21)))

(deftest input-jis.40
  (test-jis
    #(#x1B #x28 #x49 #x21
      #x1B #x24 #x40      #x21 #x22 #x23 #xFF #x25 #x26 #x27 #x00
      #x1B #x24 #x28 #x50 #x21 #x22 #x23 #xFF #x25 #x26 #x27 #x00) :recovery)
  ((kana #x21)
   (jis1 #x2122) (error error) (jis1 #x2526) (error error)
   (jis2 #x2122) (error error) (jis2 #x2526) (error error)))

