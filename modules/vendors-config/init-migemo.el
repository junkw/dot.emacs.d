;;; init-migemo.el --- el-get init file for package migemo  -*- lexical-binding: t -*-

;; (C) 2024  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jun. 29, 2024
;; Keywords: .emacs, search, japanese

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

(define-key isearch-mode-map (kbd "M-m") #'migemo-isearch-toggle-migemo)
(define-key isearch-mode-map (kbd "C-d") #'migemo-isearch-yank-char)
(define-key isearch-mode-map (kbd "C-w") #'migemo-isearch-yank-word)
(define-key isearch-mode-map (kbd "M-e") #'migemo-isearch-yank-line)

;;; init-migemo.el ends here
