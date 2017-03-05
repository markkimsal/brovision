os/pkg-install-apt.sh
----
Install groups of packages with apt-get instally -y

```
declare -a BRO\_PACKAGES=()
BRO\_PACKAGES+=('git')
BRO\_PACKAGES+=('nginx php7.0-fpm')
#this will cause apt-get update
BRO_PKG_MGR_UPDATE=1  
```

os/set-hostname.sh
---
Sets the hostname in 3 ways:

 - calls hostname
 - echos to /etc/hostname
 - replaces 127.0.1.1 line in /etc/hosts

```
BRO\_HOSTNAME=myhost
```
