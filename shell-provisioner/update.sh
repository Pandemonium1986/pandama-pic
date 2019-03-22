#!/usr/bin/env bash
###############################################
### Pandama-pic : Vagrant Shell provisioner ###
###############################################

#-- Environment Variables
VAGRANT_USER="pandemonium"

########################
# Custom configuration #
########################
apt-get update && apt-get -y upgrade

if  [ -d /home/$VAGRANT_USER/.tmuxifier ]; then
	if  [ -f /usr/bin/tmux ]; then
		su - $VAGRANT_USER -c 'git -C ~/.tmuxifier pull'
		su - $VAGRANT_USER -c 'git -C ~/.oh-my-zsh pull'
	fi
fi

if  [ -d /home/$VAGRANT_USER/git/Pandemonium1986/dotfiles ]; then
	su - $VAGRANT_USER -c 'git -C ~/git/Pandemonium1986/dotfiles pull'
fi
