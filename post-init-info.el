;;; post-init-info.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 12, 2012
;; Keywords: .emacs, info

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

(eval-after-load* 'info
  ;; In addition to INFOPATH
  (add-to-list 'Info-additional-directory-list "~/.emacs.d/share/info")
  ;; Keymap
  (defvar jkw:Info-pager-keybinds
    '(("!"   . Info-help)
      ("j"   . next-line)
      ("k"   . previous-line)
      ("J"   . (lambda () (interactive) (scroll-up 1)))
      ("K"   . (lambda () (interactive) (scroll-down 1)))
      ("b"   . Info-scroll-down)
      ("g"   . beginning-of-buffer)
      ("G"   . end-of-buffer)
      ("l"   . forward-char)
      ("h"   . backward-char)
      ("o"   . Info-follow-nearest-node)
      (":"   . Info-goto-node)
      ("M-n" . Info-next-reference)
      ("M-p" . Info-prev-reference)
      ("B"   . Info-history-back)
      ("F"   . Info-history-forward))
    "My keybinds for Info mode.")
  (define-keys Info-mode-map jkw:Info-pager-keybinds))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; post-init-info.el ends here
