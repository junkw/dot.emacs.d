;;; init-emmet-mode.el --- el-get init file for package emmet-mode

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 18, 2013
;; Keywords: .emacs, emmet, html, css

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

(with-eval-after-load 'emmet-mode
  (setopt emmet-preview-default nil)
  (setopt emmet-move-cursor-between-quotes t))

;;;; Hooks
(defun jkw:emmet-mode-init ()
  "My config for emmet mode."
  (setopt emmet-indentation 2)
  (emmet-mode +1))

(add-hooks '(web-mode nxml-mode css-mode) #'jkw:emmet-mode-init)

;;; init-emmet-mode.el ends here
