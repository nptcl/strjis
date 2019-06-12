(in-package #:strjis)

;;
;;  input-utf32v
;;
(defun test-utf32v (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf32v input output)
    (charout-result output)))

(deftest input-utf32v.1
  (test-utf32v "")
  nil)

(deftest input-utf32v.2
  (test-utf32v "Hello")
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf32v.3
  (test-utf32v #(#x0D #x41 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf32v.4
  (test-utf32v #(#x41 #x0D #x42 #x43))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf32v.5
  (test-utf32v #(#x41 #x0A #x42 #x43))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf32v.6
  (test-utf32v #(#x41 #x0A #x0D #x42 #x43))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf32v.7
  (test-utf32v #(#x41 #x0D #x0A #x42 #x43))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf32v.8
  (test-utf32v #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf32v.9
  (test-utf32v #(#x41 #x0D #x1F #x42 #x43))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf32v.10
  (test-utf32v #(#x42 #x43 #x0A))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf32v.11
  (test-utf32v #(#x42 #x43 #x0D))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf32v.12
  (test-utf32v #(#x42 #x43 #x0D #x0A))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf32v.13
  (test-utf32v #(#x20 #x42 #x43))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf32v.14
  (test-utf32v #(#x20 #x3000 #x3001))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf32v.15
  (test-utf32v #(#x20 #xD800 #x3001) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf32v.16
  (test-utf32v #(#x20 #x10FFFF #x3001))
  ((unicode #x20 #x10FFFF #x3001))) ;(jis1 #x2122)

(deftest-error input-utf32v.17
  (test-utf32v #(#x20 #x110000 #x3001)))

(deftest input-utf32v.18
  (test-utf32v #(#x20 #x110000 #x3001) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)


;;
;;  input-utf32le
;;
(defun test-utf32le (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf32le input output)
    (charout-result output)))

(deftest input-utf32le.1
  (test-utf32le #())
  nil)

(deftest input-utf32le.2
  (test-utf32le #(#x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00  #x6C #x00 #x00 #x00
                  #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf32le.3
  (test-utf32le #(#x0D #x00 #x00 #x00  #x41 #x00 #x00 #x00  #x42 #x00 #x00 #x00))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf32le.4
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0D #x00 #x00 #x00
                  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf32le.5
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0A #x00 #x00 #x00
                  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf32le.6
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0A #x00 #x00 #x00  #x0D #x00 #x00 #x00
                  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf32le.7
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0D #x00 #x00 #x00  #x0A #x00 #x00 #x00
                  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf32le.8
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0D #x00 #x00 #x00  #x0D #x00 #x00 #x00
                  #x0A #x00 #x00 #x00  #x0A #x00 #x00 #x00  #x42 #x00 #x00 #x00
                  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf32le.9
  (test-utf32le #(#x41 #x00 #x00 #x00  #x0D #x00 #x00 #x00  #x1F #x00 #x00 #x00
                  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf32le.10
  (test-utf32le #(#x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00  #x0A #x00 #x00 #x00))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf32le.11
  (test-utf32le #(#x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00  #x0D #x00 #x00 #x00))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf32le.12
  (test-utf32le #(#x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00
                  #x0D #x00 #x00 #x00  #x0A #x00 #x00 #x00))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf32le.13
  (test-utf32le #(#x20 #x00 #x00 #x00  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf32le.14
  (test-utf32le #(#x20 #x00 #x00 #x00  #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf32le.15
  (test-utf32le #(#x20 #x00 #x00 #x00  #x00 #xD8 #x00 #x00
                  #x01 #x30 #x00 #x00) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf32le.16
  (test-utf32le #(#x20 #x00 #x00 #x00  #xFF #xFF #x10 #x00  #x01 #x30 #x00 #x00))
  ((unicode #x20 #x10FFFF #x3001))) ;(jis1 #x2122)

(deftest-error input-utf32le.17
  (test-utf32le #(#x20 #x00 #x00 #x00  #x00 #x00 #x11 #x00  #x01 #x30 #x00 #x00)))

(deftest input-utf32le.18
  (test-utf32le #(#x20 #x00 #x00 #x00  #x00 #x00 #x11 #x00
                  #x01 #x30 #x00 #x00) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

;;  eof-error
(deftest input-utf32le.19
  (test-utf32le #(#x20) :recovery)
  ((error error)))

(deftest input-utf32le.20
  (test-utf32le #(#x0D #x00) :recovery)
  ((error error)))

(deftest input-utf32le.21
  (test-utf32le #(#x0D #x00 #x00) :recovery)
  ((error error)))

(deftest input-utf32le.22
  (test-utf32le #(#x0D #x00 #x00 #x00 #x0A) :recovery)
  ((error error)))


;;
;;  input-utf32be
;;
(defun test-utf32be (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf32be input output)
    (charout-result output)))

(deftest input-utf32be.1
  (test-utf32be #())
  nil)

(deftest input-utf32be.2
  (test-utf32be #(#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
                  #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf32be.3
  (test-utf32be #(#x00 #x00 #x00 #x0D  #x00 #x00 #x00 #x41  #x00 #x00 #x00 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf32be.4
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0D
                  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf32be.5
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0A
                  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf32be.6
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0A  #x00 #x00 #x00 #x0D
                  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf32be.7
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0D  #x00 #x00 #x00 #x0A
                  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf32be.8
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0D  #x00 #x00 #x00 #x0D
                  #x00 #x00 #x00 #x0A  #x00 #x00 #x00 #x0A  #x00 #x00 #x00 #x42
                  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf32be.9
  (test-utf32be #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x0D  #x00 #x00 #x00 #x1F
                  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf32be.10
  (test-utf32be #(#x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43  #x00 #x00 #x00 #x0A))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf32be.11
  (test-utf32be #(#x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43  #x00 #x00 #x00 #x0D))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf32be.12
  (test-utf32be #(#x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43
                  #x00 #x00 #x00 #x0D  #x00 #x00 #x00 #x0A))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf32be.13
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf32be.14
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf32be.15
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x00 #xD8 #x00
                  #x00 #x00 #x30 #x01) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf32be.16
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x10 #xFF #xFF  #x00 #x00 #x30 #x01))
  ((unicode #x20 #x10FFFF #x3001))) ;(jis1 #x2122)

(deftest-error input-utf32be.17
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x11 #x00 #x00  #x00 #x00 #x30 #x01)))

(deftest input-utf32be.18
  (test-utf32be #(#x00 #x00 #x00 #x20  #x00 #x11 #x00 #x00
                  #x00 #x00 #x30 #x01) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

;;  eof-error
(deftest input-utf32be.19
  (test-utf32be #(#x20) :recovery)
  ((error error)))

(deftest input-utf32be.20
  (test-utf32be #(#x00 #x00) :recovery)
  ((error error)))

(deftest input-utf32be.21
  (test-utf32be #(#x00 #x00 #x00) :recovery)
  ((error error)))

(deftest input-utf32be.22
  (test-utf32be #(#x00 #x00 #x00 #x0D #x00) :recovery)
  ((error error)))

;;  bom
(defun test-utf32 (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf32 input output)
    (charout-result output)))

(deftest input-utf32.1
  (test-utf32 #(#x00 #x00 #x00 #x41  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((unicode #x41 #x42 #x43)))

(deftest input-utf32.2
  (test-utf32 #(#x00 #x00 #xFE #xFF
                #x00 #x00 #x00 #x41  #x00 #x00 #x00 #x42  #x00 #x00 #x00 #x43))
  ((control bom) (unicode #x41 #x42 #x43)))

(deftest input-utf32.3
  (test-utf32 #(#xFF #xFE #x00 #x00
                #x41 #x00 #x00 #x00  #x42 #x00 #x00 #x00  #x43 #x00 #x00 #x00))
  ((control bom) (unicode #x41 #x42 #x43)))

(deftest input-utf32.4
  (test-utf32 #(#xFF) :recovery)
  ((error error)))

(deftest input-utf32.5
  (test-utf32 #(#xFF #xFE) :recovery)
  ((error error)))

(deftest input-utf32.6
  (test-utf32 #(#xFF #xFE #x00) :recovery)
  ((error error)))

(deftest input-utf32.7
  (test-utf32 #(#xFF #xFE #x00 #x00 #x41) :recovery)
  ((control bom) (error error)))

