;;; init-helm.el --- el-get init file for package helm

;; (C) 2013  Jumpei KAWAMI

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

(eval-when-compile
  (require 'pre-init-environments))

;;;; Init
(setopt helm-adaptive-history-file (concat user-emacs-directory "var/cache/helm-adaptive-history"))
(setopt helm-scroll-amount 8)
(setopt helm-input-idle-delay 0.01)
(setopt helm-exit-idle-delay 0.01)
(setopt helm-google-suggest-use-curl-p t)
(setopt helm-completion-mode-string "")
(setopt helm-follow-mode-persistent t)
(setopt helm-split-window-in-side-p t)
(setopt helm-autoresize-max-height 0)
(setopt helm-autoresize-min-height 35)

(helm-autoresize-mode +1)

;;;; Sources
(when mac-p
  (setopt helm-for-files-preferred-list
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-bookmarks
          helm-source-file-cache
          helm-source-files-in-current-dir
          helm-source-mac-spotlight)))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-info-pages t)

;;;; Candidates
(setopt helm-candidate-number-limit 500)
(setopt helm-ff-search-library-in-sexp t)
(setopt helm-ff-file-name-history-use-recentf t)

(setopt helm-M-x-fuzzy-match t)
(setopt helm-apropos-fuzzy-match t)
(setopt helm-buffers-fuzzy-matching t)
(setopt helm-recentf-fuzzy-match t)
(setopt helm-semantic-fuzzy-match t)
(setopt helm-imenu-fuzzy-match t)
(setopt helm-lisp-fuzzy-completion t)

(with-eval-after-load 'migemo
  (helm-migemo-mode +1))

;;;; Keymap
(keymap-global-unset "C-x c")
(keymap-global-set "C-c h"   #'helm-command-prefix)

(keymap-global-set "M-x"     #'helm-M-x)
(keymap-global-set "C-x b"   #'helm-mini)
(keymap-global-set "C-x C-b" #'helm-buffers-list)
(keymap-global-set "C-x C-f" #'helm-find-files)
(keymap-global-set "C-;"     #'helm-for-files)
(keymap-global-set "M-y"     #'helm-show-kill-ring)

(keymap-set helm-map "C-k" nil)
(keymap-set helm-map "C-q" #'helm-delete-minibuffer-contents)

(keymap-set minibuffer-local-map "C-c C-l" #'helm-minibuffer-history)

;;; init-helm.el ends here
