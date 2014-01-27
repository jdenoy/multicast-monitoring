#!/usr/bin/perl
use GD::Graph;
use GD::Graph::lines;
my $file = $ARGV[0];
open FILE, "<", $file or die $!;
my @out;
my @g_time;
my @g_frames;
my @g_bytes;
my $data;
my $max_frames;
my $min_frames;
while (<FILE>) {
 $data=$_;
 if ($data =~ /<>/ ) {
	$data =~ s/\|/\;/g;
	my ($dumpa,$time,$frames,$bytes,$dumpb) = split(/;/,$data);
	$time =~ s/^\s+|\s+$//g;
	$frames =~ s/^\s+|\s+$//g;
	$bytes =~ s/^\s+|\s+$//g;
	if ($frames > $max_frames) {$max_frames=$frames;}
	if ($frames < $min_frames) {$min_frames=$frames;}
	push @g_time,$time."";
	push @g_frames,$frames.",";
	push @g_bytes, $bytes.",";
	}
}
close (FILE);

my $title = $file;
$title =~s/.stats//g;
$title =~s/-20/ - 20/g;
$title =~s/_/ /g;
my @out=([@g_time],[@g_frames]);
my $graph = GD::Graph::lines->new(2048, 400);
$graph->set( 
      x_label           => 'Temp',
      y_label           => 'Packet par 0.01 sec',
      title             => 'IO Graph 0.01 - '.$title,
      y_max_value       => $max_frames+2,
	  y_min_value		=> $min_frames-2,
      y_tick_number     => 8,
      y_label_skip      => 2,
	  x_label_skip		=> 500,
	  x_labels_vertical => 1,
	  transparent 		=> 0
  ) or die $graph->error;
my $gd = $graph->plot(\@out) or die $graph->error;
$img_filename=$file;
$img_filename =~s/stats/png/;
open(IMG, '>'.$img_filename) or die $!;
binmode IMG;
print IMG $gd->png;
close IMG;