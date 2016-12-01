# This program is used to calculate throughput
# Usage: $gawk –f example3pktloss.awk example3.tr

#Throughput = amount of data per second that can be transferred
#Rate = bits/second
#File size = F
#Total time to revieve all bits = T
#Average Throughput = F/T * Rate


BEGIN {
   node = 27;
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > 0.05) {
      throughput = bytes_counter / (time2 - time1);
      printf("%f \t %f\n", time2, throughput) > "throughput14.xls";
      time1 = $2;
      bytes_counter = 0;
   }

   #if event is recieve and to-node is node 27 and paket type is EXP
   if ($1 == "r" && $4 == node && $5 == "exp") {
      #add packet size to bytes_counter
      bytes_counter += $6;
      num_packets++;
   }
}

END {

#print the throughput
#printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}

END {

#print the throughput
#printf("number of packets sent:%d lost:%d\n", numFs, fsDrops);

}
