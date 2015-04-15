;;; init-highlight-defined.el --- el-get init file for package highlight-defined

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 27, 2015
;; Keywords: .emacs, elisp

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

;;;; Face
(set-face-attribute 'highlight-defined-builtin-function-name-face nil
                    :inherit 'font-lock-builtin-face)
(set-face-attribute 'highlight-defined-special-form-name-face nil
                    :inherit 'font-lock-keyword-face)
(set-face-attribute 'highlight-defined-macro-name-face nil
                    :inherit 'font-lock-function-name-face
                    :slant 'italic)

;;;; Hook
(add-hook 'emacs-lisp-mode-hook #'highlight-defined-mode)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-highlight-defined.el ends here
