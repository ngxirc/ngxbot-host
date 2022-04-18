#!yaml|gpg

ngxbot:

  # Note: maintain same list order
  botusers:

    # User 1
    - username: MTecknology
      hostmasks:
        - "*@user/mtecknology"
        - "*@mtecknology.user.oftc.net"
      capabilities:
        - "owner"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdAwqJNJpbJcpXU7DcSM3Xze+PPN9PTghDJ7ogPZ3+rIUsw
          b0QUXByaOYpbNOpbgpg1eyXUh/q1NkjRSpIiz91R8AwT2+3j075rkesRDCn0h9dz
          0moBwbhib7aR2ySJbiae9R+CRZYY2n/UFi70uLmSwjh50TLr7BTvUD6TgYIvQIJn
          RhNozOmijaxtbFw9KCdHNz6MtVNV1TXR7qnrlw8zSLdPZzrEJ4Fo9MJPS5pmdx8r
          ZbMsn171objKUpFe
          =RoQd
          -----END PGP MESSAGE-----

    # User 2
    - username: NginxOps
      hostmasks:
        - "*@user/Peng"
        - "*@videolan/developer/thresh"
        # test user
        - "*@2001:470:38fe:2:*"
      capabilities:
        # nginx
        - "#nginx,factoids.alias"
        - "#nginx,factoids.learn"
        - "#nginx,factoids.change"
        - "#nginx,factoids.forget"
        - "#nginx,pbinadmin"
        # nginx-social
        - "#ngx-social,factoids.alias"
        - "#ngx-social,factoids.learn"
        - "#ngx-social,factoids.change"
        - "#ngx-social,factoids.forget"
        - "#ngx-social,pbinadmin"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdACL0cHoi9av+MK1GtafAl9NvomCzWNX1uca/5KwtE1zww
          2BN1ZasKa9NThf6YvMVBPrzhpyegH9q4sO8bKUkp8H21OYLVfUscfb7JcA0ISf0D
          0mkBu30sTV3WIUHelHeryph7oQh3N8OKz2v9+btr6ubOUmrZDRqQUEpqKR2IzZs0
          3CHFh8zEZzg3L52js64qj0W6S0cvVd5vfIiWyQpGvs1/wK1qIUAvI65BMqtAjfoP
          bPY5H1ZMy3MGXKE=
          =DUVm
          -----END PGP MESSAGE-----

    # User 3
    - username: SaltOps
      hostmasks:
        - "*@user/gtmanfred"
        - "*@user/msmith"
        - "*@user/myii"
      capabilities:
        # salt
        - "#salt,factoids.alias"
        - "#salt,factoids.learn"
        - "#salt,factoids.change"
        - "#salt,factoids.forget"
        # salt-offtopic
        - "#salt-offtopic,factoids.alias"
        - "#salt-offtopic,factoids.learn"
        - "#salt-offtopic,factoids.change"
        - "#salt-offtopic,factoids.forget"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdACL0cHoi9av+MK1GtafAl9NvomCzWNX1uca/5KwtE1zww
          2BN1ZasKa9NThf6YvMVBPrzhpyegH9q4sO8bKUkp8H21OYLVfUscfb7JcA0ISf0D
          0mkBu30sTV3WIUHelHeryph7oQh3N8OKz2v9+btr6ubOUmrZDRqQUEpqKR2IzZs0
          3CHFh8zEZzg3L52js64qj0W6S0cvVd5vfIiWyQpGvs1/wK1qIUAvI65BMqtAjfoP
          bPY5H1ZMy3MGXKE=
          =DUVm
          -----END PGP MESSAGE-----

  homedir: /opt/ngxbot
  sshpub: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhhmoZ0PLO/kCDatClPYzujgCPVnXdAsqF4zD1bFUN1 ngxbot
  sshkey: |
      -----BEGIN PGP MESSAGE-----

      hF4DmUPsRBokU2cSAQdAlemFqZqNC6LW8HiUTLqv2U5ZBNwOUz6u5hsovxWuNzgw
      SNGTpiE2ub995DHRjZ/aqRDCskfycpJR2iOjTFnyatr+i7a6f5NzqrWK9+b2mNWB
      0sCFAZV3A+GlaVUTXNUYMWG/w+HOTgK/Sk/Ll3EgD1fO/SNr1TWatWneGDJ9wvFW
      uk904I8DrO4genhx78gbgJnIzK8bW+zbZCbcwUF5np6s55k7tcWv/7eaQN9yKBuU
      UVHSb3ANa4i6oTZu9CFkhvoS3Y+0R/iilZauJtW6OMPFn7ztr2IbRGA2QuBLs4jL
      F3SBKgzMOElcJ8JnFx8sFIvojmurjuWIWlBjpbf3LxWBEZXPUEbhiLwJbOj7bLI+
      MGTnImlzoaPDBP7V3wCHeBgKqaxqAX12tWC6H1RNIbukDy+nnpiDtY1JbhLhWTgy
      QyZ1ZL8yBcaVfea+XTs8FPID/uAvj1tqc5P2nXBOyVKsuJaNGFNvRmb9ZDOE4Sm2
      FYX/MQeJ9JRzpBuOwu1k/V6t8wYfR3gNDh0azzxomfhXS9FbaqLWZg==
      =wodv
      -----END PGP MESSAGE-----

  networks:
    libera:
      channels: "##eros-chat #nginx #ngx-social #salt #salt-offtopic"
      servers: irc.libera.chat:6667
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdAEXY1rB8Z4eX/BIRYKQ21KVLUlQfyD38W0Tc6HXvPzyww
          DGVLM887Gu3niBH6tjC9Belngwc0JvQVsRkeFQZlzUrtYtzaDZSbja/axlIzzDGL
          0lMBwRtUHDCTySwwDY66LFHYELH8n89TjZ3SLIn0kTo6sUubAKOT+sxVEwmkDtXc
          TVJuSfO97LR+VDeEcnCR6k7wboeWIcMuOoZYd4UOWYKQn7lmbQ==
          =xmhk
          -----END PGP MESSAGE-----
    oftc:
      channels: ""
      servers: irc.oftc.net:6667
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdAY5ufWnNbxLmbUrzMNxqVMchKm/ixIER9YJnwSqmJonww
          grng6T6iRW+/jyyiTaFe8z9SDWYaBdjAhg6kOzNdGNN3sJ8DBq61aLoAlnNV3zt8
          0lIBiDVujLwu0ebfaYKTOINBljWWPN0jYxu81g0c7cu1YCl/3F6jeENpAUg+rSWu
          mfyKA4AbifRTiXINtE+g6WP3r8TElAnamx8tjcKqFLtPzhqF
          =O9tX
          -----END PGP MESSAGE-----
