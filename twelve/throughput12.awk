# This program is used to calculate throughput
# Usage: $gawk –f example3pktloss.awk example3.tr

#Throughput = amount of data per second that can be transferred
#Rate = bits/second
#File size = F
#Total time to revieve all bits = T
#Average Throughput = F/T * Rate


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

#some amazing math stuff goes here

}

END {

#print the throughput
#printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}