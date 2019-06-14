(in-package #:strjis)

;;
;;  list jis
;;
(deftest list-iso2022jp.ascii.1
  (coerce-list "" :input 'ascii :output 'iso2022jp)
  nil)

(deftest list-iso2022jp.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'iso2022jp)
  (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest list-iso2022jp.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-list
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'iso2022jp :recovery t))
  (#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest list-iso2022jp.jis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63
   #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.jis.2
  (let ((*kana-iso2022jp* 'zenkaku))
    (coerce-list
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63
   #x1b #x24 #x28 #x51  #x21 #x23  #x21 #x56  #x21 #x57
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.jis.3
  (let ((*kana-iso2022jp* 'reject))
    (coerce-list
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63 #x0D))

(deftest-error list-iso2022jp.jis.4
  (coerce-list
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'iso2022jp))

(deftest list-iso2022jp.jis.5
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x51  #x74 #x71))

(deftest list-iso2022jp.jis.6
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'iso2022jp :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x51  #x74 #x71))

(deftest-error list-iso2022jp.jis.7
  (coerce-list
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x23)
    :input 'jis :output 'iso2022jp))

(deftest list-iso2022jp.eucjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
      :input 'eucjis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.eucjis.2
  (coerce-list
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x51  #x74 #x71))

(deftest list-iso2022jp.shiftjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
      :input 'shiftjis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.shiftjis.2
  (coerce-list
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest list-iso2022jp.utf8.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#xEF #xBB #xBF  #x61 #x62 #x63
        #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
      :input 'utf8 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf8.2
  (coerce-list
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf16be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16be :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf16be.2
  (coerce-list
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf16le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
      :input 'utf16le :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf16le.2
  (coerce-list
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf16.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf16.2
  (coerce-list
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf16.3
  (coerce-list
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf16v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf16v :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf16v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf16v :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf32be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32be :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf32le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
        #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
        #x0D #x00 #x00 #x00)
      :input 'utf32le :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf32le.2
  (coerce-list
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf32.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf32.3
  (coerce-list
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest list-iso2022jp.utf32v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-list
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf32v :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest list-iso2022jp.utf32v.2
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf32v :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest-error list-iso2022jp.utf32v.3  
  (coerce-list
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'iso2022jp))


;;
;;  vector jis
;;
(deftest vector-iso2022jp.ascii.1
  (coerce-vector "" :input 'ascii :output 'iso2022jp)
  #())

(deftest vector-iso2022jp.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'iso2022jp)
  #(#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest vector-iso2022jp.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-vector
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'iso2022jp :recovery t))
  #(#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest vector-iso2022jp.jis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63
    #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.jis.2
  (let ((*kana-iso2022jp* 'zenkaku))
    (coerce-vector
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63
    #x1b #x24 #x28 #x51  #x21 #x23  #x21 #x56  #x21 #x57
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.jis.3
  (let ((*kana-iso2022jp* 'reject))
    (coerce-vector
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63 #x0D))

(deftest-error vector-iso2022jp.jis.4
  (coerce-vector
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'iso2022jp))

(deftest vector-iso2022jp.jis.5
  (coerce-vector
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x51  #x74 #x71))

(deftest-error vector-iso2022jp.jis.6
  (coerce-vector
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x23)
    :input 'jis :output 'iso2022jp))

(deftest vector-iso2022jp.eucjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
      :input 'eucjis :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.eucjis.2
  (coerce-vector
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1b #x24 #x28 #x51  #x74 #x71))

(deftest vector-iso2022jp.shiftjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
      :input 'shiftjis :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.shiftjis.2
  (coerce-vector
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest vector-iso2022jp.utf8.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#xEF #xBB #xBF  #x61 #x62 #x63
        #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
      :input 'utf8 :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf8.2
  (coerce-vector
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf16be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16be :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf16be.2
  (coerce-vector
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf16le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
      :input 'utf16le :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf16le.2
  (coerce-vector
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf16.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16 :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf16.2
  (coerce-vector
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf16.3
  (coerce-vector
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf16v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf16v :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf16v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf16v :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf32be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32be :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf32le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
        #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
        #x0D #x00 #x00 #x00)
      :input 'utf32le :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf32le.2
  (coerce-vector
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf32.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32 :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf32.3
  (coerce-vector
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest vector-iso2022jp.utf32v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-vector
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf32v :output 'iso2022jp))
  #(#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
    #x1B #x28 #x42  #x0D))

(deftest vector-iso2022jp.utf32v.2
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf32v :output 'iso2022jp)
  #(#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
    #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
    #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest-error vector-iso2022jp.utf32v.3  
  (coerce-vector
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'iso2022jp))


;;
;;  string iso2022jp
;;
(deftest string-iso2022jp.ascii.1
  (coerce-string "" :input 'ascii :output 'iso2022jp)
  "")

(deftest string-iso2022jp.ascii.2
  (let ((v (coerce-string "Hello" :input 'ascii :output 'iso2022jp)))
    (values
      (stringp v)
      (mapcar #'char-code (coerce v 'list))))
  t (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest string-iso2022jp.ascii.3
  (let ((*recovery-jis* (list #x42 #x42 #x43)))
    (let ((v (coerce-string
               #(#x41 #x80 #x43)
               :input 'ascii :output 'iso2022jp :recovery t)))
      (values
        (stringp v)
        (mapcar #'char-code (coerce v 'list)))))
  t (#x1B #x28 #x42  #x41 #x42 #x42 #x43
     #x1B #x28 #x42  #x43))


;;
;;  stream jis
;;
(deftest stream-iso2022jp.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'iso2022jp)
  nil)

(deftest stream-iso2022jp.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'iso2022jp)
  (#x1B #x28 #x42  #x48 #x65 #x6C #x6C #x6F))

(deftest stream-iso2022jp.ascii.3
  (let ((*recovery-jis* (list #x22 #x33 #x44)))
    (coerce-stream-debug
      #(#x20 #x21 #xFF #x40)
      :input 'ascii :output 'iso2022jp :recovery t))
  (#x1B #x28 #x42  #x20 #x21  #x22 #x33 #x44  #x1B #x28 #x42  #x40))

(deftest stream-iso2022jp.jis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63
   #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.jis.2
  (let ((*kana-iso2022jp* 'zenkaku))
    (coerce-stream-debug
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63
   #x1b #x24 #x28 #x51  #x21 #x23  #x21 #x56  #x21 #x57
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.jis.3
  (let ((*kana-iso2022jp* 'reject))
    (coerce-stream-debug
      #(#x61 #x62 #x63
        #x1B #x28 #x49  #x21 #x22 #x23
        #x1B #x28 #x42  #x0D)
      :input 'jis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63 #x0D))

(deftest-error stream-iso2022jp.jis.4
  (coerce-stream-debug
    #(#x61 #x62 #x63
      #x1B #x28 #x49  #x21 #x22 #x23
      #x1B #x28 #x42  #x0D)
    :input 'jis :output 'iso2022jp))

(deftest stream-iso2022jp.jis.5
  (coerce-stream-debug
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x22)
    :input 'jis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x51  #x74 #x71))

(deftest-error stream-iso2022jp.jis.6
  (coerce-stream-debug
    '(#x1b #x24 #x40  #x21 #x21  #x21 #x22  #x21 #x23
      #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
      #x1b #x24 #x28 #x44  #x40 #x23)
    :input 'jis :output 'iso2022jp))

(deftest stream-iso2022jp.eucjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x62 #x63  #x8E #xA1 #x8E #xA2 #x8E #xA3  #x0D)
      :input 'eucjis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.eucjis.2
  (coerce-stream-debug
    '(#xA1 #xA1  #xA1 #xA2  #xA1 #xA3
      #x8F #xEE #xFB  #x8F #xEE #xFC  #x8F #xC0 #xA2)
    :input 'eucjis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1b #x24 #x28 #x51  #x74 #x71))

(deftest stream-iso2022jp.shiftjis.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x62 #x63  #xA1 #xA2 #xA3  #x0D)
      :input 'shiftjis :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.shiftjis.2
  (coerce-stream-debug
    '(#x81 #x40  #x81 #x41  #x81 #x42  #xF4 #xF9  #xF4 #xFA)
    :input 'shiftjis :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C))

(deftest stream-iso2022jp.utf8.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#xEF #xBB #xBF  #x61 #x62 #x63
        #xEF #xBD #xA1  #xEF #xBD #xA2  #xEF #xBD #xA3  #x0D)
      :input 'utf8 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf8.2
  (coerce-stream-debug
    '(#xE3 #x80 #x80  #xE3 #x80 #x81  #xE3 #x80 #x82
      #xE6 #xB9 #x94  #xE6 #xB9 #x97  #xE6 #x8D #xBC)
    :input 'utf8 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf16be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16be :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf16be.2
  (coerce-stream-debug
    '(#x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16be :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf16le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x00  #x62 #x00  #x63 #x00  #x61 #xFF  #x62 #xFF  #x63 #xFF  #x0D #x00)
      :input 'utf16le :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf16le.2
  (coerce-stream-debug
    '(#x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16le :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf16.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x00 #x61 #x00 #x62 #x00 #x63  #xFF #x61  #xFF #x62  #xFF #x63  #x00 #x0D)
      :input 'utf16 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf16.2
  (coerce-stream-debug
    '(#xFE #xFF
      #x30 #x00  #x30 #x01  #x30 #x02
      #x6E #x54  #x6E #x57  #x63 #x7C)
    :input 'utf16 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf16.3
  (coerce-stream-debug
    '(#xFF #xFE
      #x00 #x30  #x01 #x30  #x02 #x30
      #x54 #x6E  #x57 #x6E  #x7C #x63)
    :input 'utf16 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf16v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf16v :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf16v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf16v :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf32be.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32be :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf32be.2
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32be :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf32le.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
        #x61 #xFF #x00 #x00  #x62 #xFF #x00 #x00  #x63 #xFF #x00 #x00
        #x0D #x00 #x00 #x00)
      :input 'utf32le :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf32le.2
  (coerce-stream-debug
    '(#x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32le :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf32.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
        #x00 #x00 #xFF #x61  #x00 #x00 #xFF #x62  #x00 #x00 #xFF #x63
        #x00 #x00 #x00 #x0D)
      :input 'utf32 :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf32.2
  (coerce-stream-debug
    '(#x00 #x00 #xFE #xFF
      #x00 #x00 #x30 #x00  #x00 #x00 #x30 #x01  #x00 #x00 #x30 #x02
      #x00 #x00 #x6E #x54  #x00 #x00 #x6E #x57  #x00 #x00 #x63 #x7C)
    :input 'utf32 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf32.3
  (coerce-stream-debug
    '(#xFF #xFE #x00 #x00
      #x00 #x30 #x00 #x00  #x01 #x30 #x00 #x00  #x02 #x30 #x00 #x00
      #x54 #x6E #x00 #x00  #x57 #x6E #x00 #x00  #x7C #x63 #x00 #x00)
    :input 'utf32 :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest stream-iso2022jp.utf32v.1
  (let ((*kana-iso2022jp* 'force))
    (coerce-stream-debug
      #(#x61 #x62 #x63  #xFF61 #xFF62 #xFF63  #x0D)
      :input 'utf32v :output 'iso2022jp))
  (#x1B #x28 #x42  #x61 #x62 #x63  #x1B #x28 #x49  #x21 #x22 #x23
   #x1B #x28 #x42  #x0D))

(deftest stream-iso2022jp.utf32v.2
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57 #x637C)
    :input 'utf32v :output 'iso2022jp)
  (#x1b #x24 #x28 #x51  #x21 #x21  #x21 #x22  #x21 #x23
   #x1b #x24 #x28 #x50  #x6E #x7B  #x6E #x7C
   #x1B #x24 #x28 #x51  #x74 #x71)) ;; sub #x40 #x22

(deftest-error stream-iso2022jp.utf32v.3  
  (coerce-stream-debug
    '(#x3000 #x3001 #x3002  #x6E54 #x6E57  #x6378 #x637D #x637C)
    :input 'utf32v :output 'iso2022jp))

