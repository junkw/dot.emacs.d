;;; pre-init-fonts.el --- Emacs init file  -*- lexical-binding: t; -*-

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, font

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

;;;; Font
(cond ((find-font (font-spec :name "UDEV Gothic JPDOC"))
       (set-face-attribute 'default nil
                           :family "UDEV Gothic JPDOC"
                           :height 130)
       (set-fontset-font nil
                         'japanese-jisx0208
                         (font-spec :family "UDEV Gothic JPDOC")))
      ((find-font (font-spec :name "Ricty Diminished Discord"))
       (set-face-attribute 'default nil
                           :family "Ricty Diminished Discord"
                           :height 140)
       (set-fontset-font nil
                         'japanese-jisx0208
                         (font-spec :family "Ricty Diminished Discord")))
      (t
       (set-face-attribute 'default nil
                           :family "Osaka-Mono"
                           :height 130)
       (set-fontset-font nil
                         'japanese-jisx0208
                         (font-spec :family "Osaka-Mono"))))

;;; pre-init-fonts.el ends here
