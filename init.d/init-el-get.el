;;; init-el-get.el --- el-get init file for package el-get

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 25, 2012
;; Keywords: .emacs

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

(require 'pre-init-core)
(require 'el-get)
(require 'el-get-core)
(require 'el-get-list-packages)
(require 'el-get-recipes)

;; Use function terminal-notifier-notify, when Mac OS X has terminal-notifier.app.
(when (and (file-executable-p terminal-notifier-app-path)
           (not (executable-find "growlnotify")))
  (fset 'el-get-growl 'terminal-notifier-notify))

;; el-get package menu
(defun el-get-package-menu-open-recipe ()
  "Open recipe file on package menu"
  (interactive)
  (let ((package (el-get-package-menu-get-package-name)))
    (el-get-find-recipe-file package)))

(defun el-get-package-menu-open-init-file ()
  "Open el-get init file for PACKAGE on package menu"
  (interactive)
  (let* ((package        (el-get-package-menu-get-package-name))
         (init-file-name (format "init-%s.el" package))
         (package-init-file
          (expand-file-name init-file-name el-get-user-package-directory)))
    (if (file-exists-p package-init-file)
        (find-file package-init-file)
      (when (y-or-n-p (format "Do you want to make init file for `%s'? " package))
        (find-file package-init-file)))))

;; Keymap
(define-key el-get-package-menu-mode-map "o" 'el-get-package-menu-open-recipe)
(define-key el-get-package-menu-mode-map "O" 'el-get-package-menu-open-init-file)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; init-el-get.el ends here
