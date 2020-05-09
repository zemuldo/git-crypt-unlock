# Git-Crypt Unlock

GitHub action for unlocking files encrypted using Git-Crypt on your repository.

## Version 3.0

Version 3.0 has the following important changes.

- Will not use docker.
- Curretnly only supports Ubuntu and OSX runtimes.

If your actions are running on windows or you are using a custom runtime that is not supported you can do two things

- Use version [v2.0](https://github.com/marketplace/actions/git-crypt-unlock?version=v2.0).
- Create an issue [here](https://github.com/zemuldo/git-crypt-unlock/issues) for me to include the runtimme.

## Usage

To use this action, you need a GPG key, its grip and passphrase on the secrets section of your repository.

- `GPG_KEY_GRIP` = `The sub key-grip`
- `GPG_PRIVATE_KEY` = `Base64 encoded version of the private key`
- `GPG_KEY_PASS` = `Key passphrase`

[Here is how to get the values of the required secrets](SETUP_KEYS.md)

## Example

```yml
name: Test with Git-Crypt Unlocked
on:
  push:
      branches:
          - master
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Git-Crypt Unlock
      uses: zemuldo/git-crypt-unlock@v3.0-alpha-1
      env:
        GPG_PRIVATE_KEY: ${{ secrets.GPG_PRIVATE_KEY }}
        GPG_KEY_GRIP: ${{ secrets.GPG_KEY_GRIP }}
        GPG_KEY_PASS: ${{ secrets.GPG_KEY_PASS }}
    # Any actions below here will have files have been decrypted.
    # And 🚀🚀🚀
```
