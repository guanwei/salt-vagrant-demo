common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      {% if grains['os_family'] == 'RedHat' and grains['osmajorrelease'] >= 7 %}
      - vim-enhanced
      {% elif grains['os_family'] == 'Debian' %}
      - vim
      {% endif %}
