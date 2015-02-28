;;; run-tests.el --- test helper for Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 27, 2015
;; Keywords: test

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

;;;; Initialize
(setq debug-on-error t)

(add-to-list 'load-path (concat user-emacs-directory "modules/"))
(add-to-list 'load-path (concat user-emacs-directory "lib/test/"))

(setq init-module-safe-mode-p t)
(require 'opt-init-packages)
(require 'el-get)

(setq el-get-verbose t)
(setq el-get-notify-type 'message)
(defvar el-get-local-recipe-path (file-name-as-directory (concat user-emacs-directory "etc/recipes")))
(add-to-list 'el-get-recipe-path el-get-local-recipe-path)

;;;; Internal functions
(defun el-get--recipe-exists-p (package)
  "[internal] Return non-nil if PACKAGE recipe exists."
  (ignore-errors
    (not (el-get-error-unless-package-p package))))

(defun el-get--list-local-recipes ()
  "[internal] Show el-get recipe files containing in `el-get-local-recipe-path'. "
  (cl-loop for rcp in (directory-files el-get-local-recipe-path t)
           when (string-match "\\.rcp\\'" rcp)
           collect (intern (file-name-nondirectory (file-name-sans-extension rcp)))))

;;;; Test case files
(load "test-recipe-exists")

;;;; Run all tests
(if noninteractive
    (ert-run-tests-batch-and-exit)
  (ert t))

(provide 'run-tests)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; run-tests.el ends here
