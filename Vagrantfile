
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
    nacl.vm.box = "ubuntu/xenial64"
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

end
