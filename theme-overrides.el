;;; theme-overrides.el -*- lexical-binding: t; -*-


;; (custom-set-faces!
;;   `(mode-line :background ,(doom-color 'bg-alt))
;;   `(mode-line-inactive :background ,(doom-color 'bg-alt))
;;   `(doom-modeline-bar :background ,(doom-color 'bg-alt))
;;   )

(with-eval-after-load 'ediff
  (set-face-foreground
    ediff-current-diff-face-A (doom-darken 'red 0.15))
  (set-face-background
    ediff-current-diff-face-A (doom-darken 'red 0.7))
  (set-face-background
    ediff-fine-diff-face-A (doom-darken 'red 0.9))
  (set-face-foreground
    ediff-even-diff-face-A (doom-darken 'red 0.2))
  (set-face-background
    ediff-even-diff-face-A (doom-darken 'red 0.69))
  (set-face-foreground
    ediff-odd-diff-face-A (doom-darken 'red 0.2))
  (set-face-background
    ediff-odd-diff-face-A (doom-darken 'red 0.69))
  (set-face-foreground
    ediff-current-diff-face-B (doom-darken 'green 0.15))
  (set-face-background
    ediff-current-diff-face-B (doom-darken 'green 0.7))
  (set-face-background
    ediff-fine-diff-face-B (doom-darken 'green 0.9))
  (set-face-foreground
    ediff-even-diff-face-B (doom-darken 'green 0.2))
  (set-face-background
    ediff-even-diff-face-B (doom-darken 'green 0.69))
  (set-face-foreground
    ediff-odd-diff-face-B (doom-darken 'green 0.2))
  (set-face-background
    ediff-odd-diff-face-B (doom-darken 'green 0.69))
  (set-face-foreground
    ediff-current-diff-face-C (doom-darken 'blue 0.15))
  (set-face-background
    ediff-current-diff-face-C (doom-darken 'blue 0.7))
  (set-face-background
    ediff-fine-diff-face-C (doom-darken 'blue 0.9))
  (set-face-foreground
    ediff-even-diff-face-C (doom-darken 'blue 0.2))
  (set-face-background
    ediff-even-diff-face-C (doom-darken 'blue 0.69))
  (set-face-foreground
    ediff-odd-diff-face-C (doom-darken 'blue 0.2))
  (set-face-background
    ediff-odd-diff-face-C (doom-darken 'blue 0.69))
  (set-face-foreground
    ediff-current-diff-face-Ancestor (doom-darken 'teal 0.15))
  (set-face-background
    ediff-current-diff-face-Ancestor (doom-darken 'teal 0.7))
  (set-face-background
    ediff-fine-diff-face-Ancestor (doom-darken 'teal 0.9))
  (set-face-foreground
    ediff-even-diff-face-Ancestor (doom-darken 'teal 0.2))
  (set-face-background
    ediff-even-diff-face-Ancestor (doom-darken 'teal 0.69))
  (set-face-foreground
    ediff-odd-diff-face-Ancestor (doom-darken 'teal 0.2))
  (set-face-background
    ediff-odd-diff-face-Ancestor (doom-darken 'teal 0.69)))
