set ns [new Simulator]

set logfile [open "results.data" w]
$ns trace-all $logfile

set n0 [$ns node]
set n1 [$ns node]

$ns simplex-link $n0 $n1 2Mb 10ms DropTail

set udp00 [new Agent/UDP]
set udp10 [new Agent/Null]
$udp00 set fid_ 0
$udp10 set fid_ 0
$ns attach-agent $n0 $udp00
$ns attach-agent $n1 $udp10
$ns connect $udp00 $udp10

set udp01 [new Agent/UDP]
set udp11 [new Agent/Null]
$udp01 set fid_ 1
$udp11 set fid_ 1
$ns attach-agent $n0 $udp01
$ns attach-agent $n1 $udp11
$ns connect $udp01 $udp11

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp00

set cbr1 [new Application/Traffic/CBR]
$cbr1 set rate_ 1.8Mb
$cbr1 set packetSize_ 450
$cbr1 set maxpkts_ 5000
$cbr1 attach-agent $udp01

$ns at 5.0 "$cbr0 start"
$ns at 15.0 "$cbr1 start"
$ns at 30.0 "$cbr0 stop"
$ns at 30.0 "$cbr1 stop"
$ns at 30.0 "$ns flush-trace"
$ns at 32.0 "close $logfile"
$ns at 33.0 "$ns halt"

$ns run
