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

(require 'pre-init-core)
(require 'thingatpt)

;;;; General
;; TAB
(setq-default tab-width 4)

;; Trun at EOL
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; Scroll without moving cursor
(setq scroll-preserve-screen-position t)

;; If mark is active, any typed text replaces the selection.
(delete-selection-mode 1)

;; Enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC...
(setq set-mark-command-repeat-pop t)

;; Comment style
(setq-default comment-style 'multi-line)

;;;; Highlight
(setq transient-mark-mode t)
(global-hl-line-mode 1)
(when init-module-load-only-pre-init-files ; Use `show-smartparens-mode' commonly
  (setq show-paren-delay 0)
  (show-paren-mode 1))

(require 'generic-x)

;; http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun jkw:font-lock-comment-annotations ()
  "Highlight keywords TODO, FIXME and XXX in the comment."
  (font-lock-add-keywords
   nil
   '(("\\<\\(TODO\\|FIX\\(ME\\)?\\|XXX\\):?" 1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'jkw:font-lock-comment-annotations)

;; Whitespace
(require 'whitespace)
(setq whitespace-space-regexp "\\( +\\|\x3000+\\)") ; mono and multi-byte space
(setq whitespace-style
      '(face tabs spaces trailing newline empty space-mark tab-mark newline-mark))
(setq whitespace-display-mappings
      '((space-mark   ?\xA0   [?\u00A4]      [?_])
        (space-mark   ?\x8A0  [?\x8A4]       [?_])
        (space-mark   ?\x920  [?\x924]       [?_])
        (space-mark   ?\xE20  [?\xE24]       [?_])
        (space-mark   ?\xF20  [?\xF24]       [?_])
        (space-mark   ?\u3000 [?\u25a1])
        (newline-mark ?\n     [?$ ?\n])
        (tab-mark     ?\t     [?\u00BB ?\t]  [?\\ ?\t])))

;; Remove unneeded whitespace when saving a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;; Killing
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defun kill-region-or-kill-word (orig-fun &rest args)
  "Typing `\\[kill-region]' without mark, kill the previous word.

Advice function for `kill-region'."
  (if (and (called-interactively-p 'any) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    (apply orig-fun args)))

(advice-add 'kill-region :around #'kill-region-or-kill-word)

(defun kill-word-dwim (arg)
  "Call the `kill-word' command you want (Do What I Mean).

With argument ARG, do kill commands that many times."
  (interactive "p")
  (cond ((and (called-interactively-p 'any) transient-mark-mode mark-active)
         (kill-region (region-beginning) (region-end)))
        ((eobp)
         (backward-kill-word arg))
        (t
         (let ((char (char-to-string (char-after (point)))))
           (cond ((string-match "\n" char)
                  (delete-char 1) (delete-horizontal-space))
                 ((string-match "[\t ]" char)
                  (delete-horizontal-space))
                 ((string-match "[-@\[-`{-~]" char)
                  (kill-word arg))
                 (t
                  (beginning-of-thing 'word) (kill-word arg)))))))

;; Increment and decrement an integer at point
;; http://emacsredux.com/blog/2013/07/25/increment-and-decrement-integer-at-point/
(defun thing-at-point-goto-end-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip over optional sign
    (when (looking-at "[+-]")
      (forward-char 1))
    ;; Skip over digits
    (skip-chars-forward "[[:digit:]]")
    ;; Check for at least one digit
    (unless (looking-back "[[:digit:]]")
      (error "No integer here"))))
(put 'integer 'beginning-op 'thing-at-point-goto-end-of-integer)

(defun thing-at-point-goto-beginning-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip backward over digits
    (skip-chars-backward "[[:digit:]]")
    ;; Check for digits and optional sign
    (unless (looking-at "[+-]?[[:digit:]]")
      (error "No integer here"))
    ;; Skip backward over optional sign
    (when (looking-back "[+-]")
      (backward-char 1))))
(put 'integer 'beginning-op 'thing-at-point-goto-beginning-of-integer)

(defun thing-at-point-bounds-of-integer-at-point ()
  "Get boundaries of integer at point."
  (save-excursion
    (let (beg end)
      (thing-at-point-goto-beginning-of-integer)
      (setq beg (point))
      (thing-at-point-goto-end-of-integer)
      (setq end (point))
      (cons beg end))))
(put 'integer 'bounds-of-thing-at-point 'thing-at-point-bounds-of-integer-at-point)

(defun thing-at-point-integer-at-point ()
  "Get integer at point."
  (let ((bounds (bounds-of-thing-at-point 'integer)))
    (string-to-number (buffer-substring (car bounds) (cdr bounds)))))
(put 'integer 'thing-at-point 'thing-at-point-integer-at-point)

(defun increment-integer-at-point (&optional inc)
  "Increment integer at point by one.

With numeric prefix arg INC, increment the integer by INC amount."
  (interactive "p")
  (let ((inc (or inc 1))
        (n (thing-at-point 'integer))
        (bounds (bounds-of-thing-at-point 'integer)))
    (delete-region (car bounds) (cdr bounds))
    (insert (int-to-string (+ n inc)))))

(defun decrement-integer-at-point (&optional dec)
  "Decrement integer at point by one.

With numeric prefix arg DEC, decrement the integer by DEC amount."
  (interactive "p")
  (increment-integer-at-point (- (or dec 1))))

;; Keyboad macro
(defvar jkw:kmacro-save-file (concat user-emacs-directory "etc/kmacro.el")
  "Keyboard macro is saved in this file.")

(defun kmacro-save (symbol)
  "Save keyboard macro as SYMBOL in kmacro.el."
  (interactive "Name for last kbd macro: ")
  (name-last-kbd-macro symbol)
  (with-current-buffer (find-file-noselect jkw:kmacro-save-file)
    (goto-char (point-max))
    (insert-kbd-macro symbol)
    (basic-save-buffer)))

;;;; Keymap
(keyboard-translate ?\C-h ?\C-?)
(when mac-p
  (setq mac-command-modifier 'control)
  (setq mac-option-modifier  'meta))

(global-set-key (kbd "M-/")   'hippie-expand) ; replace `dabbrev-expand'
(global-set-key (kbd "M-d")   'kill-word-dwim)
(global-set-key (kbd "M-SPC") 'cycle-spacing) ; replace `just-one-space'
(global-set-key (kbd "C-c +") 'increment-integer-at-point)
(global-set-key (kbd "C-c -") 'decrement-integer-at-point)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-editor.el ends here
