#!/usr/bin/perl
use threads;
my $chaine1 = $ARGV[0];
my $port1 = $ARGV[1];
my $chaine2 = $ARGV[2];
my $port2 = $ARGV[3];
$thr1 = threads->create('msc', 'perl ./check.multicast.pl '.$chaine1.' '.$port1);
$thr2 = threads->create('msc', 'perl ./check.multicast.pl '.$chaine2.' '.$port2);

$thr1->join();
$thr2->join();

sub msc{ ## make system call
  system( @_ );
}