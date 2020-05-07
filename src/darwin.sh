#!/bin/sh

echo "Installing GnuPG with Home-Brew"
HOMEBREW_NO_AUTO_UPDATE=1 brew install gnupg

echo "Exporting key from base64 to file "$HOME"/git-crypt-key.asc"
echo "$GPG_PRIVATE_KEY" | base64 -D > "$HOME"/git-crypt-key.asc

echo "Importing GPG Private Key"
gpg --batch --import "$HOME"/git-crypt-key.asc

echo "Trusting all keys"
for fpr in $(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}' | sort -u); do  echo -e "5\ny\n" |  gpg --command-fd 0 --expert --edit-key $fpr trust; done

echo "Kill GPG agent and allow preset pass"
gpgconf --kill gpg-agent

gpg-agent --daemon --allow-preset-passphrase --max-cache-ttl 3153600000

echo "Try a dummy export of key to cache pass"
gpg --pinentry-mode=loopback --passphrase  $GPG_PASSPHRASE -a --export-secret-keys $GPG_KEY_ID > dummy.asc

HOMEBREW_NO_AUTO_UPDATE=1 brew install git-crypt

git-crypt unlock

rm "$HOME"/dummy.asc

