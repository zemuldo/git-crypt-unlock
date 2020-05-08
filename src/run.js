const core = require('@actions/core')
const run = require("./run/main")
const setup = require("./setup/main")

main().catch(err => {
  core.setFailed(err.message)
})

async function main() {
    try {

        if(process.env.GITHUB_REPOSITORY == "zemuldo/git-crypt-unlock"){
            console.log("Setting up for local action \n")
            await setup();
        }
        await run()
    } catch(error){
        console.error(error)
        process.exit(1)
    }
}
