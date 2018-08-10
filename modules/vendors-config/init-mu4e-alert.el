;;; init-mu4e-alert.el --- el-get init file for package mu4e-alert

;; (C) 2016  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 23, 2016
;; Keywords: .emacs, mail, mu4e

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

(setq mu4e-alert-interesting-mail-query "flag:unread AND maildir:\"/inbox\"")

(when has-terminal-notifier-p
  (mu4e-alert-set-default-style 'notifier))

(mu4e-alert-enable-notifications)
(mu4e-alert-enable-mode-line-display)

;;; init-mu4e-alert.el ends here
