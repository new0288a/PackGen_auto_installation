Introduction
===========================
This is DPDK PacketGen installation tools. It automate installation of PacketGen with ansible. 


****

## Requirement
- Target Hosts OS: Ubuntu
- Python should already be installed
- Hosts can be access by root with SSH


## How To Use
### Modify configuration file
* inventory
Specify target host and login information here
```
[local_host:vars]
ansible_connection=ssh
ansible_user=root
ansible_ssh_pass=P@ssw0rd

[local_host]
10.5.95.76
10.5.97.88
```

* playbook.yml
Specify the root directory of PacketGen. It will be create if it is not existed. If this var is not defined, the default value "/root/packetgen" will be used.
```
myhome: "/root/packetgen"
```


Specify PCI ID of port to be used for PacketGen. If this var is not defined, all Intel port will be included.
```
pciid_list:
	- "03:00.0"
	- "03:00.1"
```


Specify core id to be used for each port. If this var is not defined, (Number of port * 2 + 1) will be included in order. Please make sure the total num of core is enough for all port using. Each port consume two core.
```
numa_list:
	- "0" #The first one is resurved for master core.
	- "1"
	- "3" #core 1 and 3 will be configured on my_default.cfg for port0 using (like this "[1:3].0")
	- "4"
	- "7"
```

