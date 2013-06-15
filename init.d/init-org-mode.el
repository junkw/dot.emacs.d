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

;; Org file
(setq org-insert-mode-line-in-empty-file t)
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file (expand-file-name "inbox.org" org-directory))

;; General
(setq org-startup-truncated nil)        ; Don't display continuation lines
(setq org-activate-links '(date bracket radio tag date footnote angle)) ; Fix link face with multibyte chars
(setq org-src-fontify-natively t)       ; Syntax highlight in code blocks
(setq calendar-week-start-day 1)        ; Beginning of week is Mon.

(setq org-special-ctrl-a/e t)           ; conflict with sequential-command?
(setq org-special-ctrl-k t)
(setq org-catch-invisible-edits 'show-and-error) ; Editing invisible region, expands it and warns
(setq org-return-follows-link t)        ; Open URL with RET

;; ToDo
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "PENDING(p@)" "MAYBE(m)"
                  "|" "DONE(x)" "NOTTODO(n@)")))

(setq org-log-done 'time)               ; Logging completion time

;; Tags
(setq org-tag-alist
      '(("@worksite" . ?w) ("@home" . ?h) ("@away" . ?a) ; context on place
        ("@MITs" . ?m) ("@idle" . ?i) ("@batch" . ?b) ; context on time
        ("@PC" . ?p) ("@contact" . ?c))) ; context on method

;; Capture
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Tasks")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("f" "Fix" entry
         (file+headline nil "Tasks")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("n" "Note" entry
         (file+headline nil "Notes")
         "** %?\n   %i\n   %u")))

;; Keymap
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c l") 'org-store-link)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; init-org-mode.el ends here
