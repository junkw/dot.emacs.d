;;; init-psvn.el --- el-get init file for package psvn

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 8, 2013
;; Keywords: .emacs, svn

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

(add-to-list 'process-coding-system-alist '("svn" . utf-8))
(setq svn-status-svn-process-coding-system 'utf-8)
(setq svn-status-svn-file-coding-system 'utf-8)
(setopt svn-status-default-commit-arguments '("--encoding" "UTF-8"))
(setopt svn-status-verbose nil)
(setopt svn-status-hide-unmodified t)

;;; init-psvn.el ends here
