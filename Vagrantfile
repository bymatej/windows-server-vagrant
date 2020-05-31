Vagrant.configure("2") do |config|

  puts "****** Setting up Windows Server 2019..."
  config.vm.define "windowsserver" do |windowsserver|
    # Use Windows Server 2019 box
    windowsserver.vm.box = "gusztavvargadr/windows-server"

    # Disk disk
    config.disksize.size = '50GB'

    # Configure VirtualBox provider settings
    windowsserver.vm.provider "virtualbox" do |vb|
      # Set name
      vb.name = "Windows Server 2019 by Matej"

      # Display the VirtualBox GUI when booting the machine
      vb.gui = false

      # Customize the resources on the VM (RAM and CPUs):
      vb.memory = "2048"
      vb.cpus = 2

      # Disable sound
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end

    # Run initial configuration
    windowsserver.vm.provision :shell, path: "./provisioning/init.ps1"

    # Network setup
    # Forwarding all guest TCP and UDP to host
    for i in 1..65535
      config.vm.network :forwarded_port, guest: i, host: i, protocol: "tcp", auto_correct: true
      config.vm.network :forwarded_port, guest: i, host: i, protocol: "udp", auto_correct: true
    end
    windowsserver.vm.hostname = "Windows-Server-2019-VM"
  end
  puts "****** Set up done!"

end
