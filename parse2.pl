#!/usr/bin/perl
use GD::Graph;
use GD::Graph::lines;
use GD::Graph::colour; 
use GD::Graph::Data; 

my $file = $ARGV[0];
open FILE, "<", $file or die $!;
my @out;
my @g_time;
my @g_frames;
my @g_bytes;
my @g_diff_frames;
my $data;
my $max_frames;
my $min_frames;
my $old_frames;
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
	$diff_frame=abs($old_frames-$frames);
	push @g_time,$time."";
	push @g_frames,$frames.",";
	push @g_bytes, $bytes.",";
	push @g_diff_frames,$diff_frame.",";
	$old_frames=$frames;
	}
}
close (FILE);

my $title = $file;
$title =~s/.stats//g;
$title =~s/-20/ - 20/g;
$title =~s/_/ /g;
my @out=([@g_time],[@g_frames],[@g_diff_frames]);
my $graph = GD::Graph::lines->new(2048, 400);
$graph->set( 
      x_label           => 'Temp',
      y_label           => 'Packet par 0.01 sec',
      title             => 'IO Graph 0.01 - '.$title,
      y_max_value       => $max_frames+2,
	  y_min_value		=> $min_frames-2,
      y_tick_number     => $max_frames+2,
      y_label_skip      => 1,
	  x_label_skip		=> 500,
	  x_labels_vertical => 1,
	  line_types 		=> [ 1, 3],
	  line_width 		=> 1,
	  dclrs 			=> [ qw( green red )],
	  transparent 		=> 0
  ) or die $graph->error;
  $graph->set_legend( 'Packet par 0.01 sec','Intergap moyen en ms par 0.01 sec' );
my $gd = $graph->plot(\@out) or die $graph->error;
$img_filename=$file;
$img_filename =~s/stats/png/;
open(IMG, '>cpx1.'.$img_filename) or die $!;
binmode IMG;
print IMG $gd->png;
close IMG;