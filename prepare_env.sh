{% if myhome is defined %}
export MYHOME="{{ myhome }}"
{% else %}
export MYHOME="/root/packetgen"
{% endif %}

export RTE_SDK=$MYHOME/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc

if [ "$(lsmod | grep igb_uio)" == "" ]; then
  modprobe uio
  insmod $MYHOME/dpdk/x86_64-native-linuxapp-gcc/kmod/igb_uio.ko
fi

{% for port in pciid_list %}
python $MYHOME/dpdk/usertools/dpdk-devbind.py -b igb_uio {{ port }}
{% endfor %}


if [ -d "/sys/devices/system/node/node0" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
fi

if [ -d "/sys/devices/system/node/node1" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo 1024 > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
fi



