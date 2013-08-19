;;; init-helm-ls-git.el --- el-get init file for package helm-ls-git

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Aug. 30, 2013
;; Keywords: .emacs, git

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

(setq helm-ls-git-status-command 'magit-status)

(eval-after-load-q 'monokai-theme
  (custom-theme-set-faces
   'monokai
   `(helm-ls-git-modified-not-staged-face
     ((t :foreground "#E6DB74")))       ; monokai-yellow
   `(helm-ls-git-modified-and-staged-face
     ((t :foreground "#FD971F")))       ; monokai-orange
   `(helm-ls-git-renamed-modified-face
     ((t :foreground "#FD971F")))       ; monokai-orange
   `(helm-ls-git-untracked-face
     ((t :foreground "#F92672")))       ; monokai-red
   `(helm-ls-git-added-copied-face
     ((t :foreground "#A6E22E")))       ; monokai-green
   `(helm-ls-git-deleted-not-staged-face
     ((t :foreground "#968B26")))       ; monokai-yellow-1
   `(helm-ls-git-deleted-and-staged-face
     ((t :foreground "#49483E")))       ; monokai-bg+2
   `(helm-ls-git-conflict-face
     ((t :foreground "#AE81FF")))))     ; monokai-purple

;; Keymap
(global-set-key (kbd "C-x c g") 'helm-ls-git-ls)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-helm-ls-git.el ends here
