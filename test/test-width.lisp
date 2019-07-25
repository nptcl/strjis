(in-package #:strjis)

;;
;;  east-asian<=
;;
(deftest east-asian<=.1
  (east-asian<= 100 100 nil)
  t)

(deftest east-asian<=.2
  (east-asian<= 100 101 nil)
  nil)

(deftest east-asian<=.3
  (east-asian<= 100 101 200)
  t)

(deftest east-asian<=.4
  (east-asian<= 100 201 200)
  nil)


;;
;;  east-asian-symbol
;;
(deftest east-asian-symbol.1
  (east-asian-symbol #x20)
  NA)

(deftest east-asian-symbol.2
  (east-asian-symbol #xA4)
  A)

(deftest east-asian-symbol.3
  (east-asian-symbol #x0402)
  N)

(deftest east-asian-symbol.4
  (east-asian-symbol #x0403)
  N)

(deftest east-asian-symbol.5
  (east-asian-symbol #x040F)
  N)

(deftest east-asian-symbol.6
  (east-asian-symbol #x0410)
  A)

(deftest east-asian-symbol.7
  (east-asian-symbol #x01DA87)
  N)


;;
;;  east-asian-width
;;
(deftest east-asian-width.1
  (east-asian-width #x20)
  1)

(deftest east-asian-width.2
  (east-asian-width #xA4)
  2)

(deftest east-asian-width.3
  (east-asian-width #x0402)
  1)

(deftest east-asian-width.4
  (east-asian-width #x20A9)
  1)


;;
;;  east-asian-length
;;
(deftest east-asian-length.1
  (east-asian-length "Hello")
  5)

(deftest east-asian-length.2
  (east-asian-length
    #(#x3053 #x3093 #x306B #x3061 #x306F
      #x61 #x62 #x63 #x64 #x4ECA #x65E5 #x306F))
  20)

(deftest east-asian-length.3
  (east-asian-length
    '(#x3053 #x3093 #x306B #x3061 #x306F
      #x61 #x62 #x63 #x64 #x4ECA #x65E5 #x306F))
  20)

;(deftest east-asian-length.4
;  (east-asian-length
;    (coerce
;      (mapcar
;        #'code-char
;        '(#x3053 #x3093 #x306B #x3061 #x306F
;          #x61 #x62 #x63 #x64 #x4ECA #x65E5 #x306F))
;      'string))
;  20)

