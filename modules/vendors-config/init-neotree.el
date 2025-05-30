;;; init-neotree.el --- el-get init file for package neotree

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 11, 2015
;; Keywords: .emacs, file

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

(setopt neo-theme 'nerd)
(setopt neo-persist-show nil)
(setopt neo-smart-open t)
(setopt neo-cwd-line-style 'button)

(with-eval-after-load 'projectile
;;;; Commands
  (defun neotree-find-project-root-or-current-directory ()
    "Quick select project or current directory as node in NeoTree."
    (interactive)
    (let ((path (if (fboundp 'projectile-project-root)
                    (ignore-errors (projectile-project-root))
                  nil)))
      (neotree-find path)))

;;;; Keymap
  (keymap-global-set "C-x C-d" #'neotree-find-project-root-or-current-directory))

;;; init-neotree.el ends here
