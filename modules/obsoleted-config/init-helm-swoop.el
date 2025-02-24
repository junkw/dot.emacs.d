;;; init-helm-swoop.el --- el-get init file for package helm-swoop

;; (C) 2014  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 12, 2014
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

(setopt helm-multi-swoop-edit-save t)
(setopt helm-swoop-split-with-multiple-windows nil)
(setopt helm-swoop-split-direction 'split-window-vertically)
(setopt helm-swoop-speed-or-color t)
(setopt helm-swoop-move-to-line-cycle t)
(setopt helm-swoop-use-fuzzy-match nil)

;;;; Keymap
(keymap-set helm-command-map "M-i" #'helm-swoop)
(keymap-set helm-command-map "M-I" #'helm-multi-swoop)
(keymap-set helm-command-map "M-a" #'helm-multi-swoop-all)
(keymap-set helm-command-map "M-p" #'helm-multi-swoop-projectile)

(keymap-set isearch-mode-map "M-i" #'helm-swoop-from-isearch)

(with-eval-after-load 'helm-swoop
  (keymap-set helm-swoop-map "M-i" #'helm-multi-swoop-all-from-helm-swoop)
  (keymap-set helm-swoop-map "C-r" #'helm-previous-line)
  (keymap-set helm-swoop-map "C-s" #'helm-next-line)

  (keymap-set helm-multi-swoop-map "C-r" #'helm-previous-line)
  (keymap-set helm-multi-swoop-map "C-s" #'helm-next-line))

;;; init-helm-swoop.el ends here
