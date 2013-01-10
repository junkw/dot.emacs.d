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

(require 'package)
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Fix original recipes
(setq el-get-sources
      '((:name el-get :branch "master")
        (:name js2-mode :branch "emacs24")
        (:name jshint-mode :features flymake-jshint)
        (:name php-mode :features php-mode)
        ))

(defvar jkw:el-get-package-list-from-recipe
  '(ace-jump-mode auto-async-byte-compile cssm-mode ctags dired+ eldoc-extension expand-region
                  flymake-csslint flymake-html-validator flymake-phpcs geben goto-chg
                  html5 info+ lispxmp migemo mmm-mode paredit php-align psvn rainbow-mode
                  recentf-ext scratch-ext sequential-command undo-tree viewer)
  "List of packages I use straight from recipe files")

;; Init after loading el-get
(defun jkw:el-get-sync-packages ()
  "Install or update packages via el-get, and init them as needed."
  (setq el-get-verbose t)
  (add-to-list 'el-get-recipe-path "~/.emacs.d/etc/el-get/local-recipes/")
  (setq el-get-user-package-directory "~/.emacs.d/init.d/")
  (let* ((src (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
         (pkg (append src jkw:el-get-package-list-from-recipe)))
    (el-get 'sync pkg)))

;; el-get bootstrap
(if (require 'el-get nil t)
    (jkw:el-get-sync-packages)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)
       (el-get-elpa-build-local-recipes)
       (jkw:el-get-sync-packages)))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; opt-init-packages.el ends here
