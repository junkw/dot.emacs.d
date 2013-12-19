;;; init-region-bindings-mode.el --- el-get init file for package region-bindings-mode

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 17, 2013
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

(region-bindings-mode-enable)

;;;; Keymap
(define-key region-bindings-mode-map "g" 'keyboard-quit)

(eval-after-load* 'multiple-cursors
  (defvar jkw:rk-multiple-cursors-keybinds
    '(("n" . 'mc/mark-next-like-this)
      ("p" . 'mc/mark-previous-like-this)
      ("m" . 'mc/mark-more-like-this-extended)
      ("a" . 'mc/mark-all-like-this)
      ("d" . 'mc/mark-all-like-this-dwim))
    "My keybinds for multiple-cursors on region-bindings-mode.")

  (define-keys region-bindings-mode-map jkw:rk-multiple-cursors-keybinds))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-region-bindings-mode.el ends here
