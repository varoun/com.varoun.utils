;;;; Package definition for Utilties.
(in-package :cl-user)

(defpackage #:com.varoun.utils
  (:use #:common-lisp)

  (:export #:remove-keywords
           #:nremove-keywords)

  (:export #:defun-inline
           #:defconstant-eql
           #:defconstant-equal
           #:defconstant-equalp
           #:defconstant-eqx)

  (:export #:ensure-directory-string/
           #:ensure-directory-string
           #:rebase-path)

  (:export #:assert-bug))
