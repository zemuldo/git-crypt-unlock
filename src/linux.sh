#!/bin/sh

# Put GCP service account key from base64 to json on a file.
echo "$GPG_PRIVATE_KEY" | base64 -d > "$HOME"/git-crypt-key.asc

gpg --batch --import git-crypt-key.asc

gpgconf --kill gpg-agent

gpg-agent --daemon --allow-preset-passphrase --max-cache-ttl 3153600000

/usr/lib/gnupg2/gpg-preset-passphrase --preset --passphrase $GPG_KEY_PASS "$GPG_KEY_GRIP"

sudo apt-get install git-crypt

git-crypt unlock

