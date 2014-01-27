#!/usr/bin/perl
#monitor
my $chaine = $ARGV[0];
my $port = $ARGV[1];
while (1) {
	system('perl check.multicast.pl '.$chaine.' '.$port);
}