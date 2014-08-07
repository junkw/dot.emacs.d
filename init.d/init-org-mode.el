;;; init-org-mode.el --- el-get init file for package org-mode

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 2, 2013
;; Keywords: .emacs, org-mode

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

;; Load modules
(add-to-list 'org-modules 'org-habit)
(add-to-list 'org-modules 'org-man)

;; Org file
(add-to-list 'auto-mode-alist '("\\.org_archive\\'" . org-mode))
(setq org-insert-mode-line-in-empty-file t)
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file (expand-file-name "inbox.org" org-directory))

;;;; General
(setq org-startup-truncated nil)        ; Don't display continuation lines
(setq org-startup-folded 'content)      ; Show all headlines at startup of org mode
(setq org-activate-links '(date bracket radio tag date footnote angle)) ; Fix link face with multibyte chars
(setq org-src-fontify-natively t)       ; Syntax highlight in code blocks
(setq calendar-week-start-day 1)        ; Beginning of week is Mon.
(setq org-list-allow-alphabetical t)    ; XXX avoid error by typing C-e

(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-catch-invisible-edits 'show-and-error) ; Editing invisible region, expands it and warns
(setq org-return-follows-link t)        ; Open URL with RET
(setq org-use-speed-commands t)

;;;; ToDo
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "MIT(m)" "STARTED(s!)" "PENDING(p@/!)" "|" "DONE(x)" "NOTTODO(n@)")))

(setq org-log-done 'time)               ; Logging completion time
(setq org-log-into-drawer t)            ; Logging into :LOGBOOK:

;;;; Tags
(setq org-tag-alist
      '(("@work" . ?w) ("@home" . ?h) ("@out" . ?o) ; context on place
        ("@idle" . ?i) ("@batch" . ?b) ; context on time
        ("@contact" . ?c) ("@delegate" . ?d))) ; context on method

;;;; Capture
(setq org-capture-templates
      '(("s" "Stuffs such as tasks, ideas, or other information" entry (file nil)
         "* %?\n  %i"
         :empty-lines-before 1
         :clock-resume t
         :kill-buffer t)
        ("c" "Code annotaion" entry (file nil)
         "* %?%^G\n  %u\n  %a\n  %i"
         :empty-lines-before 1
         :clock-resume t
         :kill-buffer t)))

;;;; Agenda
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-files `(,org-directory "~/Dropbox/org/"))

;;;; Keymap
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c l") 'org-store-link)

(org-defkey org-mode-map (kbd "C-c C-x d") nil)
(org-defkey org-mode-map (kbd "C-c C-x I") 'org-insert-drawer)

(org-defkey org-mode-map (kbd "C-c C-x l") 'org-metaleft)
(org-defkey org-mode-map (kbd "C-c C-x r") 'org-metaright)
(org-defkey org-mode-map (kbd "C-c C-x u") 'org-metaup)
(org-defkey org-mode-map (kbd "C-c C-x d") 'org-metadown)
(org-defkey org-mode-map (kbd "C-c C-x L") 'org-shiftmetaleft)
(org-defkey org-mode-map (kbd "C-c C-x R") 'org-shiftmetaright)
(org-defkey org-mode-map (kbd "C-c C-x U") 'org-shiftmetaup)
(org-defkey org-mode-map (kbd "C-c C-x D") 'org-shiftmetadown)
(org-defkey org-mode-map (kbd "C-c U")     'org-shiftup)
(org-defkey org-mode-map (kbd "C-c D")     'org-shiftdown)
(org-defkey org-mode-map (kbd "C-c L")     'org-shiftleft)
(org-defkey org-mode-map (kbd "C-c R")     'org-shiftright)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-org-mode.el ends here
