uwsgi:
  pkg.installed:
    - pkgs:
      - uwsgi
      - uwsgi-plugin-python3
      {% for dep in salt.pillar.get('webapps:uwsgi-depends', []) %}
      - {{ dep }}
      {% endfor %}
  service.running:
    - enable: True
    - require:
      - pkg: uwsgi
