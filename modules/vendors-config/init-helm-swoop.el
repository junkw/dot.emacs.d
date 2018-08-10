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

(setq helm-multi-swoop-edit-save t)
(setq helm-swoop-split-with-multiple-windows nil)
(setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-swoop-speed-or-color t)
(setq helm-swoop-move-to-line-cycle t)
(setq helm-swoop-use-fuzzy-match nil)

;;;; Keymap
(define-key helm-command-prefix (kbd "M-i") #'helm-swoop)
(define-key helm-command-prefix (kbd "M-I") #'helm-multi-swoop)
(define-key helm-command-prefix (kbd "M-a") #'helm-multi-swoop-all)
(define-key helm-command-prefix (kbd "M-p") #'helm-multi-swoop-projectile)

(define-key isearch-mode-map (kbd "M-i") #'helm-swoop-from-isearch)

(with-eval-after-load 'helm-swoop
  (define-key helm-swoop-map (kbd "M-i") #'helm-multi-swoop-all-from-helm-swoop)
  (define-key helm-swoop-map (kbd "C-r") #'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") #'helm-next-line)

  (define-key helm-multi-swoop-map (kbd "C-r") #'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") #'helm-next-line))

;;; init-helm-swoop.el ends here
