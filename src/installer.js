const {exec} = require('@actions/exec')
const path = require('path')

module.exports = async function (platform) {
    if(platform == "darwin"){
        console.log("Setting up on OS X \n")
        await exec(path.join(__dirname, 'darwin.sh'))
    }

    else if(platform == "linux") {
        console.log("Setting up on Linux")
        await exec(path.join(__dirname, 'linux.sh'))
    }

}