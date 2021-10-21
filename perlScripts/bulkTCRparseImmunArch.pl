#!/usr/bin/perl 

use warnings;

if (@ARGV < 2) {
	print STDERR "\nUsage: scTCRparseImmunArch.pl <immunarch data table> <output directory> <analysis name>\n";
	print STDERR "Program parsing the data from Immunarch output for custom plots like circos or triangles\n";
	print STDERR "Generates new file in the given output folder\n";
	print STDERR "\t\n";
	exit;
}

my $rand = rand();
my $inFile = $ARGV[0];
my $outDir = $ARGV[1];
my $analysisName = $ARGV[2];
my $outfile = $outDir . "/bulkTCR_IAcountTable." . $analysisName . ".txt";

# read in data from immunarch data file; 

open OUT, ">$outfile";
open IN, $inFile or die "Could not open file: \"$inFile\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	 	print OUT "clonotype_ID";
 	 	for ($i = 1; $i < @line ; $i++) {
			print OUT "\t$line[$i]";
			}
		print OUT "\n";

	} else {
		print OUT $line[3];
		print OUT "_$line[4]_$line[5]_$line[6]";
 	 	for ($i = 1; $i < @line ; $i++) {
			print OUT "\t$line[$i]";
			}
		print OUT "\n";
	}
}
close IN;
close OUT;

exit;
