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

(require 'pre-init-environments)

;;;; Init
(setq helm-adaptive-history-file (concat user-emacs-directory "var/cache/helm-adaptive-history"))
(setq helm-candidate-number-limit 300)
(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-exit-idle-delay 0.01)
(setq helm-quick-update t)
(setq helm-persistent-action-use-special-display t)
(setq helm-yank-symbol-first t)

(setq helm-completion-mode-string "")

;;;; Sources
(when mac-p
  (setq helm-for-files-preferred-list
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-bookmarks
          helm-source-file-cache
          helm-source-files-in-current-dir
          helm-source-mac-spotlight)))

;;;; Candidates
(with-eval-after-load 'migemo
  (helm-migemo-mode +1))

(setq helm-M-x-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)

;;;; Keymap
(global-set-key (kbd "M-x")     #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)
(global-set-key (kbd "C-;")     #'helm-for-files)
(global-set-key (kbd "C-M-y")   #'helm-show-kill-ring)

(define-key helm-map (kbd "C-k") nil)

(define-key helm-map (kbd "C-q")   #'helm-delete-minibuffer-contents)
(define-key helm-map (kbd "C-M-n") #'helm-next-source)
(define-key helm-map (kbd "C-M-p") #'helm-previous-source)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-helm.el ends here
