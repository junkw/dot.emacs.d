;;; post-init-html.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 21, 2012
;; Keywords: .emacs, nxml

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

(require 'pre-init-core)

(add-to-list 'auto-mode-alist '("\\.\\(xml\\|atom\\|[sx]?html?\\)\\'" . nxml-mode))

(eval-after-load-q "nxml-mode"
  ;; Autocompletion
  (setq nxml-slash-auto-complete-flag t)
  (setq nxml-bind-meta-tab-to-complete-flag t)

  ;; Indentation
  (setq nxml-child-indent 2)
  (setq nxml-attribute-indent 4))

(defun jkw:nxml-mode-hooks ()
  "My config for nxml mode"
  (linum-mode 1)
  (flymake-mode 1))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; post-init-html.el ends here