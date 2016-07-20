# vagrant-ubuntu16.4-LEMP-provision-script
Vagrantfile and bash script to provision Ubuntu 16.4 with the LEMP stack.

Usage
=====

1. Make sure [Vagrant](https://www.vagrantup.com/) is installed and running properly.
1. Clone the repository in the place where you will initialize your Vagrant box.
1. Delete the .git directory (you'll want your own repo for version conrolling your code)
1. Modify the domain name to change it to what you want to use in the Vagrantfile
1. Modify the common.sh file:
    1. Add the domain name you are using (it must match the domain name in the Vagrantfile)
    1. Put in any database credentials you will be using
    1. Comment out any sections you won't be using (Composer for example)
1. Run 'vagrant up' from a terminal window
