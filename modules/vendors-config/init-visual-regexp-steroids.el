;;; init-visual-regexp-steroids.el --- el-get init file for package visual-regexp-steroids  -*- lexical-binding: t; -*-

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 3, 2018
;; Keywords: .emacs, regexp

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

;;;; Keymap
(keymap-global-set "M-%"   #'vr/replace)
(keymap-global-set "C-M-%" #'vr/query-replace)

(with-eval-after-load 'multiple-cursors
  (keymap-global-set "C-c m" #'vr/mc-mark))

;;; init-visual-regexp-steroids.el ends here
