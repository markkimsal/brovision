Master-less Server Provisioning with Bash
=========
Start provisioning your servers and images without the steep learning curve.


Start
---
Start by defining a node to be provisioned.
```
mkdir -p nodes/myservers/
echo -e "HOST=192.168.1.x
PORT=22
USER=pi
declare -a TASKS=('ping')
" > nodes/myservers/raspberry_pi.sh
```

Test out the server connection with the ping task
```
./brovision.sh raspberry_pi
```
