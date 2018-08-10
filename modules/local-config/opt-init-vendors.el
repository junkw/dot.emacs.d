;;; opt-init-vendors.el --- Emacs init file

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jun. 30, 2018
;; Keywords: .emacs, package, ELPA, el-get

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

(eval-when-compile
  (require 'pre-init-environments))
(require 'opt-init-packages)


;;;; Installed packages via el-get
(setq jkw:el-get-used-packages-preload
      (append '(alert
                avy
                editorconfig
                origami
                projectile
                smartrep
                undo-tree
                yasnippet yasnippet-snippets)
              (when has-cmigemo-p
                '(migemo))
              (when has-mu-p
                '(mu4e-alert))
              (when has-node-p
                '(tern
                  vmd-mode))))

(setq jkw:el-get-used-packages
      '(ace-isearch ace-window
                    ag
                    anzu
                    auto-async-byte-compile
                    beginend
                    cl-lib-highlight
                    company-mode company-flx company-quickhelp company-statistics company-tern company-web
                    composer
                    csv-mode
                    dash-at-point
                    dumb-jump
                    e2wm e2wm-bookmark
                    electric-align
                    eldoc-extension elisp-def
                    emmet-mode
                    expand-region
                    flycheck flyspell-correct
                    geben
                    gist git-gutter
                    goto-chg
                    helm helm-ag helm-descbinds helm-ls-git helm-projectile helm-rg helm-swoop
                    highlight-defined highlight-indentation highlight-symbol
                    info+
                    js2-mode json-mode
                    lispxmp
                    magit magit-lfs magit-svn
                    markdown-mode
                    multiple-cursors
                    mwim
                    neotree
                    org-mode org-reveal org-rich-yank ox-pandoc
                    php-mode phpunit
                    psvn
                    rainbow-mode
                    recentf-ext
                    rg
                    scratch-ext
                    smart-newline
                    ssh-deploy
                    sql-indent sqlup-mode
                    twittering-mode
                    viewer
                    visual-regexp-steroids
                    web-mode
                    wgrep
                    which-key
                    yaml-mode))

(setq jkw:el-get-used-packages-postload
      (append '(monokai-theme zerodark-theme)
              '(ac-php
                ace-jump-helm-line
                popwin
                powerline
                smartparens)
              (when has-phan-p
                '(flycheck-phanclient
                  phan))
              (when has-phpstan-p
                '(phpstan))))

;;;; Initialize packages
(el-get--pre-initialize-el-get)

(unless init-module-safe-mode-p
  (unless (require 'el-get nil t)
    ;; If el-get doesn't exist, install it
    (el-get--installer))
  (el-get--post-initialize-el-get)
  (el-get-initialize-packages))

;;; opt-init-vendors.el ends here
