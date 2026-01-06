;;; init-wgrep.el --- el-get init file for package wgrep  -*- lexical-binding: t; -*-

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 16, 2013
;; Keywords: .emacs, grep

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

(setopt wgrep-auto-save-buffer t)
(setopt wgrep-enable-key (kbd "C-c C-e"))
(setopt wgrep-change-readonly-file t)
(with-eval-after-load 'ag (require 'wgrep-ag))
(with-eval-after-load 'rg (require 'wgrep-ag))

;;; init-wgrep.el ends here
