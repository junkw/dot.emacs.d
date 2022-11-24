;;; early-init.el --- Emacs init file

;; Copyright (C) 2022  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 24, 2022
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

;; Disable Magic File Name temporary
(defconst file-name-handler-alist-origin file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun jkw:restore-file-name-handler-alist ()
  "[internal] restore `file-name-handler-alist'."
  (setq file-name-handler-alist file-name-handler-alist-origin))

(add-hook 'emacs-startup-hook #'jkw:restore-file-name-handler-alist)

;; Set big GC temporary
(defconst gc-cons-threshold-origin gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)

;; Loading elisp files
(setq load-prefer-newer t)

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
	  (expand-file-name  "var/eln-cache/" user-emacs-directory))))

;; Disable startup screen
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; GUI
(if (window-system)
  ;; Window
  (setq frame-inhibit-implied-resize t)

  ;; Bar
  (push '(menu-bar-lines . 0) default-frame-alist)
  (push '(tool-bar-lines . 0) default-frame-alist)
  (push '(vertical-scroll-bars) default-frame-alist))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; early-init.el ends here
