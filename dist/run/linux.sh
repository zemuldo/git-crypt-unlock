#!/bin/sh

if [ -n "$GPG_PRIVATE_KEY" ]
 then
  echo "ERROR: This action can not run without Base 64 encoded GPG key in Variable GPG_PRIVATE_KEY"
  exit 1
else
  echo "Setting up GnbuPG"
fi

GPG_KEY_FILE_NAME="$HOME"/git-crypt-key.asc

echo "$GPG_PRIVATE_KEY" | base64 -d > GPG_KEY_FILE_NAME

gpg --batch --import GPG_KEY_FILE_NAME

if [ -n "$GPG_KEY_PASS" ] && [ -n "$GPG_KEY_GRIP" ]
 then
  gpgconf --kill gpg-agent

  gpg-agent --daemon --allow-preset-passphrase --max-cache-ttl 3153600000

  /usr/lib/gnupg2/gpg-preset-passphrase --preset --passphrase $GPG_KEY_PASS "$GPG_KEY_GRIP"
else
  echo echo -e "\033[33mGPG Key Grip and Passphrase not provided, Skipping and will run without\033[0m"
fi

echo "Intalling GitCrypt"
sudo apt-get install git-crypt