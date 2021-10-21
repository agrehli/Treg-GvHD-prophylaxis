#!/usr/bin/perl 

use warnings;

if (@ARGV < 2) {
	print STDERR "\nUsage: scTCRcreateTRBVCountTable.pl <10X outs directory - input> <output directory> <analysis name>\n";
	print STDERR "Program filtering and combining the TRBV segement information of clonotype files from cell ranger output\n";
	print STDERR "Generates new file in the given output folder\n";
	
	print STDERR "\t\n";
	exit;
}

# my $R="/misc/software/package/RBioC/3.4.3/bin/R" ;

my $rand = rand();
my $primDir = $ARGV[0];
my $outDir = $ARGV[1];
my $analysisName = $ARGV[2];
my $inFile = $primDir . "/filtered_contig_annotations.csv" ;
my $outfile = $outDir . "/scTRBVcountTable." . $analysisName . ".txt";
my $tmpFile1 = $rand . ".file1.txt" ;
my $tmpFile2 = $rand . ".file2.txt" ;
my $tmpFile1s = $rand . ".file1s.txt" ;
my $barcode = "x";
my $tab = "\t";

# read in data from clonotypes file; filter for top TRB is multiple with same barcode

open OUT, ">$tmpFile1";
open IN, $inFile or die "Could not open file: \"$inFile\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[,]+/;
 	if ($. == 1) {
 	 	print OUT $line[0];
 		print OUT "\tv_gene\tcount\n";
	} else {
		if ($line[5] eq "TRB" && $line[0] ne $barcode) {
#		if ($line[5] eq "TRB") {
			print OUT $line[0];
			print OUT "\t$line[6]\t1\n";
			$barcode = $line[0];
			}
	}
}
close IN;
close OUT;

# sort file

   	`(head -n 1 $tmpFile1 && tail -n +2 $tmpFile1 | sort -k 2,2) > $tmpFile1s `;

# count csegments

open OUT, ">$tmpFile2";
open IN, $tmpFile1s or die "Could not open file: \"$tmpFile1s\"\n";

my $counter = 0;
while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	 	print OUT $line[1];
 		print OUT "\tcount\n";
 	} elsif ($. == 2) {
 		for ($i = 0; $i < @line ; $i++) {
 			$preline[$i] = $line[$i];
 				}
	} else {
		if ($preline[1] eq $line[1]) {
			$preline[2] = $preline[2] + $line[2];
			$counter++;

		} else {
	 		print OUT $preline[1];
	 		print OUT "\t$preline[2]\n";				
			for ($i = 0; $i < @line ; $i++) {
 				$preline[$i] = $line[$i];
 				}
		}
	}
}

print OUT $preline[1];
print OUT "\t$preline[2]\n";				

print STDERR "\n\tcounted TRBV segments\n";
close IN;
close OUT;

   	`(head -n 1 $tmpFile2 && tail -n +2 $tmpFile2 | sort -k 1,1) > $outfile `;




#removing temporary files
	`rm $rand.* `;

exit;
