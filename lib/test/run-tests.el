;;; run-tests.el --- test helper for Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 27, 2015
;; Keywords: test

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

(require 'cl-lib)
(require 'ert)

;;;; Initialize
(setq debug-on-error t)

(defvar init-module-safe-mode-p t)
(defvar init-module-modules-path
  (file-name-as-directory (concat user-emacs-directory "modules")))
(defvar init-module-core-path
  (file-name-as-directory (concat init-module-modules-path "core")))
(defvar init-module-local-config-path
  (file-name-as-directory (concat init-module-modules-path "local-config")))
(defvar init-module-vendors-config-path
  (file-name-as-directory (concat init-module-modules-path "vendors-config")))

(add-to-list 'load-path init-module-core-path)
(add-to-list 'load-path init-module-local-config-path)
(add-to-list 'load-path (file-name-as-directory (concat user-emacs-directory "lib/test")))

(load "opt-init-packages.el" nil t)
(load "opt-init-additional-packages.el" nil t)
(require 'el-get)

(setq el-get-verbose t)
(setq el-get-notify-type 'message)

;;;; Libraries
(el-get 'sync 'dash)
(require 'test-utils)

;;;; Test case files
(load "testcase-recipe-exists")
(load "testcase-package-depends")

;;;; Run all tests
(if noninteractive
    (ert-run-tests-batch-and-exit)
  (ert t))

(provide 'run-tests)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; run-tests.el ends here
