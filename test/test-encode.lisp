(in-package #:strjis)

;;
;;  shirtjis
;;
;; shiftjis-jis1
(deftest shiftjis-jis1.1
  (shiftjis-jis1 #x2121)
  #x81 #x40)

(deftest shiftjis-jis1.2
  (shiftjis-jis1 #x2122)
  #x81 #x41)

(deftest shiftjis-jis1.3
  (shiftjis-jis1 #x215F)
  #x81 #x7E)

(deftest shiftjis-jis1.4
  (shiftjis-jis1 #x2160)
  #x81 #x80)

(deftest shiftjis-jis1.5
  (shiftjis-jis1 #x2221)
  #x81 #x9F)

(deftest shiftjis-jis1.6
  (shiftjis-jis1 #x227E)
  #x81 #xFC)

(deftest shiftjis-jis1.7
  (shiftjis-jis1 #x2321)
  #x82 #x40)

(deftest shiftjis-jis1.8
  (shiftjis-jis1 #x235F)
  #x82 #x7E)

(deftest shiftjis-jis1.9
  (shiftjis-jis1 #x2360)
  #x82 #x80)

(deftest shiftjis-jis1.10
  (shiftjis-jis1 #x237E)
  #x82 #x9E)

(deftest shiftjis-jis1.11
  (shiftjis-jis1 #x2421)
  #x82 #x9F)

(deftest shiftjis-jis1.12
  (shiftjis-jis1 #x3021)
  #x88 #x9F)

(deftest shiftjis-jis1.13
  (shiftjis-jis1 #x5F21)
  #xE0 #x40)

(deftest shiftjis-jis1.14
  (shiftjis-jis1 #x6021)
  #xE0 #x9F)

(deftest shiftjis-jis1.15
  (shiftjis-jis1 #x7E7E)
  #xEF #xFC)

;; shiftjis-jis2-first
(deftest shiftjis-jis2-first.1
  (shiftjis-jis2-first #x21)
  t)

(deftest shiftjis-jis2-first.2
  (shiftjis-jis2-first #x2B)
  nil)

(deftest shiftjis-jis2-first.3
  (shiftjis-jis2-first #x2C)
  t)

;; shiftjis-jis2
(deftest shiftjis-jis2.1
  (shiftjis-jis2 #x2121)
  #xF0 #x40)

(deftest shiftjis-jis2.2
  (shiftjis-jis2 #x2221)
  nil)

(deftest shiftjis-jis2.3
  (shiftjis-jis2 #x2161)
  #xF0 #x81)

(deftest shiftjis-jis2.4
  (shiftjis-jis2 #x2321)
  #xF1 #x40)

(deftest shiftjis-jis2.5
  (shiftjis-jis2 #x2361)
  #xF1 #x81)

(deftest shiftjis-jis2.6
  (shiftjis-jis2 #x237E)
  #xF1 #x9E)

(deftest shiftjis-jis2.7
  (shiftjis-jis2 #x7E21)
  #xFC #x9F)

(deftest shiftjis-jis2.8
  (shiftjis-jis2 #x7E61)
  #xFC #xDF)

(deftest shiftjis-jis2.9
  (shiftjis-jis2 #x7E76)
  #xFC #xF4)


;;
;;  utf16
;;
(deftest utf16-surrogate.1
  (coerce-list
    #(#x40 #x50 #xFFFF #x010000 #x0ABCDE #x60)
    :input 'utf32v :output 'utf16v)
  (#x0040  #x0050  #xffff  #xd800 #xdc00  #xda6f #xdcde  #x0060))

(deftest utf16-surrogate.2
  (coerce-list
    '(#x0040  #x0050  #xffff  #xd800 #xdc00  #xda6f #xdcde  #x0060)
    :input 'utf16v :output 'utf32v)
  (#x40 #x50 #xFFFF #x010000 #x0ABCDE #x60))

