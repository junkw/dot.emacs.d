;;; lazy-init-view.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 14, 2015
;; Keywords: .emacs, view

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

(require 'pre-init-keymap-utils)

;; View mode
;; Opening read-only file, enable view mode.
(setq view-read-only t)

;;;; Keymap
(define-vim-keys view-mode-map)
(define-key view-mode-map (kbd "J") #'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") #'View-scroll-line-forward)
(define-key view-mode-map (kbd ";") #'recenter-top-bottom)

;;; lazy-init-view.el ends here
