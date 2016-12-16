# set the terminal, i.e., the figure format (eps) and font (Helvetica, 20pt)
set term postscript eps enhanced "Helvetica" 20 

# reset all options to default, just for precaution
reset

# set the figure size
set size 1.0,1.0

# set the figure name
set output "buffered.eps"

# set the x axis
set xlabel "Simulation time (s)"
set xrange [0:30]
set mxtics 2

# set the y axis
set mytics 2

# set the legend (boxed, on the left)
set key box left height 0.6

# set the grid (grid lines start from tics on both x and y axis)
set grid xtics ytics

# plot the data from the log file along with the theoretical curve
set ylabel "TX Delay (s)"
plot "< awk '$2 == 0 {print}' plot.data" u 1:7 w l t "CBR0" lc rgb "#AA0000", \
     "< awk '$2 == 1 {print}' plot.data" u 1:7 w l t "CBR1" lc rgb "#0000AA"

set ylabel "TX rate (kb/s)"
plot "< awk '$2 == 0 {print}' plot.data" u 1:4 w l t "CBR0" lc rgb "#AA0000", \
     "< awk '$2 == 1 {print}' plot.data" u 1:4 w l t "CBR1" lc rgb "#0000AA"

set yrange [0:0.1]
set autoscale ymax

set ylabel "Packet's losts in buffer"
plot "< awk '$2 == 0 {print}' plot.data" u 1:5 w l t "CBR0" lc rgb "#AA0000", \
     "< awk '$2 == 1 {print}' plot.data" u 1:5 w l t "CBR1" lc rgb "#0000AA"
set yrange [0:0.1]
set autoscale ymax
set ylabel "Packet's errors on link"
plot "< awk '$2 == 0 {print}' plot.data" u 1:6 w l t "CBR0" lc rgb "#AA0000", \
     "< awk '$2 == 1 {print}' plot.data" u 1:6 w l t "CBR1" lc rgb "#0000AA"
