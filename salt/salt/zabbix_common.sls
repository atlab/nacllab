
fetch_zabbix_repo:
  cmd.run:
    - name: wget -O /root/zabbix-release_4.0-2+bionic_all.deb https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb
    - unless: test -e /root/zabbix-release_4.0-2+bionic_all.deb


install_zabbix_repo:
  cmd.run:
    - name: dpkg -i /root/zabbix-release_4.0-2+bionic_all.deb
    - unless: test -e /etc/apt/sources.list.d/zabbix.list

