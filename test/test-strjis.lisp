(in-package #:strjis)

;;
;;  recovery-check
;;
(deftest recovery-check.1
  (let ((*recovery-check*))
    (coerce-list "Hello" :input 'ascii :recovery t)
    *recovery-check*)
  nil)

(deftest recovery-check.2
  (let ((*recovery-check*))
    (coerce-list '(10 100 1000) :input 'ascii :recovery t)
    *recovery-check*)
  t)


;;
;;  stream-input-type
;;
(deftest stream-input-type.1
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (write-char #\A file)
      (write-char #\B file)
      (write-char #\C file))
    (with-open-file (file +debug-file+)
      (coerce-string file)))
  "ABC")

(deftest stream-input-type.2
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (write-char #\A file)
      (write-char #\B file)
      (write-char #\C file))
    (with-open-file (file +debug-file+)
      (coerce-string file :stream-input-type 'strjis::character)))
  "ABC")

(deftest stream-input-type.3
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (write-char #\A file)
      (write-char #\B file)
      (write-char #\C file))
    (with-open-file (file +debug-file+ :element-type '(unsigned-byte 8))
      (coerce-string file)))
  "ABC")

(deftest stream-input-type.4
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (write-char #\A file)
      (write-char #\B file)
      (write-char #\C file))
    (with-open-file (file +debug-file+ :element-type '(unsigned-byte 8))
      (coerce-string file :stream-input-type 'strjis::binary)))
  "ABC")


;;
;;  stream-output-type
;;
(deftest stream-output-type.1
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (coerce-stream "ABC" file))
    (debug-file-list 8))
  (#x41 #x42 #x43))

(deftest stream-output-type.2
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (coerce-stream "ABC" file :stream-input-type 'strjis::character))
    (debug-file-list 8))
  (#x41 #x42 #x43))

(deftest stream-output-type.3
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :element-type '(unsigned-byte 8))
      (coerce-stream "ABC" file))
    (debug-file-list 8))
  (#x41 #x42 #x43))

(deftest stream-output-type.4
  (progn
    (with-open-file (file +debug-file+ :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :element-type '(unsigned-byte 8))
      (coerce-stream "ABC" file :stream-input-type 'strjis::binary))
    (debug-file-list 8))
  (#x41 #x42 #x43))


;;
;;  utf max
;;
(deftest utf16v-max.1
  (coerce-vector '(#xFFFF) :input 'utf16v :output 'utf32v)
  #(#xFFFF))

(deftest utf32v-max.1
  (coerce-vector '(#x10FFFF) :input 'utf32v :output 'utf32v)
  #(#x10FFFF))


;;
;;  End Of Line
;;
(deftest eol0a.1
  (let ((*eol-0a* nil))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0a.2
  (let ((*eol-0a* #x0A))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0a.3
  (let ((*eol-0a* #x0D))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0D #x0D #x0D #xA #xD))

(deftest eol0a.4
  (let ((*eol-0a* 'eol2))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0D #x0A #x0D #x0D #xA #xD #x0A))

(deftest eol0d.1
  (let ((*eol-0d* nil))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0d.2
  (let ((*eol-0d* #x0D))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0d.3
  (let ((*eol-0d* #x0A))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0A #x0D #xA #xA))

(deftest eol0d.4
  (let ((*eol-0d* 'eol2))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0A #x0D #xA #xA))

(deftest eol0d0a.1
  (let ((*eol-0d0a* nil))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0d0a.2
  (let ((*eol-0d0a* 'eol2))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA #xA))

(deftest eol0d0a.3
  (let ((*eol-0d0a* #x0A))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #xA #xA))

(deftest eol0d0a.4
  (let ((*eol-0d0a* #x0D))
    (coerce-list '(#x41 #x42 #x0A #x0D #x0D #xA #xA)))
  (#x41 #x42 #x0A #x0D #x0D #xA))


;;
;;  twice
;;
;;  3-242B  U+304B      # HIRAGANA LETTER KA
;;  ......  U+309A      # COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
;;  3-2477  U+304B+309A # Ka~
;;
(deftest twice-forward.1
  (coerce-list '(#x41 #x42 #xA4 #xAB) :input 'eucjis :output 'utf32v)
  (#x41 #x42 #x304B))

(deftest twice-forward.2
  (coerce-list '(#x41 #x42 #xA4 #xAB #x43) :input 'eucjis :output 'utf32v)
  (#x41 #x42 #x304B #x43))

(deftest twice-forward.3
  (coerce-list '(#x41 #x42 #xA4 #xF7) :input 'eucjis :output 'utf32v)
  (#x41 #x42 #x304B #x309A))

(deftest twice-forward.4
  (coerce-list '(#x41 #x42 #xA4 #xF7 #x43) :input 'eucjis :output 'utf32v)
  (#x41 #x42 #x304B #x309A #x43))

(deftest twice-reverse.1
  (coerce-list '(#x41 #x42 #x304B) :input 'utf32v :output 'eucjis)
  (#x41 #x42 #xA4 #xAB))

(deftest twice-reverse.2
  (coerce-list '(#x41 #x42 #x304B #x43) :input 'utf32v :output 'eucjis)
  (#x41 #x42 #xA4 #xAB #x43))

(deftest twice-reverse.3
  (coerce-list '(#x41 #x42 #x304B #x309A) :input 'utf32v :output 'eucjis)
  (#x41 #x42 #xA4 #xF7))

(deftest twice-reverse.4
  (coerce-list '(#x41 #x42 #x304B #x309A #x43) :input 'utf32v :output 'eucjis)
  (#x41 #x42 #xA4 #xF7 #x43))


;;
;;  README.md
;;
(deftest readme.1
  (coerce-list
    #(#x1B #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26)
    :input 'jis :output 'utf8)
  (227 129 130 227 129 132 227 129 134))

(deftest readme.2
  (coerce-vector
    '(#x82 #xA0 #x82 #xA2 #x82 #xA4)
    :input 'shiftjis :output 'utf8bom)
  #(239 187 191 227 129 130 227 129 132 227 129 134))

(deftest readme.3
  (coerce-list
    (coerce (mapcar #'code-char '(#x3042 #x3044 #x3046)) 'string)
    :output 'eucjis)
  (164 162 164 164 164 166))

(deftest readme.4
  (let ((c (coerce-string
             '(#x1B #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26)
             :input 'jis)))
    (values
      (stringp c)
      (mapcar #'char-code (coerce c 'list))))
  t (#x3042 #x3044 #x3046))

(deftest readme.5
  (progn
    (with-open-file (output +debug-file+ :direction :output
                            :if-exists :supersede
                            :if-does-not-exist :create)
      (write-sequence "ABC" output))
    (with-open-file (input +debug-file+ :direction :input)
      (with-open-file (output +debug-file2+ :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create
                              :element-type '(unsigned-byte 8))
        (coerce-stream input output :output 'utf16be)))
    (debug-file-list 8 +debug-file2+))
  (#x00 #x41 #x00 #x42 #x00 #x43))

(deftest readme.6
  (progn
    (with-open-file (output +debug-file+ :direction :output
                            :if-exists :supersede
                            :if-does-not-exist :create)
      (write-sequence "ABC" output))
    (with-open-file (input +debug-file+ :direction :input
                           :element-type '(unsigned-byte 8))
      (with-open-file (output +debug-file2+ :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create
                              :element-type '(unsigned-byte 8))
        (coerce-stream input output :input 'eucjis :output 'shiftjis)))
    (debug-file-list 8 +debug-file2+))
  (#x41 #x42 #x43))


;;
;;  error
;;
(deftest recovery-integer.1
  (let ((*recovery-unicode* #x20))
    (coerce-list
      '(40 50 #xD800 60)
      :input 'utf32v :output 'utf32v :recovery t))
  (40 50 #x20 60))

(deftest recovery-integer.2
  (let ((*recovery-unicode* #\A))
    (coerce-list
      '(40 50 #xD800 60)
      :input 'utf32v :output 'utf32v :recovery t))
  (40 50 #x41 60))


;;
;;  encode-symbol
;;
(deftest encode-symbol.1
  (coerce-list '(40 50 60) :input :u-t-f-8)
  (40 50 60))

(deftest encode-symbol.2
  (coerce-list '(40 50 60) :input 'u-t-f-8)
  (40 50 60))

(deftest encode-symbol.3
  (coerce-list '(40 50 60) :input :uni-co-de)
  (40 50 60))

(deftest encode-symbol.4
  (coerce-list '(40 50 60) :input 'uni-co-de)
  (40 50 60))


;;
;;  vector-size
;;
(deftest vector-size.1
  (coerce-string "HelloHello" :size 3)
  "HelloHello")

(deftest vector-size.2
  (coerce-string "HelloHello" :size #xFFFF)
  "HelloHello")

(deftest vector-size.3
  (coerce-vector "HelloHello" :size 3)
  #(#x48 #x65 #x6C #x6C #x6F  #x48 #x65 #x6C #x6C #x6F))

(deftest vector-size.4
  (coerce-vector "HelloHello" :size 100)
  #(#x48 #x65 #x6C #x6C #x6F  #x48 #x65 #x6C #x6C #x6F))

