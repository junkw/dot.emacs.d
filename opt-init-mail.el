;;; opt-init-mail.el --- Emacs init file

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 24, 2013
;; Keywords: .emacs, mail

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

;; mu4e
(when (and (executable-find "mu") (require 'mu4e nil t))
  (require 'org-mu4e)

  (setq mail-user-agent 'mu4e-user-agent)

  ;; Mail directories
  (setq mu4e-maildir        "~/Mail")
  (setq mu4e-attachment-dir "~/Downloads")
  (setq mu4e-sent-folder    "/Sent Mail")
  (setq mu4e-drafts-folder  "/Drafts")
  (setq mu4e-trash-folder   "/Trash")

  ;; External command
  (setq mu4e-get-mail-command  (executable-find "offlineimap"))
  (setq mu4e-html2text-command (concat (executable-find "html2text") " -utf8 -width 72"))
  (setq mu4e-update-interval 3600)      ; 60 mins.

  ;; Compose
  (setq mu4e-sent-messages-behavior 'delete)
  (setq org-mu4e-convert-to-html t)
  (setq message-signature-file "~/.emacs.d/etc/mu4e/signature")

  ;; SMTP
  (require 'smtpmail)

  (setq message-send-mail-function 'smtpmail-send-it)
  (when (executable-find "gnutls-cli")
    (setq smtpmail-stream-type 'ssl))
  (setq smtpmail-default-smtp-server "smtp.gmail.com")
  (setq smtpmail-smtp-server         "smtp.gmail.com")
  (setq smtpmail-smtp-service 465)
  (setq message-kill-buffer-on-exit t)

  ;; View
  (setq mu4e-split-view 'vertical)
  (setq mu4e-headers-visible-columns 90)
  (setq mu4e-view-show-images t)
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  ;; Keymap
  (setq mu4e-maildir-shortcuts
        '(("/Drafts"    . ?d)
          ("/INBOX"     . ?i)
          ("/Sent Mail" . ?t)
          ("/Starred"   . ?s))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-mail.el ends here
