# Pandama-pic

![](https://img.shields.io/github/release/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/repo-size/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/release-date/Pandemonium1986/pandama-pic.svg)
![](https://img.shields.io/github/license/Pandemonium1986/pandama-pic.svg)

Generate a software factory using vagrant and docker.  

## Getting Started

This project start a virtualbox vm from my pandama base box [pandemonium/pandama](https://app.vagrantup.com/pandemonium/boxes/pandama).  
He gives a software factory, provide by docker with this tools :

**Portainer (Engage)**  

> Portainer is a lightweight management toolset that allows you
> to easily build, manage and maintain Docker environments.

Use to manage easily running containers. Currently the software factory is managed and deployed by docker compose and will be managed and deployed into swarm in a next version.  

**Gitlab 11. (Engage)**  

> GitLab is a single application for the entire software development lifecycle. From project planning and source code management to CI/CD, monitoring, and security

Use as the source management code tool.  

**Jenkins 2. (Engage)**  

> Jenkins is an open source automation server with an unparalleled plugin ecosystem to support practically every tool as part of your delivery pipelines. Whether your goal is continuous integration, continuous delivery or something else entirely, Jenkins can help automate it.

Use as the continuous integration tool.  

**Nexus 3. (Engage)**  

> Nexus Repository Manager lets you proxy remote repositories and host internal artifacts. Check out our quick start guides and deep-dive technical articles to help you get the most value out of Nexus Repository.

Use as the components archives tool.  

**Sonarqube 7. (Engage)**  

> SonarQube provides the capability to not only show health of an application but also to highlight issues newly introduced. With a Quality Gate in place, you can fix the leak and therefore improve code quality systematically.

Use to measure quality of projects based on SQALE method.  

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
docker-compose up -d
```

## Navigate into the tools

|                   Tools                  |    Fqdn/Ip    |    Ports    |
| :--------------------------------------: | :-----------: | :---------: |
|  [Portainer](http://192.168.66.11:9000)  | 192.168.66.11 |     9000    |
|     [Gitlab 11](http://192.168.66.11)    | 192.168.66.11 | 80, 443, 23 |
|  [Jenkins 2](http://192.168.66.11:8080)  | 192.168.66.11 |     8080    |
|   [Nexus 3](http://192.168.66.11:8081)   | 192.168.66.11 |     8081    |
| [Sonarqube 7](http://192.168.66.11:9001) | 192.168.66.11 |     9001    |

## Authors

-   **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details

## Source
### Documentations
[Portainer](https://portainer.readthedocs.io/en/stable/)  
[Gitlab](https://docs.gitlab.com/ce/README.html)  
[Jenkins](https://jenkins.io/doc/)  
[Nexus](https://help.sonatype.com/repomanager3)  
[SonarQube](https://docs.sonarqube.org/latest/)  

### Docker images
[Docker Portainer](https://hub.docker.com/r/portainer/portainer)  
[Docker Gitlab](https://hub.docker.com/r/gitlab/gitlab-ce/)  
[Docker Jenkins](https://hub.docker.com/r/jenkins/jenkins)  
[Docker Nexus](https://hub.docker.com/r/sonatype/nexus3)  
[Docker SonarQube](https://hub.docker.com/_/sonarqube)  

### Installation
[Installation Portainer](https://portainer.readthedocs.io/en/stable/deployment.html#deploy-portainer-via-docker-compose)  
[Installation Gitlab](https://docs.gitlab.com/omnibus/docker/)  
[Installation Jenkins](https://jenkins.io/doc/book/installing/)  
[Installation Nexus](https://help.sonatype.com/repomanager3/installation/installation-methods#InstallationMethods-InstallingwithDocker)  
[Installation SonarQube](https://docs.sonarqube.org/latest/setup/install-server/)  
