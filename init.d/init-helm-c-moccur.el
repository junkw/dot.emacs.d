;;; init-helm-ls-git.el --- el-get init file for package helm-c-moccur

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 5, 2013
;; Keywords: .emacs, occur

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

(setq helm-c-moccur-helm-idle-delay 0.1)
(setq helm-c-moccur-widen-when-goto-line-flag t)
(setq helm-c-moccur-show-all-when-goto-line-flag t)
(setq helm-c-moccur-higligt-info-line-flag t)
(setq helm-c-moccur-enable-auto-look-flag t)
(setq helm-c-moccur-enable-initial-pattern t)

;;;; Keymap
(global-set-key (kbd "C-x c M-s o") 'helm-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-x c M-s O") 'helm-c-moccur-dmoccur)

(define-key isearch-mode-map (kbd "M-o") 'helm-c-moccur-from-isearch)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-helm-c-moccur.el ends here
