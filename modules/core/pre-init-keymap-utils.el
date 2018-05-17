;;; pre-init-keymap-utils.el --- Emacs init file

;; Copyright (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 10, 2017
;; Keywords: .emacs, utility, keymap

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

(require 'misc)

(defun define-vim-keys (keymap)
  "Define Vim's keybinds as KEYMAP."
  (define-key keymap (kbd "0") #'beginning-of-line)
  (define-key keymap (kbd "^") #'beginning-of-line-text)
  (define-key keymap (kbd "$") #'end-of-line)
  (define-key keymap (kbd "j") #'next-line)
  (define-key keymap (kbd "k") #'previous-line)
  (define-key keymap (kbd "J") #'scroll-up-line)
  (define-key keymap (kbd "K") #'scroll-down-line)
  (define-key keymap (kbd "b") #'scroll-down-command)
  (define-key keymap (kbd "g") #'beginning-of-buffer)
  (define-key keymap (kbd "G") #'end-of-buffer)
  (define-key keymap (kbd "l") #'forward-char)
  (define-key keymap (kbd "h") #'backward-char)
  (define-key keymap (kbd "w") #'forward-to-word)
  (define-key keymap (kbd "W") #'forward-word)
  (define-key keymap (kbd "b") #'backward-to-word)
  (define-key keymap (kbd "B") #'backward-word)
  (define-key keymap (kbd "v") #'set-mark-command))

(provide 'pre-init-keymap-utils)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-keymap-utils.el ends here
