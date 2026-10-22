;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq fancy-splash-image (concat doom-user-dir "banner.png"))

(setq doom-font (font-spec :family "Maple Mono NF" :size 14))

(setq catppuccin-flavor 'mocha
      doom-theme 'catppuccin)

(setq display-line-numbers-type t
      org-directory "~/org/"
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
  ;; golangci-lint v2 outputs a format incompatible with Flycheck's built-in parser.
  ;; Completely disable it globally so Eglot/gopls handles project diagnostics instead.
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
  ;; Adjust popup info display width/behavior so it doesn't stretch too far
  (setq corfu-popupinfo-max-width 60
        corfu-popupinfo-min-width 20))
