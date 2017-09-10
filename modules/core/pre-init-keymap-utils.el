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

(require 'cl-lib)

(defun define-vimlike-key-sets (map)
  "Define vim-like keymap sets for MAP."
  (define-key map (kbd "j") #'next-line)
  (define-key map (kbd "k") #'previous-line)
  (define-key map (kbd "J") #'scroll-up-line)
  (define-key map (kbd "K") #'scroll-down-line)
  (define-key map (kbd "b") #'scroll-down-command)
  (define-key map (kbd "g") #'beginning-of-buffer)
  (define-key map (kbd "G") #'end-of-buffer)
  (define-key map (kbd "l") #'forward-char)
  (define-key map (kbd "h") #'backward-char)
  (define-key map (kbd "w") #'forward-word)
  (define-key map (kbd "W") #'backward-word)
  (define-key map (kbd "v") #'set-mark-command))

(provide 'pre-init-keymap-utils)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-keymap-utils.el ends here
