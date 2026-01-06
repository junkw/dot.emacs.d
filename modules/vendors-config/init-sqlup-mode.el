;;; init-sqlup-mode.el --- el-get init file for package sqlup-mode  -*- lexical-binding: t; -*-

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 24, 2018
;; Keywords: .emacs, sql

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

(require 'pre-init-hook-utils)

;;;; Hooks
(add-hooks '(sql-mode sql-interactive-mode) #'sqlup-mode)

;;;; Keymap
(keymap-global-set "C-c C-u" #'sqlup-capitalize-keywords-in-region)

;;; init-sqlup-mode.el ends here
