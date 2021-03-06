;;; test-utils.el --- Utilities for testing Emacs init file

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jun. 10, 2018
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

(require 'el-get)
(require 'dash)


;;;; Initialize
(defvar el-get-origin-recipe-path
  (file-name-as-directory (concat user-emacs-directory "vendor/el-get/recipes")))
(defvar el-get-local-recipe-path
  (file-name-as-directory (concat user-emacs-directory "etc/recipes/")))

(add-to-list 'el-get-recipe-path el-get-local-recipe-path)

(defvar testcase:ignore-depends '(ace-jump-mode auto-complete mu4e))


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

(defun el-get--list-package-depends (package)
  "[internal] Return PACKAGE's :depends list."
  (let* ((source  (el-get-package-def (symbol-name package)))
         (depends (el-get-as-list (plist-get source :depends))))
    depends))

(defun el-get--missing-local-dependes (package)
  "[internal] Return migging dependencies of the local PACKAGE recipe."
  (let* ((el-get-recipe-path `(,el-get-origin-recipe-path ,el-get-local-recipe-path))
         (origin              (el-get--list-package-depends package))
         (el-get-recipe-path `(,el-get-local-recipe-path ,el-get-origin-recipe-path))
         (local               (el-get--list-package-depends package))
         (missing             (-difference (-union testcase:ignore-depends (-difference origin local))
                                           testcase:ignore-depends)))
    missing))

(provide 'test-utils)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; test-utils.el ends here
