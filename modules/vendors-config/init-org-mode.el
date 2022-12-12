;;; init-org-mode.el --- el-get init file for package org-mode

;; (C) 2013  Jumpei KAWAMI

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

;; Load modules
(add-to-list 'org-modules 'org-habit)
(add-to-list 'org-modules 'ox-man)

(require 'org-tempo)

;; Org file
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
(setq org-fold-catch-invisible-edits 'show-and-error) ; Editing invisible region, expands it and warns
(setq org-return-follows-link t)        ; Open URL with RET
(setq org-adapt-indentation t)
(setq org-use-speed-commands t)

(setq org-id-locations-file (concat user-emacs-directory "var/cache/org-id-locations"))

;;;; Link
(add-to-list 'org-link-abbrev-alist '("asin"   . "https://www.amazon.co.jp/dp/"))
(add-to-list 'org-link-abbrev-alist '("github" . "https://github.com/"))

;;;; ToDo
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "MIT(m)" "NEXT(n)" "DOING(d!)" "PENDING(p@/!)" "|" "DONE(D)" "NOTTODO(N@)")))

(setq org-log-done 'time)               ; Logging completion time
(setq org-log-into-drawer t)            ; Logging into :LOGBOOK:

;; http://emacs.stackexchange.com/questions/10206/limit-number-of-org-todo-items-in-a-certain-state
(defvar org-wip-limit 3
  "Work-In-Progress limit.")

(defvar org-wip-state "DOING"
  "A ToDo keyword of `org-todo-keywords' means 'Work-In-Progress'.")

(defun org-wip--count-todos-in-state (state)
  "[internal] Count ToDo keyword in STATE."
  (let ((counts 0))
    (org-scan-tags #'(lambda ()
                       (when (string= (org-get-todo-state) state)
                         (setq counts (1+ counts))))
                   t t)
    counts))

(defun org-wip-limitter (change-plist)
  "Limit Work-In-Progress in current Org file CHANGE-PLIST."
  (catch 'dont-block
    (when (or (not (eq (plist-get change-plist :type) 'todo-state-change))
              (not (string= (plist-get change-plist :to) org-wip-state)))
      (throw 'dont-block t))
    (when (>= (org-wip--count-todos-in-state org-wip-state) org-wip-limit)
      (setq org-block-entry-blocking (format "WIP limit: %s" org-wip-limit))
      (throw 'dont-block nil))
    t))

(add-hook 'org-blocker-hook #'org-wip-limitter)

;;;; Tags
(setq org-tag-alist
      '(("@work" . ?w) ("@home" . ?h) ("@out" . ?o) ; context on place
        ("@idle" . ?i) ("@batch" . ?b)              ; context on time
        ("BIGROCK" . ?r) ("CONTACT" . ?c) ("DELEGATE" . ?d))) ; action

;;;; Capture
(setq org-capture-templates
      `(("i" "Stuffs such as tasks, ideas, or other information" entry (file ,org-default-notes-file)
         "* %?\n  %i"
         :empty-lines-before 1
         :clock-resume t
         :kill-buffer t)
        ("s" "Process soon" entry (file ,org-default-notes-file)
         "* NEXT %?\n  SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"today\")) DEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+1d\"))\n\n  %a"
         :empty-lines-before 1
         :clock-resume t
         :kill-buffer t)
        ("a" "Code annotaion" entry (file ,org-default-notes-file)
         "* %?%^G\n  %U\n  %A\n  %i"
         :empty-lines-before 1
         :clock-resume t
         :kill-buffer t)))

;;;; Agenda
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-files `(,org-directory "~/Dropbox/Documents/org/"))
(setq org-agenda-show-log t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-time-grid
      '((daily today require-timed)
        "----------------"
        (900 1000 1100 1200 1300 1400 1500 1600 1700 1800)))
(setq org-columns-default-format "%50ITEM %TODO %3PRIORITY %SCHEDULED %Effort{:} %10CLOCKSUM")
(setq org-stuck-projects
      '("+TODO={PENDING}|+LEVEL=1+BIGROCK+TODO={TODO}"
        ("+LEVEL=2/TODO" "+LEVEL=2/NEXT" "+LEVEL=2/DOING") ("DELEGATE") nil))

(setq org-agenda-custom-commands
      '(("n" "Next Action" tags-todo "-DELEGATE/+MIT|NEXT|DOING"
         ((org-agenda-overriding-header "Next Action")
          (org-agenda-span 'week)
          (org-deadline-warning-days 3)
          (org-agenda-sorting-strategy '(todo-state-up deadline-down priority-down category-keep))))))

;;;; Refile
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))

;;;; Babel
;; PlantUML
(setq org-plantuml-jar-path "/usr/local/opt/plantuml/libexec/plantuml.jar")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)))

;;;; Export
(setq org-export-default-language "ja")

(setq org-html-doctype "html5")

(setq org-latex-pdf-process '("lualatex %b" "lualatex %b"))
(setq org-latex-classes '(("document"
                           "\\documentclass{ltjsarticle}
\\usepackage{amsmath,amssymb}
\\usepackage{atbegshi}
\\usepackage{bookmark}
\\usepackage{color}
\\usepackage{graphicx}
\\usepackage{listings}
\\usepackage{ulem}
\\usepackage{url}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
                           ("\\section{%s}" . "\\section*{%s}")
                           ("\\subsection{%s}" . "\\subsection*{%s}")
                           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                           ("\\paragraph{%s}" . "\\paragraph*{%s}")
                           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(setq org-latex-default-class "document")

;;;; Color
;; https://fuco1.github.io/2017-05-25-Fontify-done-checkbox-items-in-org-mode.html
(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-headline-done prepend))
 'append)

;;;; Keymap
(org-defkey org-mode-map (kbd "C-c C-x d") nil)
(org-defkey org-mode-map (kbd "C-c C-x I") #'org-insert-drawer)

(org-defkey org-mode-map (kbd "C-c C-x l") #'org-metaleft)
(org-defkey org-mode-map (kbd "C-c C-x r") #'org-metaright)
(org-defkey org-mode-map (kbd "C-c C-x u") #'org-metaup)
(org-defkey org-mode-map (kbd "C-c C-x d") #'org-metadown)
(org-defkey org-mode-map (kbd "C-c C-x L") #'org-shiftmetaleft)
(org-defkey org-mode-map (kbd "C-c C-x R") #'org-shiftmetaright)
(org-defkey org-mode-map (kbd "C-c C-x U") #'org-shiftmetaup)
(org-defkey org-mode-map (kbd "C-c C-x D") #'org-shiftmetadown)
(org-defkey org-mode-map (kbd "C-c U")     #'org-shiftup)
(org-defkey org-mode-map (kbd "C-c D")     #'org-shiftdown)
(org-defkey org-mode-map (kbd "C-c L")     #'org-shiftleft)
(org-defkey org-mode-map (kbd "C-c R")     #'org-shiftright)

(with-eval-after-load 'smartrep
  (smartrep-define-key org-mode-map "C-c"
    '(("C-n" . #'outline-next-visible-heading)
      ("C-p" . #'outline-previous-visible-heading))))

;;; init-org-mode.el ends here
