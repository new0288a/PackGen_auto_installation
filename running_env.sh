{% if myhome is defined %}
export MYHOME="{{ myhome }}"
{% else %}
export MYHOME="/root/packetgen"
{% endif %}

export RTE_SDK=$MYHOME/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
