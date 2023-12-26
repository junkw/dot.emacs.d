;;; opt-init-mail.el --- Emacs init file

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 6, 2017
;; Keywords: .emacs, mail, mu4e, mbsync, msmtp

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

(eval-when-compile
  (require 'pre-init-environments))

;;;; Initialize
(when has-mu-p
  ;; bin
  (setq mu4e-mu-binary has-mu-p)
  (setq mu4e-get-mail-command (format "%s -a -c %s/mbsync/config"
                                      (executable-find "mbsync") (getenv "XDG_CONFIG_HOME")))
  (when has-msmtp-p
    (setq sendmail-program has-msmtp-p))

  ;; Maildir
  (setq mu4e-mu-home        (substitute-in-file-name "${XDG_CACHE_HOME}/mu/"))
  (setq mu4e-root-maildir   (substitute-in-file-name "${XDG_DATA_HOME}/mail/"))
  (setq mu4e-drafts-folder  "/drafts")
  (setq mu4e-refile-folder  "/archive")
  (setq mu4e-sent-folder    "/sent")
  (setq mu4e-trash-folder   "/trash")
  (setq mu4e-attachment-dir (substitute-in-file-name "${HOME}/Downloads"))

  (defvar jkw:mu4e-inbox-folder   "/inbox")
  (defvar jkw:mu4e-starred-folder "/starred"))

;;;; Post-init
(with-eval-after-load 'mu4e
  ;; Sync
  (setq mu4e-update-interval (* 30 60))      ; 30 mins.
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-cache-maildir-list nil)
  (setq mu4e-hide-index-messages nil)
  (setq mu4e-index-cleanup t)
  (setq mu4e-index-lazy-check t)

  ;; SMTP
  (require 'smtpmail)

  (if has-msmtp-p
      (progn
        (setq message-send-mail-function #'message-send-mail-with-sendmail)
        (setq message-sendmail-extra-arguments '("--read-envelope-from"))
        (setq message-sendmail-f-is-evil t))
    (require 'starttls)
    (setq message-send-mail-function #'smtpmail-send-it)
    (setq starttls-use-gnutls t))

  (setq message-kill-buffer-on-exit t)
  (setq mail-user-agent 'mu4e-user-agent)

  ;; Headers
  (setq mu4e-headers-sort-field :date)
  (setq mu4e-headers-results-limit 1000)
  (setq mu4e-headers-auto-update t)
  (setq mu4e-headers-include-related nil)
  (setq mu4e-headers-skip-duplicates t)
  (setq mu4e-headers-show-threads nil)

  ;; View
  (when (not laptop-screen-p)
    (setq mu4e-split-view 'vertical)
    (setq mu4e-headers-visible-columns 90))

  (require 'mu4e-contrib)
  (setq mu4e-html2text-command #'mu4e-shr2text)

  (setq mu4e-view-show-images t)
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  ;; Find messages from same sender
  ;; https://github.com/kaz-yos/emacs/blob/master/init.d/500_email.el#L232
  (defun jkw:mu4e-action-find-messages-from-same-sender (&optional msg)
    "Extract sender from From: field and find messages from same sender."
    (interactive)
    (let* ((from (message-field-value "From"))
           (sender-address (cadr (gnus-extract-address-components from))))
      (mu4e-headers-search (concat "from:" sender-address))))
  (add-to-list 'mu4e-view-actions
               '("find same sender" . jkw:mu4e-action-find-messages-from-same-sender) t)

  (defun jkw:mu4e-action-narrow-messages-to-same-sender (&optional msg)
    "Extract sender from From: field and narrow messages to same sender."
    (interactive)
    (let* ((from (message-field-value "From"))
           (sender-address (cadr (gnus-extract-address-components from))))
      (mu4e-headers-search-narrow (concat "from:" sender-address))))
  (add-to-list 'mu4e-view-actions
               '("narrow same sender" . jkw:mu4e-action-narrow-messages-to-same-sender) t)

  ;; Accounts
  ;; https://github.com/joedicastro/dotfiles/blob/master/emacs/init.el#L1214
  (defun jkw:mu4e-select-account ()
    "Select an account from `jkw:mu4e-account-alist'."
    (funcall mu4e-completing-read-function "Compose with account: "
             (mapcar #'car jkw:mu4e-account-alist)))

  (defun jkw:mu4e-get-field (field-name)
    "Get a field var with FIELD-NAME."
    (let* ((field-var (plist-get (car (mu4e-message-field mu4e-compose-parent-message field-name)) :email)))
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

  (add-hook 'mu4e-compose-pre-hook #'jkw:mu4e-set-account)

  ;; Contacts
  (when (require 'org-contacts nil t)
    (setq mu4e-org-contacts-file (expand-file-name "contacts.org" org-directory))
    (add-to-list 'mu4e-headers-actions
                 '("org-contact-add" . mu4e-action-add-org-contact) t)
    (add-to-list 'mu4e-view-actions
                 '("org-contact-add" . mu4e-action-add-org-contact) t))

  ;; Compose
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy nil)
  (setq mu4e-sent-messages-behavior 'delete)
  (setq message-confirm-send t)

  (defun jkw:mu4e-compose-mode-init ()
    "My config for message composition."
    (when (fboundp 'yas-minor-mode)
      (yas-minor-mode +1))
    (set-fill-column 80))

  (add-hook 'mu4e-compose-mode-hook #'jkw:mu4e-compose-mode-init)

  (defun jkw:mu4e-confirm-empty-subject ()
    "Ask for confirmation when current message subject is empty."
    (or (message-field-value "Subject")
        (yes-or-no-p "Really send without Subject? ")
        (signal 'quit nil)))

  (add-hook 'message-send-hook #'jkw:mu4e-confirm-empty-subject)

  (defun jkw:mu4e-confirm-empty-to ()
    "Ask for confirmation when current message address is empty."
    (or (message-field-value "To")
        (yes-or-no-p "Really send without To? ")
        (signal 'quit nil)))

  (add-hook 'message-send-hook #'jkw:mu4e-confirm-empty-to)

  ;; http://mbork.pl/2015-11-28_Fixing_mml-attach-file_using_advice
  (defun mml-attach-file--attach-on-eob (orig-fun &rest args)
    "Attach files on the end of buffer.

Advice function for `mml-attach-file'."
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-max))
        (apply orig-fun args))))

  (advice-add 'mml-attach-file :around #'mml-attach-file--attach-on-eob)

  ;; http://mbork.pl/2016-02-06_An_attachment_reminder_in_mu4e
  (defvar jkw:message-attachment-intent-re
    (regexp-opt '("添付"
                  "ファイル"
                  "docx"
                  "pdf"
                  "pptx"
                  "xlsx"))
    "A regex which - if found in the message, and if there's no attachment - should
launch the no-attachment warning.")

  (defun jkw:message-attachment-present-p ()
    "Return t if an attachment is found in the current message."
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (when (search-forward "<#part" nil t) t))))

  (defun jkw:message-warn-if-no-attachments ()
    "Ask user if they wants to send the message even though there're no attachments."
    (when (and (save-excursion
	             (save-restriction
		           (widen)
		           (goto-char (point-min))
		           (re-search-forward jkw:message-attachment-intent-re nil t)))
	           (not (jkw:message-attachment-present-p)))
      (unless (y-or-n-p "Are you sure you want to send this message without any attachment? ")
        (signal 'quit nil))))

  (add-hook 'message-send-hook #'jkw:message-warn-if-no-attachments)

;;;; Keymap
  (setq mu4e-maildir-shortcuts
        `((,mu4e-refile-folder      . ?a)
          (,mu4e-drafts-folder      . ?d)
          (,jkw:mu4e-inbox-folder   . ?i)
          (,mu4e-sent-folder        . ?t)
          (,jkw:mu4e-starred-folder . ?s)))

  (define-key message-mode-map (kbd "C-x C-s") #'message-dont-send))

;;; opt-init-mail.el ends here
