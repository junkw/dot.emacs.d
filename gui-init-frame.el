;;; gui-init-frame.el --- Emacs init file

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 12, 2013
;; Keywords: .emacs, frame

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

;; Frame size and position
(add-to-list 'default-frame-alist '(top    . 110))
(add-to-list 'default-frame-alist '(left   . 200))
(add-to-list 'default-frame-alist '(height .  50))
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(alpha  . (92 82)))

;; Bar
(setq frame-title-format "%f")
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; gui-init-frame.el ends here