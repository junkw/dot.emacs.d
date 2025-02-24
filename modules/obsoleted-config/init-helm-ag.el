;;; init-helm-ag.el --- el-get init file for package helm-ag

;; (C) 2014  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 12, 2014
;; Keywords: .emacs, helm, ag

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

(setopt helm-ag-base-command "ag -S --nocolor --nogroup")
(setopt helm-ag-insert-at-point 'symbol)

;;;; Keymap
(keymap-set helm-command-map "M-s a" #'helm-ag)
(keymap-set helm-command-map "M-s A" #'helm-do-ag)

;;; init-helm-ag.el ends here
