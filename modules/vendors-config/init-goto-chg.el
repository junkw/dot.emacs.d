;;; init-goto-chg.el --- el-get init file for package goto-chg

;; (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 25, 2012
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

;;;; Keymap
(keymap-global-set "M-g c" #'goto-last-change)
(keymap-global-set "M-g C" #'goto-last-change-reverse)

(with-eval-after-load 'smartrep
  (smartrep-define-key global-map "M-g"
    '(("c" . #'goto-last-change)
      ("C" . #'goto-last-change-reverse))))

;;; init-goto-chg.el ends here
