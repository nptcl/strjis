(in-package #:strjis)

;;
;;  list utf8
;;
(deftest list-utf8.ascii.1
  (coerce-list "" :input 'ascii :output 'utf8)
  nil)

(deftest list-utf8.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'utf8)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-utf8.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-list #(#x20 #x80 #x40) :input 'ascii :output 'utf8 :recovery t))
  (#x20 #xE3 #x80 #x93 #x40))

(deftest list-utf8.ascii.4
  (coerce-list "Hello" :input 'ascii :output 'utf8bom)
  (#xEF #xBB #xBF  #x48 #x65 #x6C #x6C #x6F))

(deftest list-utf8.ascii.5
  (coerce-list "Hello" :input 'ascii :output 'utf8no)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-utf8.jis.1
  (coerce-list #(#x61 #x62 #x63) :input 'jis :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.jis.2
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.jis.3
  (coerce-list
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.jis.4
  (coerce-list
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.eucjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'eucjis :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.eucjis.2
  (coerce-list
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.eucjis.3
  (coerce-list
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.eucjis.4
  (coerce-list
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.shiftjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'shiftjis :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.shiftjis.2
  (coerce-list
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.shiftjis.3
  (coerce-list
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.shiftjis.4
  (coerce-list
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.1
  (coerce-list #(#x61 #x62 #x63) :input 'utf8 :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf8.2
  (coerce-list
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.3
  (coerce-list
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.4
  (coerce-list
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.5
  (coerce-list
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.6
  (coerce-list
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf8.7
  (coerce-list
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16be.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf16be.2
  (coerce-list
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16be.3
  (coerce-list
    #(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16be.4
  (coerce-list
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16le.1
  (coerce-list #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf16le.2
  (coerce-list
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16le.3
  (coerce-list
    #(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16le.4
  (coerce-list
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf16.2
  (coerce-list
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16.3
  (coerce-list
    #(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16.4
  (coerce-list
    '(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf16v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16v.3
  (coerce-list
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf16v.4
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf32be.2
  (coerce-list
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32be.3
  (coerce-list
    #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32be.4
  (coerce-list
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf32le.2
  (coerce-list
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32le.3
  (coerce-list
    #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32le.4
  (coerce-list
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf32.2
  (coerce-list
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32.3
  (coerce-list
    #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32.4
  (coerce-list
    '(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf8)
  (#x61 #x62 #x63))

(deftest list-utf8.utf32v.2
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32v.3
  (coerce-list
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest list-utf8.utf32v.4
  (coerce-list
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))


;;
;;  vector utf8
;;
(deftest vector-utf8.ascii.1
  (coerce-vector "" :input 'ascii :output 'utf8)
  #())

(deftest vector-utf8.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'utf8)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-utf8.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-vector #(#x20 #x80 #x40) :input 'ascii :output 'utf8 :recovery t))
  #(#x20 #xE3 #x80 #x93 #x40))

(deftest vector-utf8.ascii.4
  (coerce-vector "Hello" :input 'ascii :output 'utf8bom)
  #(#xEF #xBB #xBF  #x48 #x65 #x6C #x6C #x6F))

(deftest vector-utf8.ascii.5
  (coerce-vector "Hello" :input 'ascii :output 'utf8no)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-utf8.jis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'jis :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.jis.2
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.jis.3
  (coerce-vector
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.jis.4
  (coerce-vector
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.eucjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'eucjis :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.eucjis.2
  (coerce-vector
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.eucjis.3
  (coerce-vector
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.eucjis.4
  (coerce-vector
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.shiftjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'shiftjis :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.shiftjis.2
  (coerce-vector
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.shiftjis.3
  (coerce-vector
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.shiftjis.4
  (coerce-vector
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.1
  (coerce-vector #(#x61 #x62 #x63) :input 'utf8 :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf8.2
  (coerce-vector
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.3
  (coerce-vector
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.4
  (coerce-vector
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.5
  (coerce-vector
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.6
  (coerce-vector
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf8.7
  (coerce-vector
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16be.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf16be.2
  (coerce-vector
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16be.3
  (coerce-vector
    #(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16be.4
  (coerce-vector
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16le.1
  (coerce-vector #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf16le.2
  (coerce-vector
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16le.3
  (coerce-vector
    #(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16le.4
  (coerce-vector
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf16.2
  (coerce-vector
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf8)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16.3
  (coerce-vector
    #(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16.4
  (coerce-vector
    '(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf16v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16v.3
  (coerce-vector
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf16v.4
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf32be.2
  (coerce-vector
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32be.3
  (coerce-vector
    #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32be.4
  (coerce-vector
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf32le.2
  (coerce-vector
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32le.3
  (coerce-vector
    #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32le.4
  (coerce-vector
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf32.2
  (coerce-vector
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf8)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32.3
  (coerce-vector
    #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32.4
  (coerce-vector
    '(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf8)
  #(#x61 #x62 #x63))

(deftest vector-utf8.utf32v.2
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32v.3
  (coerce-vector
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8bom)
  #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
    #x61 #x62 #x63  #x0a))

(deftest vector-utf8.utf32v.4
  (coerce-vector
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8no)
  #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))


;;
;;  string utf8
;;
(deftest string-utf8.ascii.1
  (coerce-string "" :input 'ascii :output 'utf8)
  "")

(deftest string-utf8.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'utf8)
  "Hello")

(deftest string-utf8.ascii.3
  (let ((*recovery-unicode* (list #x42 #x42 #x43)))
    (coerce-string #(#x41 #x80 #x43) :input 'ascii :output 'utf8 :recovery t))
  "ABBCC")


;;
;;  stream utf8
;;
(deftest stream-utf8.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'utf8)
  nil)

(deftest stream-utf8.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf8)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-utf8.ascii.3
  (let ((*recovery-unicode* (list #x3013)))
    (coerce-stream-debug #(#x20 #x80 #x40) :input 'ascii :output 'utf8 :recovery t))
  (#x20 #xE3 #x80 #x93 #x40))

(deftest stream-utf8.ascii.4
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf8bom)
  (#xEF #xBB #xBF  #x48 #x65 #x6C #x6C #x6F))

(deftest stream-utf8.ascii.5
  (coerce-stream-debug "Hello" :input 'ascii :output 'utf8no)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-utf8.jis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'jis :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.jis.2
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.jis.3
  (coerce-stream-debug
    #(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.jis.4
  (coerce-stream-debug
    '(#x1b #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26
      #x1b #x28 #x42  #x61 #x62 #x63  #x0a)
    :input 'jis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.eucjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'eucjis :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.eucjis.2
  (coerce-stream-debug
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.eucjis.3
  (coerce-stream-debug
    #(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.eucjis.4
  (coerce-stream-debug
    '(#xa4 #xa2  #xa4 #xa4  #xa4 #xa6  #x61 #x62 #x63  #x0a)
    :input 'eucjis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.shiftjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'shiftjis :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.shiftjis.2
  (coerce-stream-debug
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.shiftjis.3
  (coerce-stream-debug
    #(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.shiftjis.4
  (coerce-stream-debug
    '(#x82 #xa0  #x82 #xa2  #x82 #xa4  #x61 #x62 #x63  #x0a)
    :input 'shiftjis :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'utf8 :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf8.2
  (coerce-stream-debug
    '(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.3
  (coerce-stream-debug
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.4
  (coerce-stream-debug
    #(#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.5
  (coerce-stream-debug
    '(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.6
  (coerce-stream-debug
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf8.7
  (coerce-stream-debug
    #(#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF
      #x61 #x62 #x63  #x0a)
    :input 'utf8 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xEF #xBB #xBF  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16be.1
  (coerce-stream-debug
    #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf16be.2
  (coerce-stream-debug
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16be.3
  (coerce-stream-debug
    #(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16be.4
  (coerce-stream-debug
    '(#x30 #x42  #x30 #x44  #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16be :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16le.1
  (coerce-stream-debug
    #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf16le.2
  (coerce-stream-debug
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16le.3
  (coerce-stream-debug
    #(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16le.4
  (coerce-stream-debug
    '(#x42 #x30  #x44 #x30  #x46 #x30  #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16le :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf16.2
  (coerce-stream-debug
    '(#xFE #xFF  #x30 #x42  #x30 #x44
      #x30 #x46  #x00 #x61  #x00 #x62  #x00 #x63  #x00 #x0a)
    :input 'utf16 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16.3
  (coerce-stream-debug
    #(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16.4
  (coerce-stream-debug
    '(#xFF #xFE  #x42 #x30  #x44 #x30  #x46 #x30
      #x61 #x00  #x62 #x00  #x63 #x00  #x0a #x00)
    :input 'utf16 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16v.1
  (coerce-stream-debug #(#x0061 #x0062 #x0063) :input 'utf16v :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf16v.2
  (coerce-stream-debug
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16v.3
  (coerce-stream-debug
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf16v.4
  (coerce-stream-debug
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf16v :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32be.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf32be.2
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32be.3
  (coerce-stream-debug
    #(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32be.4
  (coerce-stream-debug
    '(#x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44  #x00 #x00 #x30 #x46
      #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63
      #x00 #x00 #x00 #x0a)
    :input 'utf32be :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32le.1
  (coerce-stream-debug
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf32le.2
  (coerce-stream-debug
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32le.3
  (coerce-stream-debug
    #(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32le.4
  (coerce-stream-debug
    '(#x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00  #x46 #x30 #x00 #x00
      #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00
      #x0a #x00 #x00 #x00)
    :input 'utf32le :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf32.2
  (coerce-stream-debug
    '(#x00 #x00 #xFE #xFF  #x00 #x00 #x30 #x42  #x00 #x00 #x30 #x44
      #x00 #x00 #x30 #x46  #x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62
      #x00 #x00 #x00 #x63  #x00 #x00 #x00 #x0a)
    :input 'utf32 :output 'utf8)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32.3
  (coerce-stream-debug
    #(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32.4
  (coerce-stream-debug
    '(#xFF #xFE #x00 #x00  #x42 #x30 #x00 #x00  #x44 #x30 #x00 #x00
      #x46 #x30 #x00 #x00  #x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00
      #x63 #x00 #x00 #x00  #x0a #x00 #x00 #x00)
    :input 'utf32 :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32v.1
  (coerce-stream-debug #(#x0061 #x0062 #x0063) :input 'utf32v :output 'utf8)
  (#x61 #x62 #x63))

(deftest stream-utf8.utf32v.2
  (coerce-stream-debug
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86  #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32v.3
  (coerce-stream-debug
    #(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8bom)
  (#xEF #xBB #xBF  #xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86
   #x61 #x62 #x63  #x0a))

(deftest stream-utf8.utf32v.4
  (coerce-stream-debug
    '(#x3042 #x3044 #x3046  #x0061 #x0062 #x0063  #x000a)
    :input 'utf32v :output 'utf8no)
  (#xe3 #x81 #x82  #xe3 #x81 #x84  #xe3 #x81 #x86 #x61 #x62 #x63  #x0a))

