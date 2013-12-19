;;; init-projectile.el --- el-get init file for package projectile

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 23, 2013
;; Keywords: .emacs, project

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

(setq projectile-enable-caching t)
(setq projectile-cache-file "~/.emacs.d/var/cache/projectile")
(setq projectile-known-projects-file "~/.emacs.d/var/bookmark/projectile.eld")
(when (locate-library "grizzl")
  (setq projectile-completion-system 'grizzl))

(add-hook 'prog-mode-hook 'projectile-on)

;;;; Keymap
(when (locate-library "helm")
  (global-set-key (kbd "C-x c P") 'helm-projectile))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-projectile.el ends here
