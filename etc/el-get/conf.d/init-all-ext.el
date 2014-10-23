;;; init-all-ext.el --- el-get init file for package all-ext

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 7, 2013
;; Keywords: .emacs, all mode, helm, occur

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

(defun all-from-helm-ag ()
  "Call `all' from `helm' content."
  (interactive)
  (helm-run-after-quit
   'all-from-anything-occur-internal "helm-ag"
   helm-buffer helm-current-buffer))

;;;; Keymap
(with-eval-after-load 'helm-ag
  (define-key helm-map (kbd "C-c C-a") 'all-from-helm-ag))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-all-ext.el ends here
