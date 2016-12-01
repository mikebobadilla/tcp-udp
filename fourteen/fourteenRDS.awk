# This program is used to calculate the total packets sent
# Usage: $gawk –f example3pktloss.awk example3.tr




BEGIN {

# Initialization. Set two variables. fsDrops: packets drop. numFs: packets sent

fsDrops = 0;
numFs = 0;
time1 = 0;
time2 = 0;

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

time2 = time;

if (flow_id==140270 && action == "+")
  numFs++;

if (flow_id==140270 && action == "d")
  fsDrops++;

if(time2 - time1 > 0.5)
{
  receieved = numFs - fsDrops;
  printf("%f \t %f\n", time, numFs) > "14sent.xls";
  printf("%f \t %f\n", time, fsDrops) > "14dropped.xls";
  printf("%f \t %f\n", time, receieved) > "14receieved.xls";
  numFs = 0;
  fsDrops = 0;
  time1 = time;
}

}

END {

printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}
