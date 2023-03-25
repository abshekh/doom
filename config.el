;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; TODO: change lsp settings to use package
;; embark collect - <c-c><c-l>
;; embark export  - E
;; embark edit    - i

(setq user-full-name "Abhishek Singh"
      user-mail-address "john@doe.com")

;; (setq-local abshekh/font "JetBrainsMono Nerd Font")
(setq-local abshekh/font "Iosevka Term")

(setq doom-font (font-spec :family abshekh/font :size 19 :weight 'normal)
      doom-variable-pitch-font (font-spec :family abshekh/font :size 20)
      doom-unicode-font (font-spec :family abshekh/font)
      doom-big-font (font-spec :family abshekh/font :size 32 :weight 'regular))

(load (concat doom-user-dir "work-setup.el"))

;; (use-package autothemer :ensure t)
;; (setq doom-theme 'doom-moonfly)
;; (setq doom-theme 'doom-monokai-pro)

;; (custom-set-faces!
;;   `(mode-line :background ,(doom-color 'bg-alt))
;;   `(mode-line-inactive :background ,(doom-color 'bg-alt))
;;   `(doom-modeline-bar :background ,(doom-color 'bg-alt))
;;   )

;; splash screen

;; (let ((alternatives '("doomEmacs.svg"
;;                       "doomEmacsDoomOne.svg"
;;                       "doomEmacsDracula.svg"
;;                       "doomEmacsGruvbox.svg"
;;                       "doomEmacsRouge.svg"
;;                       "doomEmacsSolarized.svg"
;;                       "doomEmacsTokyoNight.svg"
;;                       "doomEmacsTokyoNight2.svg"
;;                       "doomEmacsTokyoNight3.svg")))
;;   (setq fancy-splash-image
;;         (concat doom-user-dir "/etc/splash/resize/"
;;                 (nth (random (length alternatives)) alternatives))))

(setq fancy-splash-image (concat doom-user-dir "/etc/splash/blackhole.png"))
(setq +doom-dashboard-functions #'(doom-dashboard-widget-banner doom-dashboard-widget-loaded))
;; (setq +doom-dashboard-menu-sections
;;       '(
;;         ("Jump to bookmark"
;;          :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
;;          :action bookmark-jump)
;;         ("Open project"
;;          :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
;;          :action projectile-switch-project)
;;         ("Open private configuration"
;;          :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
;;          :when (file-directory-p doom-private-dir)
;;          :action doom/open-private-config)
;;         ("Open org-agenda"
;;          :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
;;          :when (fboundp 'org-agenda)
;;          :action org-agenda)
;;         ("Recently opened files"
;;          :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
;;          :action recentf-open-files)
;;         ("Reload last session"
;;          :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
;;          :when (cond ((require 'persp-mode nil t)
;;                       (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
;;                      ((require 'desktop nil t)
;;                       (file-exists-p (desktop-full-file-name))))
;;          ;; :face (:inherit (doom-dashboard-menu-title bold))
;;          :action doom/quickload-session)
;;         ;; ("Open documentation"
;;         ;;  :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
;;         ;;  :action doom/help)
;;         ))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

;; (dolist (hook '(text-mode-hook org-mode-hook))
;;       (add-hook hook (lambda () (flyspell-mode -1)))) ;; doesn't work


;; (add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

(after! org
  (add-to-list 'org-capture-templates
               '("w" "Work-related Task" entry
                 (file+headline "~/org/work/work.org" "Work")
                 "* TODO %? \n %i\n %a"
                 :prepend t
                 )))


;; Projectile
(setq projectile-project-search-path '("~/dev/" "~/work/"))


(add-to-list 'auto-mode-alist '("^Dockerfile.*" . dockerfile-mode))

(add-hook 'calculator-mode-hook 'hide-mode-line-mode)

(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
  (line-number-mode -1)
  ;; (setq doom-modeline-bar-width 0) ; remove vertical bar from modeline
  (setq doom-modeline-vcs-max-length 25)
  (setq mode-line-percent-position nil)
  ;; (setq doom-modeline-buffer-encoding nil)
  )

;; hjkl in dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  )

;; command window
(eval-after-load 'evil-vars
  '(define-key evil-ex-completion-map (kbd "C-f") 'evil-ex-command-window))
(eval-after-load 'evil-vars
  '(define-key evil-ex-search-keymap (kbd "C-f") 'evil-ex-search-command-window))
(add-hook 'evil-command-window-mode-hook #'turn-off-smartparens-mode)
(add-hook 'minibuffer-setup-hook #'turn-off-smartparens-mode)
(add-hook 'lisp-mode-hook #'turn-off-smartparens-mode)

(use-package dwim-shell-command
  :ensure t
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  )
(require 'dwim-shell-commands)


;; resize windows with ctrl arrow keys
(global-set-key (kbd "<C-down>") 'shrink-window)
(global-set-key (kbd "<C-up>") 'enlarge-window)
(global-set-key (kbd "<C-right>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-left>") 'enlarge-window-horizontally)

;; lang/java
(add-hook 'java-mode-hook #'lsp-java-lens-mode)
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-jt-lens-mode)
;; (add-hook 'lsp-jt-mode-hook #'lsp-jt-lens-mode)
;; (add-hook 'lsp-java-lens-mode-hook #'lsp-jt-lens-mode)
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . lsp-jt-lens-mode))

(setq-hook! 'java-mode-hook
  tab-width 2
  c-basic-offset 2
  fill-column 100)
(after! lsp-java
  (push (concat "-javaagent:" (expand-file-name (concat doom-user-dir "etc/lombok/lombok-1.18.25.jar")))
        lsp-java-vmargs))
(after! java-mode
  ;; (add-hook 'java-mode-hook (lambda () (lsp-jt-lens-mode 1)))
  (setq lsp-java-format-settings-url "http://google.github.io/styleguide/eclipse-java-google-style.xml")
  (setq lsp-java-format-settings-profile "GoogleStyle"))

;; to run current file
(add-hook 'java-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "java %s" (buffer-file-name)))))


(setq auto-save-default nil)
(setq +evil-want-o/O-to-continue-comments nil)
(setq +default-want-RET-continue-comments t)
(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)

;; Set frame transparency
;; (set-frame-parameter (selected-frame) 'alpha '(96 . 96))
;; (add-to-list 'default-frame-alist '(alpha . (96 . 96)))

;; (doom/set-frame-opacity 96)
;; (add-to-list 'default-frame-alist '(alpha . 96))

;; Maximize windows by default.
;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;; (set-frame-parameter (selected-frame) 'fullscreen 'fullboth)

(add-to-list 'default-frame-alist '(fullscreen . fullscreen))
;; (set-frame-parameter (selected-frame) 'fullscreen 'fullscreen) ;; for mac

(after! flycheck
  (setq flycheck-checker-error-threshold 9999)
  ;; (setq flycheck-idle-change-delay 10.0) ;; make it 2 seconds as 1 seconds seems to fast for rust
  ;; (setq flycheck-display-errors-delay 5.0)
  (setq lsp-ui-sideline-enable nil)
  ;; (setq flycheck-check-syntax-automatically '(save idle-buffer-switch new-line))
  (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode)
  ;; (add-hook 'flycheck-popup-tip-mode-hook 'flycheck-popup-tip-error-prefix "")
  ;; (add-hook 'flycheck-popup-tip-mode-hook (lambda () (flycheck-popup-tip-error-prefix "")))
  )
(after! flycheck-popup-tip
  (setq flycheck-popup-tip-error-prefix "")
  )
;; (after! flycheck-popup-tip-mode
;;   (setq flycheck-popup-tip-error-prefix "")
;;   )

(setq lsp-response-timeout 2) ;; probably fixes lsp freezes
;; (setq lsp-diagnostic-clean-after-change t) ;; errors where showing in rust on the fly (is not working)

(setq auto-revert-check-vc-info t)
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
(setq magit-blame-styles ;; vertical blame
      '((margin
         ;; (margin-width . 60)
         (margin-width . 39)
         ;; (margin-format . ("%.6H %-15.15a %C %s"))
         (margin-format . ("%.6H %-15.15a %C"))
         (margin-face . (magit-blame-margin))
         (margin-body-face . (magit-blame-dimmed))
         (show-message . t)
         )))

;; Enable line numbers and customize their format.
;; (column-number-mode)

;; Enable line numbers for some modes
;; (dolist (mode '(text-mode-hook
;;                 prog-mode-hook
;;                 conf-mode-hook))
;;   (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Reload buffer if file on disk has changed (unless local changes exist)
(setq global-auto-revert-mode t)


(map! :n "gf" 'evil-find-file-at-point-with-line)
;; (map! :n "L" 'switch-to-prev-buffer)
;; (map! :n "H" 'switch-to-next-buffer)

;; reference gD
;; definition gd
;; implementation gI
;; decalration and reference
(map! :nv "Q" #'+format/region-or-buffer)
(map! :n "]e" 'flycheck-next-error)
(map! :n "[e" 'flycheck-previous-error)
(map! (:leader
       (:desc "LSP Rename"              :n "r" 'lsp-rename)
       (:desc "Explain error"           :n "l" 'flycheck-explain-error-at-point)
       (:desc "List buffer errors"      :n "d" 'flycheck-list-errors)
       (:desc "List workspace errors"   :n "D" 'lsp-treemacs-errors-list)
       (:prefix "c"
                (:desc "Run Code Lens"  :n "l" 'lsp-avy-lens))))

(map! (:leader
       (:prefix "o"
                (:desc "Toggle vterm popup"     :n "r" #'+vterm/toggle)
                (:desc "Open vterm here"        :n "R" #'+vterm/here)
                )))
(setq compilation-skip-threshold 2) ;; skip warings in compilation mode
(map! :after compile
      :map compilation-mode-map
      :n "]e" 'next-error
      :n "[e" 'previous-error)


(map! (:leader
       (:prefix "w"
                (:desc "Maximize Window"  :n "m" 'maximize-window))))


(map! :n "]c" #'+vc-gutter/next-hunk)
(map! :n "[c" #'+vc-gutter/previous-hunk)

;; make gutters look good
(after! git-gutter-fringe
  (setq-default fringes-outside-margins t)
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-c-to-ediff-mode-map () (define-key ediff-mode-map "c" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-c-to-ediff-mode-map)

(setq highlight-indent-guides-method 'bitmap)
(setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)

;; (map! (:leader
;;         (:desc "search" :prefix "/"
;;          :desc "Swiper"                :nv "/" #'swiper
;;          :desc "Imenu"                 :nv "i" #'imenu
;;          :desc "Imenu across buffers"  :nv "I" #'imenu-anywhere
;;          :desc "Online providers"      :nv "o" #'+jump/online-select)))

;; (add-hook 'haskell-mode-hook #'hindent-mode)

;; https://github.com/doomemacs/doomemacs/issues/920#issuecomment-425654279
;; :after is the same as after!. However, you need to give this a package name,
;; not the name of a mode or variable. You can see what package c++-mode is
;; defined in with SPC h f c++-mode.
;; function defined in cc-mode.el.gz --> therefore he package name is cc-mode.
(map! :after haskell-mode
      :map haskell-mode-map
      :n "Q" 'hindent-reformat-buffer
      :v "Q" 'hindent-reformat-region)

;; (after! haskell-mode
;;   (setq-mode-local lsp-lens-enable nil))
(setq lsp-haskell-plugin-ghcide-type-lenses-global-on nil)
(setq lsp-haskell-plugin-import-lens-code-lens-on nil)
(setq lsp-haskell-plugin-import-lens-code-actions-on nil)

(setq-hook! 'haskell-mode-hook
  lsp-lens-enable nil)
;; (after! haskell-mode
;;   (setq lsp-lens-enable nil))

;; (setq compilation-error-regexp-alist-alist
;;         ;; Tip: M-x re-builder to test this out
;;         (cons '(stack "^\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\): error:"

;;                            1 ;; file
;;                            2 ;; line
;;                            3 ;; column
;;                            )
;;               compilation-error-regexp-alist-alist))
;; (add-to-list 'compilation-error-regexp-alist-alist '(haskell "^\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\): error:" 1 2 3))

;; (after! compile
;;   (add-to-list 'compilation-error-regexp-alist 'stack)
;;   ;; (add-to-list 'compilation-error-regexp-alist-alist '(stack "^\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\): error:" 1 2 3))
;;   (add-to-list 'compilation-error-regexp-alist-alist '(stack "^\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\): [^w]rror:" 1 2))
;;   )
;; (after! compile
;;   (add-to-list 'compilation-error-regexp-alist-alist '(bloop "^\\[E\\] \\([A-Za-z0-9\\._/-]+\\):\\([0-9]+\\):\\([0-9]+\\):.*$" 1 2 3))
;;   (add-to-list 'compilation-error-regexp-alist 'bloop))

;; (add-to-list 'compilation-error-regexp-alist 'haskell)
;; (add-to-list 'compilation-error-regexp-alist-alist '(haskell "^\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\): error:" 1 2 3))

(map! :after json-mode
      :map json-mode-map
      :nv "Q" 'json-mode-beautify
      )

(define-generic-mode log-mode
  () () ()         ;; comment, keyword, & font lock
  '("\\.log")      ;; auto load
  '(my/log-mode-setup)
  "Simple mode for log files.")

(defun my/log-mode-setup ()
  "Some custom setup stuff done here by mode writer."
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode t)
  (evil-local-set-key 'normal (kbd "Q") #'my/jq-format-logs)
  ;; (evil-local-set-key 'normal (kbd "Q") 'json-pretty-print-buffer)
  ;; (evil-local-set-key 'visual (kbd "Q") 'json-pretty-print)
  ;; (map! :after config
  ;;       :map log-mode-map
  ;;       :n "Q" 'json-pretty-print-buffer
  ;;       :v "Q" 'json-pretty-print)
  ;; (column-number-mode)
  ;; (display-line-numbers-mode 1)
  )

(defun my/jq-format-logs ()
  (interactive)
  (let* ((filename buffer-file-name)
         (catname (concat "cat " filename))
         (formatted-buffer (get-buffer-create "*formatted-buffer*")))
    (unwind-protect
        (with-current-buffer formatted-buffer
          (erase-buffer)
          (insert (shell-command-to-string (concat catname " | jq -R 'fromjson? | .' | jq -s . | jq 'sort_by(.messageNumber) | .[]'"))))
      (erase-buffer)
      (insert-buffer-substring formatted-buffer)
      (kill-buffer formatted-buffer)
      )))

;; python
(after! lsp-pyright
  (add-hook 'conda-postactivate-hook (lambda () (lsp-restart-workspace)))
  (add-hook 'conda-postdeactivate-hook (lambda () (lsp-restart-workspace))))

;; pdf tools, maybe look into evil pdf tools in the future
(use-package pdf-tools
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :config
  (map! :after pdf-view
        :map pdf-view-mode-map
        :n "/" 'pdf-occur)
  (map! :after pdf-occur
        :map pdf-occur-buffer-mode-map
        :n "n" (lambda () (interactive) (forward-line) (pdf-occur-view-occurrence))
        :n "N" (lambda () (interactive) (forward-line -1) (pdf-occur-view-occurrence))))

;; set default projectile name in mode line
;; probabaly this was causing ssh over tramp to slow
;; still not verified
(setq projectile-mode-line "Projectile")

;; install shfmt with this
;; nix-env -iA nixpkgs.shfmt
(map! :after sh-mode
      :map sh-mode-map
      :n "Q" 'shfmt-buffer
      :v "Q" 'shfmt-region)


(defun abshekh/clear-vterm ()
  (interactive)
  (term-send-raw-string (s-repeat 100 "\n"))
  (vterm-send-key "<clear_scrollback>"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))

;; install nixpkgs-fmt with this
;; nix-env -iA nixpkgs.nixpkgs-fmt
(setq lsp-nix-nil-formatter ["nixpkgs-fmt"])
