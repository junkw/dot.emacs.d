;;; init-company-web.el --- el-get init file for package company-web

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 18, 2017
;; Keywords: .emacs, completion, html, css, web-mode

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

(require 'pre-init-hook-utils)

(defun jkw:company-backends-for-web-mode-init ()
  "[inwebal] Set `company-backends' for `web-mode'."
  (add-to-list (make-local-variable 'company-backends) 'company-tern)
  (add-to-list (make-local-variable 'company-backends) 'company-css)
  (add-to-list (make-local-variable 'company-backends) 'company-web-html))

(add-hooks '(css-mode nxml-mode web-mode) #'jkw:company-backends-for-web-mode-init)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-company-web.el ends here
