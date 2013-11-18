;;; opt-init-packages.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 15, 2012
;; Keywords: .emacs, el-get, ELPA

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

;; Init before loading el-get
(setq el-get-dir "~/.emacs.d/vendor/")
(add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get")))

(setq el-get-recipe-path-emacswiki "~/.emacs.d/etc/el-get/emacswiki-recipes/")
(setq el-get-recipe-path-elpa "~/.emacs.d/etc/el-get/elpa-recipes/")

;; Fix original recipes
(setq el-get-sources
      '((:name el-get :branch "master")
        (:name auto-complete :submodule nil :features auto-complete-config)
        (:name direx :depends popwin)
        (:name helm :autoloads nil)
        (:name helm-c-moccur :features helm-c-moccur)
        (:name helm-ls-git :depends (helm magit))
        (:name highlight-indentation :features highlight-indentation)
        (:name minimap :after (setq minimap-window-location 'right))
        (:name smartparens :features smartparens-config)
        (:name popwin :features popwin)
        (:name powerline :autoloads nil)
        (:name undo-tree :features undo-tree)
        (:name yasnippet :compile "yasnippet.el")
        ))

(defvar jkw:el-get-package-list-from-recipe
  '(ace-jump-mode ag all-ext anzu auto-async-byte-compile cl-lib-highlight color-moccur
                  cssm-mode ctags dired+ eldoc-extension emmet-mode expand-region
                  foreign-regexp flycheck geben gist git-gutter-fringe goto-chg grep-a-lot
                  html5 helm-c-yasnippet helm-descbinds helm-migemo highlight-symbol info+
                  js2-mode linum-relative lispxmp magit migemo mmm-mode moccur-edit
                  monokai-emacs multiple-cursors org-mode php-align php-mode psvn
                  rainbow-mode recentf-ext region-bindings-mode scratch-ext
                  sequential-command smartrep tern twittering-mode viewer wgrep)
  "List of packages I use straight from recipe files.")

;; Init after loading el-get
(defun el-get-initialize-packages ()
  "Install packages via `el-get', and initialize them."
  (interactive)
  (unless (called-interactively-p 'interactive)
    ;; Eval in the el-get bootstrap.
    (setq el-get-verbose t)
    (add-to-list 'el-get-recipe-path "~/.emacs.d/etc/el-get/local-recipes/")
    (setq el-get-user-package-directory "~/.emacs.d/init.d/"))
  (let* ((src (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
         (pkg (append src jkw:el-get-package-list-from-recipe)))
    (el-get 'sync pkg)))

;; el-get bootstrap
(if (require 'el-get nil t)
    (el-get-initialize-packages)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max)) (eval-print-last-sexp)
       ;; After el-get is installed, inits ELPA and builds its recipe files,
       ;; finally installes all packages I use.
       (el-get 'sync 'package) (package-initialize) (el-get-elpa-build-local-recipes)
       (el-get-initialize-packages)))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-packages.el ends here
