Ngxbot Host
===========

This mess contains everything that is needed to spin up a server suitable for
running the next version of ngxbot and associated web services.

Encrypted Passwords
-------------------

To encrypt a password suitable for usage in pillar data::

    gpg --import saltpub.gpg
    echo -n 'S3cr!t' | gpg --trust-model always -ear salt@ngxbot.nginx.org

`S3cr1t` as used in the previous command must be a hash of a password, use
mkpasswd to generate it.

Salt Deployment
---------------

Salt is responsible for configuring the server, including:

- IRC Bot (ngxbot)
- Pastebin Web Service (& API)
- Automated Data Backup

Usage::

    wget https://raw.githubusercontent.com/ngx/ngxbot-host/master/deploy
    bash deploy
