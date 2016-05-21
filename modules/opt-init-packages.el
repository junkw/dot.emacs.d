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
(require 'pre-init-core)

;;;; Installed packages via el-get
;; Fix original recipes
(setq el-get-sources
      '((:name helm :before (setq dired-bind-jump nil))
        (:name helm-descbinds :prepare nil :library helm :after (helm-descbinds-mode +1))
        (:name helm-ls-git :depends (helm magit))
        (:name highlight-indentation :features highlight-indentation)
        (:name monokai-theme :after (load-theme 'monokai t))
        (:name pcache
               :before (setq pcache-directory (concat user-emacs-directory "var/cache/pcache/")))
        (:name popwin :features popwin)
        (:name powerline :autoloads nil)
        (:name smartparens :features smartparens-config)
        (:name tabulated-list :builtin "24")
        (:name twittering-mode :features nil)
        (:name undo-tree :features undo-tree)
        (:name yasnippet :autoloads "yasnippet.el" :features yasnippet)))

(when has-mu-p
  (add-to-list 'el-get-sources '(:name mu4e-alert :depends (alert s ht) :library mu4e)))

(defvar jkw:el-get-preloaded-package-list-from-recipe
  '(alert origami smartrep)
  "List of packages that need to load before loading `jkw:el-get-package-list-from-recipe'.")

(when has-migemo-p
  (add-to-list 'jkw:el-get-preloaded-package-list-from-recipe 'migemo))

(defvar jkw:el-get-package-list-from-recipe
  '(ac-php ace-isearch ace-jump-mode ace-window ag anzu auto-async-byte-compile auto-complete
           beginend cl-lib-highlight dash-at-point e2wm e2wm-bookmark eldoc-extension
           elisp-slime-nav emmet-mode expand-region foreign-regexp flycheck flyspell-correct
           geben gist git-gutter-fringe goto-chg grep-a-lot helm-ag helm-swoop
           highlight-defined highlight-symbol info+ js2-mode json-mode nlinum-relative lispxmp
           magit magit-svn markdown-mode multiple-cursors mwim neotree org-mode org-reveal
           php-mode projectile psvn rainbow-mode recentf-ext scratch-ext smart-newline tern
           viewer web-mode wgrep yaml-mode)
  "List of packages I use straight from recipe files.")

(defvar jkw:el-get-package-for-mu4e-list-from-recipe
  '()
  "List of mu4e plugin packages I use straight from recipe files.")

;;;; Internal functions
(defun el-get--pre-initialize-el-get ()
  "[internal] Need to initialize before loading el-get."
  (setq el-get-dir (file-name-as-directory (concat user-emacs-directory "vendor")))
  (setq package-user-dir (file-name-as-directory (concat el-get-dir "package/elpa")))
  (setq el-get-user-package-directory (file-name-as-directory (concat user-emacs-directory "configs")))
  (add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get"))))

(defun el-get--post-initialize-el-get ()
  "[internal] Need to initialize after loading el-get."
  (add-to-list 'el-get-recipe-path (file-name-as-directory (concat user-emacs-directory "etc/recipes")))
  (el-get 'sync '(package el-get)))

(defun el-get--list-installing-packages ()
  "[internal] Return a list of installing packages via el-get."
  (let* ((rcps (append jkw:el-get-package-list-from-recipe
                       (when has-mu-p jkw:el-get-package-for-mu4e-list-from-recipe)))
         (pkgs (append jkw:el-get-preloaded-package-list-from-recipe
                       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))
                       rcps)))
    pkgs))

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
  (el-get--post-initialize-el-get)
  (el-get-initialize-packages))

(provide 'opt-init-packages)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-packages.el ends here
