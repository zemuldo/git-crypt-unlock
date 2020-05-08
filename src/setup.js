const core = require('@actions/core')
const setup = require("./setup/main")

setup().catch(err => {
  core.setFailed(err.message)
})
