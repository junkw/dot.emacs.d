;;; init-helm.el --- el-get init file for package helm

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Aug. 27, 2013
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

;;;; Init
(require 'helm-config)

(setq helm-adaptive-history-file "~/.emacs.d/var/cache/helm-adaptive-history")
(setq helm-candidate-number-limit 300)
(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-exit-idle-delay 0.01)
(setq helm-quick-update t)
(setq helm-persistent-action-use-special-display t)
(setq helm-yank-symbol-first t)

(helm-mode 1)

(setq helm-completion-mode-string "")

;; Emulate `kill-line' in helm minibuffer
;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(setq helm-delete-minibuffer-contents-from-point t)

(defadvice helm-delete-minibuffer-contents
  (before helm-delete-minibuffer-contents-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer."
  (kill-new (buffer-substring (point) (field-end))))

;;;; Sources
(when mac-p
  (setq helm-for-files-preferred-list
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-bookmarks
          helm-source-file-cache
          helm-source-files-in-current-dir
          helm-source-mac-spotlight)))

;; Fix matching method in `helm-buffers-list'.
;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(defun helm-buffers-list-pattern-transformer (pattern)
  "Match function to transform the PATTERN."
  (if (equal pattern "")
      pattern
    ;; Escape '.' to match '.' instead of an arbitrary character
    (setq pattern (replace-regexp-in-string "\\." "\\\\." pattern))
    (let ((first-char (substring pattern 0 1)))
      (cond ((equal first-char "*")
             (concat " " pattern))
            ((equal first-char "=")
             (concat "*" (substring pattern 1)))
            (t
             pattern)))))

(add-to-list 'helm-source-buffers-list
             '(pattern-transformer helm-buffers-list-pattern-transformer))

;;;; Keymap
(global-set-key [remap execute-extended-command] 'helm-M-x)
(global-set-key [remap find-file]    'helm-find-files)
(global-set-key [remap list-buffers] 'helm-buffers-list)
(global-set-key (kbd "C-;")          'helm-for-files)
(global-set-key (kbd "C-M-y")        'helm-show-kill-ring)

(define-key helm-map (kbd "C-z") nil)
(define-key helm-map (kbd "C-o") nil)

(define-key helm-map (kbd "C-o")   'helm-execute-persistent-action)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)
(define-key helm-read-file-map (kbd "C-o") 'helm-execute-persistent-action)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-helm.el ends here
