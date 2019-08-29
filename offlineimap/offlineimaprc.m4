[general]
ui = ttyui
accounts = USERNAME
maxsyncaccounts = 1
sockettimeout = 30
fysnc = false
pythonfile = ~/.offlineimap.py

[Account USERNAME]
localrepository = USERNAME-local
remoterepository = USERNAME-remote
maxconnections = 1
autorefresh = 0.5
maxsize = 8000000

[Repository USERNAME-local]
type = GmailMaildir
localfolders = MAILDIR/USERNAME
maxage = 90

[Repository USERNAME-remote]
type = Gmail
remoteuser = EMAIL
remotepasseval = mailpasswd()
realdelete = no
ssl = true
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
ssl_version = tls1_2
maxage = 90
