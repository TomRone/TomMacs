(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
(add-to-list 'load-path (expand-file-name "~/elisp"))
(add-to-list 'load-path (expand-file-name "~/elisp/rinari/"))
(require 'color-theme)
(load-file "~/elisp/color-theme-twilight.el")
(color-theme-twilight)
(require 'ido)
(ido-mode t)
(require 'rinari)	     
(load "~/elisp/nxhtml/autostart.el")
(setq
 nxhtml-global-minor-mode t
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 indent-region-mode t
 rng-nxml-auto-validate-flag nil
 nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))
;; MuMaMo-Mode for rhtml files
(add-to-list 'load-path "~/elisp/nxhtml/util")
(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))


(fset 'perl-mode 'cperl-mode)
    (setq cperl-indent-level 4
          cperl-close-paren-offset -4
          cperl-continued-statement-offset 4
          cperl-indent-parens-as-block t
          cperl-tab-always-indent t)
(setq cperl-electric-keywords t) ;; expands for keywords such as
                                     ;; foreach, while, etc...
(setq cperl-auto-newline t)
(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "M-p") 'plcmp-cmd-smart-complete)
;;Turn on Flymake
(require 'flymake)
(require 'perl-completion)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'textmate-mode)
(require 'auto-install)
(setq auto-install-directory "~/elisp")
(require 'anything)
(require 'anything-match-plugin)
 (add-hook 'cperl-mode-hook
            (lambda()
             (perl-completion-mode t)
  	    (textmate-mode t)
  	    (flymake-mode t)
  ))
  (add-hook 'perl-mode
  	  (lambda()
              (flymake-mode t)
  	    (textmate-mode t)
  	    (perl-completion-mode t)
  ))

 (require 'sr-speedbar)
(global-set-key (kbd "M-s") 'sr-speedbar-toggle)
;; Flymake ruby support

;; I don't like the default colors :)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	  (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()

	          ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
	          (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
		       (flymake-mode))
		       ))

(add-to-list 'load-path "~/elisp/ruby-mode")
(require 'ruby-mode)
(require 'ruby-electric)
 
(defun ruby-eval-buffer () (interactive)
    "Evaluate the buffer with ruby."
    (shell-command-on-region (point-min) (point-max) "ruby"))
 
(defun my-ruby-mode-hook ()
  (setq standard-indent 4)
  (ruby-electric-mode t)
  (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)
 
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(add-hook 'ruby-mode
	  (lambda()
	    (flymake-mode t)
	    (textmate-mode t)
	    (ruby-electric t)
))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(speedbar-smart-directory-expand-flag t)
 '(sr-speedbar-auto-refresh nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

