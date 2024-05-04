;;; init-cape.el --- el-get init file for package cape

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

(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-keyword)
(add-to-list 'completion-at-point-functions #'cape-file)

;;;; Hooks

(defun jkw:cape-elisp-mode-init ()
  "My cape config for Emacs Lisp mode."
  (setq-local completion-at-point-functions
            '(cape-elisp-symbol
              tags-completion-at-point-function
              cape-file
              cape-keyword
              cape-dabbrev)))

(add-hook 'emacs-lisp-mode #'jkw:cape-elisp-mode-init)

;;; init-cape.el ends here
