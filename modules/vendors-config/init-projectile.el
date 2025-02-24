;;; init-projectile.el --- el-get init file for package projectile

;; (C) 2013  Jumpei KAWAMI

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

(setopt projectile-enable-caching t)
(setopt projectile-cache-file (concat user-emacs-directory "var/cache/projectile"))
(setopt projectile-known-projects-file (concat user-emacs-directory "var/bookmark/projectile.eld"))
(setopt projectile-tags-command "ctags -uRe -f \"%s\" %s")

(add-hook 'prog-mode-hook #'projectile-mode)

;;; init-projectile.el ends here
