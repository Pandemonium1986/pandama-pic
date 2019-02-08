/**
######################
## Raw Repositories ##
######################
Create all Raw repositories for Nexus 3 configuration.
*/

// -- Main
repository.createRawHosted(
  "raw-releases-hosted",
  "raw",
  false,
  org.sonatype.nexus.repository.storage.WritePolicy.ALLOW
)

repository.createRawGroup(
  "raw-public-group",
  ["raw-releases-hosted"],
  "raw"
)
log.info('Script rawRepositories completed successfully')
