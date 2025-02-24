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
(setopt max-lisp-eval-depth 5000)

;; History size
(setopt message-log-max 5000)             ; Message log buffer
(setopt history-length 1000)              ; Minibuffer

;; Auth
(require 'auth-source)
(when mac-p
  (add-to-list 'auth-sources 'macos-keychain-generic)
  (add-to-list 'auth-sources 'macos-keychain-internet))

(setopt nsm-settings-file (concat user-emacs-directory "var/cache/network-security.data"))

;; Remote access
(setopt tramp-persistency-file-name (concat user-emacs-directory "var/cache/tramp"))
(setopt tramp-auto-save-directory temporary-file-directory)
(setopt tramp-backup-directory-alist `((".*" . ,temporary-file-directory)))

;; Lock file
(setopt create-lockfiles nil)

;; Auto save file
(setopt auto-save-default t)
(setopt auto-save-file-name-transforms
        `(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" ; for tramp
           ,(concat temporary-file-directory "\\2") t)
          ("\\`/?\\([^/]*/\\)*\\([^/]*\\)\\'"
           ,(expand-file-name (concat user-emacs-directory "var/tmp/\\2")) t)))
(setopt delete-auto-save-files t)
(setopt auto-save-timeout 300)            ; 5 min.
(setopt auto-save-interval 500)           ; 500 types

(setopt auto-save-list-file-prefix (concat user-emacs-directory "var/tmp/auto-saves-"))

;; Backup file
(setopt make-backup-files t)
(setopt backup-directory-alist
        `(("/\\.\\(bzr\\|git\\|hg\\|svn\\)/" . ,temporary-file-directory)
          ("/\\(Code\\|Documents\\)/"        . ,(concat user-emacs-directory "var/backup/"))
          (".*"                              . ,temporary-file-directory)))
(setopt backup-by-copying t)
(setopt version-control t)
(setopt kept-new-versions 3)
(setopt kept-old-versions 3)
(setopt delete-old-versions t)

;; Save mini buffer historys
(require 'savehist)
(setopt savehist-file (concat user-emacs-directory "var/cache/savehist"))
(setopt savehist-additional-variables '(search-ring regexp-search-ring))
(setopt savehist-ignored-variables '(file-name-history buffer-name-history))
(setopt savehist-autosave-interval (* 10 60)) ; sec.
(savehist-mode +1)

;; Recently used file
(require 'recentf)
(setopt recentf-save-file (concat user-emacs-directory "var/cache/recentf"))
(setopt recentf-max-menu-items 25)
(setopt recentf-max-saved-items 100)
(setopt recentf-exclude `(,tramp-file-name-regexp
                          "/\\.loaddefs\\.elc?\\'" "/TAGS\\'"
                          "/\\.cache/" "/\\.git/" "/\\.svn/"
                          "/mail/" "/tmp/" "/var/"))
(setopt recentf-auto-cleanup 'never)

(setq recentf-auto-save-timer
      (run-with-idle-timer 30 t #'recentf-save-list))
(recentf-mode +1)

;; Save cursor's place
(setopt save-place-file (concat user-emacs-directory "var/cache/saveplace"))
(save-place-mode +1)

;; Bookmark
(require 'bookmark)
(setopt bookmark-default-file (concat user-emacs-directory "var/bookmark/bookmarks"))
(setopt bookmark-save-flag 1)

;;; pre-init-session.el ends here
