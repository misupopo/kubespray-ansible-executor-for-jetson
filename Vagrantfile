# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
#     vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

    config.vm.define "amaster" do |amaster|
        amaster.vm.box_download_insecure = true
        amaster.vm.box = "hashicorp/bionic64"
        amaster.vm.network "private_network", ip: "192.168.56.1"
        amaster.vm.hostname = "amaster"
        amaster.vm.provider "virtualbox" do |v|
        v.name = "amaster"
        v.memory = 2048
        v.cpus = 1
        end

        config.vm.provision "shell" do |s|
            ssh_pub_key = File.readlines("./vagrant.pub").first.strip
            s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
            SHELL
        end

        amaster.vm.network "forwarded_port", guest: 8081, host: 8081
    end

    config.vm.define "kmaster1" do |kmaster|
        kmaster.vm.box_download_insecure = true
        kmaster.vm.box = "hashicorp/bionic64"
        kmaster.vm.network "private_network", ip: "192.168.56.2"
        kmaster.vm.hostname = "kmaster1"
        kmaster.vm.provider "virtualbox" do |v|
        v.name = "kmaster1"
        v.memory = 2048
        v.cpus = 1
        end

        config.vm.provision "shell" do |s|
            ssh_pub_key = File.readlines("./vagrant.pub").first.strip
            s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
            SHELL
        end

        kmaster.vm.network "forwarded_port", guest: 8082, host: 8082
    end

#     config.vm.define "kmaster2" do |kmaster|
#         kmaster.vm.box_download_insecure = true
#         kmaster.vm.box = "hashicorp/bionic64"
#         kmaster.vm.network "private_network", ip: "192.168.56.3"
#         kmaster.vm.hostname = "kmaster2"
#         kmaster.vm.provider "virtualbox" do |v|
#             v.name = "kmaster2"
#             v.memory = 2048
#             v.cpus = 1
#         end
#
#         config.vm.provision "shell" do |s|
#             ssh_pub_key = File.readlines("./vagrant.pub").first.strip
#             s.inline = <<-SHELL
#             echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
#             echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
#             SHELL
#         end
#
#         kmaster.vm.network "forwarded_port", guest: 8083, host: 8083
#     end
#
#     config.vm.define "kmaster3" do |kmaster|
#         kmaster.vm.box_download_insecure = true
#         kmaster.vm.box = "hashicorp/bionic64"
#         kmaster.vm.network "private_network", ip: "192.168.56.4"
#         kmaster.vm.hostname = "kmaster3"
#         kmaster.vm.provider "virtualbox" do |v|
#             v.name = "kmaster3"
#             v.memory = 2048
#             v.cpus = 1
#         end
#
#         config.vm.provision "shell" do |s|
#             ssh_pub_key = File.readlines("./vagrant.pub").first.strip
#             s.inline = <<-SHELL
#             echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
#             echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
#             SHELL
#         end
#
#         kmaster.vm.network "forwarded_port", guest: 8084, host: 8084
#     end

    config.vm.define "kworker1" do |kworker|
        kworker.vm.box_download_insecure = true
        kworker.vm.box = "hashicorp/bionic64"
        kworker.vm.network "private_network", ip: "192.168.56.5"
        kworker.vm.hostname = "kworker1"
        kworker.vm.provider "virtualbox" do |v|
            v.name = "kworker1"
            v.memory = 2048
            v.cpus = 1
        end

        config.vm.provision "shell" do |s|
            ssh_pub_key = File.readlines("./vagrant.pub").first.strip
            s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
            SHELL
        end

        kworker.vm.network "forwarded_port", guest: 8085, host: 8085
    end

#     config.vm.define "kworker2" do |kworker|
#         kworker.vm.box_download_insecure = true
#         kworker.vm.box = "hashicorp/bionic64"
#         kworker.vm.network "private_network", ip: "192.168.56.6"
#         kworker.vm.hostname = "kworker2"
#         kworker.vm.provider "virtualbox" do |v|
#             v.name = "kworker2"
#             v.memory = 2048
#             v.cpus = 1
#         end
#
#         config.vm.provision "shell" do |s|
#             ssh_pub_key = File.readlines("./vagrant.pub").first.strip
#             s.inline = <<-SHELL
#             echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
#             echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
#             SHELL
#         end
#
#         kworker.vm.network "forwarded_port", guest: 8086, host: 8086
#     end
#
#     config.vm.define "kworker3" do |kworker|
#         kworker.vm.box_download_insecure = true
#         kworker.vm.box = "hashicorp/bionic64"
#         kworker.vm.network "private_network", ip: "192.168.56.7"
#         kworker.vm.hostname = "kworker3"
#         kworker.vm.provider "virtualbox" do |v|
#             v.name = "kworker3"
#             v.memory = 2048
#             v.cpus = 1
#         end
#
#         config.vm.provision "shell" do |s|
#             ssh_pub_key = File.readlines("./vagrant.pub").first.strip
#             s.inline = <<-SHELL
#             echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
#             echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
#             SHELL
#         end
#
#         kworker.vm.network "forwarded_port", guest: 8087, host: 8087
#     end

end
