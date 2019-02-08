/**
######################
## Npm Repositories ##
######################
Create all Npm repositories for Nexus 3 configuration.
*/

// -- Main
repository.createNpmHosted(
  "npm-releases-hosted",
  "npm",
  false,
  org.sonatype.nexus.repository.storage.WritePolicy.ALLOW_ONCE
)

repository.createNpmProxy(
  "npmjs-org-proxy",
  "https://registry.npmjs.org",
  "npm",
  false
)

repository.createNpmGroup(
  "npm-public-group",
  ["npm-releases-hosted","npmjs-org-proxy"],
  "npm"
)

log.info('Script npmRepositories completed successfully')
