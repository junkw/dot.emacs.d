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
               :website "https://github.com/dimitri/el-get#readme"
               :description "Manage the external elisp bits and pieces you depend upon."
               :type github
               :branch "master"
               :pkgname "dimitri/el-get"
               :features el-get
               :info    "el-get.info"
               :load    "el-get.el")
        ))

(if (require 'el-get nil t)
    (el-get 'sync)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)
       (el-get 'sync)))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; opt-init-packages.el ends here
