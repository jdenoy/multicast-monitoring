multicast-monitoring
====================
REQUIREMENTS :
Needed perl library :

- GD::Graph
- GD::Graph::lines
- GD::Graph::colour
- GD::Graph::Data
- IO::Socket::Multicast
- Time::Piece

Needed softwares :
- tcpdump
- tshark

------------------------------
DESCRIPTIONS 

- check.multicast.pl  
	DESC : Analyse multicast trafic for 300 seconds, dumps stats using tshark, and generates io graphs for the dump
	USAGE : sudo perl ./check.multicast.pl MULTICAST_GROUP MULTICAST_GROUP_UDP_PORT
- gen_graph.pl 
	DESC : Generates io graphs for the stats file created using tshark
	USAGE : sudo perl ./gen_graph.pl
- monitor.pl  
	DESC : Analyse multicast trafic for 300 seconds, dumps stats using tshark, and generates io graphs for the dump, and keeps doing until interrupted.
	USAGE : sudo perl ./check.multicast.pl MULTICAST_GROUP MULTICAST_GROUP_UDP_PORT
- monitoring-compare.pl  
	DESC : Analyse two multicast trafic sources for 300 seconds, dumps stats using tshark, and generates io graphs for the dump.
	USAGE : sudo perl ./check.multicast.pl MULTICAST_GROUP_A MULTICAST_GROUP_UDP_PORT_A MULTICAST_GROUP_B MULTICAST_GROUP_UDP_PORT_B
- parse.pl  
	DESC : code to generate io graph, but should not be run alone
- parse2.pl
	DESC : code to generate io graph and add average intergap between packets every 10 msec, but should not be run alone