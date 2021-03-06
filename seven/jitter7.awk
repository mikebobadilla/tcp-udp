#This program is used to calculate the jitters for CBR

# Usage: gawk -f example3jitter.awk example3.tr

# jitter ＝((recvtime(j)-sendtime(j))-(recvtime(i)-sendtime(i)))/(j-i), j > i


BEGIN {

# Initialization
time1 = 0.0;
time2 = 0.0;
highest_packet_id = 0;

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



	if ( packet_id > highest_packet_id && flow_id == 70190) {
		highest_packet_id = packet_id;
	}


	#Record the transmission time

	printf("%f\n", start_time[packet_id])

	if ( start_time[packet_id] == 0 ) {

		# Record the sequence number

		start_time[packet_id] = time;

		pkt_seqno[packet_id] = seq_no;
	}


	#Record the receiving time for CBR (flow_id=2)

	if ( flow_id == 070190 && action != "d" ) {

		if ( action == "r" ) {

			end_time[packet_id] = time;

		}

		} else {

			end_time[packet_id] = -1;

		}

		time1 = time;
}


END {

last_seqno = 0;

last_delay = 0;

seqno_diff = 0;


for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {

start = start_time[packet_id];

end = end_time[packet_id];

packet_duration = end - start;


if ( start < end ) {

seqno_diff = pkt_seqno[packet_id] - last_seqno;

delay_diff = packet_duration - last_delay;

if (seqno_diff == 0) {

jitter =0;

} else {

jitter = delay_diff/seqno_diff;

}

printf("%f \t %f\n", start, jitter) > "7to19jitter.xls";

last_seqno = pkt_seqno[packet_id];

last_delay = packet_duration;

}

}

}
