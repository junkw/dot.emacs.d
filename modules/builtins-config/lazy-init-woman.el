;;; lazy-init-woman.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, man, woman

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

(require 'pre-init-keymap-utils)

;; Paths
(add-to-list 'woman-manpath (concat user-emacs-directory "share/man"))
(setq woman-cache-filename (concat user-emacs-directory "var/cache/woman")) ; Update cache: C-u M-x woman

;; Doesn't make new frame
(setq woman-use-own-frame nil)

;; For imenu
(setq woman-imenu t)
(setq woman-imenu-generic-expression
      '((nil "\n\\([A-Z].*\\|\\cj.*\\)" 1)
        ("*Subsections*" "\\` \\{3,4\\}\\([A-Z].*\\|\\cj.*\\)" 1)))

;; Jump to SEE ALSO by <r>
(setq Man-see-also-regexp "\\(SEE ALSO\\|関連項目\\)")

;; Jump to heading by <n> and <p>
(setq Man-first-heading-regexp
      "\\`\\(NAME\\|名[前称]\\|[ \t]*No manual entry fo.*\\)\\'")
(setq Man-heading-regexp "\\`\\([A-Z][A-Z0-9 /-]+\\|\\cj+\\)\\'")

;;;; Keymap
(define-vimlike-key-sets woman-mode-map)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; lazy-init-woman.el ends here
