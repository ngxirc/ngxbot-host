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

{% for dir in ['bot', 'bot/plugins', 'bot/conf', 'bot/data'] %}
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
    - require_in:
      - service: ngxbot

ngxbot-data-messageparser-orig-db:
  file.managed:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/MessageParser_orig.db
    - source: salt://ngxbot/MessageParser.db
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/data
    - require_in:
      - service: ngxbot

# ngxbot requires read-write to this in order to track usage
# ... we don't care about usage, but can't disable the feature
ngxbot-data-messageparser-db:
  cmd.wait:
    - name: cp {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/MessageParser_orig.db {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/MessageParser.db
    - runas: ngxbot
    - require:
      - file: ngxbot-data-messageparser-orig-db
    - watch:
      - file: ngxbot-data-messageparser-orig-db

{% for chan in ["#nginx", "#ngx-social", "#salt", "#salt-offtopic", "##eros-chat"] %}
ngxbot-data-chan-dir-{{ chan }}:
  file.directory:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/{{ chan }}
    - user: ngxbot
    - group: ngxbot
    - require:
      - file: ngxbot-botdirs-bot/data

ngxbot-data-chan-parsersymlink-{{ chan }}:
  file.symlink:
    - name: {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/{{ chan }}/MessageParser.db
    - target: {{ salt.pillar.get('ngxbot:homedir') }}/bot/data/MessageParser.db
    - force: True
    - user: root
    - group: root
    - require:
      - file: ngxbot-data-chan-dir-{{ chan }}
      - cmd: ngxbot-data-messageparser-db
    - require_in:
      - service: ngxbot
{% endfor %}

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
