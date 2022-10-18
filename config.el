;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Abhishek Singh"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 32 :weight 'regular))

;; (setq doom-font (font-spec :family "Monocraft" :size 17 :weight 'normal)
;;       doom-variable-pitch-font (font-spec :family "Monocraft" :size 18)
;;       doom-unicode-font (font-spec :family "Monocraft")
;;       doom-big-font (font-spec :family "Monocraft" :size 32 :weight 'regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-theme 'doom-one)

;; splash screen

(let ((alternatives '("doomEmacs.svg"
                      "doomEmacsDoomOne.svg"
                      "doomEmacsDracula.svg"
                      "doomEmacsGruvbox.svg"
                      "doomEmacsRouge.svg"
                      "doomEmacsSolarized.svg"
                      "doomEmacsTokyoNight.svg"
                      "doomEmacsTokyoNight2.svg"
                      "doomEmacsTokyoNight3.svg")))
  (setq fancy-splash-image
        (concat doom-user-dir "/etc/splash/resize/"
                (nth (random (length alternatives)) alternatives))))

(setq +doom-dashboard-menu-sections
      '(
        ("Jump to bookmark"
         :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
         :action bookmark-jump)
        ("Open project"
         :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Open private configuration"
         :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
         :when (file-directory-p doom-private-dir)
         :action doom/open-private-config)
        ("Open org-agenda"
         :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
         :when (fboundp 'org-agenda)
         :action org-agenda)
        ("Recently opened files"
         :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Reload last session"
         :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
         :when (cond ((require 'persp-mode nil t)
                      (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                     ((require 'desktop nil t)
                      (file-exists-p (desktop-full-file-name))))
         :face (:inherit (doom-dashboard-menu-title bold))
         :action doom/quickload-session)
        ("Open documentation"
         :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
         :action doom/help)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
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
(setq projectile-project-search-path '("~/dev/haskell/" "~/dev/rust/" "~/dev/node/" "~/work/"))


(add-to-list 'auto-mode-alist '("^Dockerfile.*" . dockerfile-mode))

(add-hook 'calculator-mode-hook 'hide-mode-line-mode)

(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
  (line-number-mode -1)
  ;; (setq doom-modeline-bar-width 0) ; remove vertical bar from modeline
  (setq mode-line-percent-position nil)
  (setq doom-modeline-buffer-encoding nil))

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

(use-package dwim-shell-command
  :ensure t
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  )
(require 'dwim-shell-commands)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; resize windows with ctrl arrow keys
(global-set-key (kbd "<C-down>") 'shrink-window)
(global-set-key (kbd "<C-up>") 'enlarge-window)
(global-set-key (kbd "<C-right>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-left>") 'enlarge-window-horizontally)

;; lang/java

;; Enforce Google Java Code Style
;; See https://google.github.io/styleguide/javaguide.html
;; (when (featurep! :lang java)
;;   (when (featurep! :lang java +lsp)
;;     (setq
;;      lsp-java-format-settings-url "http://google.github.io/styleguide/eclipse-java-google-style.xml"))
;;   (set-formatter! 'google-java-format
;;     '("google-java-format" "-")
;;     :modes 'java-mode)
;;   (setq-hook! 'java-mode-hook
;;     tab-width 2
;;     fill-column 100))

;; (when (featurep! :lang java +lsp)
;;   (setq lsp-java-maven-download-sources t
;;         lsp-java-autobuild-enabled nil
;;         lsp-java-selection-enabled nil
;;         lsp-java-code-generation-use-blocks t
;;         lsp-java-code-generation-generate-comments t
;;         lsp-java-code-generation-to-string-code-style "STRING_BUILDER")

;;   ;; Lombok support
;;   ;; See https://github.com/redhat-developer/vscode-java/wiki/Lombok-support
;;   (after! lsp-java
;;     (push (concat "-javaagent:" (expand-file-name (concat doom-private-dir "etc/lombok/lombok-1.18.25.jar")))
;;           lsp-java-vmargs))

;;   ;; Groovy
;;   (add-hook 'groovy-mode-local-vars-hook #'lsp!))

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

;; (add-to-list 'default-frame-alist '(fullscreen . fullscreen))
(set-frame-parameter (selected-frame) 'fullscreen 'fullscreen) ;; for mac

(after! flycheck
  (setq flycheck-checker-error-threshold 9999)
  ;; (setq flycheck-idle-change-delay 10.0) ;; make it 2 seconds as 1 seconds seems to fast for rust
  ;; (setq flycheck-display-errors-delay 5.0)
  (setq lsp-ui-sideline-enable nil)
  ;; (setq flycheck-check-syntax-automatically '(save idle-buffer-switch new-line))
  (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode)
  )

(setq lsp-response-timeout 2) ;; probably fixes lsp freezes
;; (setq lsp-diagnostic-clean-after-change t) ;; errors where showing in rust on the fly (is not working)

(setq auto-revert-check-vc-info t)
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

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
