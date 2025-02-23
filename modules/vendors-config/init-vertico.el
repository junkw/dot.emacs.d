;;; init-vertico.el --- el-get init file for package vertico

;; (C) 2023  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 13, 2023
;; Keywords: .emacs, completion

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

(require 'vertico-multiform)
(require 'vertico-quick)
(require 'vertico-directory)

;;;; Init

(setq vertico-count 15)
(setq vertico-resize t)
(setq vertico-cycle nil)
(setq vertico-buffer-display-action '(display-buffer-reuse-window))

(vertico-mode +1)

(with-eval-after-load 'consult
  (setq completion-in-region-function
        (lambda (&rest args)
          (apply (if vertico-mode
                     #'consult-completion-in-region
                   #'completion--in-region)
                 args))))

(add-hook 'minibuffer-setup-hook #'vertico-repeat-save)
(add-hook 'rfn-eshadow-update-overlay #'vertico-directory-tidy)

(vertico-multiform-mode +1)

;;;; Candidates

(advice-add #'vertico--format-candidate :around
            (lambda (orig cand prefix suffix index _start)
              (setq cand (funcall orig cand prefix suffix index _start))
              (concat
               (if (= vertico--index index)
                   (propertize "» " 'face 'vertico-current)
                 "  ")
               cand)))

(setq vertico-multiform-commands
      '((consult-line (vertico-sort-override-function . vertico-sort-alpha))
        (consult-imenu buffer indexed)
        (consult-yank-pop indexed)
        (org-refile grid reverse indexed)))

(setq vertico-multiform-categories
      '((symbol (vertico-sort-function . vertico-sort-alpha))
        (file reverse (vertico-sort-function . sort-directories-first))
        (consult-locate reverse)
        (consult-ripgrep buffer)))

(defun sort-directories-first (files)
  "[internal] Still sort by history position, length and alphabetically."
  (setq files (vertico-sort-history-length-alpha files))
  (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
         (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))

(defun vertico--truncate-candidates (args)
  "Left-truncate recentf filename candidates."
  (if-let ((arg (car args))
           (type (get-text-property 0 'multi-category arg))
           ((eq (car-safe type) 'file))
           (w (max 30 (- (window-width) 38)))
           (l (length arg))
           ((> l w)))
      (setcar args (concat "..." (truncate-string-to-width arg l (- l w)))))
  args)

(advice-add #'vertico--format-candidate :filter-args #'vertico--truncate-candidates)

;;;; Commands

(with-eval-after-load 'embark
  (defun vertico-quick-embark (&optional arg)
    "Embark on candidate using quick keys."
    (interactive)
    (when (vertico-quick-jump)
      (embark-act arg))))

;;;; Keymap
(keymap-set vertico-map "?" #'minibuffer-completion-help)
(keymap-set vertico-map "TAB" #'vertico-insert)
(keymap-set vertico-map "C-i" #'vertico-insert)
(keymap-set vertico-map "C-o" #'vertico-quick-insert)
(keymap-set vertico-map "C-O" #'vertico-quick-embark)
(keymap-set vertico-map "C-e" #'vertico-quick-exit)
(keymap-set vertico-map "ESC" #'minibuffer-keyboard-quit)

(keymap-set vertico-map "RET" #'vertico-directory-enter)
(keymap-set vertico-map "C-l" #'vertico-directory-up)
(keymap-set vertico-map "<backspace>" #'vertico-directory-delete-char)
(keymap-set vertico-map "C-w" #'vertico-directory-delete-word)
(keymap-set vertico-map "M-<backspace>" #'vertico-directory-delete-word)

;;; init-vertico.el ends here
