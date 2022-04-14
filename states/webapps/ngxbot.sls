/etc/nginx/conf.d/ngxbot.conf:
  file.managed:
    - source: salt://webapps/nginx-cfg/ngxbot.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
