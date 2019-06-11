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
    d.pull_images "portainer/portainer:latest"
    d.pull_images "sonarqube:latest"
    d.pull_images "sonatype/nexus3:latest"
  end

  # Provisioning configuration
  config.vm.provision "ansible-pandama-pic", type: "ansible", run: "once" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "ansible-provisioner/ansible.cfg"
    ansible.playbook = "ansible-provisioner/pandama-pic.yml"
  end

  config.vm.hostname = "pandama-pic"
  config.vm.post_up_message = "Starting pandama-pic"
  config.vm.define "pandama-pic"
end
