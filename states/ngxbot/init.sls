{% set homedir = salt.pillar.get('ngxbot:homedir') %}
##
# User
##

ngxbot:
  group.present:
    - gid: 8001
  user.present:
    - shell: /bin/bash
    - home: {{ homedir }}
    - uid: 8001
    - gid: 8001
    - remove_groups: True
    - require:
      - group: ngxbot
  file.absent:
    - name: {{ homedir }}/.ssh/authorized_keys

ngxbot-gitconfig:
  file.managed:
    - name: {{ homedir }}/.gitconfig
    - user: ngxbot
    - group: ngxbot
    - require:
      - user: ngxbot
    - contents: |
        [user]
            email = salt@ngxbot.nginx.org
            name = ngxbot

ngxbot-ssh:
  file.directory:
    - name: {{ homedir }}/.ssh
    - user: ngxbot
    - group: ngxbot
    - dir_mode: 700
    - require:
      - user: ngxbot

ngxbot-ssh-pubkey:
  file.managed:
    - name: {{ homedir }}/.ssh/id_ed25519.pub
    - contents_pillar: ngxbot:sshpub
    - user: ngxbot
    - group: ngxbot
    - mode: 644
    - require:
      - file: ngxbot-ssh

ngxbot-ssh-prvkey:
  file.managed:
    - name: {{ homedir }}/.ssh/id_ed25519
    - contents_pillar: ngxbot:sshkey
    - user: ngxbot
    - group: ngxbot
    - mode: 600
    - require:
      - file: ngxbot-ssh

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
    - name: {{ homedir }}/ngxbot.conf
    - source: salt://ngxbot/ngxbot.conf
    - template: jinja
    - user: root
    - group: root

{% for dir in ['bot', 'bot/plugins', 'bot/conf', 'bot/data'] %}
ngxbot-botdirs-{{ dir }}:
  file.directory:
    - name: {{ homedir }}/{{ dir }}
    - user: ngxbot
    - group: ngxbot
{% endfor %}

ngxbot-conf-users:
  file.managed:
    - name: {{ homedir }}/bot/conf/users.conf
    - source: salt://ngxbot/bot_users.conf
    - template: jinja
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/conf

ngxbot-data-tmp:
  file.directory:
    - name: {{ homedir }}/bot/data/tmp
    - user: ngxbot
    - group: ngxbot
    - require:
      - file: ngxbot-botdirs-bot/data

# Limnoria creates temp files before replacing config files but leaves behind
# temp files when the replace fails for salt-managed files.
ngxbot-data-tmp-cleanup:
  cron.present:
    - name: rm -f {{ homedir }}/bot/data/tmp/*
    - identifier: ngxbot-tmp-cleanup
    - special: '@hourly'
    - require:
      - file: ngxbot-data-tmp


{% for src, plugin in [
    ('ngxbot', 'Irccat'),
    ('ngxbot', 'PbinAdmin'),
    ('supybot', 'AttackProtector'),
    ] %}
ngxbot-plugin-{{ plugin }}:
  file.symlink:
    - name: {{ homedir }}/bot/plugins/{{ plugin }}
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

##
# Bot Plugin - Irccat
##

ngxbot-conf-irccat:
  file.managed:
    - name: {{ homedir }}/bot/conf/sections.json
    - contents_pillar: pbin-creds:irccat-config
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/conf
    - require_in:
      - service: ngxbot

##
# Bot Plugin - MessageParser
##

ngxbot-data-messageparser-db:
  file.managed:
    - name: {{ homedir }}/bot/data/MessageParser.db
    - source: salt://ngxbot/MessageParser.db
    - user: root
    - group: root
    - require:
      - file: ngxbot-botdirs-bot/data
    - require_in:
      - service: ngxbot

{% for chan in ["#nginx", "#ngx-social", "#salt", "#salt-offtopic", "##eros-chat"] %}
ngxbot-data-chan-dir-{{ chan }}:
  file.directory:
    - name: {{ homedir }}/bot/data/{{ chan }}
    - user: ngxbot
    - group: ngxbot
    - require:
      - file: ngxbot-botdirs-bot/data

ngxbot-data-chan-parsersymlink-{{ chan }}:
  file.symlink:
    - name: {{ homedir }}/bot/data/{{ chan }}/MessageParser.db
    - target: {{ homedir }}/bot/data/MessageParser.db
    - force: True
    - user: root
    - group: root
    - require:
      - file: ngxbot-data-chan-dir-{{ chan }}
      - file: ngxbot-data-messageparser-db
    - require_in:
      - service: ngxbot
{% endfor %}

##
# Bot Plugin - Factoids
# This also handles automatic backups
##

ngxbot-factoids:
  git.cloned:
    - name: git@github.com:ngx/ngxbot-host.git
    - branch: factoids
    - target: {{ homedir }}/bot/data/factoids
    - identity: {{ homedir }}/.ssh/id_ed25519
    - user: ngxbot
    - require:
      - user: ngxbot

{% for channel, factsdb in [
    ("#nginx", "nginx.db"),
    ("#ngx-social", "nginx.db"),
    ("#salt", "salt.db"),
    ("#salt-offtopic", "salt.db"),
    ] %}
ngxbot-factoids-symlink-{{ channel }}:
  file.symlink:
    - name: {{ homedir }}/bot/data/{{ channel }}/Factoids.db
    - target: {{ homedir }}/bot/data/factoids/{{ factsdb }}
    - force: True
    - user: root
    - group: root
    - require:
      - git: ngxbot-factoids
    - require_in:
      - service: ngxbot
{% endfor %}

ngxbot-factoids-backup:
  cmd.run:
    - name: git commit -am automatic-snapshot; git push origin factoids
    - unless: git diff --exit-code
    - cwd: {{ homedir }}/bot/data/factoids/
    - runas: ngxbot
    - require:
      - git: ngxbot-factoids
      - file: ngxbot-gitconfig
