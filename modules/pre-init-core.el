;;; pre-init-core.el --- Emacs init file

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

;;;; Compatibility
(when (fboundp 'apropos-macrop)
  (fset 'apropos-macrop 'macrop))          ; 24.4+

;;;; System type predicates
(defvar mac-p (eq system-type 'darwin)
  "Return t if this system is Mac OS X.")
(defvar cocoa-p (featurep 'ns)
  "Return t if this Emacs is cocoa version.")
(defvar mac-port-p (featurep 'mac)
  "Return t if this Emacs is mac port version.")
(defvar linux-p (eq system-type 'gnu/linux)
  "Return t if this system is Linux.")
(defvar cygwin-p (eq system-type 'cygwin)
  "Return t if this Emacs runs with Cygwin.")
(defvar nt-p (eq system-type 'windows-nt)
  "Return t if this Emacs is NTEmacs.")
(defvar windows-p (or cygwin-p nt-p)
  "Return t if this system is Windows.")

;;;; Display size predicates
(defvar laptop-screen-p (<= (display-pixel-height) 900)
  "Return t if this display size is 15ich or less.")

;;;; Hook
(defun add-hooks (modes function)
  "`add-hook' extension for batch adding to the list of MODES the function FUNCTION."
  (cl-loop for mode in modes
           do (add-hook (intern (concat (symbol-name mode) "-hook")) function)))

;;;; Paths
(defun getenv-from-shell (variable)
  "Get the value of environment variable VARIABLE from the user's shell."
  (interactive (list (read-envvar-name "Get environment variable: " t)))
  (with-temp-buffer
    (call-process (getenv "SHELL") nil (current-buffer) nil
                  "--login" "-i" "-c" (concat "echo __RESULT=$" variable))
    (re-search-backward "__RESULT=\\(.*\\)" nil t)
    (let ((result (match-string 1)))
      (when (called-interactively-p 'interactive)
        (message "%s" (if result result "Not set")))
      result)))

(defun setenv-path-from-shell (path)
  "Inherit the same value of environment variable PATH as on the user's shell.

If argument PATH is environment variable $PATH, set `exec-path' dynamically."
  (let ((path-from-shell (getenv-from-shell path)))
    (setenv path path-from-shell)
    (when (string-equal path "PATH")
      (setq exec-path (split-string path-from-shell path-separator)))))

;;;; Theme
(defsubst custom-active-theme ()
  "Get current theme name as string."
  (symbol-name (car custom-enabled-themes)))

(defun custom-theme-active-p (theme)
  "Return t if THEME is active."
  (equal (custom-active-theme) theme))

;;;; Notify
(when mac-p
  (defun terminal-notifier-notify (title message)
    "Send a MESSAGE with TITLE in Mac OS X Notification Center using terminal-notify.app."
    (let* ((name "*terminal-notifier*")
           (proc
            (start-process name name
                           (executable-find "terminal-notifier")
                           "-title" title
                           "-message" message
                           "-activate" "org.gnu.Emacs")))
      (process-send-eof proc))))

(provide 'pre-init-core)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-core.el ends here