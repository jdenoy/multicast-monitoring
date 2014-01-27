#!/usr/bin/perl
    use strict;
    use warnings;
    my $dir = './';
    opendir(DIR, $dir) or die $!;
    while (my $file = readdir(DIR)) {
        next unless (-f "$dir/$file");
        next unless ($file =~ m/\.stats$/);
		printf("Generating IO Graph for ".$file."\n");
		system('perl parse.pl '.$file);
		system('perl parse2.pl '.$file);
        print "$file\n";
    }
    closedir(DIR);
    exit 0;