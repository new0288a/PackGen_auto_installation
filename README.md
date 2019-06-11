Introduction
===========================
This is DPDK PacketGen installation tools. It automate installation of PacketGen with ansible. 


****

## Requirement
- Target Hosts OS: Ubuntu
- Python should already be installed on target hosts
- Target Hosts can be access by root with SSH without password
- Target Hosts has to have two DPDK compatibility NIC


## How To Use
### Modify configuration file
___inventory___

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
  



___playbook.yml___

Specify the root directory of PacketGen. It will be create if it is not existed. If this var is not defined, the default value "/root/packetgen" will be used.
```
myhome: "/root/packetgen"
```  
  
Specify PCI ID of DPDK compability NIC to be used for PacketGen. If this var is not defined, all Intel port will be included.
```
pciid_list:
	- "03:00.0"
	- "03:00.1"
```  
  
Specify core id to be used for each port. If this var is not defined, (Number of port * 2 + 1) will be included in order. Please make sure the total num of core is enough for all port using. Each port consume two core.
```
numa_list:
	- "0" #The first one is reserved for master core.
	- "1"
	- "3" #core 1 and 3 will be configured on my_default.cfg for port0 using (like this "[1:3].0")
	- "4"
	- "7"
```  
  
### Install PacketGen on target hosts
Deploy PactetGen with ansible after modify configuration file.
```
ansible-playbook playbook.yml
```
  
### Running PacketGen
```
cd /root/packetgen/pktgen-dpdk/  #goto pktgen-dpdk under PacketGen root directory
source ../prepare_env.sh && ./tools/run.py my_default
```
