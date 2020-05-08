#!/bin/sh

echo "Unlocking files"
git-crypt unlock

rm "$HOME"/git-crypt-key.asc
