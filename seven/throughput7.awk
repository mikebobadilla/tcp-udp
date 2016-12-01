# This program is used to calculate throughput

BEGIN {
   node = 19;
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > 0.05) {
      throughput = bytes_counter / (time2 - time1);
      printf("%f \t %f\n", time2, throughput) > "throughput7.xls";
      time1 = $2;
      bytes_counter = 0;
   }

   #if event is recieve and to-node is node 19 and paket type is CBR
   if ($1 == "r" && $4 == node && $5 == "cbr") {
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
