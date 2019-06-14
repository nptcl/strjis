;;
;;  input encoding
;;
(in-package #:strjis)

;;
;;  input-ascii
;;
(defun input-ascii (input output)
  (prog (c)
    start1
    (setq c (inbyte-next input))
    start2
    (if (null c) (go finish))
    (if (< c #x20) (go control))
    (if (< c #x7F) (go ascii))
    (if (= c #x7F) (go control))
    (go recovery)

    ascii
    (charout-ascii output c)
    (go start1)

    control
    (unless (= c #x0D)
      (charout-control output c)
      (go start1))
    (setq c (inbyte-next input))
    (unless c
      (charout-control output #x0D)
      (go finish))
    (when (= c #x0A)
      (charout-control output 'eol2)
      (go start1))
    (charout-control output #x0D)
    (go start2)

    recovery
    (unless *recovery*
      (error "Invalid ascii encoding, ~x." c))
    (charout-error output c)
    (go start1)

    finish))


;;
;;  input-jis
;;
(defun input-jis1 (a b)
  (declare (type (integer #x21 #x7E) a b))
  (highlow a b))

(defun input-jis2 (output a b)
  (declare (type (integer #x21 #x7E) a b))
  (let ((ku (- a #x20))
        (code (input-jis1 a b)))
    (if (or (some (lambda (x) (= ku x)) '(2 6 7 9 10 11))
            (<= 16 ku 77))
      (charout-sub output code)
      (charout-jis2 output code))))

(defun input-jis (input output)
  (prog (c p)
    start1
    (setq c (inbyte-next input))
    start2
    (if (null c) (go finish))
    (if (= c #x1B) (go escape))
    (if (and *kana-shift* (= c #x0E)) (go kana-shift))
    (if (< c #x20) (go control))
    (if (< c #x7F) (go ascii))
    (if (= c #x7F) (go control))
    (if (<= #xA1 c #xDF) (go kana))
    (go recovery-ascii)

    ascii
    (charout-ascii output c)
    (go start1)

    control
    (unless (= c #x0D)
      (charout-control output c)
      (go start1))
    (setq c (inbyte-next input))
    (when (null c)
      (charout-control output #x0D)
      (go finish))
    (when (= c #x0A)
      (charout-control output 'eol2)
      (go start1))
    (charout-control output #x0D)
    (go start2)

    kana
    (charout-kana output (logand c #x7F))
    (go start1)

    kana-shift
    (setq c (inbyte-next input))
    (if (null c) (go finish))
    (if (= c #x0F) (go start1))
    (if (= c #x1B) (go escape))
    (when (<= #x21 c #x5F)
      (charout-kana output c)
      (go kana-shift))
    (when *recovery*
      (charout-error output c)
      (go kana-shift))
    (error "Invalid jis encoding, ~x (kana-shift)." c)

    recovery-ascii
    (when *recovery*
      (charout-error output c)
      (go start1))
    (error "Invalid jis encoding, ~x (recovery-ascii)." c)

    escape
    (setq c (inbyte-next input))
    (if (null c) (go nullcheck))
    (if (= c #x24) (go escape-24))
    (if (= c #x26) (go escape-26))
    (if (= c #x28) (go escape-28))
    (go escape1)

    escape-24
    (setq c (inbyte-next input))
    (if (null c) (go nullcheck))
    (if (= c #x28) (go escape-24-28))
    (if (= c #x40) (go jis1))
    (if (= c #x42) (go jis1))
    (go escape1)

    escape-24-28
    (setq c (inbyte-next input))
    (if (null c) (go nullcheck))
    (if (= c #x4F) (go jis1))
    (if (= c #x51) (go jis1))
    (if (= c #x44) (go jis2))
    (if (= c #x50) (go jis2))
    (go escape1)

    escape-26
    (setq c (inbyte-next input))
    (unless c (go nullcheck))
    (if (/= c #x40) (go escape1))
    (setq c (inbyte-next input))
    (unless c (go nullcheck))
    (if (/= c #x1B) (go escape1))
    (setq c (inbyte-next input))
    (unless c (go nullcheck))
    (if (/= c #x24) (go escape1))
    (setq c (inbyte-next input))
    (unless c (go nullcheck))
    (if (/= c #x42) (go escape1))
    (go jis1)

    escape-28
    (setq c (inbyte-next input))
    (if (null c) (go nullcheck))
    (if (= c #x42) (go start1))
    (if (= c #x49) (go kana-mode))
    (if (= c #x4A) (go start1))
    (go escape1)

    nullcheck
    (when *recovery*
      (charout-error output nil)
      (go finish))
    (error "Invalid jis encoding (nullcheck).")

    escape1
    (unless *recovery*
      (error "Invalid jis escape, ~x (escape1)." c))
    escape2
    (setq c (inbyte-next input))
    (unless c
      (charout-error output c)
      (go finish))
    (when (= c #x1B)
      (charout-error output c)
      (go escape))
    (go escape2)

    kana-mode
    (setq c (inbyte-next input))
    (unless c
      (go finish))
    (if (= c #x1B)
      (go escape))
    (when (<= #x21 c #x5F)
      (charout-kana output c)
      (go kana-mode))
    (if *recovery*
      (charout-error output c)
      (go kana-mode))
    (error "Invalid jis escape, ~x (kana-mode)." c)

    jis1
    (setq c (inbyte-next input))
    (unless c
      (go finish))
    (if (= c #x1B)
      (go escape))
    (if (<= #x21 c #x7E)
      (go jis1-second))
    (when *recovery*
      (charout-error output c)
      (if (eql (inbyte-next input) #x1B) ;; skip
        (go escape)
        (go jis1)))
    (error "Invalid jis escape, ~x (jis1)." c)

    jis1-second
    (setq p c c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (<= #x21 c #x7E)
      (charout-jis1 output (input-jis1 p c))
      (go jis1))
    (when *recovery*
      (charout-error output c)
      (go jis1))
    (error "Invalid jis escape, ~x ~x (jis1-second)." p c)

    jis2
    (setq c (inbyte-next input))
    (unless c
      (go finish))
    (if (= c #x1B)
      (go escape))
    (if (<= #x21 c #x7E)
      (go jis2-second))
    (when *recovery*
      (charout-error output c)
      (if (eql (inbyte-next input) #x1B) ;; skip
        (go escape)
        (go jis2)))
    (error "Invalid jis escape, ~x (jis2)." c)

    jis2-second
    (setq p c c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (<= #x21 c #x7E)
      (input-jis2 output p c)
      (go jis2))
    (when *recovery*
      (charout-error output c)
      (go jis2))
    (error "Invalid jis escape, ~x ~x (jis2-second)." p c)

    finish))


;;
;;  input-eucjis
;;
(defun input-eucjis-convert (a b)
  (declare (type (integer #xA1 #xFE) a b))
  (highlow (logand a #x7F) (logand b #x7F)))

(defun input-eucjis-second (output p c)
  (let ((v (input-eucjis-convert p c)))
    (cond ((gethash v *forward-iso4*)
           (charout-jis2 output v))
          ((gethash v *forward-jis2*)
           (charout-sub output v))
          (t (charout-sub output v)))))

(defun input-eucjis (input output)
  (prog (c p)
    start1
    (setq c (inbyte-next input))
    start2
    (if (null c) (go finish))
    (if (< c #x20) (go control))
    (if (< c #x7F) (go ascii))
    (if (= c #x7F) (go control))
    (if (= c #x8E) (go kana))
    (if (= c #x8F) (go jis2))
    (if (<= #xA1 c #xFE) (go jis1))
    (go recovery1)

    ascii
    (charout-ascii output c)
    (go start1)

    control
    (unless (= c #x0D)
      (charout-control output c)
      (go start1))
    (setq c (inbyte-next input))
    (unless c
      (charout-control output #x0D)
      (go finish))
    (when (= c #x0A)
      (charout-control output 'eol2)
      (go start1))
    (charout-control output #x0D)
    (go start2)

    kana
    (setq c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (<= #xA0 c #xDF)
      (charout-kana output (logand c #x7F))
      (go start1))
    (go recovery1)

    jis1
    (setq p c c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (<= #xA1 c #xFE)
      (charout-jis1 output (input-eucjis-convert p c))
      (go start1))
    (go recovery1)

    jis2
    (setq c (inbyte-next input))
    (unless c
      (go nullcheck))
    (if (<= #xA1 c #xFE)
      (go jis2-second))
    (go recovery1)

    jis2-second
    (setq p c c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (<= #xA1 c #xFE)
      (input-eucjis-second output p c)
      (go start1))
    (go recovery1)

    nullcheck
    (when *recovery*
      (charout-error output nil)
      (go finish))
    (error "Invalid euc-jis encoding (null).")

    recovery1
    (unless *recovery*
      (error "Invalid euc-jis encoding, ~x." c))
    (charout-error output c)
    (go start1)

    finish))


;;
;;  input-shiftjis
;;
(deftype input-shiftjis-second ()
  '(or (integer #x40 #x7E) (integer #x80 #xFC)))

(defun input-shiftjis1 (output a b)
  (check-type a (or (integer #x81 #x9F) (integer #xE0 #xEF)))
  (check-type b input-shiftjis-second)
  (when (<= #xE0 a)
    (decf a #x40))
  (when (<= #x80 b)
    (decf b 1))
  (if (<= #x9E b)
    (progn
      (setq a (ash (- a #x70) 1))
      (decf b #x7D))
    (progn
      (setq a (1- (ash (- a #x70) 1)))
      (decf b #x1F)))
  (charout-jis1 output (highlow a b)))

(defun input-shiftjis2-first (even a)
  (declare (type boolean even))
  (declare (type (integer #xF0 #xF4) a))
  (if even
    (ecase a (#xF0 #x28) (#xF1 #x24) (#xF2 #x2C) (#xF3 #x2E))
    (ecase a (#xF0 #x21) (#xF1 #x23) (#xF2 #x25) (#xF3 #x2D) (#xF4 #x2F))))

(defun input-shiftjis2 (output a b)
  (check-type a (integer #xF0 #xFC))
  (check-type b input-shiftjis-second)
  (let ((even (<= #x9F b)))
    (if (or (< a #xF4) (and (not even) (= a #xF4)))
      (setq a (input-shiftjis2-first even a))
      (progn
        (setq a (- (ash a 1) #x017B))
        (if even (incf a))))
    (decf b (cond (even #x7E)
                  ((<= b #x7E) #x1F)
                  (t #x20)))
    (charout-jis2 output (highlow a b))))

(defun input-shiftjis-convert (output a b)
  (declare (type (or (integer #x81 #x9F) (integer #xE0 #xFC)) a))
  (declare (type input-shiftjis-second b))
  (if (< a #xF0)
    (input-shiftjis1 output a b)
    (input-shiftjis2 output a b)))

(defun input-shiftjis (input output)
  (prog (c p)
    start1
    (setq c (inbyte-next input))
    start2
    (if (null c) (go finish))
    (if (< c #x20) (go control))
    (if (< c #x7F) (go ascii))
    (if (= c #x7F) (go control))
    (if (= c #x80) (go recovery1))
    (if (< c #xA0) (go jis))
    (if (< c #xE0) (go kana))
    (if (< c #xFD) (go jis))
    (go recovery1)

    ascii
    (charout-ascii output c)
    (go start1)

    control
    (unless (= c #x0D)
      (charout-control output c)
      (go start1))
    (setq c (inbyte-next input))
    (unless c
      (charout-control output #x0D)
      (go finish))
    (when (= c #x0A)
      (charout-control output 'eol2)
      (go start1))
    (charout-control output #x0D)
    (go start2)

    kana
    (charout-kana output (logand c #x7F))
    (go start1)

    jis
    (setq p c c (inbyte-next input))
    (unless c
      (go nullcheck))
    (when (or (<= #x40 c #x7E) (<= #x80 c #xFC))
      (input-shiftjis-convert output p c)
      (go start1))
    (go recovery1)

    nullcheck
    (when *recovery*
      (charout-error output nil)
      (go finish))
    (error "Invalid shift-jis encoding (null).")

    recovery1
    (unless *recovery*
      (error "Invalid shift-jis encoding, ~x." c))
    (charout-error output c)
    (go start1)

    finish))


;;
;;  input-unicode
;;
(defun input-unicode (input output &optional c)
  (prog (v)
    (if c (go start2))
    start1
    (multiple-value-setq (c v) (funcall input))
    (when (eq c 'error)
      (setq c v)
      (go invalid))
    start2
    (if (null c) (go finish))
    (if (< c #x20) (go control))
    (if (< c #x7F) (go ascii))
    (if (= c #x7F) (go control))
    (if (< c #xD800) (go unicode))
    (if (< c #xE000) (go surrogate))
    (if (< c #x110000) (go unicode))
    (go invalid)

    ascii
    (charout-unicode output c)
    (go start1)

    control
    (unless (= c #x0D)
      (charout-control output c)
      (go start1))
    (multiple-value-setq (c v) (funcall input))
    (when (eq c 'error)
      (setq c v)
      (go invalid))
    (unless c
      (charout-control output #x0D)
      (go finish))
    (when (= c #x0A)
      (charout-control output 'eol2)
      (go start1))
    (charout-control output #x0D)
    (go start2)

    unicode
    (charout-unicode output c)
    (go start1)

    surrogate
    (when *recovery* (go recovery))
    (error "Invalid unicode ~x (surrogate)." c)

    invalid
    (when *recovery* (go recovery))
    (error "Invalid unicode ~x (invalid)." c)

    recovery
    (charout-error output c)
    (go start1)

    finish))


;;
;;  input-utf8
;;
(defmacro input-utf8-sequence (input c v &optional shift)
  `(progn
     (setq ,c (inbyte-next ,input))
     (unless ,c
       (return 'error))
     (unless (<= #x80 ,c #xBF)
       (return2 'error ,c))
     ,(if shift
        `(setq ,v (logior ,v (ash (logand ,c #x3F) ,shift)))
        `(setq ,v (logior ,v (logand ,c #x3F))))))

(defun input-utf8-next (input)
  (prog (c v)
    (setq c (inbyte-next input))
    (if (null c) (return nil))
    (if (< c #x80) (go sequence1))
    (if (< c #xC0) (go invalid))
    (if (< c #xE0) (go sequence2))
    (if (< c #xF0) (go sequence3))
    (if (< c #xF8) (go sequence4))
    (if (< c #xFC) (go sequence5))
    (if (< c #xFE) (go sequence6))
    (go invalid)

    sequence1
    (return c)

    sequence2
    (setq v (ash (logand c #x1F) 6))
    (input-utf8-sequence input c v)
    (unless (<= #x0080 v)
      (return2 'error v))
    (return v)

    sequence3
    (setq v (ash (logand c #x0F) 12))
    (input-utf8-sequence input c v 6)
    (input-utf8-sequence input c v)
    (unless (<= #x0800 v)
      (return2 'error v))
    (return v)

    sequence4
    (setq v (ash (logand c #x07) 18))
    (input-utf8-sequence input c v 12)
    (input-utf8-sequence input c v 6)
    (input-utf8-sequence input c v)
    (unless (<= #x010000 v)
      (return2 'error v))
    (return v)

    sequence5
    (setq v (ash (logand c #x03) 24))
    (input-utf8-sequence input c v 18)
    (input-utf8-sequence input c v 12)
    (input-utf8-sequence input c v 6)
    (input-utf8-sequence input c v)
    (unless (<= #x00200000 v)
      (return2 'error v))
    (return v)

    sequence6
    (setq v (ash (logand c #x01) 30))
    (input-utf8-sequence input c v 24)
    (input-utf8-sequence input c v 18)
    (input-utf8-sequence input c v 12)
    (input-utf8-sequence input c v 6)
    (input-utf8-sequence input c v)
    (unless (<= #x04000000 v)
      (return2 'error v))
    (return v)

    invalid
    (return (values 'error c))))

(defun input-utf8-read (input output &optional c)
  (input-unicode
    (lambda () (input-utf8-next input))
    output c))

(defun input-utf8 (input output)
  (multiple-value-bind (c v) (input-utf8-next input)
    (cond ((null c) nil)
          ((eq c 'error)
           (unless *recovery*
             (error "UTF8-BOM error."))
           (charout-error output v)
           (input-utf8-read input output))
          ((= c #xFEFF)
           (charout-control output 'bom)
           (input-utf8-read input output))
          (t (input-utf8-read input output c)))))


;;
;;  input-utf16v
;;
(defun input-utf16-merge (a b)
  (declare (type (integer #xD800 #xDBFF) a))
  (declare (type (integer #xDC00 #xDFFF) b))
  (logior
    (ash (1+ (logand (ash a -6) #x0F)) 16)
    (ash (logand a #x3F) 10)
    (logand b #x03FF)))

(defun input-utf16v-next (input)
  (prog (a b)
    (setq a (inbyte-next input))
    (if (null a) (return nil))
    (if (< a #xD800) (return a))
    (if (< a #xDC00) (go surrogate))
    (if (< a #xE000) (return2 'error a))
    (if (< a #x010000) (return a))
    (return2 'error a)

    surrogate
    (setq b (inbyte-next input))
    (if (null b) (return 'error))
    (unless (<= #xDC00 b #xDFFF) (return2 'error b))
    (return (input-utf16-merge a b))))

(defun input-utf16v (input output)
  (input-unicode
    (lambda () (input-utf16v-next input))
    output))


;;
;;  input-utf16
;;
(defun input-utf16-next (input)
  (prog (a b x y)
    (setq x (inbyte-next input))
    (if (null x) (return nil))
    (setq y (inbyte-next input))
    (if (null y) (return 'error))
    (if *big-endian-p*
      (setq a (highlow x y))
      (setq a (highlow y x)))
    (if (< a #xD800) (return a))
    (if (< a #xDC00) (go surrogate))
    (if (< a #xE000) (return2 'error a))
    (if (< a #x010000) (return a))
    (return2 'error a)

    surrogate
    (setq x (inbyte-next input))
    (if (null x) (return 'error))
    (setq y (inbyte-next input))
    (if (null y) (return 'error))
    (if *big-endian-p*
      (setq b (highlow x y))
      (setq b (highlow y x)))
    (unless (<= #xDC00 b #xDFFF) (return2 'error b))
    (return (input-utf16-merge a b))))

(defun input-utf16le (input output)
  (let ((*big-endian-p* nil))
    (input-unicode
      (lambda () (input-utf16-next input))
      output)))

(defun input-utf16be (input output &optional c)
  (let ((*big-endian-p* t))
    (input-unicode
      (lambda () (input-utf16-next input))
      output c)))

(defun input-utf16-next-be (input)
  (let ((*big-endian-p* t))
    (input-utf16-next input)))

(defun input-utf16 (input output)
  (multiple-value-bind (c v) (input-utf16-next-be input)
    (cond ((null c))
          ((eq c 'error)
           (unless *recovery*
             (error "UTF16-BOM error."))
           (charout-error output v)
           (input-utf16le input output))
          ((= c #xFEFF)
           (charout-control output 'bom)
           (input-utf16be input output))
          ((= c #xFFFE)
           (charout-control output 'bom)
           (input-utf16le input output))
          (t (input-utf16be input output c)))))


;;
;;  input-utf32v
;;
(defun input-utf32v (input output)
  (input-unicode
    (lambda () (inbyte-next input))
    output))


;;
;;  input-utf32
;;
(defun input-utf32-next (input)
  (prog (a b c d)
    (setq a (inbyte-next input))
    (if (null a) (return nil))
    (setq b (inbyte-next input))
    (if (null b) (return 'error))
    (setq c (inbyte-next input))
    (if (null c) (return 'error))
    (setq d (inbyte-next input))
    (if (null d) (return 'error))
    (if *big-endian-p*
      (return (highlow4 a b c d))
      (return (highlow4 d c b a)))))

(defun input-utf32le (input output)
  (let ((*big-endian-p* nil))
    (input-unicode
      (lambda () (input-utf32-next input))
      output)))

(defun input-utf32be (input output &optional c)
  (let ((*big-endian-p* t))
    (input-unicode
      (lambda () (input-utf32-next input))
      output c)))

(defun input-utf32-next-be (input)
  (let ((*big-endian-p* t))
    (input-utf32-next input)))

(defun input-utf32 (input output)
  (multiple-value-bind (c v) (input-utf32-next-be input)
    (cond ((null c))
          ((eq c 'error)
           (unless *recovery*
             (error "UTF32-BOM error."))
           (charout-error output v)
           (input-utf32le input output))
          ((= c #x0000FEFF)
           (charout-control output 'bom)
           (input-utf32be input output))
          ((= c #xFFFE0000)
           (charout-control output 'bom)
           (input-utf32le input output))
          (t (input-utf32be input output c)))))

