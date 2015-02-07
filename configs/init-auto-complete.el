;;; init-auto-complete.el --- el-get init file for package auto-complete

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 23, 2013
;; Keywords: .emacs, completion

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

;; Candidates
(add-to-list 'ac-dictionary-directories
             (concat (el-get-package-directory "auto-complete") "dict"))
(setq ac-user-dictionary-files (concat user-emacs-directory "etc/auto-complete.dict"))
(setq ac-comphist-file (concat user-emacs-directory "var/cache/ac-comphist.dat"))

;; Enable default settings
(setq ac-auto-start 3)
(setq ac-use-menu-map t)
(when (custom-theme-active-p "monokai")
  (setq ac-fuzzy-cursor-color "#F92672"))

(add-to-list 'ac-modes 'web-mode)
(ac-config-default)
(ac-flyspell-workaround)

;;;; Keymap
(ac-set-trigger-key "TAB")
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(define-key ac-completing-map (kbd "C-M-g") 'ac-stop)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-auto-complete.el ends here
