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

(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t)
(setq company-require-match nil)
(setq company-show-numbers t)
(setq company-dabbrev-downcase nil)

(defun company-visible-and-explicit-action-p ()
  "[internal] Return t if tooltip is visible and user explicit action took place."
  (and (company-tooltip-visible-p)
       (company-explicit-action-p)))
(setq company-auto-complete #'company-visible-and-explicit-action-p)

(setq company-transformers '(company-sort-by-backend-importance))
(setq company-frontends '(company-echo-metadata-frontend
                          company-pseudo-tooltip-unless-just-one-frontend-with-delay
                          company-preview-frontend))

;; Modes
(setq company-etags-everywhere '(nxml-mode))

(with-eval-after-load 'php-mode
  (add-to-list 'company-etags-modes 'php-mode)
  (add-to-list 'company-etags-everywhere 'php-mode)
  (add-to-list 'company-dabbrev-code-modes 'php-mode))

(with-eval-after-load 'web-mode
  (add-to-list 'company-etags-modes 'web-mode)
  (add-to-list 'company-etags-everywhere 'web-mode)
  (add-to-list 'company-dabbrev-code-modes 'web-mode))

;; Backends
(setq company-backends '(company-capf company-dabbrev-code
                                      company-yasnippet company-etags
                                      company-files company-ispell
                                      (company-dabbrev company-abbrev)))

(defun jkw:company-backends-for-emacs-lisp-mode-init ()
  "[internal] Set `company-backends' for `emacs-lisp-mode'."
  (add-to-list (make-local-variable 'company-backends) 'company-elisp))

(add-hook 'emacs-lisp-mode-hook #'jkw:company-backends-for-emacs-lisp-mode-init)

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
(global-set-key (kbd "C-c y") #'company-yasnippet)

(define-key company-active-map (kbd "C-h") #'delete-backward-char)
(define-key company-active-map (kbd "C-?") #'company-show-doc-buffer)
(define-key company-active-map (kbd "TAB") #'company-complete-common-or-cycle-if-tooltip-visible-or-complete-selection)
(define-key company-active-map (kbd "C-i") #'company-complete-common-or-cycle-if-tooltip-visible-or-complete-selection)
(define-key company-active-map (kbd "C-n") #'company-select-next)
(define-key company-active-map (kbd "C-p") #'company-select-previous)
(define-key company-active-map (kbd "C-v") #'company-next-page)
(define-key company-active-map (kbd "M-v") #'company-previous-page)
(define-key company-active-map (kbd "C-s") #'company-filter-candidates)
(define-key company-active-map (kbd "C-M-s") #'company-search-candidates)

(define-key company-filter-map (kbd "C-n") #'company-select-next)
(define-key company-filter-map (kbd "C-p") #'company-select-previous)

(define-key company-search-map (kbd "C-n") #'company-select-next)
(define-key company-search-map (kbd "C-p") #'company-select-previous)

(let ((map company-active-map))
  (mapc
   (lambda (x)
     (define-key map (format "%d" x) #'company-do-complete-number))
   (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (define-key map (kbd "<RET>") nil))

;;; init-company-mode.el ends here
