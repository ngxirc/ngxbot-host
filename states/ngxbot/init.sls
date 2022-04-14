##
# User
##

ngxbot:
  group.present:
    - gid: 8001
  user.present:
    - shell: /bin/bash
    - home: {{ salt.pillar.get('ngxbot:homedir') }}
    - uid: 8001
    - gid: 8001
    - remove_groups: True
    - require:
      - group: ngxbot
  file.absent:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/.ssh/authorized_keys

##
# Plugins
##

{% for name, repo in [
    ('ngxbot', 'https://github.com/ngx/ngxbot-plugins.git'),
    ('supybot', 'https://github.com/ProgVal/Supybot-plugins.git'),
    ] %}
{{ name }}-plugins:
  git.latest:
    - name: {{ repo }}
    - target: /srv/plugins/{{ name }}
    - force_reset: True
{% endfor %}

##
# Bot Things
##

ngxbot-deps:
  pkg.installed:
    - names:
      - limnoria
      - python3-twisted
      - python3-ujson

ngxbot-config:
  file.managed:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/ngxbot.conf
    - source: salt://ngxbot/ngxbot.conf
    - template: jinja
    - user: root
    - group: root

{% for dir in ['bot', 'bot/plugins', 'bot/conf'] %}
ngxbot-botdirs-{{ dir }}:
  file.directory:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/{{ dir }}
    - user: ngxbot
    - group: ngxbot
{% endfor %}

ngxbot-conf-users:
  file.managed:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/conf/users.conf
    - source: salt://ngxbot/bot_users.conf
    - template: jinja
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/conf

ngxbot-conf-irccat:
  file.managed:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/conf/sections.json
    - contents_pillar: pbin-creds:irccat-config
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/conf

{% for src, plugin in [
    ('ngxbot', 'Irccat'),
    ('ngxbot', 'PbinAdmin'),
    ('supybot', 'AttackProtector'),
    ] %}
ngxbot-plugin-{{ plugin }}:
  file.symlink:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/plugins/{{ plugin }}
    - target: /srv/plugins/{{ src }}/{{ plugin }}
    - user: ngxbot
    - group: ngxbot
    - require:
      - file: ngxbot-botdirs-bot/plugins
      - git: {{ src }}-plugins
    - require_in:
      - service: ngxbot-service
{% endfor %}

ngxbot-service:
  file.managed:
    - name: /etc/systemd/system/ngxbot.service
    - source: salt://ngxbot/ngxbot.service
    - template: jinja
    - watch_in:
      - cmd: systemd-reload
  service.running:
    - name: ngxbot
    - enable: True
    - require:
      - file: ngxbot-service
      - cmd: systemd-reload
      - pkg: ngxbot-deps
      - file: ngxbot-config
      - file: ngxbot-conf-users
    - watch:
      - file: ngxbot-config
      - file: ngxbot-conf-users
