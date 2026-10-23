;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq fancy-splash-image (concat doom-user-dir "banner.png"))

(setq doom-font (font-spec :family "Maple Mono NF" :size 14))

(setq catppuccin-flavor 'mocha
      doom-theme 'catppuccin)

(setq display-line-numbers-type t
      org-directory "~/Documents/org/"
      projectile-project-search-path '("~/Projects/")
      +format-with-lsp nil)

(add-hook 'prog-mode-hook #'visual-line-mode)

;; ---------------------------------------------------------------------------
;; Shell / environment
;; ---------------------------------------------------------------------------
(setq shell-file-name (executable-find "bash"))
(setq-default explicit-shell-file-name (executable-find "fish"))

(unless (getenv "DOCKER_HOST")
  (when-let ((runtime-dir (getenv "XDG_RUNTIME_DIR")))
    (setenv "DOCKER_HOST" (format "unix://%s/docker.sock" runtime-dir))))

;; ---------------------------------------------------------------------------
;; Terminal (ghostel)
;; ---------------------------------------------------------------------------
(after! ghostel
  (setq ghostel-module-auto-install 'download))

;; ---------------------------------------------------------------------------
;; HTML + templ
;; ---------------------------------------------------------------------------
(define-derived-mode templ-mode web-mode "Templ"
  "Major mode for templ files.")
(add-to-list 'auto-mode-alist '("\\.templ\\'" . templ-mode))

(after! eglot
  (add-to-list 'eglot-server-programs
               '(web-mode . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(templ-mode . ("templ" "lsp"))))

(add-hook 'web-mode-hook #'eglot-ensure)

;; ---------------------------------------------------------------------------
;; SQL (Postgres language server)
;; ---------------------------------------------------------------------------
(after! eglot
  (add-to-list 'eglot-server-programs
               '(sql-mode . ("postgres-language-server" "lsp-proxy"))))
(add-hook 'sql-mode-hook #'eglot-ensure)

;; Highlight SQL as Postgres instead of generic ANSI
(setq sql-product 'postgres)

;; Format .sql on save with pg_format (via apheleia).
(setq +format-on-save-disabled-modes
      (remq 'sql-mode +format-on-save-disabled-modes))

(after! apheleia
  (setf (alist-get 'sql-mode apheleia-mode-alist) 'pgformatter))

;; ---------------------------------------------------------------------------
;; Diagnostics / Flycheck
;; ---------------------------------------------------------------------------
(after! flycheck
  (customize-set-variable 'flycheck-disabled-checkers
                          (cl-union flycheck-disabled-checkers '(golangci-lint))))

(use-package! flycheck-posframe
  :hook (flycheck-mode . flycheck-posframe-mode)
  :config
  (setq flycheck-posframe-border-width 1
        flycheck-posframe-prefix ""
        flycheck-posframe-position 'point-bottom-left-corner)
  (flycheck-posframe-configure-pretty-defaults))

;; ---------------------------------------------------------------------------
;; Formatting (apheleia; binaries come from the devshell)
;; ---------------------------------------------------------------------------
(after! apheleia
  (setf (alist-get 'web-mode apheleia-mode-alist) 'prettier)

  ;; templ-mode derives from web-mode
  (setf (alist-get 'templ apheleia-formatters) '("templ" "fmt")
        (alist-get 'templ-mode apheleia-mode-alist) 'templ)

  ;; Go: goimports + gofumpt
  (setf (alist-get 'goimports apheleia-formatters) '("goimports")
        (alist-get 'gofumpt apheleia-formatters) '("gofumpt")
        (alist-get 'go-mode apheleia-mode-alist) '(goimports gofumpt)
        (alist-get 'go-ts-mode apheleia-mode-alist) '(goimports gofumpt)))

;; ---------------------------------------------------------------------------
;; Corfu Icons (kind-icon)
;; ---------------------------------------------------------------------------
(use-package! kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to match theme background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(after! corfu
  (setq corfu-popupinfo-max-width 60
        corfu-popupinfo-min-width 20))

;; ---------------------------------------------------------------------------
;; Org-roam + Roam UI
;; ---------------------------------------------------------------------------
(setq org-roam-directory (file-truename "~/Documents/org/roam/"))

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil
        org-roam-ui-custom-theme        ; Catppuccin Mocha
        '((bg      . "#1e1e2e")   ; base
          (bg-alt  . "#181825")   ; mantle
          (fg      . "#cdd6f4")   ; text
          (fg-alt  . "#a6adc8")   ; subtext0
          (red     . "#f38ba8")
          (orange  . "#fab387")   ; peach
          (yellow  . "#f9e2af")
          (green   . "#a6e3a1")
          (cyan    . "#94e2d5")   ; teal
          (blue    . "#89b4fa")   ; blue
          (violet  . "#cba6f7")   ; mauve
          (magenta . "#f5c2e7")))) ; pink

(defun my/roam-ui-in-emacs ()
  (interactive)
  (let ((win (seq-find
              (lambda (w)
                (with-current-buffer (window-buffer w)
                  (derived-mode-p 'xwidget-webkit-mode)))
              (window-list))))
    (if win
        (select-window win)
      (unless (bound-and-true-p org-roam-ui-mode)
        (org-roam-ui-mode 1))
      (select-window (split-window-below -15))
      (xwidget-webkit-browse-url "http://127.0.0.1:35901"))))

(map! :leader
      :desc "Roam UI (in Emacs)" "n r u" #'my/roam-ui-in-emacs)
