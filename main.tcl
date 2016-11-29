#
#	Authors:
# Mike Bobadilla
# Austin Miller
#
#
# At Time	1,	all	sources	on	7	start	to	generate	traffic
# At Time	2,	all	sources	on	14	start	to	generate	traffic
# At Time	3,	the	source	on	12	starts	to	generate	traffic
# At Time	4,	the	source	on	13	starts	to	generate	traffic
# At Time	6,	link	2-3	goes	Down,	refer	to	example4.tcl
# At Time	7,	link	2-3	goes	Up,	refer	to	example4.tcl
# At Time	10,	ns	stops
#
# Create	1	UDP	agent	and	1	CBR	traffic	generator	at	node	7	and	1
# LossMonitor	traffic	consumer	at	dest PER	RED	CONNECTION.
# Create	1	UDP	agent	and	1	EXP	traffic	generator	at	node	14	and	1
# LossMonitor	traffic	consumer	at	dest PER	BLUE	CONNECTION.
# Create	1	TCP	agent	and	1	CBR	traffic	generator	at	12	and	13	and	2
# LossMonitor	traffic	consumers	at	dest FOR	GREEN	CONNECTIONS.
# Create	several	traffic	generators	at	7	and	14,	one	for	each	blue	or	red
# connecNon.	Create	2	consumers	at	28,	one	for	each	green	connecNon.
# Note:	Use	flowid	to	disNnguish	each	traffic	(a	flow	from	src	to	dst).

# create simulator
set ns [new Simulator]

# Tell the simulator to use dynamic routing
$ns rtproto DV

# create trace file
set tracefd [open main.tr w]
$ns trace-all $tracefd

#Define a 'finish' procedure
proc finish {} {
        global ns nf

        $ns flush-trace
 #Close the trace file
 #       close $nf

        exit 0
}

#create nodes

for {set i 0} {$i < 29} {incr i} {
        set n($i) [$ns node]
}

### CREATE LINKS ###

# Orange Links --------------------------------------------------------

#links between 0 --> 13,14,15,16
$ns duplex-link $n(0) $n(13) 1Mb 20ms DropTail
$ns queue-limit $n(0) $n(13) 10

$ns duplex-link $n(0) $n(14) 1Mb 20ms DropTail
$ns queue-limit $n(0) $n(14) 10

$ns duplex-link $n(0) $n(15) 1Mb 20ms DropTail
$ns queue-limit $n(0) $n(15) 10

$ns duplex-link $n(0) $n(16) 1Mb 20ms DropTail
$ns queue-limit $n(0) $n(16) 10

#links between 1 --> 7,8,9,10,11,12
$ns duplex-link $n(1) $n(7) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(7) 10

$ns duplex-link $n(1) $n(8) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(8) 10

$ns duplex-link $n(1) $n(9) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(9) 10

$ns duplex-link $n(1) $n(10) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(10) 10

$ns duplex-link $n(1) $n(11) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(11) 10

$ns duplex-link $n(1) $n(12) 1Mb 20ms DropTail
$ns queue-limit $n(1) $n(12) 10

#links between 4 --> 17,18,19,20
$ns duplex-link $n(4) $n(17) 1Mb 20ms DropTail
$ns queue-limit $n(4) $n(17) 10

$ns duplex-link $n(4) $n(18) 1Mb 20ms DropTail
$ns queue-limit $n(4) $n(18) 10

$ns duplex-link $n(4) $n(19) 1Mb 20ms DropTail
$ns queue-limit $n(4) $n(19) 10

$ns duplex-link $n(4) $n(20) 1Mb 20ms DropTail
$ns queue-limit $n(4) $n(20) 10

#links between 5 --> 21,22,23,24
$ns duplex-link $n(5) $n(21) 1Mb 20ms DropTail
$ns queue-limit $n(5) $n(21) 10

$ns duplex-link $n(5) $n(22) 1Mb 20ms DropTail
$ns queue-limit $n(5) $n(22) 10

$ns duplex-link $n(5) $n(23) 1Mb 20ms DropTail
$ns queue-limit $n(5) $n(23) 10

$ns duplex-link $n(5) $n(24) 1Mb 20ms DropTail
$ns queue-limit $n(5) $n(24) 10

#links between 6 --> 25,26,27,28
$ns duplex-link $n(6) $n(25) 1Mb 20ms DropTail
$ns queue-limit $n(6) $n(25) 10

$ns duplex-link $n(6) $n(26) 1Mb 20ms DropTail
$ns queue-limit $n(6) $n(26) 10

$ns duplex-link $n(6) $n(27) 1Mb 20ms DropTail
$ns queue-limit $n(6) $n(27) 10

$ns duplex-link $n(6) $n(28) 1Mb 20ms DropTail
$ns queue-limit $n(6) $n(28) 10

# Purple Links ---------------------------------------------------------

#link between 2 and 4
$ns duplex-link $n(2) $n(4) 2Mb 40ms DropTail
$ns queue-limit $n(2) $n(4) 15

#link between 3 --> 5, 6
$ns duplex-link $n(3) $n(5) 2Mb 40ms DropTail
$ns queue-limit $n(3) $n(5) 15

$ns duplex-link $n(3) $n(6) 2Mb 40ms DropTail
$ns queue-limit $n(3) $n(6) 15

# Black Link -----------------------------------------------------------

#links between 0 --> 1 --> 3 --> 2 --> 0
$ns duplex-link $n(0) $n(1) 8Mb 50ms DropTail
$ns queue-limit $n(0) $n(1) 20

$ns duplex-link $n(1) $n(3) 8Mb 50ms DropTail
$ns queue-limit $n(1) $n(3) 20

$ns duplex-link $n(3) $n(2) 8Mb 50ms DropTail
$ns queue-limit $n(3) $n(2) 20

$ns duplex-link $n(2) $n(0) 8Mb 50ms DropTail
$ns queue-limit $n(2) $n(0) 20

### CREATE AGENTS ###

# CREATE UDP AGENTS

# number 7
set udp0 [new Agent/UDP]
$ns attach-agent $n(7) $udp0

# number 14
set udp1 [new Agent/UDP]
$ns attach-agent $n(14) $udp1

# CREATE TCP AGENTS

# number 12
set tcp0 [new Agent/TCP]
$ns attach-agent $n(12) $tcp0

# number 13
set tcp1 [new Agent/TCP]
$ns attach-agent $n(13) $tcp1

### CREATE LOSS MONITORS ###

# Red
set sink0 [new Agent/LossMonitor]
$ns attach-agent $n(15) $sink0
set sink1 [new Agent/LossMonitor]
$ns attach-agent $n(16) $sink1
set sink2 [new Agent/LossMonitor]
$ns attach-agent $n(17) $sink2
set sink3 [new Agent/LossMonitor]
$ns attach-agent $n(19) $sink3
set sink4 [new Agent/LossMonitor]
$ns attach-agent $n(21) $sink4
set sink5 [new Agent/LossMonitor]
$ns attach-agent $n(24) $sink5
set sink6 [new Agent/LossMonitor]
$ns attach-agent $n(25) $sink6
set sink7 [new Agent/LossMonitor]
$ns attach-agent $n(26) $sink7
# Blue
set sink8 [new Agent/LossMonitor]
$ns attach-agent $n(8) $sink8
set sink9 [new Agent/LossMonitor]
$ns attach-agent $n(9) $sink9
set sink10 [new Agent/LossMonitor]
$ns attach-agent $n(11) $sink10
set sink11 [new Agent/LossMonitor]
$ns attach-agent $n(18) $sink11
set sink12 [new Agent/LossMonitor]
$ns attach-agent $n(20) $sink12
set sink13 [new Agent/LossMonitor]
$ns attach-agent $n(23) $sink13
set sink14 [new Agent/LossMonitor]
$ns attach-agent $n(27) $sink14
# Green
set sink15 [new Agent/LossMonitor]
$ns attach-agent $n(28) $sink15
set sink16 [new Agent/LossMonitor]
$ns attach-agent $n(28) $sink16

# CREATE TRAFFIC SOURCES

# create cbr over udp traffic --> #7 (time 1)
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1500
$cbr0 set interval_ 0.005
$cbr0 set random_ 1
$cbr0 attach-agent $udp0

# create exp over udp traffic --> #14 (time 2)
set exp0 [new Application/Traffic/Exponential]
$exp0 set packetSize_ 2000
$exp0 set burst_time_ 0.5s
$exp0 set idle_time_ 0.5s
$exp0 set rate_ 2000k
$exp0 attach-agent $udp1

# create cbr over tcp traffic --> #12 (time 3) & #13 (time 4)
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.005
$cbr1 set random_ 1
$cbr1 attach-agent $tcp0

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 1000
$cbr2 set interval_ 0.005
$cbr2 set random_ 1
$cbr2 attach-agent $tcp1

#Connect the traffic source with the "consumer"

#UDP0 / RED
$ns connect $udp0 $sink0
$ns connect $udp0 $sink1
$ns connect $udp0 $sink2
$ns connect $udp0 $sink3
$ns connect $udp0 $sink4
$ns connect $udp0 $sink5
$ns connect $udp0 $sink6
$ns connect $udp0 $sink7

#UDP1 / BLUE
$ns connect $udp1 $sink8
$ns connect $udp1 $sink9
$ns connect $udp1 $sink10
$ns connect $udp1 $sink11
$ns connect $udp1 $sink12
$ns connect $udp1 $sink13
$ns connect $udp1 $sink14

#TCP0 and TCP1 / GREEN

$ns connect $tcp0 $sink15
$ns connect $tcp1 $sink16

#### USE FOR TIME 6 #### CODE FROM EXAMPLE 4 --> REMOVE BEFORE SUBMITTING ####
#Schedule events for the CBR agent and the network dynamics
$ns at 1 "$cbr0 start"
$ns at 10 "$cbr0 stop"

$ns at 3 "$cbr1 start"
$ns at 10 "$cbr1 stop"

$ns at 4 "$cbr2 start"
$ns at 10 "$cbr2 stop"

$ns at 2 "$exp0 start"
$ns rtmodel-at 6.0 down $n(2) $n(3)
$ns rtmodel-at 7.0 up $n(2) $n(3)
$ns at 10 "$exp0 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 10.0 "finish"
$ns run
