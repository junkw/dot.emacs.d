;;; opt-init-packages.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 21, 2015
;; Keywords: el-get, ELPA

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

(require 'cl-lib)

;;;; Installed packages via el-get
;; Fix original recipes
(setq el-get-sources
      '((:name dired+ :autoloads nil)
        (:name helm :autoloads nil :before (setq dired-bind-jump nil) :features helm-config)
        (:name helm-descbinds :prepare nil :library helm :after (helm-descbinds-mode +1))
        (:name highlight-indentation :features highlight-indentation)
        (:name pcache
               :before (setq pcache-directory (concat user-emacs-directory "var/cache/pcache/")))
        (:name popwin :features popwin)
        (:name powerline :autoloads nil)
        (:name smartparens :features smartparens-config)
        (:name twittering-mode :features nil)
        (:name undo-tree :features undo-tree)
        (:name yasnippet :autoloads "yasnippet.el" :features yasnippet)))

(defvar jkw:el-get-preloaded-package-list-from-recipe
  '(sequential-command smartrep)
  "List of packages that need to load before loading `jkw:el-get-package-list-from-recipe'.")

(defvar jkw:el-get-package-list-from-recipe
  '(ace-isearch ace-jump-mode ace-window ag anzu auto-async-byte-compile auto-complete
                cl-lib-highlight cssm-mode dash-at-point dired-sync direx e2wm
                e2wm-bookmark eldoc-extension elisp-slime-nav emmet-mode expand-region
                foreign-regexp flycheck geben gist git-gutter-fringe goto-chg grep-a-lot
                helm-ag helm-c-yasnippet helm-ls-git helm-migemo helm-swoop
                highlight-defined highlight-symbol info+ js2-mode linum-relative lispxmp
                magit markdown-mode migemo monokai-emacs multiple-cursors mykie
                org-mode php-completion php-mode projectile psvn rainbow-mode recentf-ext
                scratch-ext smart-newline tern viewer web-mode wgrep yaml-mode)
  "List of packages I use straight from recipe files.")

;;;; Internal functions
(defun el-get--pre-initialize-el-get ()
  "[internal] Need to initialize before loading el-get."
  (setq el-get-dir (file-name-as-directory (concat user-emacs-directory "vendor")))
  (setq package-user-dir (file-name-as-directory (concat el-get-dir "package/elpa")))
  (setq el-get-user-package-directory (file-name-as-directory (concat user-emacs-directory "configs")))
  (add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get"))))

(defun el-get--host-initialize-el-get ()
  "[internal] Need to initialize after loading el-get."
  (add-to-list 'el-get-recipe-path (file-name-as-directory (concat user-emacs-directory "etc/recipes")))
  (el-get 'sync '(package el-get)))

(defun el-get--list-installing-packages ()
  "[internal] Return a list of installing packages via el-get."
  (let* ((src      (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
         (add-src  (append src jkw:el-get-package-list-from-recipe))
         (pkg-list (append jkw:el-get-preloaded-package-list-from-recipe add-src)))
    pkg-list))

(defun el-get--installer ()
  "[internal] Install el-get and initialize ELPA."
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch el-get-install-skip-emacswiki-recipes)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;;;; Command
(defun el-get-initialize-packages ()
  "Install packages via `el-get', and initialize them."
  (interactive)
  (let ((pkg (el-get--list-installing-packages)))
    (el-get 'sync pkg)))

;;;; Initialize packages
(el-get--pre-initialize-el-get)

(unless init-module-safe-mode-p
  (unless (require 'el-get nil t)
    ;; If el-get is not installed, install it
    (el-get--installer))
  (el-get--host-initialize-el-get)
  (el-get-initialize-packages))

(provide 'opt-init-packages)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-packages.el ends here
