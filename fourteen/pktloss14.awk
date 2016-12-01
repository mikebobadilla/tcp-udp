# This program is used to calculate the packet loss rate for CBR program
# Usage: $gawk –f example3pktloss.awk example3.tr




BEGIN {

# Initialization. Set two variables. fsDrops: packets drop. numFs: packets sent

fsDrops = 0;

numFs = 0;

}

{

action = $1;

time = $2;

from = $3;

to = $4;

type = $5;

pktsize = $6;

flow_id = $8;

src = $9;

dst = $10;

seq_no = $11;

packet_id = $12;

#number of packets sent from node 14 to 27
if (flow_id==140270 && action == "+")

numFs++;

#number of packets dropped from node 14 to 27
if (flow_id==140270 && action == "d")

fsDrops++;

}

END {

printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}
