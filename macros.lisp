(in-package #:com.varoun.utils)

(defmacro defun-inline (name arglist &body body)
  `(progn
     (declaim (inline ,name))
     (defun ,name ,arglist ,@body)))

;;
;; Use DEFCONSTANT for numbers and keywords (DEFCONSTANT-EQL is semantically the same, but safer).
;; Use DEFCONSTANT-EQUAL for lists and strings.
;; Use DEFCONSTANT-EQUALP for arrays and structures.
;; Use DEFCONSTANT-UNEQUAL for special tags such as '(#:eof).
;;
;; "One man's constant is another man's variable." -- Alan Perlis
;;
(defmacro defconstant-eql (symbol expr &optional doc)
  `(defconstant-eqx ,symbol ,expr #'eql ,@(when doc (list doc))))

(defmacro defconstant-equal (symbol expr &optional doc)
  `(defconstant-eqx ,symbol ,expr #'equal ,@(when doc (list doc))))

(defmacro defconstant-equalp (symbol expr &optional doc)
  `(defconstant-eqx ,symbol ,expr #'equalp ,@(when doc (list doc))))

(defmacro defconstant-unequal (symbol expr &optional doc)
  `(defconstant-eqx ,symbol ,expr (constantly t) ,@(when doc (list doc))))

(defmacro defconstant-eqx (symbol expr eqx &optional doc)
  `(defconstant ,symbol
     (%defconstant-eqx-value ',symbol ,expr ,eqx)
     ,@(when doc (list doc))))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defun %defconstant-eqx-value (symbol expr eqx)
  (declare (type function eqx))
  (flet ((bummer (explanation)
           (cerror "Attempt to change value anyway"
                   "~@<bad DEFCONSTANT-EQX ~S ~2I~_~S: ~2I~_~A ~S~:>"
                  symbol expr explanation (symbol-value symbol))))
    (cond ((not (boundp symbol))
           expr)
          ((not (constantp symbol))
           (bummer "already bound as a non-constant")
           expr)
          ((not (funcall eqx (symbol-value symbol) expr))
           (bummer "already bound as a different constant value")
           expr)
          (t
           (symbol-value symbol)))))
) ;; end EVAL-WHEN
