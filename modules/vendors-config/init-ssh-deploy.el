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

(setopt ssh-deploy-revision-folder (concat user-emacs-directory "var/backup/"))

;;;; Keymap
(define-prefix-command 'ssh-deploy-command-prefix-key)

(defvar ssh-deploy-mode-map
  (let* ((map (make-sparse-keymap))
         (prefix ssh-deploy-command-prefix-key))
    (keymap-set map "C-c C-z" prefix)
    (keymap-set prefix "f" #'ssh-deploy-upload-handler-forced)
    (keymap-set prefix "u" #'ssh-deploy-upload-handler)
    (keymap-set prefix "D" #'ssh-deploy-delete-handler)
    (keymap-set prefix "d" #'ssh-deploy-download-handler)
    (keymap-set prefix "x" #'ssh-deploy-diff-handler)
    (keymap-set prefix "b" #'ssh-deploy-browse-remote-base-handler)
    (keymap-set prefix "o" #'ssh-deploy-open-remote-file-handler)
    (keymap-set prefix "t" #'ssh-deploy-remote-terminal-eshell-base-handler)
    (keymap-set prefix "T" #'ssh-deploy-remote-terminal-eshell-handler)
    (keymap-set prefix "h" #'ssh-deploy-remote-terminal-shell-base-handler)
    (keymap-set prefix "H" #'ssh-deploy-remote-terminal-shell-handler)
    (keymap-set prefix "R" #'ssh-deploy-rename-handler)
    (keymap-set prefix "e" #'ssh-deploy-remote-changes-handler)
    (keymap-set prefix "m" #'ssh-deploy-remote-sql-mysql-handler)
    (keymap-set prefix "s" #'ssh-deploy-remote-sql-postgres-handler)
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
