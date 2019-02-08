Vagrant.require_version ">= 2.2.3"

Vagrant.configure("2") do |config|
  config.vm.box = "pandemonium/pandama"
  config.vm.box_version = "1.0.1"
  config.vm.network "private_network", ip: "192.168.66.11"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.name = "pandama-pic"
    vb.cpus = 2
  end

  config.vm.hostname = "pandama-pic"
  config.vm.post_up_message = "Starting pandama-pic"
  config.vm.define "pandama-pic"
end
