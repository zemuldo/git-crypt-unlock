#!/bin/sh

if ! [ -x "$(command -v gpg)" ]
 then
  HOMEBREW_NO_AUTO_UPDATE=1 brew install gnupg
fi

if [ -n "$GPG_PRIVATE_KEY" ]
 then
  echo "Setting up GnbuPG"
else
  echo "ERROR: This action can not run without Base64 encoded GPG key in Variable GPG_PRIVATE_KEY"
  exit 1
fi

echo "$GPG_PRIVATE_KEY" | base64 -D > "$HOME"/git-crypt-key.asc

gpg --batch --import "$HOME"/git-crypt-key.asc

rm "$HOME"/git-crypt-key.asc

for fpr in $(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}' | sort -u); do  echo -e "5\ny\n" |  gpg --command-fd 0 --expert --edit-key $fpr trust; done

if [ -n "$GPG_KEY_PASS" ] && [ -n "$GPG_KEY_GRIP" ]
 then
  gpgconf --kill gpg-agent

  gpg-agent --daemon --allow-preset-passphrase --max-cache-ttl 3153600000

  $GPG_PATH/gpg-preset-passphrase -c $GPG_KEY_GRIP <<<  $GPG_KEY_PASS
else
  echo echo -e "\033[33mGPG Key Grip and Passphrase not provided, Skipping and will run without\033[0m"
fi

echo "Intalling GitCrypt"
HOMEBREW_NO_AUTO_UPDATE=1 brew install git-crypt
