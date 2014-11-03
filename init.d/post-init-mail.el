;;; post-init-mail.el --- Emacs init file

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

(require 'pre-init-core)

;;;; mu4e
(when (executable-find "mu")
  (with-eval-after-load 'mu4e
    (require 'org-mu4e)

    (setq mail-user-agent 'mu4e-user-agent)

    ;; Maildir
    (setq mu4e-maildir        "~/.mail")
    (setq mu4e-attachment-dir "~/Downloads")

    ;; External command
    (setq mu4e-get-mail-command  (executable-find "offlineimap"))
    (setq mu4e-update-interval 3600)      ; 60 mins.

    (setq mu4e-html2text-command (concat (executable-find "html2text") " -utf8 -width 80"))

    ;; Compose
    (setq mu4e-sent-messages-behavior 'delete)
    (setq org-mu4e-convert-to-html t)

    (defun jkw:mu4e-compose-mode-hooks ()
      "My config for message composition."
      (set-fill-column 80)
      (flyspell-mode 1))

    (add-hook 'mu4e-compose-mode-hook 'jkw:mu4e-compose-mode-hooks)

    ;; Multiple accounts selection
    ;; https://github.com/joedicastro/dotfiles/blob/master/emacs/init.el#L1214
    (defun jkw:mu4e-select-account ()
      "Select an account from `jkw:mu4e-account-alist'."
      (funcall mu4e-completing-read-function "Compose with account: "
               (mapcar #'(lambda (var) (car var)) jkw:mu4e-account-alist)))

    (defun jkw:mu4e-get-field (field-name)
      "Get a field var with FIELD-NAME."
      (let ((field-var (cdar (mu4e-message-field mu4e-compose-parent-message field-name))))
        (string-match "@\\(.*\\)\\..*" field-var)
        (match-string 1 field-var)))

    (defun jkw:mu4e-draft-p ()
      "Return t if the message is draft."
      (let ((maildir (mu4e-message-field (mu4e-message-at-point) :maildir)))
        (if (string-match "drafts*" maildir)
            t
          nil)))

    (defun jkw:mu4e-set-account ()
      "Set the account for composing a message."
      (let* ((account
              (if mu4e-compose-parent-message
                  (let ((field (if (jkw:mu4e-draft-p)
                                   (jkw:mu4e-get-field :from)
                                 (jkw:mu4e-get-field :to))))
                    (if (assoc field jkw:mu4e-account-alist)
                        field
                      (jkw:mu4e-select-account)))
                (jkw:mu4e-select-account)))
             (account-vars (cdr (assoc account jkw:mu4e-account-alist))))
        (if account-vars
            (mapc #'(lambda (var)
                      (set (car var) (cadr var)))
                  account-vars)
          (error "No email account found"))))

    (add-hook 'mu4e-compose-pre-hook 'jkw:mu4e-set-account)

    ;; SMTP
    (require 'smtpmail)

    (setq message-send-mail-function 'smtpmail-send-it)
    (when (executable-find "gnutls-cli")
      (setq smtpmail-stream-type 'starttls))
    (setq message-kill-buffer-on-exit t)

    ;; Contacts
    (when (require 'org-contacts nil t)
      (setq mu4e-org-contacts-file (expand-file-name "contacts.org" org-directory))
      (add-to-list 'mu4e-headers-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t)
      (add-to-list 'mu4e-view-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t))

    ;; View
    (when (not laptop-screen-p)
      (setq mu4e-split-view 'vertical)
      (setq mu4e-headers-visible-columns 90))
    (setq mu4e-view-show-images t)
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))

;;;; Keymap
    (setq mu4e-maildir-shortcuts
          `((,mu4e-refile-folder      . ?a)
            (,mu4e-drafts-folder      . ?d)
            (,jkw:mu4e-inbox-folder   . ?i)
            (,mu4e-sent-folder        . ?t)
            (,jkw:mu4e-starred-folder . ?s)))

    (define-key message-mode-map (kbd "C-x C-s") 'message-dont-send)))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; post-init-mail.el ends here
