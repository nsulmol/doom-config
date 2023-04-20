;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Nick Sullivan"
      user-mail-address "nsulmol@gmail.com")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-zenburn)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Org/")


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
;;

;; Set up quick which-key menu
(setq which-key-idle-delay 0.33)

;; Maximize emacs on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Setting visual-line-mode to true everywhere
(+global-word-wrap-mode +1)

;; Org Settings ;;

;; Include plant uml path for org babel
(setq org-plantuml-exec-mode 'plantuml
      org-plantuml-executable-path "/usr/bin/plantuml")

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)
   (sh . t)
   (python . t)
   (jupyter . t)))

;; Run all python codes in jupyter by default
(after! org
  (+org-babel-load-jupyter-h 'jupyter-python)
  (org-babel-jupyter-override-src-block "python"))

;; Handle indentation properly in source blocks
;; (for some reason, was set to t)
(setq org-src-preserve-indentation nil)

;; Setting personal org-capture templates
(setq org-capture-templates '(("t" "tasks")
                              ("tw" "work task" entry
                               (file+headline "~/Org/tasks.org" "Work")
                               "* TODO %?" :empty-lines 1)
                              ("tp" "personal task" entry
                               (file+headline "~/Org/tasks.org" "Personal")
                               "* TODO %?" :empty-lines 1)
                              ("c" "code")
                              ("cw" "work code todo" entry
                               (file+headline "~/Org/tasks.org" "Work Code")
                               "* TODO %?\n  %i\n  %a")
                              ("cp" "personal code" entry
                               (file+headline "~/Org/personal/tasks.org" "Personal Code")
                               "* TODO %?\n  %i\n  %a")
                              ("n" "notes" entry
                               (file "~/Org/notes/notes.org")
                               "* %?" :empty-lines 1)))
(setq org-agenda-files '("~/Org/"))

;; Setting todos and priorities to my liking
(setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(p)" "ONHOLD(h)" "|" "DONE(d)" "CANCELED(c)")
 (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
 (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))

;; which-key changes (to allow paging for key bindings) ;;

;; must switch from minibuffer for paging to reliably work
(setq which-key-side-window-location 'bottom)

;; increasing max height to minimize cases we may need to page
(setq which-key-side-window-max-height 0.5)

;; explicitly allow paging for binding key top-menu
(setq which-key-paging-key "C-h")
(setq which-key-paging-prefixes '("C-h b t"))

;; set image auto resize to fit width
(setq image-auto-resize 3)


;; exec-path-from shell changes (so that we get all of our
;; bashrc settings)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(when (daemonp)
  (exec-path-from-shell-initialize))
