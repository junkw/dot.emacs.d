;;; opt-init-packages.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 21, 2015
;; Keywords: .emacs, packages, el-get, ELPA

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
(eval-when-compile
  (require 'pre-init-environments))

(defvar jkw:el-get-used-packages-preload '()
  "List of packages that need to load before loading `jkw:el-get-used-packages'.")

(defvar jkw:el-get-used-packages '()
  "List of packages I use straight from recipe files.")

(defvar jkw:el-get-used-packages-postload '()
  "List of packages that need to load after loading `jkw:el-get-used-packages'.")

;;;; Internal functions
(defun el-get--pre-initialize-el-get ()
  "[internal] Need to initialize before loading el-get."
  (setq el-get-dir (file-name-as-directory (concat user-emacs-directory "vendor")))
  (setq el-get-user-package-directory init-module-vendors-config-path)
  (setq package-user-dir (file-name-as-directory (concat el-get-dir "package/elpa")))
  (add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get"))))

(defun el-get--post-initialize-el-get ()
  "[internal] Need to initialize after loading el-get."
  (add-to-list 'el-get-recipe-path (file-name-as-directory (concat user-emacs-directory "etc/recipes")))
  (el-get 'sync '(package el-get)))

(defun el-get--list-used-packages ()
  "[internal] Return a list of installed packages via el-get."
  (append jkw:el-get-used-packages-preload
          jkw:el-get-used-packages
          jkw:el-get-used-packages-postload))

(defun el-get--installer ()
  "[internal] Install el-get and initialize ELPA."
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch el-get-install-skip-emacswiki-recipes)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;;;; Command
(defun el-get-initialize-packages ()
  "Install packages via `el-get', and initialize them."
  (interactive)
  (let ((pkg (el-get--list-used-packages)))
    (el-get 'sync pkg)))

(provide 'opt-init-packages)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-packages.el ends here
