;;; init-direx.el --- el-get init file for package direx

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Aug. 7, 2013
;; Keywords: .emacs, filer, dired

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

(require 'pre-init-core)
(require 'direx)
(require 'direx-project)

;; Icon
(setq direx:leaf-icon   "  ")
(setq direx:open-icon   "- ")
(setq direx:closed-icon "+ ")

;;;; Command
;; http://d.hatena.ne.jp/syohex/20130202/1359814263
(defun direx:dired-jump ()
  "Jump and display the directory tree corresponding to current buffer.

With prefix argument, execute `dired-jump'."
  (interactive)
  (cond (current-prefix-arg
         (dired-jump))
        ((not (one-window-p))
         (or (ignore-errors
               (direx-project:jump-to-project-root) t)
             (direx:jump-to-directory)))
        (t
         (or (ignore-errors
               (direx-project:jump-to-project-root-other-window) t)
             (direx:jump-to-directory-other-window))))
  (when (eq major-mode 'direx:direx-mode)
    (setq-local mode-line-format '("- " mode-line-buffer-identification "-%-"))))

;;;; Keymap
(eval-after-load* 'dired-x
  (setq dired-bind-jump nil)
  (global-set-key (kbd "C-x C-j") 'direx:dired-jump))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-direx.el ends here
