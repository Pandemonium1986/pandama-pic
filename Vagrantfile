Vagrant.require_version ">= 2.2.3"

Vagrant.configure("2") do |config|
  config.vm.box = "pandemonium/pandama"
  config.vm.box_version = "1.1.0"
  config.vm.network "private_network", ip: "192.168.66.11"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "6144"
    vb.name = "pandama-pic"
    vb.cpus = 2
  end

  config.vm.provision "docker" do |d|
    d.pull_images "gitlab/gitlab-ce:latest"
    d.pull_images "jenkins/jenkins:lts"
    d.pull_images "portainer/portainer:1.21.0"
    d.pull_images "sonarqube:latest"
    d.pull_images "sonatype/nexus3:3.16.2"
    d.pull_images "traefik:v1.7.12"
  end

  # Provisioning the configuration
  config.vm.provision "ansible-pandama-pic", type: "ansible", run: "once" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "ansible-provisioner/ansible.cfg"
    ansible.playbook = "ansible-provisioner/pandama-pic.yml"
  end

  # Provisioning gitlab
  config.vm.provision "ansible-gitlab", type: "ansible", run: "never" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "ansible-provisioner/ansible.cfg"
    ansible.playbook = "ansible-provisioner/gitlab.yml"
    ansible.host_vars = {
      "pandama-pic" => {
        "vagrant_gitlab_api_token" => ENV["GITLAB_API_TOKEN"]
      }
    }
  end

  # Provisioning portainer
  config.vm.provision "ansible-portainer", type: "ansible", run: "never" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "ansible-provisioner/ansible.cfg"
    ansible.playbook = "ansible-provisioner/portainer.yml"
    ansible.host_vars = {
      "pandama-pic" => {
        "vagrant_portainer_admin_password" => ENV["PORTAINER_ADMIN_PASSWORD"]
      }
    }
  end

  # Provisioning nexus
  config.vm.provision "ansible-nexus", type: "ansible", run: "never" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "ansible-provisioner/ansible.cfg"
    ansible.playbook = "ansible-provisioner/nexus.yml"
    ansible.host_vars = {
      "pandama-pic" => {
        "vagrant_nexus_admin_password" => ENV["NEXUS_ADMIN_PASSWORD"]
      }
    }
  end

  config.vm.hostname = "pandama-pic"
  config.vm.post_up_message = "
########################################################################################
##                              Starting pandama-pic done                             ##
##                          Please execute vagrant provision                          ##
##                            to configure gitlab instance                            ##
## GITLAB_API_TOKEN=\"MySecretToken\" vagrant provision --provision-with ansible-gitlab ##
########################################################################################
"
  config.vm.define "pandama-pic"
end
