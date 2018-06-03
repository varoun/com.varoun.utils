(in-package #:com.varoun.utils)

(defun assert-bug (format-control &rest format-arguments)

  "Detect that a bug has happened.  This is like calling ASSERT
   but does not have the TEST-FORM and PLACES stuff."

  (error 'simple-error
         :format-control format-control
         :format-arguments format-arguments))
