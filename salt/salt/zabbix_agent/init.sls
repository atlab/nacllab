# todo:
# pillarize ip
# start

zabbix_agent_packages:
  pkg.installed:
    - pkgs:
      - zabbix-agent


/etc/zabbix/zabbix_agentd.conf:
 file.managed:
   - source: salt://zabbix_agent/zabbix_agentd.conf.template
   - user: root
   - group: root
   - mode: 644
   - template: jinja
   - defaults:
     zabbix_server_address: '172.28.128.62'

zabbix-agent:
  service.running:
    - enable: True
