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

(require 'cl-lib)

;; Emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;; Garbage collection
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; History size
(setq message-log-max 5000)             ; Message log buffer
(setq history-length 1000)              ; Minibuffer

;; Auth
(require 'auth-source)
(when mac-p
  (add-to-list 'auth-sources 'macos-keychain-generic)
  (add-to-list 'auth-sources 'macos-keychain-internet))

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
      `(("/\\(Code\\|Documents\\|Docs\\)/" . ,(concat user-emacs-directory "var/backup/"))
        (".*" . ,temporary-file-directory)))
(setq backup-by-copying t)
(setq version-control t)
(setq vc-make-backup-files t)
(setq kept-new-versions 3)
(setq kept-old-versions 3)
(setq delete-old-versions t)

;; Save mini buffer historys
(require 'savehist)
(setq savehist-file (concat user-emacs-directory "var/cache/savehist"))
(setq savehist-additional-variables '(search-ring regexp-search-ring))
(setq savehist-autosave-interval (* 10 60)) ; sec.
(savehist-mode +1)

;; Recently used file
(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory "var/cache/recentf"))
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 100)
(setq recentf-exclude '("^/[^/:]+:" "/\.loaddefs.elc?$" "/COMMIT_EDITMSG$"
                        "/Drafts/" "/var/" "/TAGS$" "/tmp/"))
(recentf-mode +1)

;; Save cursor's place
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "var/cache/saveplace"))
(setq-default save-place t)

;; Bookmark
(require 'bookmark)
(setq bookmark-default-file (concat user-emacs-directory "var/bookmark/bookmarks"))
(setq bookmark-save-flag 1)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-session.el ends here
