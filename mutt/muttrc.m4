# Addresses
set realname        = 'Barry Wasdell'
set from            = 'barrywasdell@gmail.com'
set use_domain      = yes
set use_from        = yes
set reverse_name    = yes

# Headers
ignore *
unignore date subject x-user-agent posted-to content-type
unignore to cc bcc reply-to from
set edit_headers = yes

# Completion
bind editor <Tab> complete-query
bind editor ^T    complete

# Files
set editor = vim
set mailcap_path = '~/.mutt/mailcap'
set move            = no
set send_charset    = "us-ascii:utf-8"
set charset         = UTF-8

# SMTP implementation
set sendmail = "/usr/bin/msmtp"

# Mailbox
#set mbox_type  = 'Maildir'
set folder      = imaps://imap.gmail.com/

# Sub-mailboxes
set spoolfile       = +INBOX
set mbox            = "imaps://imap.gmail.com/[Gmail]/All Mail"
set postponed       = "+[Gmail]/Drafts"
set record          = ""

# Caches
set header_cache        = '~/.cache/mutt/headers'
set message_cachedir    = '~/.mutt/cache/bodies'

# Certificates
#set certificate_file = '~/.mutt/certificates'
set imap_user = barrywasdell@gmail.com
set imap_pass = alaiiatufdefklhl

set smtp_url        = 'smtps://$imap_user@smtp.gmail.com'
set smtp_pass       = alaiiatufdefklhl
set ssl_starttls    = yes
set ssl_force_tls   = yes
set signature       = "~/.mutt/signature"

# Pager
set markers     = no
set pager_stop  = yes
set tilde       = yes

# Quoting
set quote_regexp = '^(>[ \t]*)+'

# Search / Sorting
set sort        = 'reverse-threads'
set sort_aux    = 'last-date-received'
set thorough_search = yes
set strict_threads = yes

# Responses
set fast_reply              = yes
# set forward_attachments   = yes
set forward_format          = 'Fw: %s'
set include                 = yes
set use_envelope_from       = yes

# Encryption
set crypt_replysign          = yes
set crypt_replyencrypt       = yes
set crypt_replysignencrypted = yes
set crypt_use_gpgme          = yes
set crypt_verify_sig         = yes

# PGP
set pgp_auto_decode = yes

# Vim-like bindings
bind index gg first-entry
bind index G  last-entry

bind pager gg top
bind pager G  bottom

set date_format     = "%y-%m-%d %T %M %S"
set index_format    = "%4C %Z %[!%b %e at %I:%M %p] %.20n %s%* -- (%P)"

# Colors
source ~/.mutt/mutt-dark-16.muttrc

# Patch syntax highlighting
color   body    brightwhite     default         ^[[:space:]].*
color   body    yellow          default         ^(diff).*
#color  body    white           default         ^[\-\-\-].*
#color  body    white           default         ^[\+\+\+].*
#color  body    green           default         ^[\+].*
#color  body    red             default         ^[\-].*
#color  body    brightblue      default         [@@].*
color   body    brightwhite     default         ^(\s).*
color   body    cyan            default         ^(Signed-off-by).*
color   body    cyan            default         ^(Docker-DCO-1.1-Signed-off-by).*
color   body    brightwhite     default         ^(Cc)
color   body    yellow          default         "^diff \-.*"
color   body    brightwhite     default         "^index [a-f0-9].*"
color   body    brightblue      default         "^---$"
color   body    white           default         "^\-\-\- .*"
color   body    white           default         "^[\+]{3} .*"
color   body    green           default         "^[\+][^\+]+.*"
color   body    red             default         "^\-[^\-]+.*"
color   body    brightblue      default         "^@@ .*"
color   body    green           default         "LGTM"
color   body    brightmagenta   default         "-- Commit Summary --"
color   body    brightmagenta   default         "-- File Changes --"
color   body    brightmagenta   default         "-- Patch Links --"
color   body    green           default         "^Merged #.*"
color   body    red             default         "^Closed #.*"
color   body    brightblue      default         "^Reply to this email.*"
