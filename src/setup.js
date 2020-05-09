const core = require('@actions/core')
const setup = require("./setup/main")

if(!process.platform in ["linux", "darwin"]){
  core.setFailed(`This action only supports mac osx or linux runtimes ${err}`);
  process.exit(1)
}

setup().catch(err => {
  core.setFailed(`Action failed with error ${err}`)
})
