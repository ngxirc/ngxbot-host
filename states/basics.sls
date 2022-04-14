base_pkgs:
  pkg.installed:
    - names:
      - apt-transport-https
      - file
      - git
      - lsof
      - net-tools
      - screen
      - vim

base_pkgs_removed:
  pkg.purged:
    - pkgs:
      - apt-listchanges
      - nano
      - vim-tiny

systemd-reload:
  cmd.wait:
    - name: systemctl daemon-reload
