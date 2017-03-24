;;; init-dumb-jump.el --- el-get init file for package dumb-jump

;; Copyright (C) 2016  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: May. 28, 2016
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

(setq dumb-jump-default-project "~/Code/")
(setq dumb-jump-force-searcher 'rg)

;;;; Hooks
(add-hooks '(emacs-lisp-mode js2-mode php-mode) #'dumb-jump-mode)

;;;; Keymap
(define-key dumb-jump-mode-map (kbd "M-g d") #'dumb-jump-go)
(define-key dumb-jump-mode-map (kbd "M-g b") #'dumb-jump-back)
(define-key dumb-jump-mode-map (kbd "M-g ?") #'dumb-jump-quick-look)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-dumb-jump.el ends here
