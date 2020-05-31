# windows-server-vagrant
Based on this box: https://app.vagrantup.com/gusztavvargadr/boxes/windows-server
Windows server 2019 box for Vagrant (with all ports open from guest to host). This may be very insecure. I use it on my Linux server to spin it up on demand and run Windows game servers on it.

# Prerequisites
## Info
To install this box you need vagrant and virtualbox installed on your machine. Also, a disksize plugin from vagrant is required.

After that, a simple `vagrant up` command is sufficient to get it up and running. You can see GUI only if you connect through RDP.

## Install Vagrant and Virtual Box
### Windows (and other platforms)
Go to https://www.vagrantup.com/downloads.html and download Vagrant for your platform. Follow the installation instructions.
Go to https://www.virtualbox.org/wiki/Downloads and download Virtual Box for your platform. Follow the installation instructions.

After all is installed, run this in cmd or terminal:
- `vagrant plugin install vagrant-disksize`
- `vagrant plugin install vagrant-vbguest`

### MacOS
If you hava a MacOS and Brew installed, you can run the following three commands to install Vagrant and VirtualBox:
- `brew cask install vagrant`
- `brew cask install virtualbox`
- `brew cask install vagrant-manager`
- `vagrant plugin install vagrant-disksize`
- `vagrant plugin install vagrant-vbguest`

### Linux (Debian)
For Ubuntu (Debian):
- `cd ~`
- `mkdir vagrant-installation`
- `cd vagrant-installation`
- `sudo apt update && sudo apt -y upgrade`
- `sudo apt -y install virtualbox`
- `curl -o ~/vagrant-installation/vagrant.deb https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb`
- `sudo apt install ~/vagrant-installation/vagrant.deb`
- `vagrant --version`
- `rm -rf ~/vagrant-installation/`
- `vagrant plugin install vagrant-disksize`
- `vagrant plugin install vagrant-vbguest`

# Running and stopping the machines
## Tehcnical details
Operating system is **Windows Server 2019 v1809.0.2003**

The machine has 2 GB of RAM and 2 CPUs allocated. Hard disk drive size is 40 GB, but it is dynamically allocated.

Network:
- The forwarded_port network type was used
- All TCP and UDP ports are forwarded from guest to host
- Ths may be very insecure.

Users and RDP:
- RDP is activated
- Username: `vagrant`
- Password: `vagrant`

Sound:
- disabled

Gui:
- disabled

## Run commands
To setup and run the Guest machines run this command:
`vagrant up`

## Stop commands
To shut down all the machines gracefully, simply run:
`vagrant halt`

You can specify the name or id of the machine to shut only one particular machine.
`vagrant halt [name|id]`

To forcefully power off the machine add the `-f` or `--force` argument to the halt command:
`vagrant halt --force`

## Destroy commands
To destroy the machines use:
`vagrant destroy`
