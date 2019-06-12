(in-package #:strjis)

;;
;;  list utf16
;;
(deftest list-utf16.ascii.1
  (coerce-list "" :input 'ascii :output 'utf16)
  nil)

(deftest list-utf16.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'utf16)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest list-utf16.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-list #(#x20 #x80 #x40) :input 'ascii :output 'utf16 :recovery t))
  (#x00 #x20 #x30 #x13 #x00 #x40))

(deftest list-utf16.ascii.4
  (coerce-list "Hello" :input 'ascii :output 'utf16v)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-utf16.ascii.5
  (coerce-list "Hello" :input 'ascii :output 'utf16)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest list-utf16.ascii.6
  (coerce-list "Hello" :input 'ascii :output 'utf16be)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest list-utf16.ascii.7
  (coerce-list "Hello" :input 'ascii :output 'utf16bebom)
  (#xFE #xFF  #x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest list-utf16.ascii.8
  (coerce-list "Hello" :input 'ascii :output 'utf16le)
  (#x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest list-utf16.ascii.9
  (coerce-list "Hello" :input 'ascii :output 'utf16lebom)
  (#xFF #xFE  #x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest list-utf16.jis.1
  (coerce-list #(#x61 #x62 #x63) :input 'jis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.jis.2
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.jis.3
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.jis.4
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.jis.5
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.jis.6
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.jis.7
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.eucjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'eucjis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.eucjis.2
  (coerce-list
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.eucjis.3
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.eucjis.4
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.eucjis.5
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.eucjis.6
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.eucjis.7
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.shiftjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'shiftjis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.shiftjis.2
  (coerce-list
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.shiftjis.3
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.shiftjis.4
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.shiftjis.5
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.shiftjis.6
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.shiftjis.7
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.utf8.1
  (coerce-list #(#x61 #x62 #x63) :input 'utf8 :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.utf8.2
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf8.3
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf8.4
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.5
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.6
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.7
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.8
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.9
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest list-utf16.utf8.10
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  (#x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.utf8.11
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  (#x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.utf8.10
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.utf8.11
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest list-utf16.utf16be.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.utf16be.2
  (coerce-list
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf16le.1
  (coerce-list #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.utf16le.2
  (coerce-list
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf16.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.utf16.2
  (coerce-list
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf16v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest list-utf16.utf16v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf16v)
  (#x61 #x62 #x63))

(deftest list-utf16.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  (#x61 #x62 #x63))

(deftest list-utf16.utf32le.2
  (coerce-list
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf16v)
  (#x61 #x62 #x63))

(deftest list-utf16.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf16.utf32v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf16v)
  (#x61 #x62 #x63))

(deftest list-utf16.utf32v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))


;;
;;  vector utf16
;;
(deftest vector-utf16.ascii.1
  (coerce-vector "" :input 'ascii :output 'utf16)
  #())

(deftest vector-utf16.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'utf16)
  #(#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest vector-utf16.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-vector #(#x20 #x80 #x40) :input 'ascii :output 'utf16 :recovery t))
  #(#x00 #x20 #x30 #x13 #x00 #x40))

(deftest vector-utf16.ascii.4
  (coerce-vector "Hello" :input 'ascii :output 'utf16v)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-utf16.ascii.5
  (coerce-vector "Hello" :input 'ascii :output 'utf16)
  #(#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest vector-utf16.ascii.6
  (coerce-vector "Hello" :input 'ascii :output 'utf16be)
  #(#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest vector-utf16.ascii.7
  (coerce-vector "Hello" :input 'ascii :output 'utf16bebom)
  #(#xFE #xFF  #x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest vector-utf16.ascii.8
  (coerce-vector "Hello" :input 'ascii :output 'utf16le)
  #(#x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest vector-utf16.ascii.9
  (coerce-vector "Hello" :input 'ascii :output 'utf16lebom)
  #(#xFF #xFE  #x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest vector-utf16.jis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'jis :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.jis.2
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.jis.3
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.jis.4
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16be)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.jis.5
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16bebom)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.jis.6
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16le)
  #(#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.jis.7
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16lebom)
  #(#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.eucjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'eucjis :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.eucjis.2
  (coerce-vector
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.eucjis.3
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.eucjis.4
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16be)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.eucjis.5
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16bebom)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.eucjis.6
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16le)
  #(#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.eucjis.7
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16lebom)
  #(#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.shiftjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'shiftjis :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.shiftjis.2
  (coerce-vector
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.shiftjis.3
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.shiftjis.4
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16be)
  #(#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.shiftjis.5
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16bebom)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.shiftjis.6
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16le)
  #(#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.shiftjis.7
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16lebom)
  #(#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.utf8.1
  (coerce-vector #(#x61 #x62 #x63) :input 'utf8 :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.utf8.2
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  #(#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf8.3
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  #(#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf8.4
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  #(#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.5
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.6
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  #(#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.7
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  #(#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.8
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.9
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  #(#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
    #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest vector-utf16.utf8.10
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  #(#x42 #x30 #x44 #x30 #xFF #xFE
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.utf8.11
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  #(#x42 #x30 #x44 #x30 #xFF #xFE
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.utf8.10
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  #(#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.utf8.11
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  #(#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
    #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest vector-utf16.utf16be.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.utf16be.2
  (coerce-vector
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf16le.1
  (coerce-vector #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.utf16le.2
  (coerce-vector
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf16.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.utf16.2
  (coerce-vector
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf16v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf16)
  #(#x00 #x61 #x00 #x62 #x00 #x63))

(deftest vector-utf16.utf16v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf16v)
  #(#x61 #x62 #x63))

(deftest vector-utf16.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  #(#x61 #x62 #x63))

(deftest vector-utf16.utf32le.2
  (coerce-vector
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf16v)
  #(#x61 #x62 #x63))

(deftest vector-utf16.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf16.utf32v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf16v)
  #(#x61 #x62 #x63))

(deftest vector-utf16.utf32v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf16v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))


;;
;;  string utf16
;;
(deftest string-utf16.ascii.1
  (coerce-string "" :input 'ascii :output 'utf16v)
  "")

(deftest string-utf16.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'utf16v)
  "Hello")

(deftest string-utf16.ascii.3
  (let ((*recovery-unicode* (list #x42 #x42 #x43)))
    (coerce-string #(#x41 #x80 #x43) :input 'ascii :output 'utf16v :recovery t))
  "ABBCC")


;;
;;  stream utf16
;;
(deftest stream-utf16.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'utf16)
  nil)

(deftest stream-utf16.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest stream-utf16.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-stream-debug #(#x20 #x80 #x40) :input 'ascii :output 'utf16 :recovery t))
  (#x00 #x20 #x30 #x13 #x00 #x40))

(deftest stream-utf16.ascii.4
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16v)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-utf16.ascii.5
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest stream-utf16.ascii.6
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16be)
  (#x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest stream-utf16.ascii.7
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16bebom)
  (#xFE #xFF  #x00 #x48  #x00 #x65  #x00 #x6C  #x00 #x6C  #x00 #x6F))

(deftest stream-utf16.ascii.8
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16le)
  (#x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest stream-utf16.ascii.9
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf16lebom)
  (#xFF #xFE  #x48 #x00  #x65 #x00  #x6C #x00  #x6C #x00  #x6F #x00))

(deftest stream-utf16.jis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'jis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.jis.2
  (coerce-stream-debug16
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.jis.3
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.jis.4
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.jis.5
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.jis.6
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.jis.7
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.eucjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'eucjis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.eucjis.2
  (coerce-stream-debug16
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.eucjis.3
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.eucjis.4
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.eucjis.5
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.eucjis.6
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.eucjis.7
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.shiftjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'shiftjis :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.shiftjis.2
  (coerce-stream-debug16
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.shiftjis.3
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.shiftjis.4
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16be)
  (#x30 #x42 #x30 #x44 #x30 #x46  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.shiftjis.5
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #x30 #x46
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.shiftjis.6
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16le)
  (#x42 #x30 #x44 #x30 #x46 #x30  #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.shiftjis.7
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #x46 #x30
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.utf8.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'utf8 :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.utf8.2
  (coerce-stream-debug16
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf8.3
  (coerce-stream-debug16
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf8.4
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.5
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.6
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.7
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16be)
  (#x30 #x42 #x30 #x44 #xFE #xFF  #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.8
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.9
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16bebom)
  (#xFE #xFF  #x30 #x42 #x30 #x44 #xFE #xFF
   #x00 #x61 #x00 #x62 #x00 #x63  #x00 #x0a))

(deftest stream-utf16.utf8.10
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  (#x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.utf8.11
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16le)
  (#x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.utf8.10
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.utf8.11
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf16lebom)
  (#xFF #xFE  #x42 #x30 #x44 #x30 #xFF #xFE
   #x61 #x00 #x62 #x00 #x63 #x00  #x0a #x00))

(deftest stream-utf16.utf16be.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.utf16be.2
  (coerce-stream-debug16
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf16le.1
  (coerce-stream-debug #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.utf16le.2
  (coerce-stream-debug16
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf16.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.utf16.2
  (coerce-stream-debug16
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf16v.1
  (coerce-stream-debug16
    #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf16)
  (#x00 #x61 #x00 #x62 #x00 #x63))

(deftest stream-utf16.utf16v.2
  (coerce-stream-debug16
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf32be.1
  (coerce-stream-debug16
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf16v)
  (#x61 #x62 #x63))

(deftest stream-utf16.utf32be.2
  (coerce-stream-debug16
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf32le.1
  (coerce-stream-debug16
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  (#x61 #x62 #x63))

(deftest stream-utf16.utf32le.2
  (coerce-stream-debug16
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf32.1
  (coerce-stream-debug16
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf16v)
  (#x61 #x62 #x63))

(deftest stream-utf16.utf32.2
  (coerce-stream-debug16
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf16.utf32v.1
  (coerce-stream-debug16
    #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf16v)
  (#x61 #x62 #x63))

(deftest stream-utf16.utf32v.2
  (coerce-stream-debug16
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf16v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

