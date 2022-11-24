;;; pre-init-window.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

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
(which-function-mode)
(setq-default mode-line-misc-info (assq-delete-all 'which-function-mode mode-line-misc-info))

(defun which-func-ff-hook--header-line ()
  "File find hook to use Which Function mode in header line.

Advice function for `which-func-ff-hook'."
  (when which-func-mode
    (setq header-line-format '(which-function-mode ("" which-func-format)))))

(advice-add 'which-func-ff-hook :after #'which-func-ff-hook--header-line)

;;;; Echo line
(setq echo-keystrokes 0.1)              ; display rate (sec.)

;; Disable BiDi
(setq-default bidi-display-reordering nil)
(setq-default bidi-paragraph-direction 'left-to-right)

;;; pre-init-window.el ends here
