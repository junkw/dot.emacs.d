;;; init-avy.el --- el-get init file for package avy

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 7, 2018
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

(setq avy-background t)

;;;; Keymap
(keymap-global-set "M-g SPC" #'avy-goto-char-timer)
(keymap-global-set "M-g f"   #'avy-goto-line)
(keymap-global-set "M-g w"   #'avy-goto-word-1)
(keymap-global-set "M-g r"   #'avy-resume)

(with-eval-after-load 'org
  (keymap-set org-mode-map "M-g j" #'avy-org-goto-heading-timer))

;;; init-avy.el ends here
