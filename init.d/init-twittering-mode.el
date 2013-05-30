;;; init-twittering-mode.el --- el-get init file for package twittering-mode

;; Copyright (C) 2013  Jumpei KAWAMI

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

(require 'pre-init-core)

;; OAuth
(setq twittering-use-master-password t)
(setq twittering-private-info-file "~/.emacs.d/etc/twittering-mode.gpg")

;; Time Line
(setq twittering-status-format "%i %s,  %@:\n%FOLD[	]{%T  // from %f%r%R}\n")

(when (executable-find "convert")
  (setq twittering-convert-fix-size 25)
  (eval-after-load-q 'twittering-mode (twittering-icon-mode 1)))

(setq twittering-timer-interval 60)
(setq twittering-number-of-tweets-on-retrieval 100)

;; Tweet
(setq twittering-use-native-retweet t)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; init-twittering-mode.el ends here
