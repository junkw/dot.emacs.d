;;; test-recipe-exists.el --- test case for Emacs init file

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
(require 'run-tests)

(defmacro deftest-recipe-exists (package)
  `(ert-deftest ,(intern (format "test-%s-recipe-exists" package)) ()
     ,(format "Check if the %s recipe exists" package)
     (should (el-get--recipe-exists-p ',package))))

(defun deftest-recipe-exists-func (package)
  (eval `(deftest-recipe-exists ,package)))

(let ((packages (el-get--list-installing-packages)))
  (mapcar 'deftest-recipe-exists-func packages))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; test-recipe-exists.el ends here
