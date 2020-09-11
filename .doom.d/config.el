;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; --------------------- CUSTOM VARIABLES ---------------------------

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name ""
      user-mail-address "")

;; --------------------- Appearance ---------------------

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 15 :weight 'light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'doom-one)

;; --------------------- Org Mode ---------------------

(setq org-directory "~/Dropbox/org/")

(setq org-roam-directory "~/Dropbox/org/roam")

;; Org Pomodoro
;; TODO add hook to send notification to mobile when break ends

(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-long-break-length 10)

;; --------------------- Misc ---------------------

(setq display-line-numbers-type 'relative)

;; Make avy lambda searches span all windows

(setq avy-all-windows t)

;; Bookmarks get saved to with every modification

(setq bookmark-save-flag 1)

;; Always show hints for ace-window

(define-globalized-minor-mode ace-window-display-mode-global ace-window-display-mode
  (lambda () (ace-window-display-mode 1)))

(ace-window-display-mode-global 1)

;; --------------------- CUSTOM KEYMAP ---------------------------

;; Make evil-mode up/down operate in screen lines instead of logical lines

(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)

;; Also in visual mode

(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)
