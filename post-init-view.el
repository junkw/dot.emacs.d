;;; opt-init-view.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 6, 2012
;; Keywords: .emacs, view mode

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

;; Opening read-only file, enable view mode.
(setq view-read-only t)

(eval-after-load-q 'view
  ;; Keymap
  (defvar jkw:view-pager-keybinds
    '(("j" . next-line)
      ("k" . previous-line)
      ("J" . View-scroll-line-forward)
      ("K" . View-scroll-line-forward)
      ("b" . View-scroll-page-backward)
      ("g" . beginning-of-buffer)
      ("G" . end-of-buffer)
      ("l" . forward-char)
      ("h" . backward-char)
      ("w" . forward-word)
      ("W" . backward-word))
    "My keybinds for View mode.")
  (jkw:define-keys view-mode-map jkw:view-pager-keybinds))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-view.el ends here
