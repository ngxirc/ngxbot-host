/etc/nginx/conf.d/pbin.conf:
  file.managed:
    - source: salt://webapps/nginx-cfg/pbin.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/uwsgi/apps-enabled/pbin.ini:
  file.managed:
    - source: salt://webapps/uwsgi-cfg/pbin.ini
    - require:
      - pkg: uwsgi
    - watch_in:
      - service: uwsgi

webapps-pbin:
  pkg.installed:
    - names:
      - python3-cymruwhois
      - python3-bottle
      - python3-redis
      - python3-jinja2
      - python3-pygments
      - redis-server
      - uwsgi-plugin-python3
    - require_in:
      - pkg: uwsgi
  git.latest:
    - name: https://github.com/ngx/pbin.git
    - target: /srv/webapps/pbin
    - force_reset: True
    - require:
      - file: /srv/webapps
    - watch_in:
      - service: uwsgi
  file.managed:
    - name: /srv/webapps/pbin/conf/settings.cfg
    - require:
      - git: webapps-pbin
    - watch_in:
      - service: uwsgi
    - contents: |
        [bottle]
        cache_host=localhost
        cache_db=0
        port=80
        root_path=.
        url=https://paste.nginx.org/
        relay_enabled=True
        relay_chan=nginx
        relay_host=127.0.0.1
        relay_pass={{ salt.pillar.get('pbin-creds:irccat') }}
        admin_key={{ salt.pillar.get('pbin-creds:irccat') }}
        recaptcha_sitekey={{ salt.pillar.get('pbin-creds:recaptcha_site') }}
        recaptcha_secret={{ salt.pillar.get('pbin-creds:recaptcha_secret') }}
        relay_port=2525
        python_server=auto
