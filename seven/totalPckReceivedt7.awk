# This program is used to calculate the total packets received
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


if (flow_id==70190 && action == "+")

numFs++;

if (flow_id==70190 && action == "d")

fsDrops++;

}

END {

printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}
