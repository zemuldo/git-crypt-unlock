const core = require('@actions/core')
const {exec} = require('@actions/exec')
const installer = require('./installer')
const path = require('path')
const semver = require('semver')
const https = require('https')

main().catch(err => {
  core.setFailed(err.message)
})

async function main() {
    if(process.platform == "darwin"){
        console.log("Setting up on OS X \n")
        await exec(path.join(__dirname, 'darwin.sh'))
    }

    else if(process.platform == "linux") {
        console.log("Setting up on Linux")
        await exec(path.join(__dirname, 'linux.sh'))
    }
}
