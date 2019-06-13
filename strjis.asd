;;
;;  module
;;
(defsystem strjis
  :description "Japanese text reader"
  :version "1.0.0"
  :author "nptcl <nptlisp@gmail.com>"
  :licence "Unlicense"
  :in-order-to ((test-op (test-op strjis/test)))
  :pathname "src"
  :components
    ((:file "package")
     (:file "utils" :depends-on ("package"))
     (:file "type" :depends-on ("package"))
     (:file "table" :depends-on ("type"))
     (:file "inbyte" :depends-on ("type"))
     (:file "width" :depends-on ("utils" "table"))
     (:file "charqueue" :depends-on ("type"))
     (:file "charout" :depends-on ("type" "charqueue"))
     (:file "input" :depends-on ("inbyte" "charout" "table"))
     (:file "ascii" :depends-on ("inbyte" "charout" "table"))
     (:file "jis" :depends-on ("inbyte" "charout"))
     (:file "eucjis" :depends-on ("inbyte" "charout"))
     (:file "shiftjis" :depends-on ("inbyte" "charout" "table"))
     (:file "utf8" :depends-on ("inbyte" "charout"))
     (:file "utf16" :depends-on ("inbyte" "charout"))
     (:file "utf32" :depends-on ("inbyte" "charout"))
     (:file "strjis" :depends-on
       ("input" "ascii" "jis" "eucjis" "shiftjis" "utf8" "utf16" "utf32"))))


;;
;;  test
;;
(defsystem strjis/test
  :depends-on (strjis rt)
  :pathname "test"
  :perform (test-op (o s)
             (uiop:symbol-call 'rt 'do-tests)
             (fresh-line))
  :perform (test-op :after (o s)
             (uiop:symbol-call 'strjis 'test-after)
             (fresh-line))
  :serial t
  :components
    ((:file "test-operator")
     (:file "test-utils" :depends-on ("test-operator"))
     (:file "test-inbyte" :depends-on ("test-operator"))
     (:file "test-width" :depends-on ("test-operator"))
     (:file "test-charqueue" :depends-on ("test-operator"))
     (:file "test-input-ascii" :depends-on ("test-operator"))
     (:file "test-input-jis" :depends-on ("test-operator"))
     (:file "test-input-eucjis" :depends-on ("test-operator"))
     (:file "test-input-shiftjis" :depends-on ("test-operator"))
     (:file "test-input-utf8" :depends-on ("test-operator"))
     (:file "test-input-utf16" :depends-on ("test-operator"))
     (:file "test-input-utf32" :depends-on ("test-operator"))
     (:file "test-output-ascii" :depends-on ("test-operator"))
     (:file "test-output-jis" :depends-on ("test-operator"))
     (:file "test-output-eucjis" :depends-on ("test-operator"))
     (:file "test-output-shiftjis" :depends-on ("test-operator"))
     (:file "test-output-utf8" :depends-on ("test-operator"))
     (:file "test-output-utf16" :depends-on ("test-operator"))
     (:file "test-output-utf32" :depends-on ("test-operator"))
     (:file "test-encode" :depends-on ("test-operator"))
     (:file "test-strjis" :depends-on ("test-operator"))))

