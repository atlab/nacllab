
# status:
# installs, starts in /data/mysql, but with root@localhost no password
# general todo:
# todo: apparmor?
# todo: set password, create my.cnf
# todo: parameterize mysql data directory, make part of server template 
# todo: secure_file_priv
# # merge other todos

add_percona_gpg_key:
  cmd.run:
    - name: 'gpg --keyserver  hkp://keys.gnupg.net --recv-keys 9334A25F8507EFA5'
    - unless: test -e /etc/apt/sources.list.d/percona-release.list


add_percona_apt_key:
  cmd.run:
    - name: 'gpg -a --export 9334A25F8507EFA5 | apt-key add -'
    - unless: test -e /etc/apt/sources.list.d/percona-release.list
  require:
    - cmd: 'add_percona_gpg_key'

# todo: dispatch repo based on installed system
# lsb_distrib_codename
install_percona_server:
  pkgrepo.managed:
    - humanname: percona-release
    - name: deb http://repo.percona.com/apt {{ grains['lsb_distrib_codename'] }} main
    - file: /etc/apt/sources.list.d/percona-release.list
  pkg.installed:
    - pkgs:
      - percona-server-server-5.7
      - percona-server-client-5.7
      - percona-xtrabackup-24
      - python-mysqldb


/etc/mysql/percona-server.conf.d/mysqld.cnf:
  file.managed:
   - source: salt://percona_server/mysqld.cnf.template
   - user: root
   - group: root
   - mode: 644
   - template: jinja
   - defaults:
     server_id: 11
     innodb_log_file_size: 100M
     innodb_bufer_pool_size: 100M

/data/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: 770
    - makedirs: True


mysql:
  service.running:
    - enable: True
