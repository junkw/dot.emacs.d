;;; init-marginalia.el --- el-get init file for package marginalia

;; (C) 2023  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 13, 2023
;; Keywords: .emacs, completion

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

(setq marginalia-max-relative-age 0)
(setq marginalia-align 'right)

(marginalia-mode +1)

;;;; Keymap
(keymap-set minibuffer-local-map "M-A" #'marginalia-cycle)

;;; init-marginalia.el ends here
