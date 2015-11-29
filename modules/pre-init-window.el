;;; pre-init-window.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, window

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

;;;; Window
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'emacs-lisp-mode)
(setq use-dialog-box nil)

;;;; Mode line
(setq eol-mnemonic-dos  "+CR/LF")
(setq eol-mnemonic-mac  "+CR")
(setq eol-mnemonic-unix "+LF")
(setq eol-mnemonic-undecided "")

(column-number-mode +1)
(size-indication-mode +1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*") ; ignore buffer with "*"

;; Show the function in the header line
;; http://www.emacswiki.org/emacs/WhichFuncMode
(require 'which-func)
(which-function-mode)

(setq mode-line-misc-info
      (assq-delete-all 'which-func-mode mode-line-misc-info))
(setq which-func-header-line-format
      '(which-func-mode ("" which-func-format)))

(defun which-func-ff-hook--header-line ()
  "File find hook to use Which Function mode in header line.

Advice function for `which-func-ff-hook'."
  (when which-func-mode
    (setq mode-line-misc-info
          (assq-delete-all 'which-func-mode mode-line-misc-info))
    (setq header-line-format which-func-header-line-format)))

(advice-add 'which-func-ff-hook :after #'which-func-ff-hook--header-line)

;;;; Echo line
(setq echo-keystrokes 0.1)              ; display rate (sec.)

;;;; Line number
;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)

(defun linum-schedule--delayed ()
  "Delay updating line numbers.

Advice function for `linum-schedule'."
  (run-with-idle-timer 0.02 nil #'linum-update-current))

(advice-add 'linum-schedule :override #'linum-schedule--delayed)

;; Disable BiDi
(setq-default bidi-display-reordering nil)
(setq-default bidi-paragraph-direction 'left-to-right)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; pre-init-window.el ends here
