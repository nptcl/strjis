(in-package #:strjis)

;;
;;  list eucjis
;;
(deftest list-eucjis.ascii.1
  (coerce-list "" :input 'ascii :output 'eucjis)
  nil)

(deftest list-eucjis.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'eucjis)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-eucjis.ascii.3
  (let ((*recovery-eucjis* (list #x22 #x33 #x44)))
    (coerce-list
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'eucjis :recovery t))
  (#x20 #x21  #x22 #x33 #x44  #x40))

(deftest list-eucjis.jis.1
  (coerce-list
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3 #x0D))

(deftest list-eucjis.jis.2
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest list-eucjis.eucjis.1
  (coerce-list
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.eucjis.2
  (coerce-list
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest list-eucjis.shiftjis.1
  (coerce-list
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.shiftjis.2
  (coerce-list
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3  #x8F #xEE #xFB  #x8F #xEE #xFC))

(deftest list-eucjis.utf8.1
  (coerce-list
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf8.2
  (coerce-list
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf16be.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf16be.2
  (coerce-list
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf16le.1
  (coerce-list
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf16le.2
  (coerce-list
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf16.1
  (coerce-list
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf16.2
  (coerce-list
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf16.3
  (coerce-list
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf16v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf16v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf32le.2
  (coerce-list
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf32.3
  (coerce-list
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest list-eucjis.utf32v.1
  (coerce-list
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest list-eucjis.utf32v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22


;;
;;  vector eucjis
;;
(deftest vector-eucjis.ascii.1
  (coerce-vector "" :input 'ascii :output 'eucjis)
  #())

(deftest vector-eucjis.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'eucjis)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-eucjis.ascii.3
  (let ((*recovery-eucjis* (list #x22 #x33 #x44)))
    (coerce-vector
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'eucjis :recovery t))
  #(#x20 #x21  #x22 #x33 #x44  #x40))

(deftest vector-eucjis.jis.1
  (coerce-vector
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3 #x0D))

(deftest vector-eucjis.jis.2
  (coerce-vector
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest vector-eucjis.eucjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.eucjis.2
  (coerce-vector
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest vector-eucjis.shiftjis.1
  (coerce-vector
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.shiftjis.2
  (coerce-vector
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3  #x8F #xEE #xFB  #x8F #xEE #xFC))

(deftest vector-eucjis.utf8.1
  (coerce-vector
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf8.2
  (coerce-vector
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf16be.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf16be.2
  (coerce-vector
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf16le.1
  (coerce-vector
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf16le.2
  (coerce-vector
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf16.1
  (coerce-vector
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf16.2
  (coerce-vector
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf16.3
  (coerce-vector
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf16v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf16v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf32le.2
  (coerce-vector
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf32.3
  (coerce-vector
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22

(deftest vector-eucjis.utf32v.1
  (coerce-vector
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'eucjis)
  #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest vector-eucjis.utf32v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'eucjis)
  #(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
    #x8F #xEE #xFB  #x8F #xEE #xFC
    #xF4 #xF1)) ;; sub #x40 #x22


;;
;;  string eucjis
;;
(deftest string-eucjis.ascii.1
  (coerce-string "" :input 'ascii :output 'eucjis)
  "")

(deftest string-eucjis.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'eucjis)
  "Hello")

(deftest string-eucjis.ascii.3
  (let ((*recovery-eucjis* (list #x42 #x42 #x43)))
    (coerce-string
      #(#x41 #x80 #x43)
      :input 'ascii :output 'eucjis :recovery t))
  "ABBCC")


;;
;;  stream eucjis
;;
(deftest stream-eucjis.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'eucjis)
  nil)

(deftest stream-eucjis.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'eucjis)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-eucjis.ascii.3
  (let ((*recovery-eucjis* (list #x22 #x33 #x44)))
    (coerce-stream-debug
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'eucjis :recovery t))
  (#x20 #x21  #x22 #x33 #x44  #x40))

(deftest stream-eucjis.jis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3 #x0D))

(deftest stream-eucjis.jis.2
  (coerce-stream-debug
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x21  #x40 #x22)
    :input 'jis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest stream-eucjis.eucjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
    :input 'eucjis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.eucjis.2
  (coerce-stream-debug
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2)
    :input 'eucjis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA1  #x8F #xC0 #xA2))

(deftest stream-eucjis.shiftjis.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
    :input 'shiftjis :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.shiftjis.2
  (coerce-stream-debug
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3  #x8F #xEE #xFB  #x8F #xEE #xFC))

(deftest stream-eucjis.utf8.1
  (coerce-stream-debug
    #(#xEF #xBB #xBF  #x61 #x62 #x63
      #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
    :input 'utf8 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf8.2
  (coerce-stream-debug
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf16be.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16be :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf16be.2
  (coerce-stream-debug
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf16le.1
  (coerce-stream-debug
    #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
    :input 'utf16le :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf16le.2
  (coerce-stream-debug
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf16.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
    :input 'utf16 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf16.2
  (coerce-stream-debug
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf16.3
  (coerce-stream-debug
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf16v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf16v :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf16v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf16v :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf32be.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32be :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf32be.2
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf32le.1
  (coerce-stream-debug
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
      #x0D #x00 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf32le.2
  (coerce-stream-debug
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf32.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
      #x00 #x00 #x00 #x0D)
    :input 'utf32 :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf32.2
  (coerce-stream-debug
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf32.3
  (coerce-stream-debug
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

(deftest stream-eucjis.utf32v.1
  (coerce-stream-debug
    #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
    :input 'utf32v :output 'eucjis)
  (#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D))

(deftest stream-eucjis.utf32v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x637C)
    :input 'utf32v :output 'eucjis)
  (#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
   #x8F #xEE #xFB  #x8F #xEE #xFC
   #xF4 #xF1)) ;; sub #x40 #x22

