;;; pre-init-global.el --- Emacs init file

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
(require 'pre-init-core)

;;;; Paths
(when (or cocoa-p mac-port-p)
  (cl-loop for path in '("PATH" "INFOPATH" "MANPATH")
           do (setenv-path-from-shell path)))
(add-to-list 'exec-path (concat user-emacs-directory "bin"))

;;;; Locales
(setenv "LANG" "ja_JP.UTF-8")
(setq system-time-locale "C")

;;;; Character Encoding
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(when mac-p
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  (add-to-list 'process-coding-system-alist '("mdfind" . utf-8-hfs)))

;;;; Minibuffer Edit
(fset 'yes-or-no-p 'y-or-n-p)
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode +1)

;; http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
(defun abort-recursive-edit-and-save-minibuffer ()
  "Save last command to minibuffer history when type `\\[abort-recursive-edit]'.

Advice function for `abort-recursive-edit'."
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

(advice-add 'abort-recursive-edit :before #'abort-recursive-edit-and-save-minibuffer)

;;;; Input Method
(cond (mac-port-p
       (mac-auto-ascii-mode +1))
      ((and cocoa-p (fboundp 'mac-input-method-mode))
       (setq default-input-method "MacOSX")
       (setq mac-use-input-method-on-system t)
       (mac-translate-from-yen-to-backslash)
       (add-hook 'after-init-hook 'mac-change-language-to-us)
       (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)))

;;;; Keymap
(keyboard-translate ?\C-h ?\C-?)
(when mac-p
  (setq mac-command-modifier 'control)
  (setq mac-option-modifier  'meta))

(global-set-key (kbd "C-M-g") 'keyboard-escape-quit)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-global.el ends here
