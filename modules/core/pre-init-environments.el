;;; pre-init-environments.el --- Emacs init file

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 9, 2017
;; Keywords: .emacs, utility, environments, predicates, path

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
  (require 'cl-lib))

;;;; System type predicates
(defvar cocoa-p (featurep 'ns)
  "Return t if this Emacs is Cocoa version.")
(defvar mac-port-p (featurep 'mac)
  "Return t if this Emacs is Mac port version.")
(defvar mac-p (or cocoa-p mac-port-p (eq system-type 'darwin))
  "Return t if this system is macOS.")
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
  "Return t if this display size is 15-inch or less.")

;;;; Environment predicates
(defvar depended-bins
  '("cmigemo" "mu" "msmtp" "node" "terminal-notifier" "phan" "phpstan")
  "Prospectively registered binaries.")

(defmacro defvar-has-bin-p (bin)
  "Define variable `has-BIN-p' for checking BIN's path."
  `(defvar ,(intern (format "has-%s-p" bin))
     ,(executable-find bin)
     ,(format "Return path if this system has `%s'." bin)))

(mapcar #'(lambda (bin)
            `,(eval `(defvar-has-bin-p ,bin)))
        depended-bins)

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

(provide 'pre-init-environments)

;;; pre-init-environments.el ends here
