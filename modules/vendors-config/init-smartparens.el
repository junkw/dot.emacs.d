;;; init-smartparens.el --- el-get init file for package smartparens

;; (C) 2013  Jumpei KAWAMI

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

(require 'pre-init-hook-utils)
(require 'smartparens)

;; Enable in global, but work as strict in every lisp mode
(smartparens-global-mode +1)
(add-hooks sp-lisp-modes #'smartparens-strict-mode)

;; Highlight matching pairs
(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside t)
(show-smartparens-global-mode +1)

;;;; Functions
(defun sp-point-on-web-mode-p (id action context)
  "Return t if point is code on `web-mode', nil otherwise.

Function `sp-show--pair-function' needs arguments ID, ACTION and CONTEXT."
  (when (and (eq action 'insert)
             (not (or (get-text-property (point) 'part-side)
                      (get-text-property (point) 'block-side))))
    t))

;;;; Pair and tag
(sp-pair "（" "）")
(sp-pair "｛" "｝")
(sp-pair "［" "］")
(sp-pair "「" "」")
(sp-pair "『" "』")

(sp-with-modes 'org-mode
  (sp-local-pair "*" "*" :actions '(insert wrap) :unless '(sp-point-after-word-p sp-point-at-bol-p) :skip-match 'sp--org-skip-asterisk)
  (sp-local-pair "_" "_" :unless  '(sp-point-after-word-p))
  (sp-local-pair "/" "/" :unless  '(sp-point-after-word-p))
  (sp-local-pair "~" "~" :unless  '(sp-point-after-word-p))
  (sp-local-pair "+" "+" :unless  '(sp-point-after-word-p)))

(sp-local-pair 'web-mode "<" nil :when '(sp-point-on-web-mode-p))

;;;; Keymap
(sp-use-smartparens-bindings)

;;; init-smartparens.el ends here
