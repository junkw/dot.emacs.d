;;; init-magit.el --- el-get init file for package magit

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 21, 2013
;; Keywords: .emacs, git

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

(defvar with-editor-file-name-history-exclude '())
(setq magit-repository-directories '(("~/Code/" . 3)
                                     ("~/etc/conf.d/" . 1)))

;;;; Alias
(defalias 'magit 'magit-status)

;;;; Hooks
(add-hook 'magit-pre-display-buffer-hook #'jkw:set-gc-cons-threshold-biggest)
(add-hook 'magit-post-display-buffer-hook #'jkw:set-gc-cons-threshold-default)
(add-hook 'magit-pre-refresh-hook #'jkw:set-gc-cons-threshold-biggest)
(add-hook 'magit-post-refresh-hook #'jkw:set-gc-cons-threshold-default)

;;;; Keymap
(define-prefix-command 'jkw:magit-command-prefix-key)
(keymap-global-set "C-x g" 'jkw:magit-command-prefix-key)

(let ((prefix jkw:magit-command-prefix-key))
  (keymap-set prefix "g" #'magit-status)
  (keymap-set prefix "G" #'magit-list-repositories)
  (keymap-set prefix "f" #'magit-find-file)
  (keymap-set prefix "F" #'magit-find-file-other-window)
  prefix)

;;; init-magit.el ends here
