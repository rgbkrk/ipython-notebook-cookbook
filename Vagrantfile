# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Name the box for Vagrant
  config.vm.define :IPyBox

  config.vm.provider "virtualbox" do |ipybox|
     ipybox.name = "IPyBox"
  end

  config.vm.hostname = "ipynb-cookbook-berkshelf"

  config.omnibus.chef_version = "11.4.0"

  # Default to using Ubuntu, unless specified otherwise
  case ENV['VMBOX']
  when 'centos64'
    config.vm.box = "CentOS-6.4-x86_64-minimal"
    config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"
  else
    config.vm.box = "opscode-ubuntu-12.04"
    config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"
  end

  # Forward the default 8888 port for the IPython notebook,
  # keeping the port different on the host box in case the user
  # is running the IPython notebook locally
  config.vm.network :forwarded_port, guest: 8888, host: 9999

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }

    chef.run_list = [
        "recipe[apt]",
        "recipe[yum]",
        "recipe[ipynb-cookbook::default]",
        "recipe[ipynb-cookbook::virtenv_launch]"
    ]
  end
end
