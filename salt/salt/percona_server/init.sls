
# status:
# installs, starts in /data/mysql, with root@localhost no password
# general todo:
# todo: apparmor?
# todo: set password, create my.cnf
# todo: parameterize mysql data directory, make part of server template 
# todo: secure_file_priv

# install config 1st so db always starts with correct parameters

mysql_group:
  group.present:
    - name: mysql
    - system: True


mysql_user:
  user.present:
    - name: mysql
    - system: True
    - gid: mysql
    - fullname: MySQL Server
    - home: /data/mysql
    - createhome: False
    - shell: /bin/false


# create custom datadir
/data/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: 770
    - makedirs: True


# usually installed by package; ensure present just in case
/var/run/mysqld:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: 775
    - makedirs: True


# usually installed by package; ensure present just in case
/var/log/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: 775
    - makedirs: True


/etc/mysql/percona-server.conf.d/mysqld.cnf:
  file.managed:
   - source: salt://percona_server/mysqld.cnf.template
   - makedirs: True
   - user: root
   - group: root
   - mode: 644
   - template: jinja
   - defaults:
     server_id: 11
     innodb_log_file_size: 100M
     innodb_bufer_pool_size: 100M


fetch_percona_repo:
  cmd.run:
    - name: wget -O /root/percona-release_latest.generic_all.deb https://repo.percona.com/apt/percona-release_latest.generic_all.deb
    - unless: test -e /root/percona-release_latest.generic_all.deb


install_percona_repo:
  cmd.run:
    - name: dpkg -i /root/percona-release_latest.generic_all.deb && apt update
    - unless: test -e /etc/apt/sources.list.d/percona-original-release.list


install_percona_server:
  pkg.installed:
    - pkgs:
      - percona-server-server-5.7
      - percona-server-client-5.7
      - percona-xtrabackup-24


mysql:
  service.running:
    - enable: True

