;; Copyright (c) 2003 Nikodemus Siivola
;; 
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;; 
;; The above copyright notice and this permission notice shall be included
;; in all copies or substantial portions of the Software.
;; 
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(in-package :osicat-test)

(deftest delete-directory.1
    (let ((dir (merge-pathnames "delete-directory/" *test-dir*)))
      (ensure-directories-exist dir)
      (and (eq :directory (file-kind dir))
	   (delete-directory dir)
	   (null (file-kind dir))))
  t)

(deftest delete-directory.2
    (let* ((dir (merge-pathnames "delete-directory/" *test-dir*))
	   (file (merge-pathnames "file" dir)))
      (ensure-directories-exist dir)
      (ensure-file file)
      (and (eq :regular-file (file-kind file))
	   (eq :directory (file-kind dir))
	   (eq :error (handler-case (delete-directory dir)
			(error () :error)))))
  t)

(deftest environment.1
    (unwind-protect
	 (progn
	   (setf (environment-variable 'test-variable) "TEST-VALUE")
	   (assoc "TEST-VARIABLE" environment :test 'equal))
      (makunbound-environment-variable 'test-variable))
  ("TEST-VARIABLE" . "TEST-VALUE"))

(deftest environment-variable.1
    (environment-variable 'test-variable)
  nil)

(deftest environment-variable.2
    (unwind-protect
	 (progn
	   (setf (environment-variable 'test-variable) 'test-value)
	   (environment-variable 'test-variable))
      (makunbound-environment-variable 'test-variable))
  "TEST-VALUE")

(deftest environment-variable.3
    (unwind-protect
	 (progn
	   (setf (environment-variable "test-variable") "test-value")
	   (environment-variable 'test-variable))
      (makunbound-environment-variable "test-variable"))
  nil)

(deftest environment-variable.4
    (unwind-protect
	 (progn
	   (setf (environment-variable "test-variable") "test-value")
	   (environment-variable "test-variable"))
      (makunbound-environment-variable "test-variable"))
  "test-value")

(deftest file-kind.1
    (file-kind *test-dir*)
  :directory)

(deftest file-kind.2
    (file-kind (make-pathname :name "does-not-exist" :defaults *test-dir*))
  nil)

(deftest file-kind.3
    (let* ((file (ensure-file "tmp-file"))
	   (link (ensure-link "tmp-link" :target file)))
      (unwind-protect
	   (file-kind link)
	(delete-file link)
	(delete-file file)))
  :symbolic-link)

(deftest file-kind.4
    (let ((file (ensure-file "tmp-file")))
      (unwind-protect
	   (file-kind file)
	(delete-file file)))
  :regular-file)

(deftest make-link.1
    (let ((link (merge-pathnames "make-link-test-link" *test-dir*))
	  (file (ensure-file "tmp-file")))
      (unwind-protect
	   (progn
	     (make-link link :target file)
	     (namestring (read-link link)))
	(delete-file link)
	(delete-file file)))
  #.(namestring (merge-pathnames "tmp-file" *test-dir*)))

(deftest make-link.2
    (let ((link (merge-pathnames "make-link-test-link" *test-dir*))
	  (file (ensure-file "tmp-file")))
      (unwind-protect
	   (progn
	     (make-link link :target file)
	     (file-kind link))
	(delete-file file)
	(delete-file link)))
  :symbolic-link)
	  