;;; init-ace-isearch.el --- el-get init file for package ace-isearch

;; (C) 2014  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 4, 2014
;; Keywords: .emacs, isearch, ace-jump, helm-swoop

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

(require 'consult)

(setopt ace-isearch-lighter "")

(setopt ace-isearch-use-jump 'printing-char)
(setopt ace-isearch-jump-delay 0.8)
(setopt ace-isearch-function 'avy-goto-char)

(setopt ace-isearch-use-function-from-isearch t)
(setopt ace-isearch-input-length 8)
(setopt ace-isearch-func-delay 0.8)
(setopt ace-isearch-function-from-isearch 'ace-isearch-consult-line-from-isearch)

(global-ace-isearch-mode +1)

;;;; Keymap
(keymap-set isearch-mode-map "C-'" #'ace-isearch-jump-during-isearch)

;;; init-ace-isearch.el ends here
