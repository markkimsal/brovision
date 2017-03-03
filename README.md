Master-less Server Provisioning with Bash
=========
Start provisioning your servers and images without the steep learning curve.


Start
---
Start by defining a node to be provisioned.
```
mkdir -p nodes/myservers/
echo -e "SSH_HOST=192.168.1.x
SSH_PORT=22
SSH_USER=pi
declare -a TASKS=('ping')
" > nodes/myservers/raspberry_pi.sh
```

Test out the server connection with the ping task
```
./brovision.sh raspberry_pi
```

Variables
---
Variables defined in your node file are pre-pended to any task being sent to the node.
In this way you can use _source_ to arrange your settings and password files.


```
SSH_HOST=192.168.1.x
SSH_PORT=22
SSH_USER=pi

D=$(dirname "${BASH_SOURCE[0]}")
source $D/roles/mysql.sh
source $D/roles/nginx.sh
```

It is advisable to write all your tasks and source files to use the prefix BRO\_ for all variable names.
Trying to automatically determine the variables defined in a bash script is problamatic.  Only transfering variables
prefixed with BRO\_ could prove a more reliable method in the future.
