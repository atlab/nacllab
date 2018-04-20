
# todo:
#
# - pillarize:
#   - zabbix_db_database: zabbix
#   - zabbix_db_user: zabbix
#   - zabbix_db_password: zabbix
#
# - automate initial server setup?:
#   - password reset


/etc/zabbix/zabbix_server.conf:
  file.managed:
    - source: salt://zabbix_server/zabbix_server.conf.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      zabbix_db_database: zabbix
      zabbix_db_user: zabbix
      zabbix_db_password: zabbix

     
zabbix-server:
  service.running:
    - enable: True


/etc/zabbix/apache.conf:
  file.managed:
   - source: salt://zabbix_server/apache.conf.zabbix
   - user: root
   - group: root
   - mode: 644
   - template: jinja
   - defaults:
     timezone: 'GMT'


apache2:
  service.running:
    - enable: True
