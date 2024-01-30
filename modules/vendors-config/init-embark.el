;;; init-embark.el --- el-get init file for package embark

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

(require 'embark-consult)
(require 'embark-org)

(add-to-list 'display-buffer-alist
             '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
               nil
               (window-parameters (mode-line-format . none))))

;;;; Commands
(defun embark-wgrep-rg-results ()
  "`wgrep' ripgrep results with `embark-export'."
  (interactive)
  (when (cl-search "Ripgrep" (buffer-string))
    (run-at-time 0 nil #'embark-export)
    (run-at-time 0 nil #'wgrep-change-to-wgrep-mode)
    (run-at-time 0 nil #'evil-normal-state)))

;;;; Hooks
(add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode)

;;;; Keymap
(setq prefix-help-command #'embark-prefix-help-command)

(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "M-.") #'embark-dwim)
(global-set-key (kbd "C-h B") #'embark-bindings)

(with-eval-after-load 'wgrep
  (define-key minibuffer-mode-map (kbd "C-c C-e") #'embark-wgrep-rg-results))

;;; init-embark.el ends here
