/**
################
## blobStores ##
################
Create all blobstores for Nexus 3 configuration.
*/

// -- Variables
def blobStoresMap = ["apt", "composer", "docker", "helm", "git-lfs", "maven", "npm", "nuget", "raw", "yum"]

// -- Main
blobStoresMap.each {
  blobStore.createFileBlobStore("$it", "$it")
  log.info("Create blobstore named : $it into path : $it")
}

log.info('Script blobStores completed successfully')
