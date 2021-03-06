(use-package evil 
  :ensure t
  :config
  (progn 
    (evil-mode 1)))

(use-package evil-nerd-commenter
  :ensure t
  :config
  (progn
    ;; Use default hotkeys, but also add CMD-/
    (evilnc-default-hotkeys)
    (global-set-key (kbd "s-/") 'evilnc-comment-or-uncomment-lines)))

;; Load org-mode and its settings
(load "org-mode.el")

;; Check out the intro for more info: http://tuhdo.github.io/helm-intro.html
(use-package helm
  :ensure t
  :config
  (progn
    (require 'helm-config)
    (setq helm-buffers-fuzzy-matching t)
    (helm-mode 1)

    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "C-x b") 'helm-mini)
    (global-set-key (kbd "C-x C-b") 'helm-mini)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)))

(use-package helm-package
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-c C-p") 'helm-package)))

(use-package helm-themes
  :ensure t)

(use-package smartparens
  :ensure t
  :config
  (progn
    (require 'smartparens-config)
    (show-paren-mode 1)))

(use-package rainbow-delimiters
  :ensure t
  :config
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))

(use-package flx-ido
   :ensure t
   :config
   (progn
     (ido-mode 1)
     (ido-everywhere 1)
     (flx-ido-mode 1)
     (setq ido-enable-flex-matching t)
     (setq ido-use-faces nil)))

(use-package ido-vertical-mode
  :ensure t
  :config
  (progn
	;; Mode doesn't get invoked automatically for this package...
	(ido-vertical-mode)))

(use-package company
  :ensure t
  :config
  (progn
	;(add-hook 'after-init-hook 'global-company-mode))
	))

(use-package helm-company
  :ensure t
  :config
  (progn
    (define-key company-mode-map (kbd "C-:") 'helm-company)
    (define-key company-active-map (kbd "C-:") 'helm-company)))

(use-package clojure-mode 
  :ensure t
  :config
  (progn
    (add-hook
      'clojure-mode-hook
      (lambda ()
	(eldoc-mode t)
	(smartparens-strict-mode)
	;(setq font-lock-verbose nil)
	(global-set-key (kbd "C-c t") 'clojure-jump-between-tests-and-code)
	;(paredit-mode 1)
))))

(use-package cider
  :ensure t
  :config
  (progn 
    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)     ; Use eldoc when cider is connected
    (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode) ; Use smartparens in the REPL
    (setq cider-prompt-save-file-on-load nil)                 ; Don't prompt to save file on load into REPL
    (setq cider-show-error-buffer nil)                        ; Don't show the error buffer immediately
    (setq cider-auto-select-error-buffer nil)                 ; Don't automatically select error buffer when shown
    (on-platform-do                                           ; Configure the path to lein
     (osx   (setq cider-lein-command "/usr/local/bin/lein"))
     (linux (setq cider-lein-command "/usr/bin/lein")))))

(use-package magit
  :ensure t
  :config
  (progn
    (global-set-key "\C-cgs" 'magit-status)
    (global-set-key "\C-cgd" 'magit-diff-unstaged)))

(use-package git-gutter
  :ensure t
  :config
  (progn 
    (global-git-gutter-mode +1)
    (setq git-gutter:modified-sign " ")
    (setq git-gutter:added-sign " ")
    (setq git-gutter:deleted-sign " ")
    (set-face-background 'git-gutter:modified "yellow")
    (set-face-background 'git-gutter:added "green")
    (set-face-background 'git-gutter:deleted "red")))

(use-package magit-annex
  :ensure t)

(use-package git-annex
  :ensure t)

(use-package fsharp-mode 
  :ensure t
  :mode "\\.fs\\'"
  :interpreter "fsharp"
  :config
  (progn 
    (setq fsharp-ac-use-popup t)))

(use-package markdown-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :config
  (progn
    (add-to-list 
       'auto-mode-alist 
       '("\\.html?\\'" . web-mode))))

;; Use 'M-x httpd-start' to start the web server
;; Use 'M-x impatient-mode' to start live reload for the current buffer
(use-package impatient-mode
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package csharp-mode
  :ensure t
  :config
  (progn
	(add-hook 'csharp-mode-hook (lambda () (c-set-style "c#")))))

(on-platform-do
 (windows
  (use-package omnisharp
	:ensure t
	:config
	(progn
	  (add-to-list 'company-backends 'company-omnisharp)
	  (add-hook 'csharp-mode-hook 'eldoc-mode)
	  (add-hook 'csharp-mode-hook 'omnisharp-mode)

	  (setq omnisharp--curl-executable-path "c:\\Program Files\\cURL\\bin\\curl.exe")
	  (setq omnisharp--windows-curl-tmp-file-path "c:/Users/daviwil/omnisharp-tmp-file.cs")
	  (setq omnisharp-auto-complete-want-importable-types t)
	  (setq omnisharp-server-executable-path "D:/dev/Tools/OmniSharp/OmniSharp/bin/Release/OmniSharp.exe")))))

(use-package nix-mode
  :ensure t)

(use-package twittering-mode
  :ensure t
  :defer t
  :config
  (progn
    (twittering-icon-mode 1)
    ;; TODO: This will need to be set per platform
    (setq twittering-cert-file "/etc/ssl/certs/ca-certificates.crt")
    (twittering-enable-unread-status-notifier)))

(use-package jabber
  :ensure t
  :config
  (progn
    (setq jabber-account-list '(("david@daviwil.com/Emacs")))
    (setq jabber-connection-ssl-program "gnutls")
    (setq jabber-invalid-certificate-servers '("daviwil.com"))
    (setq jabber-alert-message-wave "~/.emacs.d/sounds/jabber_message.wav")
    (setq jabber-alert-message-hooks
	  '(jabber-message-wave jabber-message-echo jabber-message-scroll))
    (setq jabber-chat-buffer-format "IM: %n")
    (jabber-mode-line-mode)))

(use-package smart-mode-line
  :ensure t
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'dark)
    (setq sml/mode-width 'full)
    (setq sml/name-width 40)

    (setq-default mode-line-format
      '("%e" 
	mode-line-front-space 
	mode-line-mule-info 
	mode-line-client 
	mode-line-modified 
	mode-line-remote 
	mode-line-frame-identification 
	mode-line-buffer-identification 
	sml/pos-id-separator 
	(vc-mode vc-mode)
	" "
	;mode-line-position 
	;evil-mode-line-tag
	sml/pre-modes-separator 
	mode-line-modes 
	mode-line-misc-info 
	mode-line-end-spaces))

    (setq rm-excluded-modes
	  (mapconcat
	   'identity
	   ; These names must start with a space!
	   '(" GitGutter" " MRev" " company" 
	     " Helm" " Undo-Tree" " Projectile.*" 
	     " Org-Agenda.*" " ElDoc" " SP/s" " cider.*")
	   "\\|"))))

(use-package projectile
  :ensure t
  :config (projectile-global-mode))

;; Install ergoemacs mode and set desired config
;; (unless (package-installed-p 'ergoemacs-mode)
;;   (package-install 'ergoemacs-mode))
;; (require 'ergoemacs-mode)
;; (setq ergoemacs-theme "hardcore") ;; Uses Hardcore Ergoemacs keyboard theme
;; (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
;; (ergoemacs-mode 1)

(use-package restclient
  :ensure t)

(on-platform-do
 (windows
  (use-package powershell
    :ensure t)))

(on-platform-do
 (linux
  (use-package emms
    :ensure t
    :config
    (progn
      (require 'emms-setup)
      (require 'emms-player-mpd)
      (emms-all)
      (emms-default-players)
      (add-to-list 'emms-info-functions 'emms-info-mpd)
      (add-to-list 'emms-player-list 'emms-player-mpd)
      (add-to-list 'emms-player-list 'emms-player-mplayer)
      (setq emms-player-mpd-music-directory "~/Music")
      (setq emms-mode-line-icon-color "white")
      (emms-mode-line-toggle)
      (emms-cache-set-from-mpd-all)
      (setq emms-source-file-default-directory "~/Music/")))))

