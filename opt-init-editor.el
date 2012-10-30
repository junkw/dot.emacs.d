;;; opt-init-editor.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 26, 2012
;; Keywords: .emacs, whitespace, kmacro

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

;; Trun at EOL
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; Scroll without moving cursor
(setq scroll-preserve-screen-position t)

;; Highlight region
(setq transient-mark-mode t)

;; Enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC...
(setq set-mark-command-repeat-pop t)

;; Comment style
(setq-default comment-style 'multi-line)

;; Make the file executable if it is a shell script
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Whitespace
(require 'whitespace)

;; Style
(setq whitespace-space-regexp "\\( +\\|\x3000+\\)") ; mono and multi-byte space
(setq whitespace-style
      '(face tabs spaces trailing newline empty space-mark tab-mark newline-mark))
(setq whitespace-display-mappings
      '(;; (space-mark   ?\      [?\u00B7]      [?.])
        (space-mark   ?\xA0   [?\u00A4]      [?_])
        (space-mark   ?\x8A0  [?\x8A4]       [?_])
        (space-mark   ?\x920  [?\x924]       [?_])
        (space-mark   ?\xE20  [?\xE24]       [?_])
        (space-mark   ?\xF20  [?\xF24]       [?_])
        (space-mark   ?\u3000 [?\u25a1])
        (newline-mark ?\n     [?$ ?\n])
        (tab-mark     ?\t     [?\u00BB ?\t]  [?\\ ?\t])))

;; Remove unneeded whitespace when saving a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Deletion and Killing
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defadvice kill-region (around kill-word-or-kill-region activate)
  "Typing C-w without mark, kill the previous word."
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

(defun kill-word-dwim (arg)
  "Call the `kill-word' command you want (Do What I Mean)."
  (interactive "p")
  (if (eolp)
      (backward-kill-word arg)
    (let ((char (char-to-string (char-after (point)))))
      (cond
       ((string= " " char)
        (delete-horizontal-space))
       ((string-match "\B" char)
        (forward-char)
        (backward-word)
        (kill-word arg))
       (t
        (kill-word arg))))))

;; Keyboad Macro
(defvar jkw:kmacro-save-file "~/.emacs.d/etc/kmacro.el"
  "Keyboard macro is saved in this file")

(defun kmacro-save (symbol)
  "Save keyboard macro in kmacro.el"
  (interactive "Name for last kbd macro: ")
  (name-last-kbd-macro symbol)
  (with-current-buffer (find-file-noselect jkw:kmacro-save-file)
    (goto-char (point-max))
    (insert-kbd-macro symbol)
    (basic-save-buffer)))

;; Keymap
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "M-d")   'kill-word-dwim)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; opt-init-editor.el ends here
