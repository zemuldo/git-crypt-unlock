#!/bin/sh

# Put GCP service account key from base64 to json on a file.
sh -c "ls"
sh -c "git-crypt unlock"
sh -c "gpg --batch --import git-crypt-key.asc"
sh -c "ls"