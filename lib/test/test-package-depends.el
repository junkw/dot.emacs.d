;;; test-package-depends.el --- test case for Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 28, 2015
;; Keywords: test, el-get

;;; This file is NOT part of GNU Emacs.

;;; License:
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;

;;; Change Log:
;;

;;; Code:

(require 'cl-lib)
(require 'ert)

(defmacro deftest-package-depends (package)
  `(ert-deftest ,(intern (format "test-package-%s-depends" package)) ()
     ,(format "Check if origin dependencies of the %s is subset of the local" package)
     (should (equal (el-get--difference-origin-and-local-dependencies ',package) nil))))

(defun deftest-package-depends-func (package)
  (eval `(deftest-package-depends ,package)))

(let ((packages (el-get--list-local-recipes)))
  (mapcar 'deftest-package-depends-func packages))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; test-package-depends.el ends here