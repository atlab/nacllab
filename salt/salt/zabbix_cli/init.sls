
# install the zabbix-cli zabbix mgmt suite
# see also: https://github.com/usit-gd/zabbix-cli/blob/master/docs/manual.rst

install_zabbix_cli_deps:
  pkg.installed:
    - pkgs:
        - python-requests
        - python-ipaddr


install_zabbix_cli:
  pkg.installed:
    - sources:
        - zabbix-cli: https://github.com/usit-gd/zabbix-cli/releases/download/1.7.0/zabbix-cli_1.7.0-1_all.deb


/root/.zabbix-cli:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: False


/root/.zabbix-cli/zabbix-cli.conf:
  file.managed:
    - source: salt://zabbix_cli/zabbix-cli.conf.template
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - defaults:
      zabbix_api_url: http://localhost/zabbix
      zabbix_hostname: mon
