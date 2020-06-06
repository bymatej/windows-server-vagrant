# windows-server-vagrant
Based on this box: https://app.vagrantup.com/gusztavvargadr/boxes/windows-server
Windows server 2019 box for Vagrant (with some ports open from guest to host). This may be very insecure, as I specified the ports I personally needed. Change the port forwarding to your liking. I use it on my Linux server to spin it up on demand and run Windows game servers on it.

# Prerequisites
## Info
To install this box you need vagrant and virtualbox installed on your machine. Also, a disksize plugin from vagrant is required.

After that, a simple `vagrant up` command is sufficient to get it up and running. You can see GUI only if you connect through RDP.

**Note: ** If you have a "GUI-less" server, like me, make sure you install ALSA (alsa utilities, actually) and add your username (used for `vagrant up` command) and add it to the `audio` group. You don't need this if you have, for example, an Ubuntu Desktop installation.

`sudo apt update`

`sudo apt install alsa-utils`

`sudo usermod -aG audio your_username`

You also might want to unmute your devices using `alsamixer` command.

More info on unmuting: http://howto.blbosti.com/2010/03/ubuntu-server-install-alsa-sound-and-moc-music-on-console/

More info on adding to group: https://askubuntu.com/a/27658

More info about my Ubuntu server: https://bymatej.com/how-to-install-and-set-up-ubuntu-server-18-04-for-domestic-usage/


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

# VM Tehcnical details
Operating system is **Windows Server 2019 v1809.0.2003**

The machine has 2 GB of RAM and 2 CPUs allocated. Hard disk drive size is 130 GB, but it is dynamically allocated.

Network:
- The forwarded_port network type was used
- Some TCP and UDP ports are forwarded from guest to host
- Ths may be very insecure (I used the ports that I personally needed)
- See the Vagrantfile for details

Users and RDP:
- RDP is activated
- Username: `vagrant`
- Password: `vagrant`

Sound:
- enabled, but not working until dummy drivers are installed

At first I disabled the sound. Then I realized that some software (mainly games) won't start properly without sound card drivers.
Then I tried installing a sound card, but I kept failing. Windows was picking some unknown media device, but I could not find drivers for it.
Then I stumbled upon a dummy audio device that tricks Windows into thinking it has a proper sound card. All software started properly with that driver.
See _Steps after vagrant up_ for more details on how to install those drivers.

Gui:
- disabled

# Running and stopping the machines

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

# Steps after vagrant up
Some software, mainly games, requires a proper sound card drivers. They won't start without them.
I tried configuring a proper audio device in Vagrantfile, but I failed. So I provided a dummy drivers that can be installed after VM is up and running.
In provisioning step I included a zip file that has dummy drivers.
If you want to install a dummy sound card follow these steps.
To learn more about dummy driver used, check it out here: https://www.vb-audio.com/Cable/

## Installation of dummy drivers
Connect to your VM via RDP. 

**Note: ** Connect to the remote PC over RDP and **check the audio option to play the sound on the remote machine**! 
If you don't have proper soundcard, you can install a dummy. 
Below is the location of installation for the dummy driver. 
If you need sound, then do this on all RDP cliets you use. 
Without the soundcard (dummy, or real one), your PC will complain about not having a sound driver and sound card, and your some of your sofware may not run.

Installation files are in `C:\Users\vagrant\Desktop\vbcable.zip`.

Extract it and run `VBCABLE_Setup_x64.exe`. Click on `Install driver` and click again on `Install` in the prompt box.

Then, reboot your VM. That's it.

You don't need this in most cases. I needed it at firs on my headless server with no audio configured.


## Install your software
Before installing anything, install Team Viewer. Connect via RDP, open Internet Explorer (yes, that old thing), and download team viewer. Acually, any VNC tool will suffice. I prefer Team Viewer.

This is needed because if you want to run a dedicated game server on this machine, you cannot do this via RDP. RDP cannot run directx. There are some limitations due to bandwith, or something like that. I don't know exactly, all I know it is not possible. 

So, you either need to have a GUI for your VM (which I don't), or you need a VNC (like Team Viewer).


Now you can install your software, games, etc.

I tipically install an Edge browser, and download my games from my private repo.

If needed (for older games/software), install Direct Play by going into Control Panel -> Install Windows Features On or Off (the server manager) -> Add roles and features -> Click Next until you get to the Features tab -> tick Direct Play and then Next and Finish. Same goes if you need .NET 3.5 or older.



# CHEERS!
