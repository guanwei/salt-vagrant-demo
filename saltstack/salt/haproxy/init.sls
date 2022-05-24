haproxy:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: haproxy
      - file: /etc/haproxy/haproxy.cfg
      - file: /etc/sysconfig/haproxy

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://haproxy/files/etc/haproxy/haproxy.cfg.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/sysconfig/haproxy:
  file.managed:
    - source: salt://haproxy/files/etc/sysconfig/haproxy
    - user: root
    - group: root
    - mode: 644