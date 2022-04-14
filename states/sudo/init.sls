sudo:
  pkg.installed

/etc/sudoers:
  file.managed:
    - source: salt://sudo/sudoers
    - mode: 440
    - user: root
    - group: root
