#!/bin/sh

# Check if GnuPG is installed else install it
if ! [ -x "$(command -v gpg)" ]
 then
  sudo apt-get install gnupg
fi

if [ -n "$GPG_PRIVATE_KEY" ]
 then
  echo "Setting up GnbuPG"
else
  echo "ERROR: This action can not run without Base 64 encoded GPG key in Variable GPG_PRIVATE_KEY"
  exit 1
fi

echo "$GPG_PRIVATE_KEY" | base64 -d > "$HOME"/git-crypt-key.asc

gpg --batch --import "$HOME"/git-crypt-key.asc

rm "$HOME"/git-crypt-key.asc

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