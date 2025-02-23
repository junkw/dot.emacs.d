;;; init-corfu.el --- el-get init file for package corfu

;; (C) 2024  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 23, 2024
;; Keywords: .emacs, completion

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

;;;; Init

(require 'corfu-popupinfo)
(require 'corfu-quick)

(setq corfu-auto t)
(setq corfu-auto-delay 0)
(setq corfu-auto-prefix 1)
(setq corfu-cycle t)
(setq corfu-on-exact-match nil)
(setq corfu-quit-no-match 'separator)
(setq tab-always-indent 'complete)

(add-hook 'prog-mode-hook #'corfu-mode)

;;;; Candidates

(defun jkw:corfu-mode-init ()
  "My config for corfu mode."
  (with-eval-after-load 'hotfuzz
    (setq-local completion-styles '(hotfuzz)))
  (corfu-popupinfo-mode +1))

(add-hook 'corfu-mode-hook #'jkw:corfu-mode-init)

;;;; Commands

(defun corfu-enable-always-in-minibuffer ()
  "Enable Corfu in the minibuffer if Vertico/Mct are not active."
  (unless (or (bound-and-true-p mct--active)
              (bound-and-true-p vertico--input)
              (eq (current-local-map) read-passwd-map))
    (setq-local corfu-echo-delay nil
                corfu-popupinfo-delay nil)
    (corfu-mode +1)))

(add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)

;;;; Keymap

(keymap-set corfu-map "TAB" #'corfu-next)
(keymap-set corfu-map "S-TAB" #'corfu-previous)
(keymap-set corfu-map "M-q" #'corfu-quick-complete)
(keymap-set corfu-map "C-q" #'corfu-quick-insert)

;;; init-corfu.el ends here
