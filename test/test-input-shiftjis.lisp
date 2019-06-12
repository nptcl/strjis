(in-package #:strjis)

(deftest input-shiftjis-second.1
  (values
    (typep #x3F 'input-shiftjis-second)
    (typep #x40 'input-shiftjis-second)
    (typep #x7E 'input-shiftjis-second)
    (typep #x7F 'input-shiftjis-second)
    (typep #x80 'input-shiftjis-second)
    (typep #xFC 'input-shiftjis-second)
    (typep #xFD 'input-shiftjis-second))
  nil t t nil t t nil)

(defun input-shiftjis1-test (a b)
  (let ((inst (make-instance 'charout-group)))
    (input-shiftjis1 inst a b)
    (let ((pos (charout-result inst)))
      (unless (= (length pos) 1)
        (error "list length error"))
      (setq pos (car pos))
      (destructuring-bind (type . list) pos
        (unless (eq type 'jis1)
          (error "type error"))
        (unless (= (length list) 1)
          (error "jis length error"))
        (car list)))))

(deftest input-shiftjis1.1
  (input-shiftjis1-test #x81 #x40)
  #x2121)

(deftest input-shiftjis1.2
  (input-shiftjis1-test #x81 #x41)
  #x2122)

(deftest input-shiftjis1.3
  (input-shiftjis1-test #x81 #x7E)
  #x215F)

(deftest input-shiftjis1.4
  (input-shiftjis1-test #x81 #x80)
  #x2160)

(deftest input-shiftjis1.5
  (input-shiftjis1-test #x81 #x9E)
  #x217E)

(deftest input-shiftjis1.6
  (input-shiftjis1-test #x81 #x9F)
  #x2221)

(deftest input-shiftjis1.7
  (input-shiftjis1-test #x81 #xFC)
  #x227E)

(deftest input-shiftjis1.8
  (input-shiftjis1-test #x82 #x40)
  #x2321)

(deftest input-shiftjis1.9
  (input-shiftjis1-test #x9F #xFC)
  #x5E7E)

(deftest input-shiftjis1.10
  (input-shiftjis1-test #xE0 #x40)
  #x5F21)

(deftest input-shiftjis1.11
  (input-shiftjis1-test #xE0 #x7E)
  #x5F5F)

(deftest input-shiftjis1.12
  (input-shiftjis1-test #xE0 #x80)
  #x5F60)

(deftest input-shiftjis1.13
  (input-shiftjis1-test #xE0 #x9E)
  #x5F7E)

(deftest input-shiftjis1.14
  (input-shiftjis1-test #xE0 #x9F)
  #x6021)

(deftest input-shiftjis1.15
  (input-shiftjis1-test #xEF #xFC)
  #x7E7E)

(deftest input-shiftjis2-first.1
  (input-shiftjis2-first nil #xF0)
  #x21)

(deftest input-shiftjis2-first.3
  (input-shiftjis2-first nil #xF1)
  #x23)

(deftest input-shiftjis2-first.4
  (input-shiftjis2-first t   #xF1)
  #x24)

(deftest input-shiftjis2-first.5
  (input-shiftjis2-first nil #xF2)
  #x25)

(deftest input-shiftjis2-first.8
  (input-shiftjis2-first t   #xF0)
  #x28)

(deftest input-shiftjis2-first.c
  (input-shiftjis2-first t   #xF2)
  #x2C)

(deftest input-shiftjis2-first.d
  (input-shiftjis2-first nil #xF3)
  #x2D)

(deftest input-shiftjis2-first.e
  (input-shiftjis2-first t   #xF3)
  #x2E)

(deftest input-shiftjis2-first.f
  (input-shiftjis2-first nil #xF4)
  #x2F)

(defun input-shiftjis2-test (a b)
  (let ((inst (make-instance 'charout-group)))
    (input-shiftjis2 inst a b)
    (let ((pos (charout-result inst)))
      (unless (= (length pos) 1)
        (error "list length error"))
      (setq pos (car pos))
      (destructuring-bind (type . list) pos
        (unless (eq type 'jis2)
          (error "type error"))
        (unless (= (length list) 1)
          (error "jis length error"))
        (car list)))))

(deftest input-shiftjis2.1
  (input-shiftjis2-test #xF0 #x40)
  #x2121)

(deftest input-shiftjis2.2
  (input-shiftjis2-test #xF0 #x4E)
  #x212F)

(deftest input-shiftjis2.3
  (input-shiftjis2-test #xF0 #x4F)
  #x2130)

(deftest input-shiftjis2.4
  (input-shiftjis2-test #xF0 #x7E)
  #x215F)

(deftest input-shiftjis2.5
  (input-shiftjis2-test #xF0 #x80)
  #x2160)

(deftest input-shiftjis2.6
  (input-shiftjis2-test #xF0 #x9E)
  #x217E)

(deftest input-shiftjis2.7
  (input-shiftjis2-test #xF1 #x40)
  #x2321)

(deftest input-shiftjis2.8
  (input-shiftjis2-test #xF1 #x9E)
  #x237E)

(deftest input-shiftjis2.9
  (input-shiftjis2-test #xF2 #x40)
  #x2521)

(deftest input-shiftjis2.10
  (input-shiftjis2-test #xF0 #x9F)
  #x2821)

(deftest input-shiftjis2.11
  (input-shiftjis2-test #xF0 #xFC)
  #x287E)

(deftest input-shiftjis2.12
  (input-shiftjis2-test #xF2 #x9F)
  #x2C21)

(deftest input-shiftjis2.13
  (input-shiftjis2-test #xF3 #x40)
  #x2D21)

(deftest input-shiftjis2.14
  (input-shiftjis2-test #xF3 #x9F)
  #x2E21)

(deftest input-shiftjis2.15
  (input-shiftjis2-test #xF4 #x40)
  #x2F21)

(deftest input-shiftjis2.16
  (input-shiftjis2-test #xF4 #x9F)
  #x6E21)

(deftest input-shiftjis2.17
  (input-shiftjis2-test #xF5 #x40)
  #x6F21)

(deftest input-shiftjis2.18
  (input-shiftjis2-test #xF5 #x9F)
  #x7021)

(deftest input-shiftjis2.19
  (input-shiftjis2-test #xF6 #x40)
  #x7121)

(deftest input-shiftjis2.20
  (input-shiftjis2-test #xF6 #x9F)
  #x7221)

(deftest input-shiftjis2.21
  (input-shiftjis2-test #xF7 #x40)
  #x7321)

(deftest input-shiftjis2.22
  (input-shiftjis2-test #xF7 #x9F)
  #x7421)

(deftest input-shiftjis2.23
  (input-shiftjis2-test #xF8 #x40)
  #x7521)

(deftest input-shiftjis2.24
  (input-shiftjis2-test #xF8 #x9F)
  #x7621)

(deftest input-shiftjis2.25
  (input-shiftjis2-test #xF9 #x40)
  #x7721)

(deftest input-shiftjis2.26
  (input-shiftjis2-test #xF9 #x9F)
  #x7821)

(deftest input-shiftjis2.27
  (input-shiftjis2-test #xFA #x40)
  #x7921)

(deftest input-shiftjis2.28
  (input-shiftjis2-test #xFA #x9F)
  #x7A21)

(deftest input-shiftjis2.29
  (input-shiftjis2-test #xFB #x40)
  #x7B21)

(deftest input-shiftjis2.30
  (input-shiftjis2-test #xFB #x9F)
  #x7C21)

(deftest input-shiftjis2.31
  (input-shiftjis2-test #xFC #x40)
  #x7D21)

(deftest input-shiftjis2.32
  (input-shiftjis2-test #xFC #x9F)
  #x7E21)

(deftest input-shiftjis2.33
  (input-shiftjis2-test #xFC #xF4)
  #x7E76)

(deftest input-shiftjis-convert.1
  (let ((inst (make-instance 'charout-group)))
    (input-shiftjis-convert inst #xEF #xFC)
    (charout-result inst))
  ((jis1 #x7E7E)))

(deftest input-shiftjis-convert.2
  (let ((inst (make-instance 'charout-group)))
    (input-shiftjis-convert inst #xF0 #x40)
    (charout-result inst))
  ((jis2 #x2121)))


;; input-shiftjis
(defun test-shiftjis (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-shiftjis input output)
    (charout-result output)))

(deftest input-shiftjis.1
  (test-shiftjis "")
  nil)

(deftest input-shiftjis.2
  (test-shiftjis "Hello")
  ((ascii #x48 #x65 #x6C #x6C #x6F)))

(deftest input-shiftjis.3
  (test-shiftjis #(#x0D #x41 #x42))
  ((control #x0D) (ascii #x41 #x42)))

(deftest input-shiftjis.4
  (test-shiftjis #(#x41 #x0D #x42 #x43))
  ((ascii #x41) (control #x0D) (ascii #x42 #x43)))

(deftest input-shiftjis.5
  (test-shiftjis #(#x41 #x0A #x42 #x43))
  ((ascii #x41) (control #x0A) (ascii #x42 #x43)))

(deftest input-shiftjis.6
  (test-shiftjis #(#x41 #x0A #x0D #x42 #x43))
  ((ascii #x41) (control #x0A #x0D) (ascii #x42 #x43)))

(deftest input-shiftjis.7
  (test-shiftjis #(#x41 #x0D #x0A #x42 #x43))
  ((ascii #x41) (control eol2) (ascii #x42 #x43)))

(deftest input-shiftjis.8
  (test-shiftjis #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((ascii #x41) (control #x0D eol2 #x0A) (ascii #x42 #x43)))

(deftest input-shiftjis.9
  (test-shiftjis #(#x41 #x0D #x1F #x42 #x43))
  ((ascii #x41) (control #x0D #x1F) (ascii #x42 #x43)))

(deftest input-shiftjis.10
  (test-shiftjis #(#x20 #x42 #x43))
  ((ascii #x20 #x42 #x43)))

(deftest input-shiftjis.11
  (test-shiftjis #(#x20 #x42 #x43 #x7E #x7F #x30))
  ((ascii #x20 #x42 #x43 #x7E) (control #x7F) (ascii #x30)))

(deftest-error input-shiftjis.12
  (test-shiftjis #(#x20 #x42 #x43 #x7E #x80 #x30)))

(deftest input-shiftjis.13
  (test-shiftjis #(#x20 #x42 #x43 #x7E #x80 #x30) :recovery)
  ((ascii #x20 #x42 #x43 #x7E) (error error) (ascii #x30)))

(deftest input-shiftjis.14
  (test-shiftjis #(#x20 #x42 #x43 #x7E #x81 #x40 #x30))
  ((ascii #x20 #x42 #x43 #x7E) (jis1 #x2121) (ascii #x30)))

(deftest input-shiftjis.15
  (test-shiftjis #(#x81 #x40 #xE0 #x9F))
  ((jis1 #x2121 #x6021)))

(deftest input-shiftjis.16
  (test-shiftjis #(#x81 #x40 #xE0 #x9F #xA1 #xDF #x0A #x40))
  ((jis1 #x2121 #x6021) (kana #x21 #x5F) (control #x0A) (ascii #x40)))

(deftest input-shiftjis.17
  (test-shiftjis #(#x81 #x40 #xE0 #x9F #xF0 #x40))
  ((jis1 #x2121 #x6021) (jis2 #x2121)))

(deftest-error input-shiftjis.18
  (test-shiftjis #(#x81 #x40 #xFF #x9F #xF0 #x40)))

(deftest input-shiftjis.19
  (test-shiftjis #(#x81 #x40 #xFF #x9F #xF0 #x40) :recovery)
  ((jis1 #x2121) (error error) (jis1 #x5E72) (ascii #x40)))

(deftest-error input-shiftjis.20
  (test-shiftjis #(#x81 #x40 #xE0)))

(deftest input-shiftjis.21
  (test-shiftjis #(#x81 #x40 #xE0) :recovery)
  ((jis1 #x2121) (error error)))

(deftest-error input-shiftjis.22
  (test-shiftjis #(#x81 #x40 #xE0 #x10 #x30)))

(deftest input-shiftjis.23
  (test-shiftjis #(#x81 #x40 #xE0 #x10 #x30) :recovery)
  ((jis1 #x2121) (error error) (ascii #x30)))

(deftest input-shiftjis.24
  (test-shiftjis #(#x42 #x43 #x0A))
  ((ascii #x42 #x43) (control #x0A)))

(deftest input-shiftjis.25
  (test-shiftjis #(#x42 #x43 #x0D))
  ((ascii #x42 #x43) (control #x0D)))

(deftest input-shiftjis.26
  (test-shiftjis #(#x42 #x43 #x0D #x0A))
  ((ascii #x42 #x43) (control eol2)))

