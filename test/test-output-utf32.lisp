(in-package #:strjis)

;;
;;  list utf32
;;
(deftest list-utf32.ascii.1
  (coerce-list "" :input 'ascii :output 'utf32)
  nil)

(deftest list-utf32.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'utf32)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest list-utf32.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-list #(#x20 #x80 #x40) :input 'ascii :output 'utf32 :recovery t))
  (#x00 #x00 #x00 #x20 #x00 #x00 #x30 #x13 #x00 #x00 #x00 #x40))

(deftest list-utf32.ascii.4
  (coerce-list "Hello" :input 'ascii :output 'utf32v)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-utf32.ascii.5
  (coerce-list "Hello" :input 'ascii :output 'utf32)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest list-utf32.ascii.6
  (coerce-list "Hello" :input 'ascii :output 'utf32be)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest list-utf32.ascii.7
  (coerce-list "Hello" :input 'ascii :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest list-utf32.ascii.8
  (coerce-list "Hello" :input 'ascii :output 'utf32le)
  (#x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00  #x6C #x00 #x00 #x00
   #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest list-utf32.ascii.9
  (coerce-list "Hello" :input 'ascii :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00
   #x6C #x00 #x00 #x00  #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest list-utf32.jis.1
  (coerce-list #(#x61 #x62 #x63) :input 'jis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.jis.2
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.jis.3
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.jis.4
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.jis.5
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.jis.6
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest list-utf32.jis.7
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest list-utf32.eucjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'eucjis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.eucjis.2
  (coerce-list
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.eucjis.3
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.eucjis.4
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.eucjis.5
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.eucjis.6
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest list-utf32.eucjis.7
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest list-utf32.shiftjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'shiftjis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.shiftjis.2
  (coerce-list
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.shiftjis.3
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.shiftjis.4
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.shiftjis.5
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.shiftjis.6
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest list-utf32.shiftjis.7
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest list-utf32.utf8.1
  (coerce-list #(#x61 #x62 #x63) :input 'utf8 :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.utf8.2
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf8.3
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf8.4
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.5
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.6
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.7
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.8
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.9
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest list-utf32.utf8.10
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest list-utf32.utf8.11
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest list-utf32.utf8.12
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  (#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #xFF #xFE #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest list-utf32.utf8.13
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #xFF #xFE #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest list-utf32.utf16be.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.utf16be.2
  (coerce-list
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf16le.1
  (coerce-list #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.utf16le.2
  (coerce-list
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf16.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.utf16.2
  (coerce-list
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf16v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest list-utf32.utf16v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf32v)
  (#x61 #x62 #x63))

(deftest list-utf32.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  (#x61 #x62 #x63))

(deftest list-utf32.utf32le.2
  (coerce-list
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf32v)
  (#x61 #x62 #x63))

(deftest list-utf32.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest list-utf32.utf32v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf32v)
  (#x61 #x62 #x63))

(deftest list-utf32.utf32v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))


;;
;;  vector utf32
;;
(deftest vector-utf32.ascii.1
  (coerce-vector "" :input 'ascii :output 'utf32)
  #())

(deftest vector-utf32.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'utf32)
  #(#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
    #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest vector-utf32.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-vector #(#x20 #x80 #x40) :input 'ascii :output 'utf32 :recovery t))
  #(#x00 #x00 #x00 #x20 #x00 #x00 #x30 #x13 #x00 #x00 #x00 #x40))

(deftest vector-utf32.ascii.4
  (coerce-vector "Hello" :input 'ascii :output 'utf32v)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-utf32.ascii.5
  (coerce-vector "Hello" :input 'ascii :output 'utf32)
  #(#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
    #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest vector-utf32.ascii.6
  (coerce-vector "Hello" :input 'ascii :output 'utf32be)
  #(#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
    #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest vector-utf32.ascii.7
  (coerce-vector "Hello" :input 'ascii :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65
    #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest vector-utf32.ascii.8
  (coerce-vector "Hello" :input 'ascii :output 'utf32le)
  #(#x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00  #x6C #x00 #x00 #x00
    #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest vector-utf32.ascii.9
  (coerce-vector "Hello" :input 'ascii :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00  #x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00
    #x6C #x00 #x00 #x00  #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest vector-utf32.jis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'jis :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.jis.2
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.jis.3
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.jis.4
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32be)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.jis.5
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.jis.6
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32le)
  #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
    #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
    #x0a #x00 #x00 #x00))

(deftest vector-utf32.jis.7
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
    #x46 #x30 #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
    #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest vector-utf32.eucjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'eucjis :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.eucjis.2
  (coerce-vector
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.eucjis.3
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.eucjis.4
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32be)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.eucjis.5
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.eucjis.6
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32le)
  #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
    #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
    #x0a #x00 #x00 #x00))

(deftest vector-utf32.eucjis.7
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
    #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
    #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest vector-utf32.shiftjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'shiftjis :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.shiftjis.2
  (coerce-vector
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.shiftjis.3
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.shiftjis.4
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32be)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.shiftjis.5
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.shiftjis.6
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32le)
  #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
    #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
    #x0a #x00 #x00 #x00))

(deftest vector-utf32.shiftjis.7
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
    #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
    #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest vector-utf32.utf8.1
  (coerce-vector #(#x61 #x62 #x63) :input 'utf8 :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.utf8.2
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  #(#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf8.3
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  #(#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf8.4
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.5
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.6
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.7
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
    #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
    #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.8
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.9
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  #(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
    #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
    #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest vector-utf32.utf8.10
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
    #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
    #x0a #x00 #x00 #x00))

(deftest vector-utf32.utf8.11
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
    #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
    #x0a #x00 #x00 #x00))

(deftest vector-utf32.utf8.12
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
    #xFF #xFE #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
    #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest vector-utf32.utf8.13
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
    #xFF #xFE #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
    #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest vector-utf32.utf16be.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.utf16be.2
  (coerce-vector
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf16le.1
  (coerce-vector #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.utf16le.2
  (coerce-vector
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf16.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.utf16.2
  (coerce-vector
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf16v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf32)
  #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest vector-utf32.utf16v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf32v)
  #(#x61 #x62 #x63))

(deftest vector-utf32.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  #(#x61 #x62 #x63))

(deftest vector-utf32.utf32le.2
  (coerce-vector
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf32v)
  #(#x61 #x62 #x63))

(deftest vector-utf32.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest vector-utf32.utf32v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf32v)
  #(#x61 #x62 #x63))

(deftest vector-utf32.utf32v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf32v)
  #(#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))


;;
;;  string utf32
;;
(deftest string-utf32.ascii.1
  (coerce-string "" :input 'ascii :output 'utf32v)
  "")

(deftest string-utf32.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'utf32v)
  "Hello")

(deftest string-utf32.ascii.3
  (let ((*recovery-unicode* (list #x42 #x42 #x43)))
    (coerce-string #(#x41 #x80 #x43) :input 'ascii :output 'utf32v :recovery t))
  "ABBCC")


;;
;;  stream utf32
;;
(deftest stream-utf32.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'utf32)
  nil)

(deftest stream-utf32.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest stream-utf32.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-stream-debug #(#x20 #x80 #x40) :input 'ascii :output 'utf32 :recovery t))
  (#x00 #x00 #x00 #x20 #x00 #x00 #x30 #x13 #x00 #x00 #x00 #x40))

(deftest stream-utf32.ascii.4
  (coerce-stream-debug32
    "Hello" :input 'ascii :output 'utf32v)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-utf32.ascii.5
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest stream-utf32.ascii.6
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32be)
  (#x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65  #x00 #x00 #x00 #x6C
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest stream-utf32.ascii.7
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x48  #x00 #x00 #x00 #x65
   #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6C  #x00 #x00 #x00 #x6F))

(deftest stream-utf32.ascii.8
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32le)
  (#x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00  #x6C #x00 #x00 #x00
   #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest stream-utf32.ascii.9
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x48 #x00 #x00 #x00  #x65 #x00 #x00 #x00
   #x6C #x00 #x00 #x00  #x6C #x00 #x00 #x00  #x6F #x00 #x00 #x00))

(deftest stream-utf32.jis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'jis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.jis.2
  (coerce-stream-debug32
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.jis.3
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.jis.4
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.jis.5
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.jis.6
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest stream-utf32.jis.7
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest stream-utf32.eucjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'eucjis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.eucjis.2
  (coerce-stream-debug32
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.eucjis.3
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.eucjis.4
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.eucjis.5
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.eucjis.6
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest stream-utf32.eucjis.7
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest stream-utf32.shiftjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'shiftjis :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.shiftjis.2
  (coerce-stream-debug32
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.shiftjis.3
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.shiftjis.4
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.shiftjis.5
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.shiftjis.6
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest stream-utf32.shiftjis.7
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest stream-utf32.utf8.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'utf8 :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.utf8.2
  (coerce-stream-debug32
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf8.3
  (coerce-stream-debug32
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32v)
  (#x3042 #x3044 #xFEFF  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf8.4
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.5
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.6
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.7
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32be)
  (#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #xFE #xFF
   #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
   #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.8
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.9
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32bebom)
  (#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
   #x00 #x00 #xFE #xFF  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
   #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a))

(deftest stream-utf32.utf8.10
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest stream-utf32.utf8.11
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32le)
  (#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #xFF #xFE #x00 #x00
   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
   #x0a #x00 #x00 #x00))

(deftest stream-utf32.utf8.12
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  (#xFF #xFE #x00 #x00   #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #xFF #xFE #x00 #x00   #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00   #x0a #x00 #x00 #x00))

(deftest stream-utf32.utf8.13
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf32lebom)
  (#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
   #xFF #xFE #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
   #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00))

(deftest stream-utf32.utf16be.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.utf16be.2
  (coerce-stream-debug32
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf16le.1
  (coerce-stream-debug #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.utf16le.2
  (coerce-stream-debug32
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf16.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.utf16.2
  (coerce-stream-debug32
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf16v.1
  (coerce-stream-debug #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf32)
  (#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63))

(deftest stream-utf32.utf16v.2
  (coerce-stream-debug32
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf32be.1
  (coerce-stream-debug32
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf32v)
  (#x61 #x62 #x63))

(deftest stream-utf32.utf32be.2
  (coerce-stream-debug32
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf32le.1
  (coerce-stream-debug32
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  (#x61 #x62 #x63))

(deftest stream-utf32.utf32le.2
  (coerce-stream-debug32
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf32.1
  (coerce-stream-debug32
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf32v)
  (#x61 #x62 #x63))

(deftest stream-utf32.utf32.2
  (coerce-stream-debug32
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

(deftest stream-utf32.utf32v.1
  (coerce-stream-debug32
    #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf32v)
  (#x61 #x62 #x63))

(deftest stream-utf32.utf32v.2
  (coerce-stream-debug32
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf32v)
  (#x3042 #x3044 #x3046  #x61 #x62 #x63  #x0a))

