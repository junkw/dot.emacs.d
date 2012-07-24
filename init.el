;;; init.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 24, 2012
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
;; https://github.com/purcell/emacs.d/blob/master/init-exec-path.el
(defun set-exec-path-from-shell-PATH ()
  "Inherits PATH environment variable used by the user's shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (featurep 'ns)
  (set-exec-path-from-shell-PATH)
  (add-to-list 'exec-path "~/.emacs.d/bin"))

;; Character Encoding
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(when (featurep 'ns)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Window
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; Bar
(when window-system
  (setq frame-title-format "%f")
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

;; Mode line
(setq eol-mnemonic-dos "(CR+LF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

(column-number-mode t)
(size-indication-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*") ; ignore buffer with "*"

;; TAB
(setq-default tab-width 4)

;; Highlight
(global-hl-line-mode t)
(setq show-paren-delay 0)
(show-paren-mode t)

(require 'generic-x)

;; Font
(when (find-font (font-spec :name "Ricty"))
  (set-face-attribute 'default nil
                      :family "Ricty"
                      :height 140)
  (set-fontset-font nil
                    'japanese-jisx0208
                    (font-spec :family "Ricty")))

;; Global keymap
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-S-k") 'kill-whole-line)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
