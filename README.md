# Symfony 1 Askeet
Vagrant set up to be used with the Symfony 1 Askeet tutorial.

#Vagrant

## Prerequisites: Install Virtual Box and Vagrant

   - [Virtual Box](https://www.virtualbox.org/wiki/Downloads). Tested with 4.3.18
   - [Vagrant](https://www.vagrantup.com/downloads.html). Tested with 1.6.5

## Setup

1.	Add this entry to your hosts file (sudo vi /etc/hosts;): 127.0.0.1	askeet.local  

1.	Clone this git repo to your local computer

		$ git clone git@github.com:SmellyFish/symfony1-askeet.git pardot-askeet

2.	`cd` into the cloned repo directory

		$ cd pardot-askeet

3.	Bring the Vagrant box up

		$ vagrant up --provider virtualbox

4. Log in to the guest machine

		$ vagrant ssh

5. Navigate to the root of the askeet project

		$ cd /var/www/askeet
		
6. Begin the [askeet tutorial](http://symfony.com/legacy/doc/askeet/1_0/en/1) starting with initializing the Symfony project

## Notes
* The project is accessible by browser at http://askeet.local:8080/
* The box comes with Symfony 1.0.22 pre-installed.
* Host machine - the actual computer you're using. This machine is used to run Git commands, Vagrant commands, boot up the guest machine, etc.
* Guest machine - the virtual server spun up by the host machine via Vagrant. To SSH into this box, run `$ vagrant ssh` from the `pardot-askeet` directory on the host machine.
* Root password is `root`
* MySQL credentials are `root`, `root`

## Windows Perils
Have no idea if this works on Windows

# Features
## Puppet
We use [Puppet for provisioning](http://docs.vagrantup.com/v2/provisioning/puppet_apply.html); here's our main [manifest file](https://github.com/SmellyFish/symfony1-askeet/blob/master/puppet/manifests/site.pp).

## Vagrant
Vagrantfile describes the type of machine required for the project and is located [here](https://github.com/SmellyFish/symfony1-askeet/blob/master/Vagrantfile).
