set ns [new Simulator]

set logfile [open "results.data" w]
$ns trace-all $logfile

set n0 [$ns node]
set n1 [$ns node]

$ns simplex-link $n0 $n1 2Mb 10ms DropTail

set udp0 [new Agent/UDP]
set udp1 [new Agent/Null]
$ns attach-agent $n0 $udp0
$ns attach-agent $n1 $udp1
$ns connect $udp0 $udp1

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp0

$ns at 5.0 "$cbr start"
$ns at 30.0 "$cbr stop"
$ns at 30.0 "$ns flush-trace"
$ns at 32.0 "close $logfile"
$ns at 33.0 "$ns halt"

$ns run
