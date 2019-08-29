account gmail
host smtp.gmail.com
from EMAIL
user EMAIL
passwordeval PASSCMD

auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
port 587
logfile ~/.msmtp.log

#account bwasd
#host smtp.gmail.com
#from email
#user email

#auth on
#tls on
#tls_trust_file /etc/ssl/certs/ca-certificates.crt
#port 587

#account b4cx
#host smtp.gmail.com
#from email
#user email
#auth on
#tls on
#tls_trust_file /etc/ssl/certs/ca-certificates.crt
#port 587

account default : gmail
