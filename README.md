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


Node specific tasks
----
Sometimes you have a script that is not applicable to any other host.  Maybe it has passwords in it.  Maybe it is for a specific architecture that you cannot make generic.  In these cases, you can put the file into a "tasks/" folder in your node groups.


```
brovision.sh
├── tasks
│   └── os
│       └── set-hostname.sh
├── nodes
│   ├── MYSERVERS #separate git repo
│   │    ├── my-rpi.sh
│   │    └── tasks/
│   │       └── install-repozytorium.sh

```

In the above case, install-repozytorium is really only applicable to raspberry-pi devices.  Trying to make a generic repo adding task is not very rewarding.  We can call this task directly in the my-rpi.sh node file:


```
#nodes/MYSERVERS/my-rpi.sh

declare -a TASKS=()
TASKS+=('install-repozytorium.sh')
```

Notice that we include the file extension ".sh".  The brovision.sh file will examine any "tasks/" folder under the directory which holds the specified node file.  If it cannot find a file there, it seeks to look under tasks/*/*.sh.

Basically:
  - refer to just the file with .sh extension for custom task files
  - but, refer to directory or directory/task.sh for generic tasks.
