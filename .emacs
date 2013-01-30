(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/elisp")
(global-font-lock-mode t)
(shell)
(process-kill-without-query (get-process "shell"))
(setq x-select-enable-clipboard t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(require 'tramp)
(setq tramp-default-method "ssh")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

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
;; package.el
;; -----------------------------------

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(require 'paredit)
(require 'highlight-parentheses)

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
(setq erc-keywords '("sayem"))
(setq erc-autojoin-channels-alist '((".*" "#rubyonrails" "#ruby" "#javascript" "#iosdev" "#iphonedev" "#iphone")))

;; -----------------------------------
;; ido
;; -----------------------------------

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; ----------------------------------
;; lisp
;; ----------------------------------

;; scheme
;; -----------------

(load-file "~/elisp/geiser/elisp/geiser.el")

(setq geiser-racket-binary "~/bin/racket")
(setq geiser-active-implementations '(racket))

(defun scheme-custom-setup ()
  (highlight-parentheses-mode)
  (paredit-mode))

(add-hook 'scheme-mode-hook 'scheme-custom-setup)
(add-hook 'inferior-scheme-mode-hook 'scheme-custom-setup)

;; elisp
;; -----------------

(defun elisp-custom-setup ()
  (font-lock-add-keywords nil '(("(\\|)" . 'paren-face)))
  (highlight-parentheses-mode)
  (paredit-mode))

(add-hook 'emacs-lisp-mode-hook 'elisp-custom-setup)

;; ----------------------------------
;; c, c++
;; ----------------------------------

(require 'cc-mode)
(global-set-key [(f9)] 'compile)
(setq compilation-window-height 8)
(setq compilation-finish-function
      (lambda (buf str)

        (if (string-match "exited abnormally" str)

            ;;there were errors
            (message "compilation errors, press C-x ` to visit")

          ;;no errors, make the compilation window go away in 0.5 seconds
          (run-at-time 0.5 nil 'delete-windows-on buf)
          (message "NO COMPILATION ERRORS!"))))

(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
(add-to-list 'magic-mode-alist
                `(,(lambda ()
                     (and (string= (file-name-extension buffer-file-name) "h")
                          (re-search-forward "@\\<interface\\>" 
					     magic-mode-regexp-match-limit t)))
                  . objc-mode))

;; -----------------------------------
;; rails
;; -----------------------------------

(add-to-list 'load-path "~/elisp/rinari")
(require 'rinari)
(require 'haml-mode)

(add-to-list 'load-path "~/elisp/rails-minor-mode")
(require 'rails)

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))

(setq save-abbrevs 'silently)

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)

(add-to-list 'load-path "~/elisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
(lambda () (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.rhtml" . html-mode))
(add-hook 'ruby-mode-hook 'customize-ruby)

;; -----------------------------------
;; web dev
;; -----------------------------------

(add-to-list 'load-path "~/elisp/web-mode.el")
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.inc\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.haml\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode)) 

(add-to-list 'load-path "~/elisp/rainbow-mode.el")
(require 'rainbow-mode)

(defun all-css-modes() (css-mode) (rainbow-mode)) 
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes)) 

;; -----------------------------------
;; javascript
;; -----------------------------------

(autoload 'espresso-mode "espresso")
(add-to-list 'load-path "~/elisp/moz.el")
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-to-list 'load-path "~/elisp/coffee-mode.el")
(require 'coffee-mode)

;; ------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
