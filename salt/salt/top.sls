# todo: grains on startup & use here
# https://docs.saltstack.com/en/latest/topics/reactor/index.html#minion-start-reactor
base:
  '*':
    - common
    - zabbix_common
    - zabbix_agent
  'mon':
    - percona_server
    - zabbix_server
  'mysql*':
    - percona_server
