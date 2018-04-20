
# todo: zabbix server is sloo


add_zabbix_gpg_key:
  cmd.run:
    - name: 'gpg --keyserver  hkp://keys.gnupg.net --recv-keys 082AB56BA14FE591'
    - unless: test -e /etc/apt/sources.list.d/zabbix.list

add_zabbix_apt_key:
  cmd.run:
    - name: 'gpg -a --export 082AB56BA14FE591 | apt-key add -'
    - unless: test -e /etc/apt/sources.list.d/zabbix.list
  require:
    - cmd: 'add_zabbix_gpg_key'

add_zabbix_repo:
  pkgrepo.managed:
    - humanname: zabbix
    - name: deb http://repo.zabbix.com/zabbix/3.4/ubuntu xenial main
    - file: /etc/apt/sources.list.d/zabbix.list

