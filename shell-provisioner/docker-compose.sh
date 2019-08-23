#!/bin/bash -eu
###############################################
### Pandama-pic : Vagrant Shell provisioner ###
###############################################
#-- Description
# Vagrant shell provisioner used to start docker-compose.

#-- Environment variables
VAGRANT_USER="pandemonium"
#==============================================================================#

##########
## Main ##
##########
#-- Execute docker-compose
su - $VAGRANT_USER -c 'cd /vagrant && docker-compose up -d'
