#!yaml|gpg

ngxbot:
  homedir: /opt/ngxbot
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

  # Note: maintain same list order
  botusers:
    - username: MTecknology
      capabilities:
        - "owner"
      hostmasks:
        - "*@user/mtecknology"
        - "*@mtecknology.user.oftc.net"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdAwqJNJpbJcpXU7DcSM3Xze+PPN9PTghDJ7ogPZ3+rIUsw
          b0QUXByaOYpbNOpbgpg1eyXUh/q1NkjRSpIiz91R8AwT2+3j075rkesRDCn0h9dz
          0moBwbhib7aR2ySJbiae9R+CRZYY2n/UFi70uLmSwjh50TLr7BTvUD6TgYIvQIJn
          RhNozOmijaxtbFw9KCdHNz6MtVNV1TXR7qnrlw8zSLdPZzrEJ4Fo9MJPS5pmdx8r
          ZbMsn171objKUpFe
          =RoQd
          -----END PGP MESSAGE-----
    - username: NginxOps
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
      hostmasks:
        - "*@user/Peng"
        - "*@videolan/developer/thresh"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdACL0cHoi9av+MK1GtafAl9NvomCzWNX1uca/5KwtE1zww
          2BN1ZasKa9NThf6YvMVBPrzhpyegH9q4sO8bKUkp8H21OYLVfUscfb7JcA0ISf0D
          0mkBu30sTV3WIUHelHeryph7oQh3N8OKz2v9+btr6ubOUmrZDRqQUEpqKR2IzZs0
          3CHFh8zEZzg3L52js64qj0W6S0cvVd5vfIiWyQpGvs1/wK1qIUAvI65BMqtAjfoP
          bPY5H1ZMy3MGXKE=
          =DUVm
          -----END PGP MESSAGE-----
    - username: SaltOps
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
      hostmasks:
        - "*@user/gtmanfred"
      password: |
          -----BEGIN PGP MESSAGE-----

          hF4DmUPsRBokU2cSAQdACL0cHoi9av+MK1GtafAl9NvomCzWNX1uca/5KwtE1zww
          2BN1ZasKa9NThf6YvMVBPrzhpyegH9q4sO8bKUkp8H21OYLVfUscfb7JcA0ISf0D
          0mkBu30sTV3WIUHelHeryph7oQh3N8OKz2v9+btr6ubOUmrZDRqQUEpqKR2IzZs0
          3CHFh8zEZzg3L52js64qj0W6S0cvVd5vfIiWyQpGvs1/wK1qIUAvI65BMqtAjfoP
          bPY5H1ZMy3MGXKE=
          =DUVm
          -----END PGP MESSAGE-----
