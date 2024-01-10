;;; pre-init-global.el --- Emacs init file

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
(require 'pre-init-keymap-utils)

;;;; Paths
(when (or cocoa-p mac-port-p)
  (cl-loop for path in '("PATH" "INFOPATH" "MANPATH")
           do (setenv-path-from-shell path)))
(add-to-list 'exec-path (concat user-emacs-directory "bin"))

;;;; Locales
(setenv "LANG" "ja_JP.UTF-8")
(setq system-time-locale "C")

;;;; Character Encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(when mac-p
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  (add-to-list 'process-coding-system-alist '("mdfind" . utf-8-hfs)))

;;;; Native Compile
(with-eval-after-load 'comp
  (setq native-comp-async-jobs-number 8)
  (setq native-comp-speed 3))

(defun jkw:native-comp-all-packages ()
  "Native compile my all packages."
  (interactive)
  (native-compile-async (concat user-emacs-directory "init.el"))
  (native-compile-async (concat user-emacs-directory "early-init.el"))
  (native-compile-async init-module-core-path 'recursively)
  (native-compile-async init-module-builtins-config-path 'recursively)
  (native-compile-async init-module-local-config-path 'recursively)
  (native-compile-async init-module-vendors-config-path 'recursively)
  (native-compile-async el-get-dir 'recursively))

;;;; Minibuffer Edit
(setq use-short-answers t)
(minibuffer-depth-indicate-mode +1)

;; http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
(defun abort-recursive-edit--and-save-minibuffer ()
  "Save last command to minibuffer history when type `\\[abort-recursive-edit]'.

Advice function for `abort-recursive-edit'."
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

(advice-add 'abort-recursive-edit :before #'abort-recursive-edit--and-save-minibuffer)

;;;; Input Method
(cond (mac-port-p
       (setq default-input-method "japanese")
       (mac-auto-ascii-mode +1))
      (cocoa-p
       (setq default-input-method "macOS")))

;;;; Keyboard quit
;; https://with-emacs.com/posts/tips/quit-current-context/
(defun keyboard-quit-dwim ()
  "Quit current context.

This function is a combination of `keyboard-quit' and `keyboard-escape-quit'
with some parts omitted and some custom behavior added."
  (interactive)
  (cond ((region-active-p)
         ;; Avoid adding the region to the window selection.
         (setq saved-region-selection nil)
         (let (select-active-regions)
           (deactivate-mark)))
        ((eq last-command 'mode-exited) nil)
        (current-prefix-arg
         nil)
        (defining-kbd-macro
          (message
           (substitute-command-keys
            "Quit is ignored during macro defintion, use \\[kmacro-end-macro] if you want to stop macro definition"))
          (cancel-kbd-macro-events))
        ((active-minibuffer-window)
         (when (get-buffer-window "*Completions*")
           ;; hide completions first so point stays in active window when
           ;; outside the minibuffer
           (minibuffer-hide-completions))
         (abort-recursive-edit))
        (t
         (when completion-in-region-mode
           (completion-in-region-mode -1))
         (let ((debug-on-quit nil))
           (signal 'quit nil)))))

;;;; Keymap
(when mac-p
  (setq mac-command-modifier 'control)
  (setq mac-option-modifier  'meta))

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-unset-key (kbd "C-h"))
(global-set-key (kbd "C-x ?") #'help-command)
(global-set-key [remap keyboard-quit] #'keyboard-quit-dwim)
(define-key global-map (kbd "C-\\") #'toggle-input-method)

(define-vim-keys messages-buffer-mode-map)

;;; pre-init-global.el ends here
