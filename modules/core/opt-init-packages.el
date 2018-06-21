;;; opt-init-packages.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

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

(defvar jkw:el-get-preloaded-package-list-from-recipe
  '()
  "List of packages that need to load before loading `jkw:el-get-package-list-from-recipe'.")

(defvar jkw:el-get-package-list-from-recipe
  '()
  "List of packages I use straight from recipe files.")

(defvar jkw:el-get-postloaded-package-list-from-recipe
  '()
  "List of packages that need to load after loading `jkw:el-get-package-list-from-recipe'.")

;;;; Internal functions
(defun el-get--pre-initialize-el-get ()
  "[internal] Need to initialize before loading el-get."
  (setq el-get-dir (file-name-as-directory (concat user-emacs-directory "vendor")))
  (setq package-user-dir (file-name-as-directory (concat el-get-dir "package/elpa")))
  (setq el-get-user-package-directory init-module-vendors-config-path)
  (add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get"))))

(defun el-get--post-initialize-el-get ()
  "[internal] Need to initialize after loading el-get."
  (add-to-list 'el-get-recipe-path (file-name-as-directory (concat user-emacs-directory "etc/recipes")))
  (when (not (and has-terminal-notifier-p (fboundp 'alert)))
    (setq el-get-notify-type 'message))
  (el-get 'sync '(package el-get)))

(defun el-get--list-installing-packages ()
  "[internal] Return a list of installing packages via el-get."
  (let ((pkgs (append jkw:el-get-preloaded-package-list-from-recipe
                      jkw:el-get-package-list-from-recipe
                      jkw:el-get-postloaded-package-list-from-recipe)))
    pkgs))

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
  (let ((pkg (el-get--list-installing-packages)))
    (el-get 'sync pkg)))

(defun el-get-byte-recompile-all ()
  "Perform byte-recompile of all installed packages."
  (interactive)
  (cl-loop for pkg in (el-get--list-installing-packages)
           do (el-get-byte-compile pkg)
           finally (message "All packages are byte-recompiled.")))

(provide 'opt-init-packages)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-packages.el ends here
