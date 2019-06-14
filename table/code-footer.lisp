
;;
;;  make unicode table
;;
(defun defstrjis (forward reverse size input)
  (let ((fwd (make-hash-table :test 'eql :size size))
        (rev (make-hash-table :test 'eql :size size)))
    (dolist (c (symbol-value input))
      (destructuring-bind (x . y) c
        (setf (gethash x fwd) y)
        (unless (eq y t)
          (setf (gethash y rev) x))))
    (setf (symbol-value forward) fwd)
    (setf (symbol-value reverse) rev)
    (makunbound input)))

(defun defsingle (symbol size input)
  (let ((table (make-hash-table :test 'eql :size size)))
    (dolist (c (symbol-value input))
      (destructuring-bind (x . y) c
        (setf (gethash x table) y)))
    (setf (symbol-value symbol) table)
    (makunbound input)))

(defun deftwice (forward reverse size input)
  (let ((fwd (make-hash-table :test 'eql :size size))
        (rev (make-hash-table :test 'eql :size size)))
    (dolist (c (symbol-value input))
      (destructuring-bind (x y z) c
        (setf (gethash x fwd) (list y z))
        (setf (gethash y rev) (list z x))))
    (setf (symbol-value forward) fwd)
    (setf (symbol-value reverse) rev)
    (makunbound input)))

(defun define-strjis ()
  (defstrjis '*forward-ascii* '*reverse-ascii* +size-ascii+ '*input-ascii*)
  (defstrjis '*forward-kana* '*reverse-kana* +size-kana+ '*input-kana*)
  (defstrjis '*forward-jis1* '*reverse-jis1* +size-jis1+ '*input-jis1*)
  (defstrjis '*forward-jis2* '*reverse-jis2* +size-jis2+ '*input-jis2*)
  (defstrjis '*forward-iso3* '*reverse-iso3* +size-iso3+ '*input-iso3*)
  (defstrjis '*forward-iso4* '*reverse-iso4* +size-iso4+ '*input-iso4*)
  (defsingle '*forward-zenkaku* +size-zenkaku+ '*input-zenkaku*)
  (deftwice '*forward-twice* '*reverse-twice* +size-twice+ '*input-twice*))

(define-strjis)

