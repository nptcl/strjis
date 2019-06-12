(in-package #:strjis)

;;
;;  input-utf16v
;;
(deftest input-utf16-merge.1
  (input-utf16-merge #xD800 #xDC00)
  #x010000)

(deftest input-utf16-merge.2
  (input-utf16-merge #xDBFF #xDFFF)
  #x10FFFF)

(deftest input-utf16-merge.3
  (input-utf16-merge #xDBFF #xDC00)
  #x10FC00)

(deftest input-utf16-merge.4
  (input-utf16-merge #xD800 #xDFFF)
  #x0103FF)

(defun test-utf16v (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf16v input output)
    (charout-result output)))

(deftest input-utf16v.1
  (test-utf16v "")
  nil)

(deftest input-utf16v.2
  (test-utf16v "Hello")
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf16v.3
  (test-utf16v #(#x0D #x41 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf16v.4
  (test-utf16v #(#x41 #x0D #x42 #x43))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf16v.5
  (test-utf16v #(#x41 #x0A #x42 #x43))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf16v.6
  (test-utf16v #(#x41 #x0A #x0D #x42 #x43))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf16v.7
  (test-utf16v #(#x41 #x0D #x0A #x42 #x43))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf16v.8
  (test-utf16v #(#x41 #x0D #x0D #x0A #x0A #x42 #x43))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf16v.9
  (test-utf16v #(#x41 #x0D #x1F #x42 #x43))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf16v.10
  (test-utf16v #(#x42 #x43 #x0A))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf16v.11
  (test-utf16v #(#x42 #x43 #x0D))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf16v.12
  (test-utf16v #(#x42 #x43 #x0D #x0A))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf16v.13
  (test-utf16v #(#x20 #x42 #x43))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf16v.14
  (test-utf16v #(#x20 #x3000 #x3001))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf16v.15
  (test-utf16v #(#x20 #xD7FF #xE000 #xFFFF #x3001) :recovery)
  ((unicode #x20 #xD7FF #xE000 #xFFFF #x3001))) ;(jis1 #x2122)

(deftest input-utf16v.16
  (test-utf16v #(#x20 #xDC00 #xDFFF #x010000 #x3001) :recovery)
  ((unicode #x20) (error error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16v.17
  (test-utf16v #(#x20 #xD800 #xD800 #xDBFF #xDBFF #x3001) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16v.18
  (test-utf16v #(#x20 #x10FFFF #x3001) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16v.19
  (test-utf16v #(#x20 #x100000 #x3001) :recovery)
  ((unicode #x20) (error error) (unicode #x3001)))

(deftest input-utf16v.20
  (test-utf16v #(#x20 #xD800 #xDC00 #xDBFF #xDFFF #x3001))
  ((unicode #x20 #x010000 #x10FFFF #x3001)))

(deftest input-utf16v.21
  (test-utf16v #(#x20 #xDBFF #xDC00 #xD800 #xDFFF #x3001))
  ((unicode #x20 #x10FC00 #x0103FF #x3001)))

(deftest input-utf16v.22
  (test-utf16v #(#x20 #xD900 #xDBFF #xDA00 #xE000 #x3001) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001)))


;;
;;  input-utf16le
;;
(defun test-utf16le (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf16le input output)
    (charout-result output)))

(deftest input-utf16le.1
  (test-utf16le #())
  nil)

(deftest input-utf16le.2
  (test-utf16le #(#x48 #x00 #x65 #x00 #x6C #x00 #x6C #x00 #x6F #x00))
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf16le.3
  (test-utf16le #(#x0D #x00 #x41 #x00 #x42 #x00))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf16le.4
  (test-utf16le #(#x41 #x00 #x0D #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf16le.5
  (test-utf16le #(#x41 #x00 #x0A #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf16le.6
  (test-utf16le #(#x41 #x00 #x0A #x00 #x0D #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf16le.7
  (test-utf16le #(#x41 #x00 #x0D #x00 #x0A #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf16le.8
  (test-utf16le #(#x41 #x00 #x0D #x00 #x0D #x00
                  #x0A #x00 #x0A #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf16le.9
  (test-utf16le #(#x41 #x00 #x0D #x00 #x1F #x00 #x42 #x00 #x43 #x00))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf16le.10
  (test-utf16le #(#x42 #x00 #x43 #x00 #x0A #x00))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf16le.11
  (test-utf16le #(#x42 #x00 #x43 #x00 #x0D #x00))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf16le.12
  (test-utf16le #(#x42 #x00 #x43 #x00 #x0D #x00 #x0A #x00))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf16le.13
  (test-utf16le #(#x20 #x00 #x42 #x00 #x43 #x00))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf16le.14
  (test-utf16le #(#x20 #x00 #x00 #x30 #x01 #x30))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf16le.15
  (test-utf16le #(#x20 #x00 #xFF #xD7 #x00 #xE0 #xFF #xFF #x01 #x30) :recovery)
  ((unicode #x20 #xD7FF #xE000 #xFFFF #x3001))) ;(jis1 #x2122)

(deftest input-utf16le.16
  (test-utf16le #(#x20 #x00 #x00 #xDC #xFF #xDF #x01 #x30) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16le.17
  (test-utf16le #(#x20 #x00 #x00 #xD8 #x00 #xD8
                  #xFF #xDB #xFF #xDB #x01 #x30) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16le.18
  (test-utf16le #(#x20 #x00 #x00 #xD9 #xFF #xFF #x01 #x30) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16le.19
  (test-utf16le #(#x20 #x00 #x00 #xD9 #x00 #x00 #x01 #x30) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16le.20
  (test-utf16le #(#x20 #x00 #x00 #xD8 #x00 #xDC #xFF #xDB #xFF #xDF #x01 #x30))
  ((unicode #x20 #x010000 #x10FFFF #x3001)))

(deftest input-utf16le.21
  (test-utf16le #(#x20 #x00 #xFF #xDB #x00 #xDC #x00 #xD8 #xFF #xDF #x01 #x30))
  ((unicode #x20 #x10FC00 #x0103FF #x3001)))

(deftest input-utf16le.22
  (test-utf16le #(#x20 #x00 #x00 #xD9 #xFF #xDB
                  #x00 #xDA #x00 #xE0 #x01 #x30) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001)))

;;  eof-error
(deftest input-utf16le.23
  (test-utf16le #(#x20) :recovery)
  ((error error)))

(deftest input-utf16le.24
  (test-utf16le #(#x0D #x00 #x0A) :recovery)
  ((error error)))

(deftest input-utf16le.25
  (test-utf16le #(#x00 #xD8 #x00) :recovery)
  ((error error)))


;;
;;  input-utf16be
;;
(defun test-utf16be (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf16be input output)
    (charout-result output)))

(deftest input-utf16be.1
  (test-utf16be #())
  nil)

(deftest input-utf16be.2
  (test-utf16be #(#x00 #x48 #x00 #x65 #x00 #x6C #x00 #x6C #x00 #x6F))
  ((unicode #x48 #x65 #x6C #x6C #x6F)))

(deftest input-utf16be.3
  (test-utf16be #(#x00 #x0D #x00 #x41 #x00 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf16be.4
  (test-utf16be #(#x00 #x41 #x00 #x0D #x00 #x42 #x00 #x43))
  ((unicode #x41) (control #x0D) (unicode #x42 #x43)))

(deftest input-utf16be.5
  (test-utf16be #(#x00 #x41 #x00 #x0A #x00 #x42 #x00 #x43))
  ((unicode #x41) (control #x0A) (unicode #x42 #x43)))

(deftest input-utf16be.6
  (test-utf16be #(#x00 #x41 #x00 #x0A #x00 #x0D #x00 #x42 #x00 #x43))
  ((unicode #x41) (control #x0A #x0D) (unicode #x42 #x43)))

(deftest input-utf16be.7
  (test-utf16be #(#x00 #x41 #x00 #x0D #x00 #x0A #x00 #x42 #x00 #x43))
  ((unicode #x41) (control eol2) (unicode #x42 #x43)))

(deftest input-utf16be.8
  (test-utf16be #(#x00 #x41 #x00 #x0D #x00 #x0D
                  #x00 #x0A #x00 #x0A #x00 #x42 #x00 #x43))
  ((unicode #x41) (control #x0D eol2 #x0A) (unicode #x42 #x43)))

(deftest input-utf16be.9
  (test-utf16be #(#x00 #x41 #x00 #x0D #x00 #x1F #x00 #x42 #x00 #x43))
  ((unicode #x41) (control #x0D #x1F) (unicode #x42 #x43)))

(deftest input-utf16be.10
  (test-utf16be #(#x00 #x42 #x00 #x43 #x00 #x0A))
  ((unicode #x42 #x43) (control #x0A)))

(deftest input-utf16be.11
  (test-utf16be #(#x00 #x42 #x00 #x43 #x00 #x0D))
  ((unicode #x42 #x43) (control #x0D)))

(deftest input-utf16be.12
  (test-utf16be #(#x00 #x42 #x00 #x43 #x00 #x0D #x00 #x0A))
  ((unicode #x42 #x43) (control eol2)))

(deftest input-utf16be.13
  (test-utf16be #(#x00 #x20 #x00 #x42 #x00 #x43))
  ((unicode #x20 #x42 #x43)))

(deftest input-utf16be.14
  (test-utf16be #(#x00 #x20 #x30 #x00 #x30 #x01))
  ((unicode #x20 #x3000 #x3001)))  ;(jis1 #x2121 #x2122)

(deftest input-utf16be.15
  (test-utf16be #(#x00 #x20 #xD7 #xFF #xE0 #x00 #xFF #xFF #x30 #x01) :recovery)
  ((unicode #x20 #xD7FF #xE000 #xFFFF #x3001))) ;(jis1 #x2122)

(deftest input-utf16be.16
  (test-utf16be #(#x00 #x20 #xDC #x00 #xDF #xFF #x30 #x01) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16be.17
  (test-utf16be #(#x00 #x20 #xD8 #x00 #xD8 #x00
                  #xDB #xFF #xDB #xFF #x30 #x01) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16be.18
  (test-utf16be #(#x00 #x20 #xD9 #x00 #xFF #xFF #x30 #x01) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16be.19
  (test-utf16be #(#x00 #x20 #xD9 #x00 #x00 #x00 #x30 #x01) :recovery)
  ((unicode #x20) (error error) (unicode #x3001))) ;(jis1 #x2122)

(deftest input-utf16be.20
  (test-utf16be #(#x00 #x20 #xD8 #x00 #xDC #x00 #xDB #xFF #xDF #xFF #x30 #x01))
  ((unicode #x20 #x010000 #x10FFFF #x3001)))

(deftest input-utf16be.21
  (test-utf16be #(#x00 #x20 #xDB #xFF #xDC #x00 #xD8 #x00 #xDF #xFF #x30 #x01))
  ((unicode #x20 #x10FC00 #x0103FF #x3001)))

(deftest input-utf16be.22
  (test-utf16be #(#x00 #x20 #xD9 #x00 #xDB #xFF
                  #xDA #x00 #xE0 #x00 #x30 #x01) :recovery)
  ((unicode #x20) (error error error) (unicode #x3001)))

;;  eof-error
(deftest input-utf16be.23
  (test-utf16be #(#x20) :recovery)
  ((error error)))

(deftest input-utf16be.24
  (test-utf16be #(#x00 #x0D #x00) :recovery)
  ((error error)))

(deftest input-utf16be.25
  (test-utf16be #(#xD8 #x00 #xDC) :recovery)
  ((error error)))


;;
;;  input-utf16
;;
(defun test-utf16 (str &optional recovery)
  (let ((input (make-inbyte str))
        (output (make-instance 'charout-group))
        (*recovery* recovery))
    (input-utf16 input output)
    (charout-result output)))

(deftest input-utf16.1
  (test-utf16 #(#x00 #x0D #x00 #x41 #x00 #x42))
  ((control #x0D) (unicode #x41 #x42)))

(deftest input-utf16.2
  (test-utf16 #(#xFE #xFF #x00 #x0D #x00 #x41 #x00 #x42))
  ((control bom #x0D) (unicode #x41 #x42)))

(deftest input-utf16.3
  (test-utf16 #(#xFF #xFE #x0D #x00 #x41 #x00 #x42 #x00))
  ((control bom #x0D) (unicode #x41 #x42)))

(deftest input-utf16.4
  (test-utf16 #(#xFE #xDD #x00 #xAA #x00 #x0D #x00 #x41 #x00 #x42) :recovery)
  ((unicode #xFEDD #xAA) (control #x0D) (unicode #x41 #x42)))

(deftest input-utf16.5
  (test-utf16 #(#xFF #xAA #x00 #x0D #x00 #x41 #x00 #x42) :recovery)
  ((unicode #xFFAA) (control #x0D) (unicode #x41 #x42)))

