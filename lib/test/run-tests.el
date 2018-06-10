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

(defvar init-module-safe-mode-p t)
(defvar init-module-modules-directory
  (file-name-as-directory (concat user-emacs-directory "modules")))
(defvar init-module-builtins-config-directory
  (file-name-as-directory (concat init-module-modules-directory "builtins-config")))
(defvar init-module-core-directory
  (file-name-as-directory (concat init-module-modules-directory "core")))
(defvar init-module-local-config-directory
  (file-name-as-directory (concat init-module-modules-directory "local-config")))
(defvar init-module-vendors-config-directory
  (file-name-as-directory (concat init-module-modules-directory "vendors-config")))

(add-to-list 'load-path init-module-core-directory)
(add-to-list 'load-path init-module-local-config-directory)
(add-to-list 'load-path (file-name-as-directory (concat user-emacs-directory "lib/test")))

(load "opt-init-packages.el" nil t)
(load "opt-init-additional-packages.el" nil t)
(require 'el-get)

(setq el-get-verbose t)
(setq el-get-notify-type 'message)

(defvar el-get-origin-recipe-path
  (file-name-as-directory (concat user-emacs-directory "vendor/el-get/recipes")))
(defvar el-get-local-recipe-path
  (file-name-as-directory (concat user-emacs-directory "etc/recipes/")))
(add-to-list 'el-get-recipe-path el-get-local-recipe-path)

;;;; Libraries
(el-get 'sync 'dash)

(require 'el-get-dependencies)
(require 'dash)

;;;; Internal functions
(defun el-get--recipe-exists-p (package)
  "[internal] Return non-nil if PACKAGE recipe exists."
  (ignore-errors
    (not (el-get-error-unless-package-p package))))

(defun el-get--list-local-recipes ()
  "[internal] Show el-get recipe files containing in `el-get-local-recipe-path'."
  (cl-loop for rcp in (directory-files el-get-local-recipe-path t)
           when (string-match "\\.rcp\\'" rcp)
           collect (intern (file-name-base rcp))))

(defun el-get--difference-origin-and-local-dependencies (package)
  "[internal] Return PACKAGE dependencies list with only the :depends of origin that are not in local."
  (let* ((el-get-recipe-path `(,el-get-origin-recipe-path ,el-get-local-recipe-path))
         (origin-depends (el-get-dependencies package))
         (el-get-recipe-path `(,el-get-local-recipe-path ,el-get-origin-recipe-path))
         (local-depends (el-get-dependencies package)))
    (-difference origin-depends local-depends)))

;;;; Test case files
(load "test-recipe-exists")
(load "test-package-depends")

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
