
zabbix:
  mysql_database.present: []
  mysql_user.present:
    - host: localhost
    - password: zabbix
  mysql_grants.present:
    - grant: all
    - database: zabbix.*
    - user: zabbix
    - host: localhost
  cmd.run:
    - name: gzip -dc /usr/share/doc/zabbix-server-mysql/create.sql.gz|mysql -Dzabbix -uzabbix -hlocalhost -pzabbix
    - creates:
      - /data/mysql/zabbix/users.frm
