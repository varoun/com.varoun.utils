(in-package #:com.varoun.utils)

;; Constants
(defconstant-equal $crlf
   #.(format nil "~C~C" (code-char 13) (code-char 10)))

;; Filesystem interface

(defun ensure-directory-string-internal (dir)

  "Given a string, just return it, except that if it's the
   empty string, return '.' instead.  Given a pathname object,
   return a string representing the directory of the pathname,
   with a trailing slash.  Given nil, return the value of
   *default-pathname-defaults*, which is often a pathname
   object with no components supplied.  If it's empty,
   return '.'"

  (check-type dir (or pathname string null))
  (when (null dir)
    (setf dir *default-pathname-defaults*))
  (when (pathnamep dir)
    (setf dir (namestring (ensure-directory-pathname dir))))
  (when (equal dir "")
    (setf dir "."))
  dir)

(defun ensure-directory-string/ (dir)

  "Given a pathname or filename string that is intended
   to represent a directory, return it as a string that
   ALWAYS has a trailing slash."

  (setf dir (ensure-directory-string-internal dir))
  (unless (and (< 0 (length dir)) (eql (aref dir (1- (length dir))) #\/))
    (setf dir (concatenate 'string dir "/")))
  dir)

(defun ensure-directory-string (dir)

  "Given a pathname or filename string that is intended
   to represent a directory, return it as a string that
   NEVER has a trailing slash."

  (setf dir (ensure-directory-string-internal dir))
  (when (and (< 1 (length dir)) (eql (aref dir (1- (length dir))) #\/))
    (setf dir (subseq dir 0 (1- (length dir)))))
  dir)

(defun rebase-path (path old-root new-root)

  "Takes a pathname or filename string, and returns a pathname
   object.  Converts OLD-ROOT to NEW-ROOT in PATH."

  (merge-pathnames
   (enough-namestring path old-root)
   new-root))
