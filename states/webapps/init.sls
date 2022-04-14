include:
  {% for webapp in salt.pillar.get('webapps', []) %}
  - .{{ webapp }}
  {% endfor %}
