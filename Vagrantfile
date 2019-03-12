
# require './config.rb'

# todo: 
#  - full parameterize:
#    - param master IP here, to minion configs
#    - full minion generate:
#      - define global var
#      - mk minion key & config, auto-ip
#      - vagrant up minion


Vagrant.configure("2") do |config|

  config.vm.define "nacl" do |nacl|
    # nacl.vm.box = "generic/ubuntu1804" # does funky dns stuff nobueno
    nacl.vm.box = "ubuntu/bionic64"
    nacl.vm.hostname = "nacl"
    nacl.vm.network "private_network", ip: "172.28.128.61"

    # # there:
    # $ find saltstack -type d
    # saltstack
    # saltstack/etc
    # saltstack/keys
    # saltstack/pillar
    # saltstack/salt
    # saltstack/salt/common
    # saltstack/salt/misc

    # # here:
    # $ find salt -type d
    # salt
    # salt/roots
    
    # there (master):
    # master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    # master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"

    # mkdir -p salt/{salt,pillar}

    # CONFIRM:
    # for new nodes in net, on master:
    # host='foo'
    # salt-key --gen-keys=${host}
    # cp -p ${host}.pem ${host}.pub /vagrant
    # then update configs here (seed_master, per sub node)


    nacl.vm.synced_folder "salt/salt/", "/srv/salt"
    nacl.vm.synced_folder "salt/pillar/", "/srv/pillar"

    nacl.vm.provision :salt do |salt|

      salt.install_type = "stable"

      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
      salt.install_master = true
      # salt.no_minion = true

      salt.master_config = "salt/etc/master"
      salt.master_key = "salt/keys/nacl.pem"
      salt.master_pub = "salt/keys/nacl.pub"
      salt.seed_master = {
                            "nacl" => "salt/keys/nacl.pub",
                            "mon" => "salt/keys/mon.pub",
                            "mysql1" => "salt/keys/mysql1.pub",
                            "mysql2" => "salt/keys/mysql2.pub",
                            "mysql3" => "salt/keys/mysql3.pub",
                         }

      salt.minion_id = "nacl"
      salt.minion_config = "salt/etc/nacl"
      salt.minion_key = "salt/keys/nacl.pem"
      salt.minion_pub = "salt/keys/nacl.pub"

    end
  end

  config.vm.define "mon" do |mon|
    mon.vm.box = "ubuntu/xenial64"
    mon.vm.hostname = "mon"
    mon.vm.network "private_network", ip: "172.28.128.62"

    mon.vm.provision :salt do |salt|

      # 2018.3 has borked mysql permissions
      # 
      # see also: 
      # https://github.com/saltstack/salt/issues/46917
      # https://www.vagrantup.com/docs/provisioning/salt.html
      # salt.install_type = "stable"

      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      # if more debug needed:
      # salt.bootstrap_options = "-D"
      # also note: must zap minion key on master if reprovisioning
      # salt-key --delete=mon

      salt.minion_id = "mon"
      salt.minion_config = "salt/etc/mon"
      salt.minion_key = "salt/keys/mon.pem"
      salt.minion_pub = "salt/keys/mon.pub"

    end
  end

  # dblab merge
  config.vm.define "mysql1" do |mysql1|
    mysql1.vm.box = "ubuntu/bionic64"
    mysql1.vm.hostname = "mysql1"
    mysql1.vm.network "private_network", ip: "172.28.128.11"
    mysql1.vm.synced_folder "/Users/chris/src/", "/src/"

    mysql1.vm.provision :salt do |salt|

      # 2018.3 has borked mysql permissions
      # 
      # see also: 
      # https://github.com/saltstack/salt/issues/46917
      # https://www.vagrantup.com/docs/provisioning/salt.html
      # salt.install_type = "stable"

      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      # if more debug needed:
      # salt.bootstrap_options = "-D"
      # also note: must zap minion key on master if reprovisioning
      # salt-key --delete=mon

      salt.minion_id = "mysql1"
      salt.minion_config = "salt/etc/mysql1"
      salt.minion_key = "salt/keys/mysql1.pem"
      salt.minion_pub = "salt/keys/mysql1.pub"

    end
  end

  config.vm.define "mysql2" do |mysql2|
    mysql2.vm.box = "ubuntu/xenial64"
    mysql2.vm.hostname = "mysql2"
    mysql2.vm.network "private_network", ip: "172.28.128.12"
    mysql2.vm.synced_folder "/Users/chris/src/", "/src/"

    mysql2.vm.provision :salt do |salt|

      # 2018.3 has borked mysql permissions
      #
      # see also: 
      # https://github.com/saltstack/salt/issues/46917
      # https://www.vagrantup.com/docs/provisioning/salt.html
      # salt.install_type = "stable"

      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      # if more debug needed:
      # salt.bootstrap_options = "-D"
      # also note: must zap minion key on master if reprovisioning
      # salt-key --delete=mon

      salt.minion_id = "mysql3"
      salt.minion_config = "salt/etc/mysql3"
      salt.minion_key = "salt/keys/mysql3.pem"
      salt.minion_pub = "salt/keys/mysql3.pub"
    end



  end

  config.vm.define "mysql3" do |mysql3|
    mysql3.vm.box = "ubuntu/bionic64"
    mysql3.vm.hostname = "mysql3"
    mysql3.vm.network "private_network", ip: "172.28.128.13"

    mysql3.vm.synced_folder "/Users/chris/src/", "/src/"
    
    # XXX: should be mysql3.vm provider??
    config.vm.provider :virtualbox do |vb|

      # vb.customize ["modifyvm", :id, "--memory", "2048"]
      # vb.customize ["modifyvm", :id, "--cpus", "2"]
      # vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
      # # vb.customize ["modifyvm", :id, "--audio", "none"]
      # vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      # vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
      # vb.customize ["modifyvm", :id, "--vram", "64"]
      # vb.customize ["modifyvm", :id, "--vram", "64"]

      # Aux Data Disk
      # better: try this: https://github.com/kusnier/vagrant-persistent-storage
      # todo: gen uuid into file used later by salt stuffs
      # todo: persistent / reattaching across destroysish
      #   andor host side iscsi targets
      # TODO:uuid doesn't show on host side..
      # 
      # require 'SecureRandom'
      # SecureRandom.uuid
      # .. file save? file load?
      #
      # disk_file="#{mysql3.vm.hostname}-auxdisk.vmdk"
      # disk_uuid='1BE5C0D5-CDA9-4FE4-828F-252D0C48043B'  

      # vb.customize ['createhd', '--filename', disk_file,
      #               '--size', 1024 * 1]  # size in mb
      # vb.customize ['storageattach', :id, '--storagectl',
      #               'SCSI', '--port', 2, '--device', 0,  # port >1; device=0
      #               '--comment', disk_file,
      #               '--setuuid', disk_uuid,
      #               '--type', 'hdd', '--medium', disk_file]

    end

    disk_file="#{mysql3.vm.hostname}-auxdisk.vmdk"  # todo: rename .vdi on build
    config.persistent_storage.enabled = true
    config.persistent_storage.location = disk_file
    config.persistent_storage.size = 5000
    config.persistent_storage.mountname = 'mysql'
    config.persistent_storage.filesystem = 'ext4'
    config.persistent_storage.mountpoint = '/data/mysql'
    config.persistent_storage.volgroupname = 'vgdb'
    config.persistent_storage.diskdevice = '/dev/sdc'
    # config.persistent_storage.use_lvm = false  # if nolvm (todo nolvm opts)
    # config.persistent_storage.partition = false  # if nopart

    mysql3.vm.provision :salt do |salt|

      # 2018.3 has borked mysql permissions
      #
      # see also: 
      # https://github.com/saltstack/salt/issues/46917
      # https://www.vagrantup.com/docs/provisioning/salt.html
      # salt.install_type = "stable"

      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      # if more debug needed:
      # salt.bootstrap_options = "-D"
      # also note: must zap minion key on master if reprovisioning
      # salt-key --delete=mon

      salt.minion_id = "mysql3"
      salt.minion_config = "salt/etc/mysql3"
      salt.minion_key = "salt/keys/mysql3.pem"
      salt.minion_pub = "salt/keys/mysql3.pub"
    end
  end

end
