/etc/nginx/conf.d/ngxbot.conf:
  file.managed:
    - source: salt://webapps/nginx-cfg/ngxbot.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/srv/webapps/ngxbot:
  file.directory: []

/srv/webapps/ngxbot/index.html:
  file.managed:
    - contents: |
        <!DOCTYPE html><html>
        <head><title>ngxbot</title></head>
        <body>
        Logs are no longer public.<br />
        Factoids now backed up to <a href="https://github.com/ngx/ngxbot-host/tree/factoids">github</a>.
        </body>
        </html>
