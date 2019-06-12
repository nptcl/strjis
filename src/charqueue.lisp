(in-package #:strjis)

;;
;;  charqueue
;;
(defclass charqueue ()
  ((root :initform nil)
   (tail :initform nil)
   (size :initarg :size :type (integer 0 *))
   (index :initform 0 :type (integer 0 *))
   (call :initarg :call)
   (element :initarg :element)))

(defclass charbit ()
  ((next :initform nil)
   (index :initform 0)
   vector))

(defclass charqueue-any (charqueue) ())
(defclass charqueue-byte (charqueue) ())
(defclass charqueue-jiscode (charqueue) ())
(defclass charqueue-unicode (charqueue) ())

(defun make-charqueue (type element size)
  (make-instance
    type :element element :size size
    :call (lambda () (make-array size :element-type element))))

(defun make-charqueue-any (size)
  (make-charqueue 'charqueue-any t size))

(defun make-charqueue-byte (size)
  (make-charqueue 'charqueue-byte 'bytecode size))

(defun make-charqueue-jiscode (size)
  (make-charqueue 'charqueue-jiscode 'jiscode size))

(defun make-charqueue-unicode (size)
  (make-charqueue 'charqueue-unicode 'unicode size))

(defun make-charbit (inst)
  (with-slots (call) inst
    (let ((inst (make-instance 'charbit)))
      (with-slots (vector) inst
        (setq vector (funcall call)))
      inst)))

(defun push-charbit (inst c)
  (with-slots (next index vector) inst
    (when (< index (length vector))
      (when (and (zerop index) next)
        (setf (slot-value next 'index) 0))
      (setf (elt vector index) c)
      (incf index 1)
      t)))

(defun clear-charbit (inst)
  (setf (slot-value inst 'index) 0))

(defun push-next-charqueue (inst)
  (with-slots (tail) inst
    (with-slots (next) tail
      (setf (slot-value next 'index) 0)
      (setq tail next))))

(defun push-new-charqueue (inst)
  (with-slots (tail) inst
    (let ((next (make-charbit inst)))
      (setf (slot-value tail 'next) next)
      (setq tail next))))

(defun push-charqueue (inst c)
  (with-slots (root tail index) inst
    (unless root
      (setq root (make-charbit inst))
      (setq tail root))
    (unless (push-charbit tail c)
      (if (slot-value tail 'next)
        (push-next-charqueue inst)
        (push-new-charqueue inst))
      (push-charbit tail c))
    (incf index 1))
  c)

(defun pushrest-charqueue (inst &rest args)
  (dolist (c args)
    (push-charqueue inst c)))

(defun root-charqueue-p (root)
  (declare (type (or null charbit) root))
  (and root (/= (slot-value root 'index) 0)))

(defun copy-charqueue (write root pos)
  (when (root-charqueue-p root)
    (with-slots (next index vector) root
      (if (= (length vector) index)
        (setf (subseq write pos) vector)
        (setf (subseq write pos) (subseq vector 0 index)))
      (copy-charqueue write next (+ pos index)))))

(defun result-charqueue (inst)
  (with-slots (element index root) inst
    (let ((vector (make-array index :element-type element)))
      (copy-charqueue vector root 0)
      vector)))

(defun memcpy-charqueue (dst src start size)
  (dotimes (i size)
    (setf (char dst (+ start i)) (code-char (elt src i)))))

(defun copy-string-charqueue (write root pos)
  (when (root-charqueue-p root)
    (with-slots (next index vector) root
      (memcpy-charqueue write vector pos index)
      (copy-string-charqueue write next (+ pos index)))))

(defun string-charqueue (inst)
  (with-slots (element index root) inst
    (let ((string (make-string index)))
      (copy-string-charqueue string root 0)
      string)))

(defun clear-charqueue (inst)
  (with-slots (root tail index) inst
    (setq tail root)
    (when tail
      (clear-charbit tail))
    (setq index 0)))

(defun free-charqueue (inst)
  (with-slots (root tail index) inst
    (setq tail nil root nil)
    (setq index 0)))

