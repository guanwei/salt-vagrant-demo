python36-PyMySQL:
  pkg.installed

mariadb-server:
  pkg.installed:
    - require:
      - pkg: python36-PyMySQL

mariadb:
  service.running:
    - watch:
      - pkg: mariadb-server
      - file: /etc/my.cnf

/etc/my.cnf:
  file.managed:
    - source: salt://mariadb/files/etc/my.cnf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: mariadb-server

/etc/salt/minion.d/mariadb.conf:
  file.managed:
    - source: salt://mariadb/files/etc/salt/minion.d/mariadb.conf
    - user: root
    - group: root
    - mode: 640
    - require:
      - service: mariadb

/etc/mysql/salt.cnf:
  file.managed:
    - source: salt://mariadb/files/etc/mysql/salt.cnf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - service: mariadb

restart_minion_for_mariadb:
  service.running:
    - name: salt-minion
    - watch:
      - file: /etc/salt/minion.d/mariadb.conf