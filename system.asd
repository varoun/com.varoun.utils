;;; -*- mode: lisp -*-

(in-package :common-lisp-user)

(asdf:defsystem #:com.varoun.utils
  :name "Common Utilities."
  :description "Common Utilities."
  :long-description "Common utilities."
  :depends-on (#:closer-mop)
  :components ((:file "pkgdcl")
               (:file "globals" :depends-on ("pkgdcl"))
               (:file "errors" :depends-on ("pkgdcl"))
               (:file "lists" :depends-on ("globals"))
               (:file "macros" :depends-on ("globals"))
               (:file "filesystem" :depends-on ("macros"))))
