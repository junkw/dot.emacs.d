;;; init-ssh-deploy.el --- el-get init file for package ssh-deploy

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 13, 2018
;; Keywords: .emacs, tramp, ssh, deploy

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

(require 'ssh-deploy)

(setq ssh-deploy-revision-folder (concat user-emacs-directory "var/backup/"))

;;;; Keymap
(define-prefix-command 'ssh-deploy-command-prefix-key)

(defvar ssh-deploy-mode-map
  (let* ((map (make-sparse-keymap))
         (prefix ssh-deploy-command-prefix-key))
    (define-key map (kbd "C-c C-z") prefix)
    (define-key prefix (kbd "f") #'ssh-deploy-upload-handler-forced)
    (define-key prefix (kbd "u") #'ssh-deploy-upload-handler)
    (define-key prefix (kbd "D") #'ssh-deploy-delete-handler)
    (define-key prefix (kbd "d") #'ssh-deploy-download-handler)
    (define-key prefix (kbd "x") #'ssh-deploy-diff-handler)
    (define-key prefix (kbd "b") #'ssh-deploy-browse-remote-base-handler)
    (define-key prefix (kbd "o") #'ssh-deploy-open-remote-file-handler)
    (define-key prefix (kbd "t") #'ssh-deploy-remote-terminal-eshell-base-handler)
    (define-key prefix (kbd "T") #'ssh-deploy-remote-terminal-eshell-handler)
    (define-key prefix (kbd "h") #'ssh-deploy-remote-terminal-shell-base-handler)
    (define-key prefix (kbd "H") #'ssh-deploy-remote-terminal-shell-handler)
    (define-key prefix (kbd "R") #'ssh-deploy-rename-handler)
    (define-key prefix (kbd "e") #'ssh-deploy-remote-changes-handler)
    (define-key prefix (kbd "m") #'ssh-deploy-remote-sql-mysql-handler)
    (define-key prefix (kbd "s") #'ssh-deploy-remote-sql-postgres-handler)
    map)
  "Keymap for `ssh-deploy-mode'.")

;;;; Functions
(defun ssh-deploy-upload-on-save ()
  "[internal] To setup a upload hook on save do with `after-save-hook'."
  (if ssh-deploy-on-explicit-save
      (ssh-deploy-upload-handler)))

(defun ssh-depoy-auto-store-remote-changes ()
  "[internal] To setup automatic storing of base revisions and detection of remote change do with `find-file-hook'."
  (if ssh-deploy-automatically-detect-remote-changes
      (ssh-deploy-remote-changes-handler)))

;;;; Mode
(defvar ssh-deploy-lighter " Deploy")

(define-minor-mode ssh-deploy-mode
  "Minor mode for automatic deploy file when saved."
  :group 'ssh-deploy
  :lighter ssh-deploy-lighter
  :keymap  ssh-deploy-mode-map
  (if ssh-deploy-mode
      (add-hook 'after-save-hook #'ssh-deploy-upload-on-save nil t)
    (remove-hook 'after-save-hook #'ssh-deploy-upload-on-save t)))

;;; init-ssh-deploy.el ends here
