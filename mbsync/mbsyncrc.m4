Expunge None
Create Both

MaildirStore local
Path MAILDIR/work/
Inbox MAILDIR/work/INBOX

IMAPStore work
Host imap.gmail.com
Port 993
User EMAIL
Pass PASSCMD
SSLType IMAPS
SSLVersions TLSv1.2

Channel work
Master :work:
Slave :local:work
Expunge Slave
Sync PullNew Push
