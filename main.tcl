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

#create nodes
for {set i 0} {$i <= 28} {incr i} {
        set n($i) [$ns node]
}

### CREATE LINKS ### 

# Orange Links --------------------------------------------------------

#links between 0 --> 13,14,15,16

#links between 1 --> 7,8,9,10,11,12

#links between 4 --> 17,18,19,20

#links between 5 --> 21,22,23,24

#links between 6 --> 25,26,27,28

# Purple Links ---------------------------------------------------------

#link between 2 and 4

#link between 3 --> 5, 6

# Black Link -----------------------------------------------------------

#links between 0 --> 1 --> 3 --> 2 --> 0

### CREATE AGENTS ###

# CREATE UDP AGENTS

# number 7
set udp0 [new Agent/UDP]
$ns attach-agent $n7 $udp0

# number 14
set udp1 [new Agent/UDP]
$ns attach-agent $n14 $udp1

# CREATE TCP AGENTS

# number 12
set tcp0 [new Agent/TCP]
$ns attach-agent $n12 $tcp0

# number 13
set tcp1 [new Agent/TCP]
$ns attach-agent $n13 $tcp1

### CREATE LOSS MONITORS ###

# Red
set sink0 [new Agent/LossMonitor]
set sink1 [new Agent/LossMonitor]
set sink2 [new Agent/LossMonitor]
set sink3 [new Agent/LossMonitor]
set sink4 [new Agent/LossMonitor]
set sink5 [new Agent/LossMonitor]
set sink6 [new Agent/LossMonitor]
set sink7 [new Agent/LossMonitor]
# Blue
set sink8 [new Agent/LossMonitor]
set sink9 [new Agent/LossMonitor]
set sink10 [new Agent/LossMonitor]
set sink11 [new Agent/LossMonitor]
set sink12 [new Agent/LossMonitor]
set sink13 [new Agent/LossMonitor]
set sink14 [new Agent/LossMonitor]
# Green
set sink15 [new Agent/LossMonitor]
set sink16 [new Agent/LossMonitor]


# CREATE TRAFFIC SOURCES

# create cbr over udp traffic --> #7 (time 1)
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1500
$cbr0 set interval_ 0.005
$cbr0 set random_ 1
$cbr0 attach-agent $udp0

# create exp over udp traffic --> #24 (time 2)
set exp0 [new Application/Traffic/Exponential]
$exp0 set packetSize_ 2000
$exp0 set burst_time_ 0.5s
$exp0 set idle_time_ 0.5s
$exp0 set rate_ 2000k
$exp0 attach-agent $udp1

# create cbr over tcp traffic --> #12 (time 3) & #13 (time 4)
set cbr1 [new Application/Traffic/TCP]
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.005
$cbr1 set random_ 1
$cbr1 attach-agent $tcp0

set cbr2 [new Application/Traffic/TCP]
$cbr2 set packetSize_ 1000
$cbr2 set interval_ 0.005
$cbr2 set random_ 1
$cbr2 attach-agent $tcp1


#### USE FOR TIME 6 #### CODE FROM EXAMPLE 4 --> REMOVE BEFORE SUBMITTING ####
#Schedule events for the CBR agent and the network dynamics
# $ns at 0.5 "$cbr0 start"
# $ns rtmodel-at 1.0 down $n(1) $n(2)
# $ns rtmodel-at 2.0 up $n(1) $n(2)
# $ns at 4.5 "$cbr0 stop"
# Call the finish procedure after 5 seconds of simulation time
# $ns at 5.0 "finish"
