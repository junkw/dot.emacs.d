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
(global-set-key (kbd "M-g SPC") #'avy-goto-char-timer)
(global-set-key (kbd "M-g f")   #'avy-goto-line)
(global-set-key (kbd "M-g w")   #'avy-goto-word-1)
(global-set-key (kbd "M-g r")   #'avy-resume)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-g j") #'avy-org-goto-heading-timer))

;;; init-avy.el ends here
