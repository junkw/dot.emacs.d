;;; opt-init-diff.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, diff, ediff

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

(setopt diff-switches "-u")               ; unified diff format
(setopt ediff-window-setup-function #'ediff-setup-windows-plain) ; don't make 'Ediff Control Panel' frame
(setopt ediff-split-window-function #'split-window-horizontally) ; split ediff window, side by side
(setopt ediff-keep-variants nil)          ; remove unmodified buffers

;;; opt-init-diff.el ends here
