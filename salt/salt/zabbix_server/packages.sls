
# todo: fix deps
#    - require:
#      - sls: percona_server
#      - sls: zabbix_common

zabbix_server_packages:
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql
      - zabbix-frontend-php
