;;; init-markdown-mode.el --- el-get init file for package markdown-mode

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 2, 2017
;; Keywords: .emacs, markdown

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

(setq markdown-command (executable-find "pandoc"))

;;;; Hooks
(defun jkw:markdown-mode-init ()
  "Config for markdown mode."
  (set (make-local-variable 'delete-trailing-whitespace--enabled-flag-p) nil))

(add-hook 'markdown-mode-hook #'jkw:markdown-mode-init)

;;;; Keymap
(when (executable-find "vmd")
  (define-key markdown-mode-map (kbd "C-c C-c l") #'vmd-mode))

(with-eval-after-load 'smartrep
  (smartrep-define-key markdown-mode-map "C-c"
    '(("C-n" . #'markdown-outline-next)
      ("C-p" . #'markdown-outline-previous)
      ("C-f" . #'markdown-outline-next-same-level)
      ("C-b" . #'markdown-outline-previous-same-level)
      ("C-u" . #'markdown-outline-up))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-markdown-mode.el ends here
