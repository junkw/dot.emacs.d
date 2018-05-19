;;; opt-init-lisp.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, lisp, elisp

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
(require 'pre-init-hook-utils)

(find-function-setup-keys)

;;;; Documentation
(require 'eldoc)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'ielm-mode-hook #'eldoc-mode)

;;;; Hooks
(defun jkw:lisp-mode-init ()
  "My config for (Emacs) Lisp mode."
  (eldoc-mode +1)
  (setq indent-tabs-mode nil)
  (setq imenu-prev-index-position-function nil)
  (add-to-list 'imenu-generic-expression '("Sections" "\\`;;;; \\(.+\\)\\'" 1) t))

(add-hooks '(emacs-lisp-mode lisp-mode lisp-interaction-mode) #'jkw:lisp-mode-init)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-lisp.el ends here
