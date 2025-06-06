;;; post-init-editor.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
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

;;;; General
(require 'thingatpt)

;; TAB
(setq-default tab-width 4)

;; Trun at EOL
(setopt truncate-lines nil)
(setopt truncate-partial-width-windows nil)

;; Disable auto indentation
(electric-indent-mode -1)

;; Scroll without moving cursor
(setopt scroll-preserve-screen-position t)

;; If mark is active, any typed text replaces the selection.
(delete-selection-mode +1)

;; Enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC...
(setopt set-mark-command-repeat-pop t)

;; Comment style
(setq-default comment-style 'multi-line)

;;;; Highlight
(setopt transient-mark-mode t)
(global-hl-line-mode +1)

(require 'generic-x)

;; http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun jkw:font-lock-comment-annotations ()
  "Highlight keywords TODO, FIXME and XXX in the comment."
  (font-lock-add-keywords
   nil
   '(("\\<\\(TODO\\|FIX\\(ME\\)?\\|XXX\\):?" 1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'jkw:font-lock-comment-annotations)

;;;; Documentation
(require 'eldoc)
(setopt eldoc-idle-delay 0.2)
(setopt eldoc-minor-mode-string "")
(setopt eldoc-echo-area-use-multiline-p t)

;; Whitespace
(require 'whitespace)
(setopt whitespace-space-regexp "\\( +\\|\x3000+\\)") ; mono and multi-byte space
(setopt whitespace-style
        '(face tabs spaces trailing newline empty space-mark tab-mark newline-mark))
(setopt whitespace-display-mappings
        '((space-mark   ?\xA0   [?\u00A4]      [?_])
          (space-mark   ?\x8A0  [?\x8A4]       [?_])
          (space-mark   ?\x920  [?\x924]       [?_])
          (space-mark   ?\xE20  [?\xE24]       [?_])
          (space-mark   ?\xF20  [?\xF24]       [?_])
          (space-mark   ?\u3000 [?\u25a1])
          (newline-mark ?\n     [?$ ?\n])
          (tab-mark     ?\t     [?\u00BB ?\t]  [?\\ ?\t])))

(defvar delete-trailing-whitespace--enabled-flag-p t)
(defun delete-trailing-whitespace--enabled-flag (orig-fun &rest args)
  "Remove unneeded whitespace when saving a file.

If `delete-trailing-whitespace--enabled-flag-p' is nil, don't excute
`delete-trailing-whitespace'.
\"(setq-local delete-trailing-whitespace--enabled-flag-p nil)\"

Advice function for ORIG-FUN `delete-trailing-whitespace' (the ARGS is region)."
  (if delete-trailing-whitespace--enabled-flag-p
      (apply orig-fun args)))
(advice-add 'delete-trailing-whitespace :around #'delete-trailing-whitespace--enabled-flag)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;;;; Spell check
(let ((hunspell (executable-find "hunspell")))
  (when hunspell
    (setopt ispell-program-name hunspell)
    (setopt ispell-local-dictionary "en_US")
    (setopt ispell-local-dictionary-alist
            '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))
    (setopt ispell-really-hunspell t)))
(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")) ; for Japanese

;;;; Killing
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defun kill-region--or-kill-word (orig-fun &rest args)
  "Typing `\\[kill-region]' without mark, kill the previous word.

Advice function for ORIG-FUN `kill-region' (the ARGS is region)."
  (if (and (called-interactively-p 'any) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    (apply orig-fun args)))

(advice-add 'kill-region :around #'kill-region--or-kill-word)

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
  (let ((save-match-data t))
    ;; Skip over optional sign
    (when (looking-at "[+-]")
      (forward-char 1))
    ;; Skip over digits
    (skip-chars-forward "[[:digit:]]")
    ;; Check for at least one digit
    (unless (looking-back "[[:digit:]]" 1)
      (error "No integer here"))))
(put 'integer 'beginning-op 'thing-at-point-goto-end-of-integer)

(defun thing-at-point-goto-beginning-of-integer ()
  "Go to end of integer at point."
  (let ((save-match-data t))
    ;; Skip backward over digits
    (skip-chars-backward "[[:digit:]]")
    ;; Check for digits and optional sign
    (unless (looking-at "[+-]?[[:digit:]]")
      (error "No integer here"))
    ;; Skip backward over optional sign
    (when (looking-back "[+-]" 1)
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

;; Rectangle
;; https://twitter.com/rubikitch/status/718219606578589697
(defun quote-rectangle (start end)
  "Quote region from START to END."
  (interactive "r")
  (string-rectangle start end "> "))

;;;; Keymap
(keymap-global-set "M-/"   #'hippie-expand)  ; replace `dabbrev-expand'
(keymap-global-set "M-d"   #'kill-word-dwim) ; override when `easy-kill' is used
(keymap-global-set "M-SPC" #'cycle-spacing)  ; replace `just-one-space'
(keymap-global-set "C-c +" #'increment-integer-at-point)
(keymap-global-set "C-c -" #'decrement-integer-at-point)
(keymap-global-set "C-x r q" #'quote-rectangle)

(keymap-global-unset "C-t")          ; `transpose-chars'
(keymap-global-unset "C-x C-t")      ; `transpose-lines'
(keymap-global-unset "C-M-t")        ; `transpose-sexps'
(keymap-global-unset "M-t")          ; `transpose-words'
(keymap-global-set "C-x t"     #'transpose-chars)
(keymap-global-set "C-x T"     #'transpose-lines)
(keymap-global-set "C-x C-M-t" #'transpose-sexps)
(keymap-global-set "C-x M-t"   #'transpose-words)

(with-eval-after-load 'flyspell
  (keymap-set flyspell-mode-map "C-;" nil))

;;; post-init-editor.el ends here
