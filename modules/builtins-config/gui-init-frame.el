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

(eval-when-compile
  (require 'pre-init-environments))

;; Frame size and position
(if laptop-screen-p
    (progn
      (add-to-list 'default-frame-alist '(top    .  60))
      (add-to-list 'default-frame-alist '(left   . 110))
      (add-to-list 'default-frame-alist '(height .  50))
      (add-to-list 'default-frame-alist '(width  . 175)))
  (progn
    (add-to-list 'default-frame-alist '(top    . 110))
    (add-to-list 'default-frame-alist '(left   . 150))
    (add-to-list 'default-frame-alist '(height .  75))
    (add-to-list 'default-frame-alist '(width  . 320))))

;; Transparent
(add-to-list 'default-frame-alist '(alpha . (92 82)))

;; Bar
(setq frame-title-format "%f")

;; Line number
(setopt display-line-numbers-type 'relative)
(setopt display-line-numbers-grow-only t)
(setopt display-line-numbers-width-start t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;;; Keymap
(keymap-global-set "<f10>" nil)
(keymap-global-set "<f11>" nil)

(keymap-global-set "<f8>" #'toggle-frame-fullscreen)

;;; gui-init-frame.el ends here
