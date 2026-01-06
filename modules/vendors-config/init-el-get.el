;;; init-el-get.el --- el-get init file for package el-get  -*- lexical-binding: t; -*-

;; (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 25, 2012
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

(require 'el-get)
(require 'el-get-core)
(require 'el-get-list-packages)
(require 'el-get-recipes)

(setopt el-get-emacswiki-base-url "https://www.emacswiki.org/emacs/download/")
(setq el-get-package-menu-sort-key "Status")

;;;; Functions
(with-eval-after-load 'alert
  (defun el-get-notify--wrapper (title message)
    "Send a message to terminal-notifier.

Advice function for `el-get-notify'."
    (alert message :title title))
  (advice-add 'el-get-notify :override #'el-get-notify--wrapper))

(defun el-get-load-package-user-init-file--with-debug (package)
  "Debug on loading the user init file for PACKAGE.

Advice function for `el-get-load-package-user-init-file'."
  (when el-get-user-package-directory
    (let* ((init-file-name (format "init-%s.el" package))
           (package-init-file
            (expand-file-name init-file-name el-get-user-package-directory))
           (file-name-no-extension (file-name-sans-extension package-init-file))
           (compiled-init-file (concat file-name-no-extension ".elc")))
      (when (file-exists-p package-init-file)
        (when el-get-byte-compile
          (el-get-byte-compile-file package-init-file))
        (condition-case err
            (progn
              (load file-name-no-extension)
              (el-get-verbose-message "el-get: load %S" file-name-no-extension))
          (error
           (el-get-verbose-message "Error in el-get user init file %S: %s"
                                   file-name-no-extension
                                   (error-message-string err))))))))

(when el-get-verbose
  (advice-add 'el-get-load-package-user-init-file
              :override
              #'el-get-load-package-user-init-file--with-debug))

;;;; Commands
(defun el-get-byte-recompile-all ()
  "Perform byte-recompile of all installed packages."
  (interactive)
  (cl-loop for pkg in (el-get--list-used-packages)
           do (el-get-byte-compile pkg)
           finally (message "All packages are byte-recompiled.")))

;; el-get package menu
(defun el-get-package-menu-open-init-file ()
  "Open `el-get' init file for PACKAGE on package menu."
  (interactive)
  (let* ((package        (el-get-package-menu-get-package-name))
         (init-file-name (format "init-%s.el" package))
         (package-init-file
          (expand-file-name init-file-name el-get-user-package-directory)))
    (if (file-exists-p package-init-file)
        (find-file package-init-file)
      (when (y-or-n-p (format "Do you want to make init file for `%s'? " package))
        (find-file package-init-file)))))

;;;; Keymap
(keymap-set el-get-package-menu-mode-map "o" #'el-get-package-menu-open-init-file)

;;; init-el-get.el ends here
