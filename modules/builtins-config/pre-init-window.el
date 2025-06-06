;;; pre-init-window.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, window

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

;;;; Window
(setopt initial-major-mode 'emacs-lisp-mode)
(setopt use-dialog-box nil)

;;;; Mode line
(setopt eol-mnemonic-dos  "+CR/LF")
(setopt eol-mnemonic-mac  "+CR")
(setopt eol-mnemonic-unix "+LF")
(setopt eol-mnemonic-undecided "")

(column-number-mode +1)
(size-indication-mode +1)

(require 'uniquify)
(setopt uniquify-buffer-name-style 'post-forward-angle-brackets)
(setopt uniquify-ignore-buffers-re "*[^*]+*") ; ignore buffer with "*"

;;;; Echo line
(setopt echo-keystrokes 0.1)              ; display rate (sec.)

;; Disable BiDi
(setq-default bidi-display-reordering nil)
(setq-default bidi-paragraph-direction 'left-to-right)

;;; pre-init-window.el ends here
