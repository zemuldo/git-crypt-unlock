const core = require('@actions/core')
const {exec} = require('@actions/exec')
const path = require('path')

main().catch(err => {
  core.setFailed(err.message)
})

async function main() {
    try {
        if(process.platform == "darwin"){
            console.log("Setting up for local action \n")
            await exec.exec('node', ['build.js']);
        }
    
        else if(process.platform == "linux") {
            console.log("Setting up on Linux")
            await exec(path.join(__dirname, 'run/linux.sh'))
        }
        else {
            console.error("This version only supports Linux and OSX, Use v1.0 for any other platform")
        }
    } catch(error){
        console.error(error)
        process.exit(1)
    }
}
