;;; -*- lexical-binding: t -*-

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer

        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

; Temas
(use-package catppuccin-theme
  :straight t
  :custom
  catppuccin-flavor 'mocha
  :config
  (catppuccin-reload))

(load-theme 'catppuccin :no-confirm)

; Geral
(use-package emacs
	:custom
	(auto-revert-verbose t) ; remove mensagem quando um arquivo é alterado por outro programa
  (display-line-numbers-type 'relative)
  (inhibit-startup-screen t)
  (initial-scratch-message "")
  (create-lockfiles nil)
  (make-backup-files nil)
  (use-dialog-box nil)
  (use-file-dialog nil)
  (use-short-answers t)
  (tab-width 2)
	(indent-tabs-mode nil)
  (global-auto-revert-mode 1)
  :hook
  (prog-mode . display-line-numbers-mode)
	:config
	(set-face-attribute 'default nil :family "MonaspiceNe Nerd Font Mono" :height 130)
  (setq custom-file (locate-user-emacs-file "custom.el"))
)

(use-package treesit-auto
  :straight t
  :defer t
  :custom
  (treesit-auto-install t)
  :hook
  (after-init . global-treesit-auto-mode)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all))

(add-to-list 'load-path (concat user-emacs-directory "packages/astro-ts-mode"))
(require 'astro-ts-mode)

(with-eval-after-load 'treesit-auto
  (let ((astro-recipe (make-treesit-auto-recipe
                       :lang 'astro
                       :ts-mode 'astro-ts-mode
                       :url "https://github.com/virchau13/tree-sitter-astro"
                       :revision "master"
                       :source-dir "src")))
    (add-to-list 'treesit-auto-recipe-list astro-recipe)))

(use-package nix-ts-mode
  :straight t
  :mode "\\.nix\\'"
  :config
  (setq lsp-nix-nixd-formatting-command [ "alejandra" ]
        lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"))

(use-package undo-tree
  :defer t
  :straight t
  :hook
  (after-init . global-undo-tree-mode)
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache/undo"))))

(use-package evil
	:straight t
	:defer t
	:hook
	(after-init . evil-mode)
	:init
	(setq evil-want-integration t)
	(setq evil-want-keybinding nil)
	:config
	(evil-set-undo-system 'undo-tree)
	(setq evil-want-fine-undo t))

(use-package evil-collection
	:straight t
	:defer t
	:hook
	(evil-mode . evil-collection-init))

(use-package evil-nerd-commenter
  :straight t
  :defer t
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package diff-hl
  :defer t
  :straight t
  :custom
  (diff-hl-side 'left)
  (diff-hl-margin-symbols-alist '((insert . "│")
                                  (delete . "-")
                                  (change . "│")
                                  (unknown . "?")
                                  (ignored . "i")))
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  (diff-hl-margin-mode)

  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package magit
  :straight t
  :defer t
  :commands (magit-status))

(use-package marginalia
  :straight t
  :defer t
  :hook
  (after-init . marginalia-mode))

(use-package vertico
  :straight t
  :custom
  (vertico-count 13)
  (vertico-resize t)
  (vertico-cycle nil)
  :hook
  (after-init . vertico-mode))

(use-package orderless
  :straight t
  :defer t
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles orderless))))
	(orderless-matching-styles
	 '(orderless-literal orderless-prefixes orderless-initialism orderless-regexp)))


(use-package corfu
  :straight t
  :defer t
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :hook (after-init . global-corfu-mode)
  :config
  (setq tab-always-indent 'complete)
  (setq
   corfu-auto t
   corfu-quit-no-match 'separator
   corfu-preview-current nil
   corfu-min-width 20
   corfu-popupinfo-delay '(1.25 . 0.5))
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-noninterruptible)
  (corfu-popupinfo-mode 1))

(use-package cape
  :straight t
  :defer t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package consult
  :straight t
  :defer t
  :diminish t
  :bind (
	 ("C-x b" . consult-buffer)
	 ("C-c r" . consult-git-grep)
	 ("C-c R" . consult-grep)))

; https://karthinks.com/software/fifteen-ways-to-use-embark/#open-a-file-as-root-without-losing-your-session
(defun sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (when (file-writable-p file)
    (user-error "File is user writeable, aborting sudo"))
  (find-file (if (file-remote-p file)
                 (concat "/" (file-remote-p file 'method) ":"
                         (file-remote-p file 'user) "@" (file-remote-p file 'host)
                         "|sudo:root@"
                         (file-remote-p file 'host) ":" (file-remote-p file 'localname))
               (concat "/sudo:root@localhost:" file))))

(use-package embark
  :straight t
  :defer t
  :bind (("C-x ." . embark-act))
  :config
  (define-key embark-file-map (kbd "S") 'sudo-find-file))

(use-package embark-consult
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package lsp-mode
  :straight t
  :defer t
  :diminish t
  :commands (lsp lsp-deferred)
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  (elixir-ts-mode . lsp-deferred)
  (nix-ts-mode . lsp-deferred)
  (ruby-ts-mode . lsp-deferred)
  (tsx-ts-mode . lsp-deferred)
  (typescript-ts-mode . lsp-deferred)
  (js-ts-mode . lsp-deferred)
  (astro-ts-mode . lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-completion-provider :none)
  (lsp-log-io nil)
  (lsp-idle-delay 0.5)
  (lsp-keep-workspace-alive nil)
  ;; core
  (lsp-enable-xref t)
  (lsp-auto-configure t)
  (lsp-enable-links nil)
  (lsp-eldoc-enable-hover t)
  (lsp-eldoc-render-all t)
  (lsp-enable-dap-auto-configure t)
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)
  (lsp-enable-imenu t)
  (lsp-enable-indentation nil)
  (lsp-enable-on-type-formatting nil)
  (lsp-enable-suggest-server-download t)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-text-document-color t)
  ;; modeline
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-workspace-status-enable nil)
  (lsp-signature-doc-lines 1)
  (lsp-eldoc-render-all t)
  ;; completion
  (lsp-completion-enable t)
  (lsp-completion-enable-additional-text-edit t)
  (lsp-enable-snippet nil)
  (lsp-completion-show-kind t)
  ;; lens
  (lsp-lens-enable t)
  ;; headerline
  (lsp-headerline-breadcrumb-enable-symbol-numbers t)
  (lsp-headerline-arrow "▶")
  (lsp-headerline-breadcrumb-enable-diagnostics nil)
  (lsp-headerline-breadcrumb-icons-enable nil)
  ;; semantic
  (lsp-semantic-tokens-enable nil)

  (lsp-disabled-clients '(ruby-ls rubocop-ls))
  :init
  (setq lsp-use-plists t))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(elixir-ts-mode . "elixir"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "lexical")
    :major-modes '(elixir-mode elixir-ts-mode)
    :server-id 'lexical)))

(with-eval-after-load 'lsp-mode
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "nixd")
                     :major-modes '(nix-mode)
                     :priority 0
                     :server-id 'nixd)))

(use-package lsp-ui
  :straight t
  :defer t)

(editorconfig-mode)

(use-package yasnippet
	:straight t
	:defer t
	:hook (after-init . yas-global-mode))

(use-package projectile
  :straight t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(use-package doom-modeline
  :straight t
  :defer t
  :hook (after-init . doom-modeline-mode))

(use-package envrc
  :straight t
  :diminish t
  :hook
  (after-init . envrc-global-mode))

(use-package vterm
  :straight t
  :ensure t)

(use-package gptel
	:straight t
	:defer t
	:bind (
         ("C-c a a" . gptel)
         ("C-c a r" . gptel-send)
         ("C-c a R" . (lambda ()
                        (interactive)
                        (let ((current-prefix-arg '(4))) ; Simula C-u
                          (call-interactively #'gptel-send))))
         )
	:config
	(setq github-key (with-temp-buffer
										 (insert-file-contents "~/.config/tokens/github.txt")
										 (string-trim (buffer-string))))
	(setq gptel-default-mode 'org-mode)

  (setq gptel-model  'gpt-4o
		gptel-backend
    (gptel-make-openai "Github Models"
      :host "models.inference.ai.azure.com"
      :endpoint "/chat/completions?api-version=2024-05-01-preview"
      :stream t
      :key github-key
      :models '(gpt-4o))))
