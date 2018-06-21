;;; gui-init-theme-utils.el --- Emacs init file

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 9, 2017
;; Keywords: .emacs, utility, theme

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

(require 'cl-lib)

(defsubst custom-active-theme ()
  "Get current theme name as string."
  (symbol-name (car custom-enabled-themes)))

(defun custom-theme-active-p (theme)
  "Return t if THEME is active."
  (equal (custom-active-theme) theme))

(provide 'gui-init-theme-utils)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; gui-init-theme-utils.el ends here
