# This program is used to calculate throughput

BEGIN {
   node = 27;
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > 0.5) {
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
   print("----------");
   printf("Total number of packets received: \n%d\n", num_packets);
   print("----------");
}
