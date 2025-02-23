;;; pre-init-keymap-utils.el --- Emacs init file

;; (C) 2017  Jumpei KAWAMI

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
  (keymap-set keymap "0" #'beginning-of-line)
  (keymap-set keymap "^" #'beginning-of-line-text)
  (keymap-set keymap "$" #'end-of-line)
  (keymap-set keymap "j" #'next-line)
  (keymap-set keymap "k" #'previous-line)
  (keymap-set keymap "J" #'scroll-up-line)
  (keymap-set keymap "K" #'scroll-down-line)
  (keymap-set keymap "u" #'scroll-up-command)
  (keymap-set keymap "d" #'scroll-down-command)
  (keymap-set keymap "g" #'beginning-of-buffer)
  (keymap-set keymap "G" #'end-of-buffer)
  (keymap-set keymap "l" #'forward-char)
  (keymap-set keymap "h" #'backward-char)
  (keymap-set keymap "w" #'forward-to-word)
  (keymap-set keymap "W" #'forward-word)
  (keymap-set keymap "b" #'backward-to-word)
  (keymap-set keymap "B" #'backward-word)
  (keymap-set keymap "v" #'set-mark-command)
  (keymap-set keymap "*" #'isearch-forward-symbol-at-point)
  keymap)

(provide 'pre-init-keymap-utils)

;;; pre-init-keymap-utils.el ends here
