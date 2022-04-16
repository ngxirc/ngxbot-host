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

vim-sanity:
  file.managed:
    - name: /etc/vim/vimrc.local
    - require:
      - pkg: base_pkgs
    - contents: |
        let skip_defaults_vim=1
        syntax on
        set mouse=
        set background=dark
        filetype plugin indent on
