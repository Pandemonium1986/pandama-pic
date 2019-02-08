/**
########################
## Maven Repositories ##
########################
Create all Maven repositories for Nexus 3 configuration.
*/

// -- Main
repository.createMavenHosted(
  "maven-releases-hosted",
  "maven",
  false,
  org.sonatype.nexus.repository.maven.VersionPolicy.RELEASE,
  org.sonatype.nexus.repository.storage.WritePolicy.ALLOW_ONCE,
  org.sonatype.nexus.repository.maven.LayoutPolicy.STRICT
)

repository.createMavenHosted(
  "maven-snapshots-hosted",
  "maven",
  false,
  org.sonatype.nexus.repository.maven.VersionPolicy.SNAPSHOT,
  org.sonatype.nexus.repository.storage.WritePolicy.ALLOW,
  org.sonatype.nexus.repository.maven.LayoutPolicy.STRICT
)

repository.createMavenProxy(
  "maven-central-proxy",
  "https://repo1.maven.org/maven2/",
  "maven",
  false,
  org.sonatype.nexus.repository.maven.VersionPolicy.RELEASE,
  org.sonatype.nexus.repository.maven.LayoutPolicy.PERMISSIVE
)

repository.createMavenGroup(
  "maven-public-group",
  ["maven-releases-hosted","maven-snapshots-hosted","maven-central-proxy"],
  "maven"
)

log.info('Script mavenRepositories completed successfully')
