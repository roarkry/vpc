ip rule add from 104.237.141.105 table 128
ip route add table 128 to 104.237.141.0/24 dev eth0
ip route add table 128 default via 104.237.141.1
