#!/bin/bash -eux
########################################
### Sonarqube : Configuration script ###
########################################
#-- Description
# Quick N' Dirty script for configure Sonarqube docker instance.

# Don't proceed to anything if SONARQUBE_ADMIN_PASSWORD is unset or empty
if [ -z "${SONARQUBE_ADMIN_PASSWORD+x}" ] || [ -z "$SONARQUBE_ADMIN_PASSWORD" ]
then
  echo -e "  SONARQUBE_ADMIN_PASSWORD is unset or empty
  Please provided SONARQUBE_ADMIN_PASSWORD via :
  export SONARQUBE_ADMIN_PASSWORD=<MY_AWESOME_PASSWORD>
  "
  exit 1
fi

#-- HTTPie options
export HTTPIE_OPTIONS=""
HTTPIE_OPTIONS="--session=/tmp/sonar.json --ignore-stdin --form --auth admin:$SONARQUBE_ADMIN_PASSWORD"

# # Fix Path on debian 9
# export PATH="$HOME/.local/bin":$PATH
#==============================================================================#

##########
## Main ##
##########
#-- Sonarqube configuration
# http $HTTPIE_OPTIONS POST sonar.docker.local/api/authentication/login

# Groups
http $HTTPIE_OPTIONS POST sonar.docker.local/api/user_groups/create \
  name="dev" description="My awesome dev group"
http $HTTPIE_OPTIONS POST sonar.docker.local/api/user_groups/create \
  name="ops" description="My awesome ops group"

# Users
http $HTTPIE_OPTIONS POST sonar.docker.local/api/users/create \
  login="alice" local="true" name="Alice Liddell" password="password1*"
http $HTTPIE_OPTIONS POST sonar.docker.local/api/users/create \
  login="bob" local="true" name="Bob Morane" password="password1*"
http $HTTPIE_OPTIONS POST sonar.docker.local/api/users/create \
  login="charlie" local="true" name="Charlie Hebdo" password="password1*"

# Memberships
http $HTTPIE_OPTIONS POST sonar.docker.local/api/user_groups/add_user \
  login="alice" name="dev"
http $HTTPIE_OPTIONS POST sonar.docker.local/api/user_groups/add_user \
  login="bob" name="ops"
http $HTTPIE_OPTIONS POST sonar.docker.local/api/user_groups/add_user \
  login="charlie" name="dev"

# Permission
http $HTTPIE_OPTIONS POST sonar.docker.local/api/permissions/remove_group \
  groupName="Anyone" permission="provisioning"
