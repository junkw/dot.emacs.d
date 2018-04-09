;;; init-js2-mode.el --- el-get init file for package js2-mode

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 20, 2012
;; Keywords: .emacs, javascript

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

(add-to-list 'auto-mode-alist '("\\.\\(js\\|json\\)\\'" . js2-mode))

(with-eval-after-load 'js2-mode
  (require 'js2-imenu-extras)
  (js2-imenu-extras-setup)
  (add-to-list 'which-func-modes 'js2-mode))

;;;; Hooks
(defun jkw:js2-mode-init ()
  "My config for js2 mode."
  (unless editorconfig-mode
    (setq indent-tabs-mode nil))
  (subword-mode +1))

(add-hook 'js2-mode-hook #'jkw:js2-mode-init)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-js2-mode.el ends here
