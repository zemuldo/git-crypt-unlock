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
  checkPlatform()
  await installer(process.platform)
}
