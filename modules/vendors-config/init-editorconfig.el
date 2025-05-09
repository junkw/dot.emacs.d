;;; init-editorconfig.el --- el-get init file for package editorconfig

;; (C) 2016  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jun. 11, 2016
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

(defvar editorconfig-mode--enable-on-contributing-repository-regexp
  "/Code/\\(github\\|worksite\\)/"
  "Regexp of directories with Contributing repository such as Github.")

(defun editorconfig-mode--enable-on-contributing-repository ()
  "Enable `editorconfig-mode' at opening file in directories
with Contributing repository such as Github."
  (when (and buffer-file-name editorconfig-mode--enable-on-contributing-repository-regexp
             (string-match editorconfig-mode--enable-on-contributing-repository-regexp buffer-file-name))
    (editorconfig-mode +1)))

(add-hook 'prog-mode-hook #'editorconfig-mode--enable-on-contributing-repository)

;;; init-editorconfig.el ends here
