/etc/apt/sources.list:
  file.managed:
    - contents: |
        deb http://deb.debian.org/debian/ bullseye main
        deb http://security.debian.org/debian-security bullseye-security main
        deb http://deb.debian.org/debian/ bullseye-updates main
        deb http://deb.debian.org/debian/ sid main

/etc/apt/preferences.d/pinning:
  file.managed:
    - contents: |
        Package: *
        Pin: release n=bullseye
        Pin-Priority: 900

        Package: *
        Pin: release n=sid
        Pin-Priority: 800
