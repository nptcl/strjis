(in-package #:strjis)

;;
;;  list jis
;;
(deftest list-jis.ascii.1
  (coerce-list "" :input 'ascii :output 'jis)
  nil)

(deftest list-jis.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'jis)
  (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest list-jis.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-list
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'jis :recovery t))
  (#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest list-jis.jis.1
  (coerce-list
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.jis.2
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest list-jis.eucjis.1
  (coerce-list
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.eucjis.2
  (coerce-list
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest list-jis.shiftjis.1
  (coerce-list
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.shiftjis.2
  (coerce-list
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest list-jis.utf8.1
  (coerce-list
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf8.2
  (coerce-list
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97
      #xE6 #x8D #xB8  #xE6 #x8D #xBD  #xE6 #x8D #xBC)
    :input 'utf8 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf16be.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf16be.2
  (coerce-list
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16be :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf16le.1
  (coerce-list
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf16le.2
  (coerce-list
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16le :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf16.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf16.2
  (coerce-list
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf16.3
  (coerce-list
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf16v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf16v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf16v :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf32le.2
  (coerce-list
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf32.3
  (coerce-list
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-jis.utf32v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-jis.utf32v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22


;;
;;  vector jis
;;
(deftest vector-jis.ascii.1
  (coerce-vector "" :input 'ascii :output 'jis)
  #())

(deftest vector-jis.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'jis)
  #(#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest vector-jis.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-vector
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'jis :recovery t))
  #(#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest vector-jis.jis.1
  (coerce-vector
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.jis.2
  (coerce-vector
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest vector-jis.eucjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.eucjis.2
  (coerce-vector
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest vector-jis.shiftjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.shiftjis.2
  (coerce-vector
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest vector-jis.utf8.1
  (coerce-vector
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf8.2
  (coerce-vector
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97
      #xE6 #x8D #xB8  #xE6 #x8D #xBD  #xE6 #x8D #xBC)
    :input 'utf8 :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf16be.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf16be.2
  (coerce-vector
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16be :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf16le.1
  (coerce-vector
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf16le.2
  (coerce-vector
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16le :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf16.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf16.2
  (coerce-vector
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16 :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf16.3
  (coerce-vector
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16 :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf16v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf16v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf16v :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf32le.2
  (coerce-vector
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf32.3
  (coerce-vector
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-jis.utf32v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'jis)
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-jis.utf32v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'jis)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22


;;
;;  string jis
;;
(deftest string-jis.ascii.1
  (coerce-string "" :input 'ascii :output 'jis)
  "")

(deftest string-jis.ascii.2
  (let ((v (coerce-string "Hello" :input 'ascii :output 'jis)))
    (values
      (stringp v)
      (mapcar #'char-code (coerce v 'list))))
  t (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest string-jis.ascii.3
  (let ((*recovery-jis* (list #x42 #x42 #x43)))
    (let ((v (coerce-string
               #(#x41 #x80 #x43)
               :input 'ascii :output 'jis :recovery t)))
      (values
        (stringp v)
        (mapcar #'char-code (coerce v 'list)))))
  t (#x1B #x28 #x42  #x41 #x42 #x42 #x43
     #x1B #x28 #x42  #x43))


;;
;;  stream jis
;;
(deftest stream-jis.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'jis)
  nil)

(deftest stream-jis.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'jis)
  (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest stream-jis.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-stream-debug
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'jis :recovery t))
  (#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest stream-jis.jis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.jis.2
  (coerce-stream-debug
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest stream-jis.eucjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.eucjis.2
  (coerce-stream-debug
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22))

(deftest stream-jis.shiftjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.shiftjis.2
  (coerce-stream-debug
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest stream-jis.utf8.1
  (coerce-stream-debug
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf8.2
  (coerce-stream-debug
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97
      #xE6 #x8D #xB8  #xE6 #x8D #xBD  #xE6 #x8D #xBC)
    :input 'utf8 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf16be.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf16be.2
  (coerce-stream-debug
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16be :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf16le.1
  (coerce-stream-debug
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf16le.2
  (coerce-stream-debug
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16le :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf16.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf16.2
  (coerce-stream-debug
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57
      #x63 #x78  #x63 #x7D  #x63 #x7C)
    :input 'utf16 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf16.3
  (coerce-stream-debug
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E
      #x78 #x63  #x7D #x63  #x7C #x63)
    :input 'utf16 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf16v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf16v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf16v :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf32be.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf32be.2
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf32le.1
  (coerce-stream-debug
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf32le.2
  (coerce-stream-debug
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf32.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf32.2
  (coerce-stream-debug
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57
      #x00 #x00 #x63 #x78  #x00 #x00 #x63 #x7D  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf32.3
  (coerce-stream-debug
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00
      #x78 #x63 #x00 #x00  #x7D #x63 #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-jis.utf32v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'jis)
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-jis.utf32v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'jis)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x23
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

