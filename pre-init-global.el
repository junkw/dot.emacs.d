;;; pre-init-global.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 15, 2012
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

;; Profile
(setq user-full-name "Jumpei KAWAMI")
(setq user-mail-address "don.t.be.trapped.by.dogma@gmail.com")

;; Paths
(when cocoa-p
  (jkw:set-env-path-from-shell "PATH"))
(add-to-list 'exec-path "~/.emacs.d/bin")

;; Character Encoding
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(when cocoa-p
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Locales
(setq system-time-locale "C")

;; Minibuffer Edit
(fset 'yes-or-no-p 'y-or-n-p)
(setq enable-recursive-minibuffers t)

;; Add last command to minibuffer history when excute `C-]'
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; Keymap
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-S-k") 'kill-whole-line)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; pre-init-global.el ends here
