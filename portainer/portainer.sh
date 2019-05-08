#!/bin/bash -u
###############################
### Portainer Configuration ###
###############################
: <<'COMMENT'
Quick N' Dirty script for configure portainer docker instance.
COMMENT

# Don't proceed to anything if PORTAINER_ADMIN_PASSWORD is unset or empty
if [ -z ${PORTAINER_ADMIN_PASSWORD+x} ] || [ -z "$PORTAINER_ADMIN_PASSWORD" ]
then
  echo -e "  PORTAINER_ADMIN_PASSWORD is unset or empty
  Please provided PORTAINER_ADMIN_PASSWORD via :
  export PORTAINER_ADMIN_PASSWORD=<MY_AWESOME_PASSWORD>
  "
  exit 1
fi

#-- Installing dependencies
pip install --user httpie
sudo apt install jq

# Fix Path on debian 9
export PATH="$HOME/.local/bin":$PATH

#-- Portainer configuration
export PORTAINER_TOKEN=`http POST :9000/api/auth Username="admin" Password="$PORTAINER_ADMIN_PASSWORD" | jq -r .jwt`

# Renaming endpoint
http PUT :9000/api/endpoints/1 \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="Docker Local Unix Socket"

# Teams
http POST :9000/api/teams \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="Dev"
http POST :9000/api/teams \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Name="Ops"

# Users
http POST :9000/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="alice" Password="password1*" Role:=2
http POST :9000/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="bob" Password="password1*" Role:=2
http POST :9000/api/users \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  Username="charlie" Password="password1*" Role:=2

# Memberships
http POST :9000/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=2 TeamID:=1 Role:=1
http POST :9000/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=3 TeamID:=2 Role:=1
http POST :9000/api/team_memberships \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  UserID:=4 TeamID:=1 Role:=2

# Endpoint Access
http PUT :9000/api/endpoints/1/access \
  "Authorization: Bearer $PORTAINER_TOKEN" \
  AuthorizedTeams:=[1,2]
