#!/bin/bash -eu
######################################
### Nexus 3 : Configuration script ###
######################################
#-- Description
# Quick N' Dirty script for configure Nexus 3 docker instance.

# Don't proceed to anything if NEXUS3_ADMIN_PASSWORD is unset or empty
if [ -z "${NEXUS3_ADMIN_PASSWORD+x}" ] || [ -z "$NEXUS3_ADMIN_PASSWORD" ]
then
  echo -e "  NEXUS3_ADMIN_PASSWORD is unset or empty
  Please provided NEXUS3_ADMIN_PASSWORD via :
  export NEXUS3_ADMIN_PASSWORD=<MY_AWESOME_PASSWORD>
  "
  exit 1
fi

#-- Nexus 3 Variables
username=admin
host=http://nexus.docker.local
#==============================================================================#

###############
## Functions ##
###############

#-- usage
# print usage on stdout.
usage() {
	cat << EOF
Usage: $0 { command }
Configure Nexus 3 with some groovy scripts.
Commands available are
  - --help|-h : Print this usage.
  - all : Create all blostores and repositories and configure security.
  - blb : Create all blostores.
  - mvn : Create and configure maven repositories.
  - npm : Create and configure npm repositories.
  - raw : Create and configure raw repositories.
  - sec : Configure security.
EOF
}

#-- addAndRunScript
# Create or update locally invocated script to remote nexus instance and execute it remotely.
function addAndRunScript {
  name=$1
  file=$2
  # using grape config that points to local Maven repo and Central Repository , default grape config fails on some downloads although artifacts are in Central
  # change the grapeConfig file to point to your repository manager, if you are already running one in your organization
  groovy -Dgroovy.grape.report.downloads=false -Dgrape.config=grapeConfig.xml addUpdateScript.groovy -u "$username" -p "$NEXUS3_ADMIN_PASSWORD" -n "$name" -f "$file" -h "$host"
  printf "\nPublished %s as %s\n\n" "$file" "$name"
  curl -v -X POST -u "$username":"$NEXUS3_ADMIN_PASSWORD" --header "Content-Type: text/plain" "$host/service/rest/v1/script/$name/run"
  printf "\nSuccessfully executed %s script\n\n\n" "$name"
}

#===============================================================================#

##########
## Main ##
##########
if [ $# -eq 0 ]; then
	echo "Error : You must pass at least one argument" 1>&2
	usage 1>&2
	exit 2
fi

while [ $# -gt 0 ]; do
	case "${1}" in
	--help|-h)
		usage
		exit 0
		;;
	all)
		addAndRunScript blostores blobStores.groovy
		addAndRunScript mavenrepositories mavenRepositories.groovy
		addAndRunScript npmrepositories npmRepositories.groovy
		addAndRunScript rawrepositories rawRepositories.groovy
		addAndRunScript security security.groovy
		;;
	blb)
		addAndRunScript blostores blobStores.groovy
		;;
	mvn)
		addAndRunScript blostores blobStores.groovy
		addAndRunScript mavenrepositories mavenRepositories.groovy
		;;
	npm)
		addAndRunScript blostores blobStores.groovy
		addAndRunScript npmrepositories npmRepositories.groovy
		;;
	raw)
		addAndRunScript blostores blobStores.groovy
		addAndRunScript rawrepositories rawRepositories.groovy
		;;
	sec)
		addAndRunScript blostores blobStores.groovy
		addAndRunScript security security.groovy
		;;
	*)
		echo "Unknown argument : $1" 1>&2
		usage 1>&2
		exit 2
	esac
	shift
done
