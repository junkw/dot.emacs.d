;;; init-consult.el --- el-get init file for package consult  -*- lexical-binding: t -*-

;; (C) 2023  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 13, 2023
;; Keywords: .emacs, completion

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

(require 'consult)

(setopt register-preview-delay 0.5)
(setq register-preview-function #'consult-register-format)
(advice-add #'register-preview :override #'consult-register-window)

(setopt xref-show-xrefs-function #'consult-xref)
(setopt xref-show-definitions-function #'consult-xref)

(setopt consult-async-refresh-delay 0.2)
(setopt consult-goto-line-numbers t)
(setopt consult-narrow-key "<")

(setopt consult-locate-args "mdfind -name")

(consult-customize
 consult-locate consult-ripgrep consult-git-grep
 consult-bookmark consult-recent-file consult-xref
 consult--source-bookmark consult--source-file-register
 consult--source-recent-file consult--source-project-recent-file
 :preview-key '(:debounce 0.4 any))

;;;; Commands

(defun consult-ripgrep-dwim (&optional dir given-initial)
  "Pass the region to `consult-ripgrep' if available.

DIR and GIVEN-INITIAL match the method signature of `consult-wrapper'."
  (interactive "P")
  (let ((initial
         (or given-initial
             (when (use-region-p)
               (buffer-substring-no-properties (region-beginning) (region-end))))))
    (consult-ripgrep dir initial)))

;;;; Hooks

(add-hook 'completion-list-mode #'consult-preview-at-point-mode)

;;;; Keymap

(keymap-global-set "<remap> <switch-to-buffer>" #'consult-buffer)
(keymap-global-set "<remap> <switch-to-buffer-other-window>" #'consult-buffer-other-window)
(keymap-global-set "<remap> <switch-to-buffer-other-frame>" #'consult-buffer-other-frame)

(keymap-global-set "C-;" #'consult-locate)
(keymap-global-set "M-y" #'consult-yank-pop)

(keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)

(keymap-set goto-map "g" #'consult-goto-line)
(keymap-set goto-map "o" #'consult-outline)
(keymap-set goto-map "i" #'consult-imenu)
(keymap-set goto-map "I" #'consult-imenu-multi)

(keymap-set search-map "l" #'consult-line)
(keymap-set search-map "e" #'consult-isearch-history)
(keymap-set search-map "d" #'consult-fd)
(keymap-set search-map "r" #'consult-ripgrep-dwim)

(keymap-set minibuffer-local-map "M-r" #'consult-history)
(keymap-set minibuffer-local-map "M-s" #'consult-history)

(keymap-set isearch-mode-map "M-h" #'consult-isearch-history)
(keymap-set isearch-mode-map "M-l" #'consult-line)

;;; init-consult.el ends here
