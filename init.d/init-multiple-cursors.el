;;; init-multiple-cursors.el --- el-get init file for package multiple-cursors

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 4, 2013
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

;; Preferences for running commands
(setq mc/list-file "~/.emacs.d/etc/multiple-cursors-list.el")

;;;; Keymap
(defvar jkw:global-multiple-cursors-keybinds
  '(("C-S-e"   . 'mc/edit-lines)
    ("C-S-r"   . 'mc/mark-all-in-region)
    ("C-c C-<" . 'mc/mark-all-like-this)
    ("C-c C-d" . 'mc/mark-all-like-this-dwim)
    ("C->"     . 'mc/mark-next-like-this)
    ("C-<"     . 'mc/mark-previous-like-this))
  "My global keybinds for multiple-cursors.")

(global-set-keys jkw:global-multiple-cursors-keybinds)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-multiple-cursors.el ends here
