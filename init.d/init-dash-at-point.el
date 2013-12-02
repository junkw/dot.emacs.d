;;; init-dash-at-point.el --- el-get init file for package dash-at-point

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 1, 2013
;; Keywords: .emacs,

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

;; Dash docset tags
(add-to-list 'dash-at-point-mode-alist '(js2-mode  . "js"))
(add-to-list 'dash-at-point-mode-alist '(objc-mode . "ios"))
(add-to-list 'dash-at-point-mode-alist '(nxml-mode . "html"))
(add-to-list 'dash-at-point-mode-alist '(web-mode  . "html"))

;; Keymap
(global-set-key (kbd "C-c d") 'dash-at-point)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-dash-at-point.el ends here
