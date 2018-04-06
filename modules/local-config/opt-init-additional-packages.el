;;; opt-init-additional-packages.el --- Emacs init file

;; Copyright (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 10, 2017
;; Keywords: .emacs, packages, el-get, ELPA

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
(require 'opt-init-packages)

;;;; Installed packages via el-get
(setq el-get-sources
      '((:name ac-php :depends (php-mode company-mode yasnippet xcscope f s) :lazy t :library php-mode)
        (:name editorconfig :features editorconfig)
        (:name company-mode :depends yasnippet)
        (:name company-statistics :depends company-mode)
        (:name company-quickhelp :depends (company-mode pos-tip))
        (:name company-tern :post-init nil)
        (:name company-web :depends (company-mode dash cl-lib web-completion-data web-mode))
        (:name helm :before (setq dired-bind-jump nil))
        (:name helm-descbinds :before nil :lazy t :library helm :after (helm-descbinds-mode +1))
        (:name helm-ls-git :depends (helm magit))
        (:name highlight-indentation :features highlight-indentation)
        (:name pcache
               :before (setq pcache-directory (concat user-emacs-directory "var/cache/pcache/")))
        (:name popwin :features popwin)
        (:name powerline :autoloads nil)
        (:name smartparens :features smartparens-config)
        (:name tabulated-list :builtin "24")
        (:name twittering-mode :features nil)
        (:name undo-tree :features undo-tree)
        (:name yasnippet :autoloads "yasnippet.el" :features yasnippet)
        (:name yasnippet-snippets :features yasnippet-snippets)
        (:name zerodark-theme :after (load-theme 'zerodark t))))

(when has-mu-p
  (add-to-list 'el-get-sources '(:name mu4e-alert :depends (alert s ht) :lazy t :library mu4e)))

(setq jkw:el-get-preloaded-package-list-from-recipe
  '(alert origami smartrep projectile))

(when has-migemo-p
  (add-to-list 'jkw:el-get-preloaded-package-list-from-recipe 'migemo))

(setq jkw:el-get-package-list-from-recipe
      '(ace-isearch ace-jump-mode ace-window ag anzu auto-async-byte-compile beginend cl-lib-highlight
                    composer dash-at-point dumb-jump e2wm e2wm-bookmark electric-align eldoc-extension
                    elisp-slime-nav emmet-mode expand-region foreign-regexp flycheck flyspell-correct
                    geben gist git-gutter-fringe goto-chg grep-a-lot helm-ag helm-swoop highlight-defined
                    highlight-symbol info+ js2-mode json-mode lispxmp magit magit-lfs magit-svn
                    markdown-mode monokai-theme multiple-cursors mwim neotree nlinum-relative org-mode
                    org-reveal ox-pandoc php-mode psvn rainbow-mode recentf-ext rg scratch-ext
                    smart-newline viewer web-mode wgrep yaml-mode))

(setq jkw:el-get-package-for-mu4e-list-from-recipe
  '())

(setq jkw:el-get-package-with-nodejs-list-from-recipe
  '(vmd-mode tern))

;;;; Initialize packages
(el-get--pre-initialize-el-get)

(unless init-module-safe-mode-p
  (unless (require 'el-get nil t)
    ;; If el-get is not installed, install it
    (el-get--installer))
  (el-get--post-initialize-el-get)
  (el-get-initialize-packages))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-additional-packages.el ends here
