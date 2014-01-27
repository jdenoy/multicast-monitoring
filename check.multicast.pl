#!/usr/bin/perl
 use strict;
 use IO::Socket::Multicast;
 use Time::Piece;

 die "Usage: $0 MULTICAST_GROUP MULTICAST_GROUP_UDP_PORT\n" if @ARGV < 2;
 my $system = $^O;
 my ($group,$port)  = @ARGV;
 my $time = localtime->strftime('%Y-%m-%d_%H-%M');
 my $sock = IO::Socket::Multicast->new(Proto=>'udp',LocalPort=>$port);
 printf("System : ".$system."\n");
 if ($system eq "linux") {
	printf("Joining ".$group."\n");
	$sock->mcast_add($group,'eth0') || die "Couldn't set group: $!\n";
	printf("Getting data on ".$group."\n");	
	system('tcpdump -s0 -i eth0 -G 180 -W 1 -w '.$group.'-'.$time.'.pcap host '.$group);
} else {
	printf("Joining ".$group."\n");
	$sock->mcast_add($group) || die "Couldn't set group: $!\n";
	printf("Getting data on ".$group."\n");	
	system('tshark  -i 1 -s0 -a duration:180 host '.$group.' -w '.$group.'-'.$time.'.pcap');
}
 printf("Analyzing ".$group."\n");
 system('tshark -q -r '.$group.'-'.$time.'.pcap -z io,stat,"0,01" >'.$group.'-'.$time.'.stats');
 printf("Generating IO Graph for ".$group."\n");
 system('perl ./parse.pl '.$group.'-'.$time.'.stats');
 system('perl ./parse2.pl '.$group.'-'.$time.'.stats');
 printf("Leaving ".$group."\n");
 $sock->mcast_drop($group);
