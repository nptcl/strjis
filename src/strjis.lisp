;; strjis
;;
;; Reading a japanese text from
;;   JIS, EUC-JIS, SHIFT-JIS, UTF-8, and any Unicode encodings.
;;
;; ESCSEQ             -    1byte  2byte  mode  type
;; 1B 28 42           (B   20-7e         ascii ASCII
;; 1B 28 4A           (J   20-7e         ascii Latin
;; 1B 28 49           (I   21-5f         kana  Kana
;; 1B 24 40           $@   21-7e  21-7e  jis1  JIS78
;; 1B 24 42           $B   21-7e  21-7e  jis1  JIS83
;; 1B 26 40 1B 24 42  &@   21-7e  21-7e  jis1  JIS90
;; 1B 24 28 4F        $B   21-7e  21-7e  jis1  JIS2000-1
;; 1B 24 28 51        $B   21-7e  21-7e  jis1  JIS2004-1
;; 1B 24 28 50        $B   21-7e  21-7e  jis2  JIS2000-2
;; 1B 24 28 44        $D   21-7e  21-7e  jis2  JIS0212sub
;;
(in-package #:strjis)

(defun coerce-call2 (call x input)
  (ecase input
    (utf8        (funcall call x #'input-utf8      ))
    (jis         (funcall call x #'input-jis       ))
    (eucjp       (funcall call x #'input-eucjis    ))
    (eucjis      (funcall call x #'input-eucjis    ))
    (shiftjis    (funcall call x #'input-shiftjis  ))
    (utf16       (funcall call x #'input-utf16     ))
    (utf16v      (funcall call x #'input-utf16v    ))
    (utf16be     (funcall call x #'input-utf16be   ))
    (utf16le     (funcall call x #'input-utf16le   ))
    (utf32       (funcall call x #'input-utf32     ))
    (utf32v      (funcall call x #'input-utf32v    ))
    (utf32be     (funcall call x #'input-utf32be   ))
    (utf32le     (funcall call x #'input-utf32le   ))
    (ascii       (funcall call x #'input-ascii     ))))

(defun coerce-call3 (call x input)
  (ecase input
    (utf8        (funcall call x #'input-utf8      t   ))
    (jis         (funcall call x #'input-jis       nil ))
    (eucjp       (funcall call x #'input-eucjis    nil ))
    (eucjis      (funcall call x #'input-eucjis    nil ))
    (shiftjis    (funcall call x #'input-shiftjis  nil ))
    (utf16       (funcall call x #'input-utf16     t   ))
    (utf16v      (funcall call x #'input-utf16v    t   ))
    (utf16be     (funcall call x #'input-utf16be   t   ))
    (utf16le     (funcall call x #'input-utf16le   t   ))
    (utf32       (funcall call x #'input-utf32     t   ))
    (utf32v      (funcall call x #'input-utf32v    t   ))
    (utf32be     (funcall call x #'input-utf32be   t   ))
    (utf32le     (funcall call x #'input-utf32le   t   ))
    (ascii       (funcall call x #'input-ascii     nil ))))

(defun implementation-unicode-symbol (type)
  (when (or (eq type 'unicode)
            (eq (strjis-force-symbol type) 'unicode))
    (or (if (<= char-code-limit #xFF) 'utf8)
        (if (<= char-code-limit #xFFFF) 'utf16v)
        'utf32v)))

(defun strjis-force-symbol (type)
  (intern (remove #\- (if (symbolp type)
                        (symbol-name type)
                        type))))

(defparameter +input-symbol+
  '(utf8 jis eucjp eucjis shiftjis
         utf16 utf16v utf16be utf16le
         utf32 utf32v utf32be utf32le
         ascii))

(defun input-symbol (type)
  (or (find type +input-symbol+)
      (find (strjis-force-symbol type) +input-symbol+)
      (implementation-unicode-symbol type)
      (error "Invalid input element-type ~S." type)))

(defparameter +output-symbol+
  '(utf8 utf8bom utf8no jis eucjp eucjis shiftjis
         utf16 utf16v utf16be utf16le utf16bebom utf16lebom
         utf32 utf32v utf32be utf32le utf32bebom utf32lebom
         ascii))

(defun output-symbol (type)
  (or (find type +output-symbol+)
      (find (strjis-force-symbol type) +output-symbol+)
      (implementation-unicode-symbol type)
      (error "Invalid output element-type ~S." type)))


;;
;;  coerce-list
;;
(defun coerce-list-output (x input output)
  (ecase output
    (utf8       (coerce-call2 #'list-utf8       x input))
    (utf8bom    (coerce-call2 #'list-utf8bom    x input))
    (utf8no     (coerce-call2 #'list-utf8no     x input))
    (jis        (coerce-call3 #'list-jis        x input))
    (eucjp      (coerce-call3 #'list-eucjis     x input))
    (eucjis     (coerce-call3 #'list-eucjis     x input))
    (shiftjis   (coerce-call3 #'list-shiftjis   x input))
    (utf16      (coerce-call2 #'list-utf16      x input))
    (utf16v     (coerce-call2 #'list-utf16v     x input))
    (utf16be    (coerce-call2 #'list-utf16be    x input))
    (utf16le    (coerce-call2 #'list-utf16le    x input))
    (utf16bebom (coerce-call2 #'list-utf16bebom x input))
    (utf16lebom (coerce-call2 #'list-utf16lebom x input))
    (utf32      (coerce-call2 #'list-utf32      x input))
    (utf32v     (coerce-call2 #'list-utf32v     x input))
    (utf32be    (coerce-call2 #'list-utf32be    x input))
    (utf32le    (coerce-call2 #'list-utf32le    x input))
    (utf32bebom (coerce-call2 #'list-utf32bebom x input))
    (utf32lebom (coerce-call2 #'list-utf32lebom x input))
    (ascii      (coerce-call2 #'list-ascii      x input))))

(defun coerce-list (x &key (input 'unicode) (output 'unicode)
                      ((:recovery *recovery*))
                      ((:stream-input-type *stream-input-type*)))
  (let ((input (input-symbol input))
        (output (output-symbol output)))
    (coerce-list-output x input output)))


;;
;;  coerce-vector
;;
(defun coerce-vector-output (x input output)
  (ecase output
    (utf8       (coerce-call2 #'vector-utf8       x input))
    (utf8bom    (coerce-call2 #'vector-utf8bom    x input))
    (utf8no     (coerce-call2 #'vector-utf8no     x input))
    (jis        (coerce-call3 #'vector-jis        x input))
    (eucjp      (coerce-call3 #'vector-eucjis     x input))
    (eucjis     (coerce-call3 #'vector-eucjis     x input))
    (shiftjis   (coerce-call3 #'vector-shiftjis   x input))
    (utf16      (coerce-call2 #'vector-utf16      x input))
    (utf16v     (coerce-call2 #'vector-utf16v     x input))
    (utf16be    (coerce-call2 #'vector-utf16be    x input))
    (utf16le    (coerce-call2 #'vector-utf16le    x input))
    (utf16bebom (coerce-call2 #'vector-utf16bebom x input))
    (utf16lebom (coerce-call2 #'vector-utf16lebom x input))
    (utf32      (coerce-call2 #'vector-utf32      x input))
    (utf32v     (coerce-call2 #'vector-utf32v     x input))
    (utf32be    (coerce-call2 #'vector-utf32be    x input))
    (utf32le    (coerce-call2 #'vector-utf32le    x input))
    (utf32bebom (coerce-call2 #'vector-utf32bebom x input))
    (utf32lebom (coerce-call2 #'vector-utf32lebom x input))
    (ascii      (coerce-call2 #'vector-ascii      x input))))

(defun coerce-vector (x &key (input 'unicode) (output 'unicode)
                        ((:size *vector-size*) +buffer-size+)
                        ((:recovery *recovery*))
                        ((:stream-input-type *stream-input-type*)))
  (let ((input (input-symbol input))
        (output (output-symbol output)))
    (coerce-vector-output x input output)))


;;
;;  coerce-string
;;
(defun coerce-string-output (x input output)
  (ecase output
    (utf8       (coerce-call2 #'string-utf8       x input))
    (utf8bom    (coerce-call2 #'string-utf8bom    x input))
    (utf8no     (coerce-call2 #'string-utf8no     x input))
    (jis        (coerce-call3 #'string-jis        x input))
    (eucjp      (coerce-call3 #'string-eucjis     x input))
    (eucjis     (coerce-call3 #'string-eucjis     x input))
    (shiftjis   (coerce-call3 #'string-shiftjis   x input))
    (utf16      (coerce-call2 #'string-utf16      x input))
    (utf16v     (coerce-call2 #'string-utf16v     x input))
    (utf16be    (coerce-call2 #'string-utf16be    x input))
    (utf16le    (coerce-call2 #'string-utf16le    x input))
    (utf16bebom (coerce-call2 #'string-utf16bebom x input))
    (utf16lebom (coerce-call2 #'string-utf16lebom x input))
    (utf32      (coerce-call2 #'string-utf32      x input))
    (utf32v     (coerce-call2 #'string-utf32v     x input))
    (utf32be    (coerce-call2 #'string-utf32be    x input))
    (utf32le    (coerce-call2 #'string-utf32le    x input))
    (utf32bebom (coerce-call2 #'string-utf32bebom x input))
    (utf32lebom (coerce-call2 #'string-utf32lebom x input))
    (ascii      (coerce-call2 #'string-ascii      x input))))

(defun coerce-string (x &key (input 'unicode) (output 'unicode)
                        ((:size *vector-size*) +buffer-size+)
                        ((:recovery *recovery*))
                        ((:stream-input-type *stream-input-type*)))
  (let ((input (input-symbol input))
        (output (output-symbol output)))
    (coerce-string-output x input output)))


;;
;;  coerce-stream
;;
(defun coerce-stream-output (x input output)
  (ecase output
    (utf8       (coerce-call2 #'stream-utf8       x input))
    (utf8bom    (coerce-call2 #'stream-utf8bom    x input))
    (utf8no     (coerce-call2 #'stream-utf8no     x input))
    (jis        (coerce-call3 #'stream-jis        x input))
    (eucjp      (coerce-call3 #'stream-eucjis     x input))
    (eucjis     (coerce-call3 #'stream-eucjis     x input))
    (shiftjis   (coerce-call3 #'stream-shiftjis   x input))
    (utf16      (coerce-call2 #'stream-utf16      x input))
    (utf16v     (coerce-call2 #'stream-utf16v     x input))
    (utf16be    (coerce-call2 #'stream-utf16be    x input))
    (utf16le    (coerce-call2 #'stream-utf16le    x input))
    (utf16bebom (coerce-call2 #'stream-utf16bebom x input))
    (utf16lebom (coerce-call2 #'stream-utf16lebom x input))
    (utf32      (coerce-call2 #'stream-utf32      x input))
    (utf32v     (coerce-call2 #'stream-utf32v     x input))
    (utf32be    (coerce-call2 #'stream-utf32be    x input))
    (utf32le    (coerce-call2 #'stream-utf32le    x input))
    (utf32bebom (coerce-call2 #'stream-utf32bebom x input))
    (utf32lebom (coerce-call2 #'stream-utf32lebom x input))
    (ascii      (coerce-call2 #'stream-ascii      x input))))

(defun coerce-stream (x y &key (input 'unicode) (output 'unicode)
                        ((:size *vector-size*) +buffer-size+)
                        ((:recovery *recovery*))
                        ((:stream-input-type *stream-input-type*))
                        ((:stream-output-type *stream-output-type*)))
  (let ((input (input-symbol input))
        (output (output-symbol output))
        (*stream-output* y))
    (coerce-stream-output x input output)))

