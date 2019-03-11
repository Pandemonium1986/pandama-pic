# Pandama-pic

![](https://img.shields.io/github/release/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/repo-size/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/release-date/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/license/Pandemonium1986/pandama-pic.svg)

Generate a software factory using vagrant and docker.  

## Getting Started

This project start a virtualbox vm from my pandama base box [pandemonium/pandama](https://app.vagrantup.com/pandemonium/boxes/pandama).  
He gives a software factory, provide by docker with this tools :

-   Nexus 3. (Engage)
-   Jenkins 2. (Soon)
-   Sonarqube 7. (Soon)
-   Gitlab 11.7. (Soon)

### Prerequisites

-   [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.
-   [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.

You can read official documentation for installation instruction and read my cheatsheet.  

-   [VirtualBox cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Vagrant.md).  
-   [Vagrant cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/VirtualBox.md).  
-   [Docker Compose cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Docker-Compose.md).  

If you are on windows I strongly recommended you to read those links if you want to used the Wsl (Debian in my case). Otherwise use mintty or cmder for vagrant command execution.

-   [Wsl cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Wsl.md).  
-   [Manage and configure Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings)  
-   [Chmod/Chown WSL Improvements](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
-   [Vagrant and Wsl](https://www.vagrantup.com/docs/other/wsl.html)

### Installing

Simply initialize and up the box.

```sh
mkdir -p ~/git/Pandemonium1986/pandama-pic
cd  ~/git/Pandemonium1986/pandama-pic
git clone https://github.com/Pandemonium1986/pandama-pic
vagrant up
```

If you want to access to the vm after 'up' use

```sh
vagrant ssh
```

### Important note

"pandama-pic" is provisioning with the vagrant docker provisioner.  
We can downloads images use by docker-compose.yml at the beginning on the vagrant up command.  
He result in the downloading of 1Go of docker images. So be warn if your are on limited network.

## Running the factory

The vagrant box is self contained. To run the factory :

```sh
cd /vagrant
docker-compose --project-name "pandama-pic" up -d
```

If you don't want to use "--project-name" in all commands, export COMPOSE_PROJECT_NAME.  
Or leave them empty. The default project name witch is the current directory name.

## Authors

-   **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
