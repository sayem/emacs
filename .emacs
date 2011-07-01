(add-to-list 'load-path "~/.emacs.d/")
(global-font-lock-mode t)
(shell)
(process-kill-without-query (get-process "shell"))
(setq x-select-enable-clipboard t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(require 'tramp)
(setq tramp-default-method "ssh")

;; -----------------------------------
;; unicode
;; -----------------------------------

(message "Setting UTF-8 encoding")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; -----------------------------------
;; git
;; -----------------------------------

(progn
  (setq egg-dir "~/elisp/egg")
  (load-file (format "%s/egg.el" egg-dir))
  (require 'egg))

;; -----------------------------------
;; irc
;; -----------------------------------

(add-to-list 'load-path "~/elisp/erc")
(require 'erc)
(require 'erc-match)
(erc :server "irc.freenode.net" :port 6667 :nick "sayem")
(setq erc-keywords '("sayem"))
(setq erc-autojoin-channels-alist '((".*" "#rubyonrails" "#ruby" "#javascript" "#startups" "#github")))

;; -----------------------------------
;; ido
;; -----------------------------------

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; -----------------------------------
;; rails
;; -----------------------------------

(add-to-list 'load-path "~/elisp/rinari")
(require 'rinari)
(require 'haml-mode)

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)

(add-to-list 'load-path "~/elisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
	  (lambda () (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.rhtml" . html-mode))
(add-hook 'ruby-mode-hook 'customize-ruby)

;; -----------------------------------------------------------------------------
;; javascript
;; -----------------------------------------------------------------------------

(autoload 'espresso-mode "espresso")
(add-to-list 'load-path "~/elisp/moz.el")
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;; ------------------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(abbrev-mode t)
 '(confirm-kill-emacs nil)
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
