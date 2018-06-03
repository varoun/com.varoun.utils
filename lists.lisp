(in-package #:com.varoun.utils)


(defun remove-keywords (plist keys)

  "Given a property list and a list of keys, return a new property list that omits any entries with
   any of those keys.  The returned list may share structure with PLIST."

  ;; complements of erik naggum on comp.lang.lisp
  ;; google: naggum + sans
  (let ((sans ()))
    (loop
      (let ((tail (nth-value 2 (get-properties plist keys))))
        ;; this is how it ends
        (unless tail
          (return (nreconc sans plist)))
        ;; copy all the unmatched keys
        (loop until (eq plist tail) do
                 (push (pop plist) sans)
                 (push (pop plist) sans))
        ;; skip the matched key
        (setq plist (cddr plist))))))

(defun nremove-keywords (list keywords)

  "Given a property list and a list of keys, destructively
   make and return a new property
   list that omits any entries with any of those keys."

  (loop with previous = nil
        for (key . valrest) on list by #'cddr do
        (if (member key keywords)
          (if previous
            (setf (cdr previous) (cdr valrest))
            (setf list (cdr valrest)))
          (setf previous valrest)))
  list)
