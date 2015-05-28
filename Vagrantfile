# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
VAGRANT_DEFAULT_PROVIDER = "virtualbox"

# Minimum required version of Vagrant needed to run.
Vagrant.require_version ">= 1.4.3"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox"

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Give it a name so it is not another default box.
  config.vm.define "askeetbox" do |askeetbox|
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "askeet_centos_64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"

  #config.vm.boot_timeout = 400

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "10.10.10.13"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Give this server a name
  config.vm.hostname = "askeet.local"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true
  # config.ssh.private_key_path = "~/.ssh/id_rsa"
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder "askeet", "/var/www/askeet", :id => "vm", :owner => "vagrant", :group => "vagrant", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "~/.ssh", "/root/.ssh/", :id => "ssh", :owner => "vagrant", :group => "vagrant", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "puppet/hieradata", "/etc/puppet/hieradata", :id => "hiera", :owner => "vagrant", :group => "vagrant", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "puppet/files", "/etc/puppet/files", :id => "files", :owner => "vagrant", :group => "vagrant", :mount_options => ["dmode=777", "fmode=777"]
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
  # config.vm.provider "virtualbox" do |vb|
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file cc_centos_64_goldie.pp in the manifests_path directory.
  #

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = 'puppet/hiera.yaml'
    #Enable verbose mode to debug
    #puppet.options = ["--verbose", "--debug",]
  end


end
