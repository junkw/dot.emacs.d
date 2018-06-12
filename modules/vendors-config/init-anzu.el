;;; init-anzu.el --- el-get init file for package anzu

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep 29, 2013
;; Keywords: .emacs, mode line, isearch

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

(when (featurep 'migemo)
  (setq anzu-use-migemo t))
(setq anzu-mode-lighter "")

(defun jkw:anzu-update-format (here total)
  "Set format \"[HERE/TOTAL]\" and face for Anzu on mode line."
  (propertize (format " [%d/%d]" here total)
              'face '((:foreground "#CDF187" :weight bold))))
(setq anzu-mode-line-update-function #'jkw:anzu-update-format)

(setq anzu-cons-mode-line-p nil)
(setcar (cdr (assq 'isearch-mode minor-mode-alist))
        '(:eval (anzu--update-mode-line)))

(global-anzu-mode +1)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-anzu.el ends here
