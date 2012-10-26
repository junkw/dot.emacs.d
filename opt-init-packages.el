;;; opt-init-packages.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 15, 2012
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

;; ELPA
(require 'package)
(setq package-user-dir "~/.emacs.d/vendor/package/elpa")
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; el-get
(setq el-get-dir "~/.emacs.d/vendor/")
(add-to-list 'load-path "~/.emacs.d/vendor/el-get")

(setq el-get-recipe-path-emacswiki "~/.emacs.d/etc/el-get/emacswiki-recipes/")
(setq el-get-recipe-path-elpa "~/.emacs.d/etc/el-get/elpa-recipes/")
(setq el-get-user-package-directory "~/.emacs.d/init.d/")
(setq el-get-verbose t)

(setq el-get-sources
      '((:name el-get
               :website     "https://github.com/dimitri/el-get#readme"
               :description "Manage the external elisp bits and pieces you depend upon."
               :type        github
               :branch      "master"
               :pkgname     "dimitri/el-get"
               :features    el-get
               :info        "el-get.info"
               :load        "el-get.el")
        (:name eldoc-extension
               :website     "http://emacswiki.org/emacs/eldoc-extension.el"
               :description "Some extension for eldoc"
               :type        emacswiki
               :features    eldoc-extension)
        (:name info+
               :description "Extensions for `info.el'."
               :website     "http://emacswiki.org/emacs/info+.el"
               :type        emacswiki
               :library     info
               :after       (require 'info+))
        (:name scratch-ext
               :website     "https://github.com/kyanagi/scratch-ext-el#readme"
               :description "Extensions for *scratch*"
               :type        github
               :branch      "master"
               :pkgname     "kyanagi/scratch-ext-el"
               :features    scratch-ext)
        (:name sequential-command
               :website     "http://www.emacswiki.org/SequentialCommand"
               :description "Many commands into one command"
               :type        github
               :branch      "master"
               :pkgname     "emacsmirror/sequential-command"
               :features    sequential-command)
        (:name undo-tree
               :website     "http://www.dr-qubit.org/emacs.php#undo-tree"
               :description "Treat undo history as a tree"
               :type        git
               :url         "http://www.dr-qubit.org/git/undo-tree.git"
               :features    undo-tree
               :after       (global-undo-tree-mode))
        ))

(setq jkw:el-get-package-list-from-recipe
      '(ace-jump-mode auto-async-byte-compile dired+ expand-region goto-chg paredit recentf-ext))

(defun jkw:el-get-sync-packages ()
  "Install or update packages via el-get, and init them as needed."
  (let* ((src (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
         (pkg (append src jkw:el-get-package-list-from-recipe)))
    (el-get 'sync pkg)))

(if (require 'el-get nil t)
    (jkw:el-get-sync-packages)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch el-get-install-skip-emacswiki-recipes)
       (goto-char (point-max))
       (eval-print-last-sexp)
       (jkw:el-get-sync-packages)))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; opt-init-packages.el ends here
