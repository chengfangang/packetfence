This folder contains helper scripts to put in place "Monit" monitoring system configuration files related to PacketFence and dependant services to be monitored.

 * 00_packetfence.sh: Everything related to basic PacketFence

 * 10_packetfence-portsec.sh: Will add some checks for port-security related services

 * 20_packetfence-drbd.sh: Will add some checks for DRBD

 * 30_packetfence-activeactive.sh: Will add some checks for active-active clustering related services

Scripts will output result in /etc/monit.d/packetfence.monit
