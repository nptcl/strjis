(in-package #:strjis)

(defconstant +buffer-size+ 64)

(defvar *forward-ascii*)
(defvar *forward-kana*)
(defvar *forward-jis1*)
(defvar *forward-jis2*)
(defvar *forward-iso3*)
(defvar *forward-iso4*)
(defvar *forward-twice*)
(defvar *reverse-ascii*)
(defvar *reverse-kana*)
(defvar *reverse-jis1*)
(defvar *reverse-jis2*)
(defvar *reverse-iso3*)
(defvar *reverse-iso4*)
(defvar *reverse-twice*)
(defvar *east-asian-width*)
(defvar *east-asian-symbol*)

(defvar *recovery-ascii*     (list #x2E))
(defvar *recovery-jis*       (list #x1B #x24 #x28 #x51 #x22 #x2E))
(defvar *recovery-eucjis*    (list #xA2 #xAE))
(defvar *recovery-shiftjis*  (list #x81 #xAC))
(defvar *recovery-unicode*   (list #x3013))
(defvar *recovery-check*     nil)

(defvar *eol-0a*    nil)
(defvar *eol-0d*    nil)
(defvar *eol-0d0a*  nil)

(defvar *input-kana-shift* t)
(defvar *big-endian-p*)
(defvar *recovery*)
(defvar *vector-size*)
(defvar *stream-output*)
(defvar *stream-output-type* nil)
(defvar *stream-input-type* nil)
(defvar *bom-control* nil)

(deftype bytecode ()
  `(unsigned-byte 8))
(deftype jiscode ()
  `(integer 0 #xFFFF))
(deftype unicode ()
  `(integer 0 #x10FFFF))

;;  strjis
(defclass strjis () ())

