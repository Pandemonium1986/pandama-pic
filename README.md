<!-- markdownlint-disable MD036 -->
# Pandama-pic

![license](https://img.shields.io/github/release/Pandemonium1986/pandama-pic.svg)
![repo-size](https://img.shields.io/github/repo-size/Pandemonium1986/pandama-pic.svg)
![release-date](https://img.shields.io/github/release-date/Pandemonium1986/pandama-pic.svg)
![license](https://img.shields.io/github/license/Pandemonium1986/pandama-pic.svg)

Generate a software factory using vagrant and docker.  

## Getting Started

This project start a virtualbox vm from my pandama base box [pandemonium/pandama](https://app.vagrantup.com/pandemonium/boxes/pandama).  
He gives a software factory, provide by docker with this tools :

**Traefik (Done)**  

> Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need.

Use as HTTP reverse proxy. To easily connect to the service expose by the running containers.  

**Portainer (Done)**  

> Portainer is a lightweight management toolset that allows you to easily build, manage and maintain Docker environments.

Use to manage easily running containers. Currently the software factory is managed and deployed by docker compose and will be managed and deployed into swarm in a next version.  

**Gitlab 12. (Done)**  

> GitLab is a single application for the entire software development lifecycle. From project planning and source code management to CI/CD, monitoring, and security

Use as the source management code tool.  

**Jenkins 2. (Done)**  

> Jenkins is an open source automation server with an unparalleled plugin ecosystem to support practically every tool as part of your delivery pipelines. Whether your goal is continuous integration, continuous delivery or something else entirely, Jenkins can help automate it.

Use as the continuous integration tool.  

**Nexus 3. (Done)**  

> Nexus Repository Manager lets you proxy remote repositories and host internal artifacts. Check out our quick start guides and deep-dive technical articles to help you get the most value out of Nexus Repository.

Use as the components archives tool.  

**Sonarqube 7. (Done)**  

> SonarQube provides the capability to not only show health of an application but also to highlight issues newly introduced. With a Quality Gate in place, you can fix the leak and therefore improve code quality systematically.

Use to measure quality of projects based on SQALE method.  

### Prerequisites

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.
- [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.

You can read official documentation for installation instruction and read my cheatsheet.  

- [VirtualBox cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/VirtualBox.md).  
- [Vagrant cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Vagrant.md).  
- [Docker Compose cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Docker-Compose.md).  

If you are on windows I strongly recommended you to read those links if you want to used the Wsl (Debian in my case). Otherwise use mintty or cmder for vagrant command execution. Better solution is to simply used a linux environment.

- [Wsl cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Wsl.md).  
- [Manage and configure Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings)  
- [Chmod/Chown WSL Improvements](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
- [Vagrant and Wsl](https://www.vagrantup.com/docs/other/wsl.html)

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
He result in the downloading of more than 1Go of docker images. So be warned if you are on limited network.

## Running the factory

The factory is automatically started at vagrant up with a shell provisioner.  
To manually run the factory :

```sh
cd /vagrant
docker-compose up -d
```

## Provisioning and configuring the tools

All tools are configured with ansible. With native idempotent modules or custom scripts.  

To configure a particular tool you have to invoke vagrant provision command.  
Don't forget to export or specify the tool's admin password

```sh
{TOOL}_ADMIN_PASSWORD="MySecretPassword" vagrant provision --provision-with ansible-{tool}
```

Exhaustive commands are :

```sh
GITLAB_API_TOKEN="MySecretToken" vagrant provision --provision-with ansible-gitlab
NEXUS3_ADMIN_PASSWORD="MySecretPassword" vagrant provision --provision-with ansible-nexus
PORTAINER_ADMIN_PASSWORD="MySecretPassword" vagrant provision --provision-with ansible-portainer
SONARQUBE_ADMIN_PASSWORD="MySecretPassword" vagrant provision --provision-with ansible-sonarqube
```

### Portainer

He configure portainer with :

- Rename primary endpoint.
- Add Alice, Bob, Charlie users and Dev and Ops teams.
- Add Alice and Charlie to Dev team and Bob to Ops team.
- Give Dev and Ops team members access to the primary endpoint.

### Nexus 3

He configure nexus 3 with :

- Create blobstores, maven and npm repositories.
- Add Alice, Bob, Charlie, Jeenkins users and Dev and Ops roles.
- Add Alice and Charlie to Dev role and Bob and Jenkins to Ops role.
- Disable anonymous access.

### Gitlab 12

He configure gitlab 12 with :

- Add Alice, Bob, Charlie users and Dev and Ops groups.
- Add Alice and Charlie to Dev team and Bob to Ops groups.

### Jenkins 2

He configure jenkins 2 with :

- Add Alice, Bob, Charlie users.
- Installed all recommended plugins.
- Used JCasC plugin to configure jenkins.

### SonarQube 7

He configure SonarQube 7 with :

- Add Alice, Bob, Charlie users and Dev and Ops groups.
- Add Alice and Charlie to Dev team and Bob to Ops groups.
- Remove provisioning to the anyone group

## Navigate into the tools

You need to add this line in your host /etc/hosts :

```txt
192.168.66.11   traefik.docker.local portainer.docker.local nexus.docker.local gitlab.docker.local sonar.docker.local jenkins.docker.local
```

|                    Tools                   |                Fqdn / Ip               |    Ports    |
| :----------------------------------------: | :------------------------------------: | :---------: |
|   [Gitlab 12](http://gitlab.docker.local)  |   gitlab.docker.local / 192.168.66.11  | 80, 443, 23 |
|  [Jenkins 2](http://jenkins.docker.local)  |  jenkins.docker.local / 192.168.66.11  |     8080    |
|    [Nexus 3](http://nexus.docker.local)    |   nexus.docker.local / 192.168.66.11   |     8081    |
| [Portainer](http://portainer.docker.local) | portainer.docker.local / 192.168.66.11 |     9000    |
|   [Traefik](http://traefik.docker.local)   |  traefik.docker.local / 192.168.66.11  |     8080    |
|  [Sonarqube 7](http://sonar.docker.local)  |  19sonar.docker.local / 192.168.66.11  |     9000    |

## Authors

- **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details

## Source

### Documentations

[Gitlab](https://docs.gitlab.com/ce/README.html)  
[Jenkins](https://jenkins.io/doc/)  
[Nexus](https://help.sonatype.com/repomanager3)  
[Portainer](https://portainer.readthedocs.io/en/stable/)  
[SonarQube](https://docs.sonarqube.org/latest/)  

### Docker images

[Docker Gitlab](https://hub.docker.com/r/gitlab/gitlab-ce/)  
[Docker Jenkins](https://hub.docker.com/r/jenkins/jenkins)  
[Docker Nexus](https://hub.docker.com/r/sonatype/nexus3)  
[Docker Portainer](https://hub.docker.com/r/portainer/portainer)  
[Docker SonarQube](https://hub.docker.com/_/sonarqube)  

### Installation

[Installation Gitlab](https://docs.gitlab.com/omnibus/docker/)  
[Installation Jenkins](https://jenkins.io/doc/book/installing/)  
[Installation Nexus](https://help.sonatype.com/repomanager3/installation/installation-methods#InstallationMethods-InstallingwithDocker)  
[Installation Portainer](https://portainer.readthedocs.io/en/stable/deployment.html#deploy-portainer-via-docker-compose)  
[Installation SonarQube](https://docs.sonarqube.org/latest/setup/install-server/)  
