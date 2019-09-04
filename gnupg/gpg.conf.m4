# This is an implementation based on Riseup OpenPGP Best Practices
# https://help.riseup.net/en/security/message-security/openpgp/best-practices

# Default Key

# The default key to sign with. If this option is not used, the default key is
# the first key found in the secret keyring

default-key KEY

# Encrypt messages for self if recipient is absent
default-recipient-self

# Behavior

# Disable inclusion of the version string in ASCII armored output
no-emit-version

# Disable comment string in clear text signatures and ASCII armored messages
no-comments

# Show complete dates and use column seperation for --with-colon listing mode
fixed-list-mode

# Set keyid-format "none"; all keyid formats can be forged
keyid-format none
with-subkey-fingerprint

# Display the calculated validity of user IDs during key listings
#list-options show-uid-validity
#verify-options show-uid-validity

# Try to use the GnuPG-Agent. With this option, GnuPG first tries to connect to
# the agent before it asks for a passphrase.
use-agent

# When using --refresh-keys, if the key in question has a preferred keyserver
# URL, then disable use of that preferred keyserver to refresh the key from
keyserver-options no-honor-keyserver-url

# When searching for a key with --search-keys, include keys that are marked on
# the keyserver as revoked
keyserver-options include-revoked

# Algorithm and Ciphers
personal-cipher-preferences AES256 AES192 AES CAST5

personal-digest-preferences SHA512

cert-digest-algo SHA512

default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
