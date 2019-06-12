(in-package #:strjis)

;;
;;  range
;;
(deftest return2.1
  (block nil
    (return2 10 20))
  10 20)

(deftest highlow.1
  (highlow #xAB #xCD)
  #xABCD)

(deftest highlow4.1
  (highlow4 #xAB #xCD #x12 #x34)
  #xABCD1234)

(deftest split2-byte.1
  (split2-byte #x12)
  0 #x12)

(deftest split2-byte.2
  (split2-byte #x1234)
  #x12 #x34)

(deftest split4-byte.1
  (split4-byte #x1234)
  0 0 #x12 #x34)

(deftest split4-byte.2
  (split4-byte #x1234ABCD)
  #x12 #x34 #xAB #xCD)

(deftest pushdolist.1
  (let (list)
    (push 'a list)
    (pushdolist '(b c d) list)
    list)
  (d c b a))

