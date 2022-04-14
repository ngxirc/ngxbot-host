ssh-user:
  group.present

root:
  user.present:
    - shell: /bin/bash
    - home: /root
    - uid: 0
    - gid: 0
    - password: {{ pillar['root_pass'] }}
    - remove_groups: True
  file.absent:
    - name: /root/.ssh/authorized_keys

{% for user, attr in salt.pillar.get('admins', {}).items() %}
{{ user }}:
  group.present:
    - gid: {{ attr['gid'] }}
  user.present:
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: {{ attr['uid'] }}
    - gid: {{ attr['gid'] }}
    {% if 'pwd' in attr %}
    - password: {{ attr['pwd'] }}
    {% endif %}
    - optional_groups:
      - ssh-user
      - sudo
    - remove_groups: False
    - require:
      - group: ssh-user
      - group: {{ user }}

{% if 'keys' in attr %}
{{ user }}-ssh:
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ attr['keys'] }}
    - fingerprint_hash_type: md5
    - require:
      - group: {{ user }}
{% endif %}

{% endfor %}
