(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")


(setq-default dotspacemacs--configuration-layers
              '((mu4e :variables
                      mu4e-installation-path "/usr/share/emacs/site-lisp/mu4e/")))



(require 'smtpmail)


; smtp
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("maxxcan@disroot.org" 587 nil nil))
      smtpmail-default-smtp-server "disroot.org"
      smtpmail-smtp-server "disroot.org"
      smtpmail-smtp-service 587
      smtpmail-stream-type 'starttls
      smtpmail-local-domain "disroot.org"
      smtpmail-debug-info t)
(setq message-kill-buffer-on-exit t)

(require 'mu4e)

(setq mu4e-maildir (expand-file-name "~/.mail/disroot"))

(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent Items")
(setq mu4e-trash-folder  "/Trash")
(setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file

; get mail
(setq mu4e-get-mail-command "mbsync -a"
      mu4e-html2text-command "w3m -T text/html"
      mu4e-update-interval 120
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil)

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/Sent Items"   . ?s)
         ("/Trash"       . ?t)
         ("/Drafts"    . ?d)
         ))

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "maxxcan@disroot.org"
    user-mail-address "maxxcan@disroot.org"
    user-full-name  "Patricio Martínez")

;; don't save message to Sent Messages, IMAP takes care of this
; (setq mu4e-sent-messages-behavior 'delete)

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mu4e-alert configuration

(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)


;;;;;;;;;;;;;;;;;, fix this problems:
;; https://github.com/syl20bnr/spacemacs/issues/4490

(evilified-state-evilify-map mu4e-headers-mode-map
  :mode mu4e-headers-mode
  :bindings
  (kbd "n") 'mu4e-headers-next)

(evilified-state-evilify-map mu4e-view-mode-map
  :mode mu4e-view-mode
  :bindings
  (kbd "n") 'mu4e-view-headers-next)

