(in-package #:strjis)

;;
;;  list shiftjis
;;
(deftest list-shiftjis.ascii.1
  (coerce-list "" :input 'ascii :output 'shiftjis)
  nil)

(deftest list-shiftjis.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'shiftjis)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-shiftjis.ascii.3
  (let ((*recovery-shiftjis* (list #x22 #x33 #x44)))
    (coerce-list
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'shiftjis :recovery t))
  (#x20 #x21  #x22 #x33 #x44  #x40))

(deftest list-shiftjis.jis.1
  (coerce-list
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.jis.2
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.eucjis.1
  (coerce-list
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.eucjis.2
  (coerce-list
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.shiftjis.1
  (coerce-list
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.shiftjis.2
  (coerce-list
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF)
    :input 'shiftjis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF))

(deftest list-shiftjis.utf8.1
  (coerce-list
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf8.2
  (coerce-list
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf16be.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf16be.2
  (coerce-list
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf16le.1
  (coerce-list
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf16le.2
  (coerce-list
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf16.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf16.2
  (coerce-list
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf16.3
  (coerce-list
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf16v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf16v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf32le.2
  (coerce-list
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf32.3
  (coerce-list
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest list-shiftjis.utf32v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest list-shiftjis.utf32v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22


;;
;;  vector shiftjis
;;
(deftest vector-shiftjis.ascii.1
  (coerce-vector "" :input 'ascii :output 'shiftjis)
  #())

(deftest vector-shiftjis.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'shiftjis)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-shiftjis.ascii.3
  (let ((*recovery-shiftjis* (list #x22 #x33 #x44)))
    (coerce-vector
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'shiftjis :recovery t))
  #(#x20 #x21  #x22 #x33 #x44  #x40))

(deftest vector-shiftjis.jis.1
  (coerce-vector
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.jis.2
  (coerce-vector
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.eucjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.eucjis.2
  (coerce-vector
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.shiftjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.shiftjis.2
  (coerce-vector
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF)
    :input 'shiftjis :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF))

(deftest vector-shiftjis.utf8.1
  (coerce-vector
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf8.2
  (coerce-vector
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf16be.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf16be.2
  (coerce-vector
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf16le.1
  (coerce-vector
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf16le.2
  (coerce-vector
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf16.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf16.2
  (coerce-vector
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf16.3
  (coerce-vector
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf16v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf16v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf32le.2
  (coerce-vector
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf32.3
  (coerce-vector
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22

(deftest vector-shiftjis.utf32v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'shiftjis)
  #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest vector-shiftjis.utf32v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'shiftjis)
  #(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
    #xEA #xEF)) ;; sub #x40 #x22


;;
;;  string shiftjis
;;
(deftest string-shiftjis.ascii.1
  (coerce-string "" :input 'ascii :output 'shiftjis)
  "")

(deftest string-shiftjis.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'shiftjis)
  "Hello")

(deftest string-shiftjis.ascii.3
  (let ((*recovery-shiftjis* (list #x42 #x42 #x43)))
    (coerce-string
      #(#x41 #x80 #x43)
      :input 'ascii :output 'shiftjis :recovery t))
  "ABBCC")


;;
;;  stream shiftjis
;;
(deftest stream-shiftjis.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'shiftjis)
  nil)

(deftest stream-shiftjis.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'shiftjis)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-shiftjis.ascii.3
  (let ((*recovery-shiftjis* (list #x22 #x33 #x44)))
    (coerce-stream-debug
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'shiftjis :recovery t))
  (#x20 #x21  #x22 #x33 #x44  #x40))

(deftest stream-shiftjis.jis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.jis.2
  (coerce-stream-debug
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.eucjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.eucjis.2
  (coerce-stream-debug
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.shiftjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.shiftjis.2
  (coerce-stream-debug
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF)
    :input 'shiftjis :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA #xEA #xEF))

(deftest stream-shiftjis.utf8.1
  (coerce-stream-debug
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf8.2
  (coerce-stream-debug
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf16be.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf16be.2
  (coerce-stream-debug
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf16le.1
  (coerce-stream-debug
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf16le.2
  (coerce-stream-debug
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf16.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf16.2
  (coerce-stream-debug
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf16.3
  (coerce-stream-debug
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf16v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf16v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf32be.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf32be.2
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf32le.1
  (coerce-stream-debug
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf32le.2
  (coerce-stream-debug
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf32.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf32.2
  (coerce-stream-debug
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf32.3
  (coerce-stream-debug
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

(deftest stream-shiftjis.utf32v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'shiftjis)
  (#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D))

(deftest stream-shiftjis.utf32v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'shiftjis)
  (#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA
   #xEA #xEF)) ;; sub #x40 #x22

