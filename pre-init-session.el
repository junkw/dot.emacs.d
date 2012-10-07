;;; pre-init-session.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 15, 2012
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

;; Emacsclient
(server-start)

;; Garbage collection
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; Opening a file larger than 25 MB, asks for confirmation first.
(setq large-file-warning-threshold (* 50 1024 1024))

;; History size
(setq message-log-max 5000)             ; Message log buffer
(setq history-length 1000)              ; Minibuffer

;; Auto save file
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/var/tmp/") t)))
(setq delete-auto-save-files t)
(setq auto-save-timeout 300)            ; 5 min.
(setq auto-save-interval 500)           ; 500 types

(setq auto-save-list-file-prefix "~/.emacs.d/var/tmp/auto-saves-")

;; Backup file
(setq make-backup-files t)
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/var/backup/"))
(setq backup-by-copying t)
(setq version-control t)
(setq vc-make-backup-files t)
(setq kept-new-versions 3)
(setq kept-old-versions 3)
(setq delete-old-versions t)
(setq trim-versions-without-asking t)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; pre-init-session.el ends here
