
# require './config.rb'

# todo: 
#  - full parameterize:
#    - param master IP here, to minion configs
#    - full minion generate:
#      - define global var
#      - mk minion key & config, auto-ip
#      - vagrant up minion


Vagrant.configure("2") do |config|

  config.vm.define "nacl1" do |nacl1|
    nacl1.vm.box = "ubuntu/bionic64"
    nacl1.vm.hostname = "nacl1"
    nacl1.vm.network "private_network", ip: "172.28.128.61"

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

    nacl1.vm.synced_folder "salt/salt/", "/srv/salt"
    nacl1.vm.synced_folder "salt/pillar/", "/srv/pillar"

    nacl1.vm.provision :salt do |salt|

      # salt.install_type = "stable"
      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
      salt.install_master = true
      # salt.no_minion = true

      salt.master_config = "salt/etc/master"
      salt.master_key = "salt/keys/master.pem"
      salt.master_pub = "salt/keys/master.pub"
      salt.seed_master = {
                            "nacl1" => "salt/keys/nacl1.pub",
                            "nacl2" => "salt/keys/nacl2.pub",
                            "mon" => "salt/keys/mon.pub",
                            "mysql1" => "salt/keys/mysql1.pub",
                            "mysql2" => "salt/keys/mysql2.pub",
                            "mysql3" => "salt/keys/mysql3.pub",
                         }

      salt.minion_id = "nacl1"
      salt.minion_config = "salt/etc/nacl1"
      salt.minion_key = "salt/keys/nacl1.pem"
      salt.minion_pub = "salt/keys/nacl1.pub"

    end
  end

  config.vm.define "nacl2" do |nacl2|
    nacl2.vm.box = "ubuntu/bionic64"
    nacl2.vm.hostname = "nacl2"
    nacl2.vm.network "private_network", ip: "172.28.128.62"

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

    nacl2.vm.synced_folder "salt/salt/", "/srv/salt"
    nacl2.vm.synced_folder "salt/pillar/", "/srv/pillar"

    nacl2.vm.provision :salt do |salt|

      # salt.install_type = "stable"
      salt.install_type = "git"
      salt.install_args = "2018.3"

      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
      salt.install_master = true
      # salt.no_minion = true

      salt.master_config = "salt/etc/master"
      salt.master_key = "salt/keys/master.pem"
      salt.master_pub = "salt/keys/master.pub"
      salt.seed_master = {
                            "nacl1" => "salt/keys/nacl1.pub",
                            "nacl2" => "salt/keys/nacl2.pub",
                            "mon" => "salt/keys/mon.pub",
                            "mysql1" => "salt/keys/mysql1.pub",
                            "mysql2" => "salt/keys/mysql2.pub",
                            "mysql3" => "salt/keys/mysql3.pub",
                         }

      salt.minion_id = "nacl2"
      salt.minion_config = "salt/etc/nacl2"
      salt.minion_key = "salt/keys/nacl2.pem"
      salt.minion_pub = "salt/keys/nacl2.pub"

    end
  end

  config.vm.define "mon" do |mon|
    mon.vm.box = "ubuntu/bionic64"
    mon.vm.hostname = "mon"
    mon.vm.network "private_network", ip: "172.28.128.63"

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
    mysql2.vm.box = "ubuntu/bionic64"
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

      salt.minion_id = "mysql2"
      salt.minion_config = "salt/etc/mysql2"
      salt.minion_key = "salt/keys/mysql2.pem"
      salt.minion_pub = "salt/keys/mysql2.pub"
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

      # enlarge root vol (untested)
      # https://github.com/sprotheroe/vagrant-disksize

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
      
    # Aux Data Disk (disabled)
    # can be used to persist mysql data across VM's
    # (useful for system upgrade testing, etc)
    #
    # 1st, install: https://github.com/kusnier/vagrant-persistent-storage
    #
    # Then, as needed, enable stanzas in the vms as follows:
    #

    #disk_file="#{mysql3.vm.hostname}-auxdisk.vdi"
    #mysql3.persistent_storage.enabled = true
    #mysql3.persistent_storage.location = disk_file
    #mysql3.persistent_storage.size = 5000
    #mysql3.persistent_storage.mountname = 'mysql'
    #mysql3.persistent_storage.filesystem = 'ext4'
    #mysql3.persistent_storage.mountpoint = '/data/mysql'
    #mysql3.persistent_storage.volgroupname = 'vgdb'
    #mysql3.persistent_storage.diskdevice = '/dev/sdc'
    # # mysql3.persistent_storage.use_lvm = false  # if nolvm (todo nolvm opts)
    # # mysql3.persistent_storage.partition = false  # if nopart

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
