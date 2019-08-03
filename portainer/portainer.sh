#!/bin/bash -eu
########################################
### Portainer : Configuration script ###
########################################
#-- Description
# Quick N' Dirty script for configure Portainer docker instance.

# Don't proceed to anything if PORTAINER_ADMIN_PASSWORD is unset or empty
if [ -z "${PORTAINER_ADMIN_PASSWORD+x}" ] || [ -z "$PORTAINER_ADMIN_PASSWORD" ]
then
  echo -e "  PORTAINER_ADMIN_PASSWORD is unset or empty
  Please provided PORTAINER_ADMIN_PASSWORD via :
  export PORTAINER_ADMIN_PASSWORD=<MY_AWESOME_PASSWORD>
  "
  exit 1
fi

#-- http options
export HTTP_OPTIONS=""
HTTP_OPTIONS="--ignore-stdin"

#-- Installing dependencies
pip install --user httpie
sudo apt install jq

# Fix Path on debian 9
export PATH="$HOME/.local/bin":$PATH

#-- Portainer configuration
export PORTAINER_TOKEN=""
PORTAINER_TOKEN=$(http $HTTP_OPTIONS POST portainer.docker.local/api/auth Username="admin" Password="$PORTAINER_ADMIN_PASSWORD" | jq -r .jwt)

# Renaming endpoint
http $HTTP_OPTIONS PUT portainer.docker.local/api/endpoints/1 \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="Docker Local Unix Socket"

# Teams
http $HTTP_OPTIONS POST portainer.docker.local/api/teams \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="dev"
http $HTTP_OPTIONS POST portainer.docker.local/api/teams \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="ops"

# Users
http $HTTP_OPTIONS POST portainer.docker.local/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="alice" Password="password1*" Role:=2
http $HTTP_OPTIONS POST portainer.docker.local/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="bob" Password="password1*" Role:=2
http $HTTP_OPTIONS POST portainer.docker.local/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="charlie" Password="password1*" Role:=2

# Memberships
http $HTTP_OPTIONS POST portainer.docker.local/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=2 TeamID:=1 Role:=1
http $HTTP_OPTIONS POST portainer.docker.local/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=3 TeamID:=2 Role:=1
http $HTTP_OPTIONS POST portainer.docker.local/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=4 TeamID:=1 Role:=2

# Endpoint Access
http $HTTP_OPTIONS PUT portainer.docker.local/api/endpoints/1 \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserAccessPolicies:='{"2":{"RoleID":1},"3":{"RoleID":2}}'
