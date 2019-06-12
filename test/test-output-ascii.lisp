(in-package #:strjis)

;;
;;  list ascii
;;
(deftest list-ascii.ascii.1
  (coerce-list "" :input 'ascii :output 'ascii)
  nil)

(deftest list-ascii.ascii.2
  (coerce-list "Hello" :input 'ascii :output 'ascii)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest list-ascii.ascii.3
  (let ((*recovery-ascii* (list #x44 #x55 #x66)))
    (coerce-list #(#x20 #x80 #x40) :input 'ascii :output 'ascii :recovery t))
  (#x20 #x44 #x55 #x66 #x40))

(deftest list-ascii.jis.1
  (coerce-list #(#x61 #x62 #x63) :input 'jis :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.eucjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'eucjis :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.shiftjis.1
  (coerce-list #(#x61 #x62 #x63) :input 'shiftjis :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf8.1
  (coerce-list #(#x61 #x62 #x63) :input 'utf8 :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf16be.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf16le.1
  (coerce-list #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf16.1
  (coerce-list #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf16v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf16v :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf32be.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf32le.1
  (coerce-list
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf32.1
  (coerce-list
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'ascii)
  (#x61 #x62 #x63))

(deftest list-ascii.utf32v.1
  (coerce-list #(#x0061 #x0062 #x0063) :input 'utf32v :output 'ascii)
  (#x61 #x62 #x63))


;;
;;  vector ascii
;;
(deftest vector-ascii.ascii.1
  (coerce-vector "" :input 'ascii :output 'ascii)
  #())

(deftest vector-ascii.ascii.2
  (coerce-vector "Hello" :input 'ascii :output 'ascii)
  #(#x48 #x65 #x6C #x6C #x6F))

(deftest vector-ascii.ascii.3
  (let ((*recovery-ascii* (list #x44 #x55 #x66)))
    (coerce-vector #(#x20 #x80 #x40) :input 'ascii :output 'ascii :recovery t))
  #(#x20 #x44 #x55 #x66 #x40))

(deftest vector-ascii.jis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'jis :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.eucjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'eucjis :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.shiftjis.1
  (coerce-vector #(#x61 #x62 #x63) :input 'shiftjis :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf8.1
  (coerce-vector #(#x61 #x62 #x63) :input 'utf8 :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf16be.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf16le.1
  (coerce-vector #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf16.1
  (coerce-vector #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf16v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf16v :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf32be.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf32le.1
  (coerce-vector
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf32.1
  (coerce-vector
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'ascii)
  #(#x61 #x62 #x63))

(deftest vector-ascii.utf32v.1
  (coerce-vector #(#x0061 #x0062 #x0063) :input 'utf32v :output 'ascii)
  #(#x61 #x62 #x63))


;;
;;  string utf8
;;
(deftest string-ascii.ascii.1
  (coerce-string "" :input 'ascii :output 'ascii)
  "")

(deftest string-ascii.ascii.2
  (coerce-string "Hello" :input 'ascii :output 'ascii)
  "Hello")

(deftest string-ascii.ascii.3
  (let ((*recovery-ascii* (list #x42 #x42 #x43)))
    (coerce-string #(#x41 #x80 #x43) :input 'ascii :output 'ascii :recovery t))
  "ABBCC")


;;
;;  stream ascii
;;
(deftest stream-ascii.ascii.1
  (coerce-stream-debug "" :input 'ascii :output 'ascii)
  nil)

(deftest stream-ascii.ascii.2
  (coerce-stream-debug "Hello" :input 'ascii :output 'ascii)
  (#x48 #x65 #x6C #x6C #x6F))

(deftest stream-ascii.ascii.3
  (let ((*recovery-ascii* (list #x44 #x55 #x66)))
    (coerce-stream-debug #(#x20 #x80 #x40) :input 'ascii :output 'ascii :recovery t))
  (#x20 #x44 #x55 #x66 #x40))

(deftest stream-ascii.jis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'jis :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.eucjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'eucjis :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.shiftjis.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'shiftjis :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf8.1
  (coerce-stream-debug #(#x61 #x62 #x63) :input 'utf8 :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf16be.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16be :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf16le.1
  (coerce-stream-debug #(#x61 #x00 #x62 #x00 #x63 #x00) :input 'utf16le :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf16.1
  (coerce-stream-debug #(#x00 #x61 #x00 #x62 #x00 #x63) :input 'utf16 :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf16v.1
  (coerce-stream-debug #(#x0061 #x0062 #x0063) :input 'utf16v :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf32be.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32be :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf32le.1
  (coerce-stream-debug
    #(#x61 #x00 #x00 #x00  #x62 #x00 #x00 #x00  #x63 #x00 #x00 #x00)
    :input 'utf32le :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf32.1
  (coerce-stream-debug
    #(#x00 #x00 #x00 #x61  #x00 #x00 #x00 #x62  #x00 #x00 #x00 #x63)
    :input 'utf32 :output 'ascii)
  (#x61 #x62 #x63))

(deftest stream-ascii.utf32v.1
  (coerce-stream-debug #(#x0061 #x0062 #x0063) :input 'utf32v :output 'ascii)
  (#x61 #x62 #x63))

