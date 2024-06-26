;;; pre-init-session.el --- Emacs init file

;; (C) 2012  Jumpei KAWAMI

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

(eval-when-compile
  (require 'cl-lib)
  (require 'pre-init-environments))

;; Emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;; Garbage collection
(defun jkw:set-gc-cons-threshold-biggest ()
  "[internal] set `gc-cons-threshold' for packages useing big memory."
  (setq gc-cons-threshold most-positive-fixnum))

(defun jkw:set-gc-cons-threshold-default ()
  "[internal] set `gc-cons-threshold' as default."
  (setq gc-cons-threshold (* 50 gc-cons-threshold-origin)))

(run-with-idle-timer
 60.0 t
 #'jkw:set-gc-cons-threshold-default)

(add-hook 'minibuffer-setup-hook #'jkw:set-gc-cons-threshold-biggest)
(add-hook 'minibuffer-exit-hook #'jkw:set-gc-cons-threshold-default)

;; Limit lisp binding
(setq max-lisp-eval-depth 5000)

;; History size
(setq message-log-max 5000)             ; Message log buffer
(setq history-length 1000)              ; Minibuffer

;; Auth
(require 'auth-source)
(when mac-p
  (add-to-list 'auth-sources 'macos-keychain-generic)
  (add-to-list 'auth-sources 'macos-keychain-internet))

(setq nsm-settings-file (concat user-emacs-directory "var/cache/network-security.data"))

;; Remote access
(setq tramp-persistency-file-name (concat user-emacs-directory "var/cache/tramp"))
(setq tramp-auto-save-directory temporary-file-directory)
(setq tramp-backup-directory-alist `((".*" . ,temporary-file-directory)))

;; Lock file
(setq create-lockfiles nil)

;; Auto save file
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" ; for tramp
         ,(concat temporary-file-directory "\\2") t)
        ("\\`/?\\([^/]*/\\)*\\([^/]*\\)\\'"
         ,(expand-file-name (concat user-emacs-directory "var/tmp/\\2")) t)))
(setq delete-auto-save-files t)
(setq auto-save-timeout 300)            ; 5 min.
(setq auto-save-interval 500)           ; 500 types

(setq auto-save-list-file-prefix (concat user-emacs-directory "var/tmp/auto-saves-"))

;; Backup file
(setq make-backup-files t)
(setq backup-directory-alist
      `(("/\\.\\(bzr\\|git\\|hg\\|svn\\)/" . ,temporary-file-directory)
        ("/\\(Code\\|Documents\\)/"        . ,(concat user-emacs-directory "var/backup/"))
        (".*"                              . ,temporary-file-directory)))
(setq backup-by-copying t)
(setq version-control t)
(setq kept-new-versions 3)
(setq kept-old-versions 3)
(setq delete-old-versions t)

;; Save mini buffer historys
(require 'savehist)
(setq savehist-file (concat user-emacs-directory "var/cache/savehist"))
(setq savehist-additional-variables '(search-ring regexp-search-ring))
(setq savehist-ignored-variables '(file-name-history buffer-name-history))
(setq savehist-autosave-interval (* 10 60)) ; sec.
(savehist-mode +1)

;; Recently used file
(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory "var/cache/recentf"))
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 100)
(setq recentf-exclude `(,tramp-file-name-regexp
                        "/\\.loaddefs\\.elc?\\'" "/TAGS\\'"
                        "/\\.cache/" "/\\.git/" "/\\.svn/"
                        "/mail/" "/tmp/" "/var/"))
(setq recentf-auto-cleanup 'never)

(setq recentf-auto-save-timer
      (run-with-idle-timer 30 t #'recentf-save-list))
(recentf-mode +1)

;; Save cursor's place
(setq save-place-file (concat user-emacs-directory "var/cache/saveplace"))
(save-place-mode +1)

;; Bookmark
(require 'bookmark)
(setq bookmark-default-file (concat user-emacs-directory "var/bookmark/bookmarks"))
(setq bookmark-save-flag 1)

;;; pre-init-session.el ends here
