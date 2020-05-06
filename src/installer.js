const {exec} = require('@actions/exec')
const path = require('path')

module.exports = async function (platform) {
    if(platform == "darwin"){
        console.log("Setting up on OS X")
        await installGnuPGDarwin()
        await installGitCryptDarwin()
    }

    else if(platform == "linux") {
        console.log("Setting up on Linux")
        await installGnuPGLinux()
        await installGitCryptLinux()
    }

}

/**
 * Install GnuPG.
 *
 */
async function installGnuPGLinux() {
    await exec(path.join(__dirname, 'linux/install-gpg.sh'))
}
async function installGnuPGDarwin() {
    await exec(path.join(__dirname, 'darwin/install-gpg.sh'))
}

/**
 * Install Git-Crypt.
 *
 */
async function installGitCryptLinux() {
    await exec(path.join(__dirname, 'linux/install-git-crypt.sh'))
}
async function installGitCryptDarwin() {
    await exec(path.join(__dirname, 'darwin/install-git-crypt.sh'))
}