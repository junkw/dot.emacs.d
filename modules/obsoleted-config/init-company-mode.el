;;; init-company-mode.el --- el-get init file for package company-mode

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 12, 2017
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

(setopt company-idle-delay 0.3)
(setopt company-minimum-prefix-length 3)
(setopt company-selection-wrap-around t)
(setopt company-require-match nil)
(setopt company-show-numbers t)
(setopt company-dabbrev-downcase nil)

(defun company-visible-and-explicit-action-p ()
  "[internal] Return t if tooltip is visible and user explicit action took place."
  (and (company-tooltip-visible-p)
       (company-explicit-action-p)))
(setopt company-auto-complete #'company-visible-and-explicit-action-p)

(setopt company-transformers '(company-sort-by-backend-importance))
(setopt company-frontends '(company-echo-metadata-frontend
                          company-pseudo-tooltip-unless-just-one-frontend-with-delay
                          company-preview-frontend))

;; Modes
(with-eval-after-load 'php-mode
  (add-to-list 'company-dabbrev-code-modes 'php-mode))

(with-eval-after-load 'web-mode
  (add-to-list 'company-dabbrev-code-modes 'web-mode))

(with-eval-after-load 'js2-mode
  (add-to-list 'company-dabbrev-code-modes 'js2-mode))

;; Backends
(setopt company-backends '(company-dabbrev-code company-capf company-files
                                              company-yasnippet company-ispell
                                              (company-dabbrev company-abbrev)))

(defun jkw:company-backends-for-emacs-lisp-mode-init ()
  "[internal] Set `company-backends' for `emacs-lisp-mode'."
  (add-to-list (make-local-variable 'company-backends) '(company-elisp company-etags)))

(add-hook 'emacs-lisp-mode-hook #'jkw:company-backends-for-emacs-lisp-mode-init)

(with-eval-after-load 'org
  ;; http://xenodium.com/emacs-org-block-company-completion/
  ;; https://github.com/xenodium/dotsies/blob/master/emacs/ar/company-org-block.el
  (require 'map)
  (require 'seq)

  (defvar company-org-block-bol-p t
    "If t, detect completion when at begining of line, otherwise detect completion anywhere.")
  (defvar company-org--regexp "<\\([^ ]*\\)")

  (defun company-org-block (command &optional arg &rest ignored)
    "Complete org babel languages into source blocks."
    (interactive (list 'interactive))
    (cl-case command
      (interactive (company-begin-backend 'company-org-block))
      (prefix (company-org-block--grab-symbol-cons))
      (candidates (company-org-block--candidates arg))
      (post-completion
       (company-org-block--expand arg))))

  (defun company-org-block--candidates (prefix)
    "Return a list of org babel languages matching PREFIX."
    (seq-filter (lambda (language)
                  (string-prefix-p prefix language))
                ;; Flatten `org-babel-load-languages' and
                ;; `org-structure-template-alist', join, and sort.
                (seq-sort
                 #'string-lessp
                 (append
                  (mapcar #'prin1-to-string
                          (map-keys org-babel-load-languages))
                  (map-values org-structure-template-alist)))))

  (defun company-org-block--template-p (template)
    (seq-contains-p (map-values org-structure-template-alist)
                    template))

  (defun company-org-block--expand (insertion)
    "Replace INSERTION with actual source block."
    (delete-region (point) (- (point) (1+ ;; Include "<" in length.
                                       (length insertion))))
    (if (company-org-block--template-p insertion)
        (company-org-block--wrap-point insertion
                                       ;; May be multiple words.
                                       ;; Take the first one.
                                       (nth 0 (split-string insertion)))
      (company-org-block--wrap-point (format "src %s" insertion)
                                     "src")))

  (defun company-org-block--wrap-point (begin end)
    "Wrap point with block using BEGIN and END.

For example:
#+begin_BEGIN
  |
#+end_END"
    (insert (format "#+begin_%s\n" begin))
    (insert "  ")
    ;; Saving excursion restores point to location inside code block.
    (save-excursion
      (insert (format "\n#+end_%s" end))))

  (defun company-org-block--grab-symbol-cons ()
    "Return cons with symbol and t whenever prefix of < is found.

For example: \"<e\" -> (\"e\" . t)"
    (when (looking-back (if company-org-block-bol-p
                            (concat "^" company-org--regexp)
                          company-org--regexp)
                        (line-beginning-position))
      (cons (match-string-no-properties 1) t)))

  (defun jkw:company-backends-for-org-mode-init ()
    "[internal] Set `company-backends' for `org-mode'."
    (add-to-list (make-local-variable 'company-backends) 'company-org-block))

  (add-hook 'org-mode-hook #'jkw:company-backends-for-org-mode-init))

;; Enalbe company-mode
(global-company-mode +1)

;;;; Commands
(defun company-complete-common-or-cycle-if-tooltip-visible-or-complete-selection ()
  "Complete common or cycle if appropriate, or complete selection.

Insert selection if only preview is showing or only one candidate, otherwise complete common or cycle."
  (interactive)
  (if (and (company-tooltip-visible-p) (> company-candidates-length 1))
      (call-interactively 'company-complete-common-or-cycle)
    (call-interactively 'company-complete-selection)))

;; https://oremacs.com/2017/12/27/company-numbers/
(defun company-do-complete-number ()
  "[internal] Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))

;;;; Keymap
(keymap-global-set "C-c y" #'company-yasnippet)

(keymap-set company-active-map "C-h" #'delete-backward-char)
(keymap-set company-active-map "C-?" #'company-show-doc-buffer)
(keymap-set company-active-map "TAB" #'company-complete-common-or-cycle-if-tooltip-visible-or-complete-selection)
(keymap-set company-active-map "C-i" #'company-complete-common-or-cycle-if-tooltip-visible-or-complete-selection)
(keymap-set company-active-map "C-n" #'company-select-next)
(keymap-set company-active-map "C-p" #'company-select-previous)
(keymap-set company-active-map "C-v" #'company-next-page)
(keymap-set company-active-map "M-v" #'company-previous-page)
(keymap-set company-active-map "C-s" #'company-filter-candidates)
(keymap-set company-active-map "C-M-s" #'company-search-candidates)

(keymap-set company-search-map "C-n" #'company-select-next)
(keymap-set company-search-map "C-p" #'company-select-previous)

(let ((map company-active-map))
  (mapc
   (lambda (x)
     (keymap-set map (format "%d" x) #'company-do-complete-number))
   (number-sequence 0 9))
  (keymap-set map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (keymap-set map "RET" nil))

;;; init-company-mode.el ends here
