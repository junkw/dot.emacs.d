;;; init-which-key.el --- el-get init file for package which-key  -*- lexical-binding: t; -*-

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 15, 2018
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

(which-key-mode +1)

(setopt which-key-lighter "")
(setopt which-key-popup-type 'side-window)
(setopt which-key-side-window-location 'bottom)
(setopt which-key-side-window-max-height 0.2)
(setopt which-key-idle-delay 2.5)
(setopt which-key-sort-order 'which-key-description-order)

;;; init-which-key.el ends here
