;;; init-twittering-mode.el --- el-get init file for package twittering-mode

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: May. 28, 2013
;; Keywords: .emacs, twitter

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

;; OAuth
(setq twittering-use-master-password t)
(setq twittering-private-info-file (concat user-emacs-directory "etc/twittering-mode.gpg"))

;; Time Line
(setq twittering-status-format "%i %s,  %@:\n%FOLD[	]{%T  // from %f%r%R}\n")

(when (executable-find "convert")
  (setq twittering-convert-fix-size 25)
  (with-eval-after-load 'twittering-mode (twittering-icon-mode +1)))

(setq twittering-timer-interval 60)
(setq twittering-number-of-tweets-on-retrieval 100)

;; Tweet
(setq twittering-use-native-retweet t)
(setq twittering-retweet-format '(nil _ " RT @%s: %t"))

;;;; Hooks
(add-hook 'twittering-edit-mode-hook #'flyspell-mode)

;;; init-twittering-mode.el ends here
