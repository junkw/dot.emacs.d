;;; init-helm-ls-git.el --- el-get init file for package helm-ls-git

;; (C) 2013  Jumpei KAWAMI

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

(setq helm-ls-git-status-command 'magit-status-internal)
(setq helm-ls-git-fuzzy-match t)

(add-to-list 'helm-for-files-preferred-list 'helm-source-ls-git-status)

;;;; Keymap
(keymap-set helm-command-map "g" #'helm-ls-git)

;;; init-helm-ls-git.el ends here
