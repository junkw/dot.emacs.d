;;; init-monokai-emacs.el --- el-get init file for package monokai-emacs

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 30, 2013
;; Keywords: .emacs, custom theme

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

(custom-theme-set-faces
 'monokai
 ;; Basic coloring for Built-in package
 `(header-line
   ((t :foreground "#75715E"            ; monokai-fg-1
       :background "#171A0B"            ; monokai-bg-1
       :box nil)))
 ;; helm
 `(helm-header
   ((t :foreground "#A6E22E"            ; monokai-green
       :background "#171A0B"            ; monokai-bg-1
       :underline nil :box nil)))
 `(helm-source-header
   ((t :foreground "#E6DB74"            ; monokai-yellow
       :background "#3E3D31"            ; monokai-bg+1
       :height 180 :weight bold
       :underline t :box nil)))
 ;; helm-ls-git
 `(helm-ls-git-modified-not-staged-face
   ((t :foreground "#E6DB74")))         ; monokai-yellow
 `(helm-ls-git-modified-and-staged-face
   ((t :foreground "#FD971F")))         ; monokai-orange
 `(helm-ls-git-renamed-modified-face
   ((t :foreground "#FD971F")))         ; monokai-orange
 `(helm-ls-git-untracked-face
   ((t :foreground "#F92672")))         ; monokai-red
 `(helm-ls-git-added-copied-face
   ((t :foreground "#A6E22E")))         ; monokai-green
 `(helm-ls-git-deleted-not-staged-face
   ((t :foreground "#968B26")))         ; monokai-yellow-1
 `(helm-ls-git-deleted-and-staged-face
   ((t :foreground "#49483E")))         ; monokai-bg+2
 `(helm-ls-git-conflict-face
   ((t :foreground "#AE81FF")))         ; monokai-purple
 ;; highlight-indentation
 `(highlight-indentation-face
   ((t :background "#49483E")))         ; monokai-bg+2
 `(highlight-indentation-current-column-face
   ((t :background "#3E3D31")))         ; monokai-bg+1
 ;; smartparens
 `(sp-show-pair-mismatch-face
   ((t :foreground "#171A0B"            ; monokai-bg-1
       :background "#F92672"            ; monokai-red
       :weight bold)))
 `(sp-show-pair-match-face
   ((t :foreground "#171A0B"            ; monokai-bg-1
       :background "#FD971F"            ; monokai-orange
       :weight bold)))
 ;; web-mode
 `(web-mode-symbol-face
   ((t :inherit font-lock-keyword-face)))
 `(web-mode-current-element-highlight-face
   ((t :background "#171A0B")))         ; monokai-bg-1
 `(web-mode-comment-keyword-face
   ((t :weight bold :box nil)))
)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-monokai-emacs.el ends here
