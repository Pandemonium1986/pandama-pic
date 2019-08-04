#!/usr/bin/env bash
###############################################
### Pandama-pic : Vagrant Shell provisioner ###
###############################################

#-- Environment Variables
VAGRANT_USER="pandemonium"

#-- Execute docker-compose
su - $VAGRANT_USER -c 'cd /vagrant && docker-compose up -d'
