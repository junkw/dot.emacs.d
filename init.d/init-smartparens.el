;;; init-smartparens.el --- el-get init file for package smartparens

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 9, 2013
;; Keywords: .emacs

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
(require 'smartparens)

;; Enable in global, but work as strict in every lisp mode
(smartparens-global-mode 1)
(add-hooks sp--lisp-modes 'smartparens-strict-mode)

;; Highlight matching pairs
(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside t)
(show-smartparens-global-mode 1)

;;;; Pair management
(sp-with-modes 'org-mode
  (sp-local-tag "*" "*" "*")
  (sp-local-tag "/" "/" "/")
  ;; (sp-local-tag "_" "_" "_")            ; doesn't work because char _ is replaced with inserted text
  (sp-local-tag "=" "=" "=")
  (sp-local-tag "~" "~" "~")
  (sp-local-tag "+" "+" "+"))

(sp-with-modes '(nxml-mode web-mode)
  (sp-local-tag  "<" "<_>" "</_>"
                 :transform 'sp-match-sgml-tags
                 :post-handlers '(sp-html-post-handler)))

(sp-with-modes '(text-mode org-mode web-mode)
  (sp-local-pair "（" "）")
  (sp-local-pair "「" "」")
  (sp-local-pair "『" "』"))

;;;; Keymap
(sp-use-smartparens-bindings)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-smartparens.el ends here
