#!/usr/bin/perl 

use warnings;

if (@ARGV < 5) {
	print STDERR "\nUsage: scTCRcreateJoinedCountTable.pl <output dir> <output file name>\n";
	print STDERR "Program joining reformated IA clonotype count data from several samples into one table\n";
	print STDERR "\trequired:\n";
	print STDERR "\t-mergeFiles <scTCRcountTable files from scTCRcreateCountTable.pl> \n";
	print STDERR "\t-sampleNames <names for samples> (default: sample1, sample2, etc.) \n";
	print STDERR "\toptional:\n";
	print STDERR "\t-groupNames <group1 group1 group2 etc> generates sum column for each group in seperate columns\n";
	print STDERR "\t-norm <value> number of cells (in thousands) to normalize each sample to\n";
	print STDERR "\t\n";
	exit;
}

my $rand = rand();
my $outDir = $ARGV[0];
my $outfileName = $ARGV[1];
my $outfile = $outDir . "/" . $outfileName . ".clonotypeTable.txt";
my @sums =();

my @unionFiles =();
my @sortedUnionFiles =();
my @sampleNames =();
my @groupNames =();
my $namesGiven = 0;
my $groupsGiven = 0;
my $filecount = 0;
my $o = "";
my $tmpFileA1 = $rand . ".fileA1.txt" ;
my $tmpFileA1s = $rand . ".fileA1s.txt" ;
my $tmpFileC1 = $rand . ".fileC1.txt" ;
my $tmpFileC = $rand . ".fileC.txt" ;
my $tab = "\t";
my $sortcolumn = 0;
my $norm = 0;

for (my $i=0;$i<@ARGV;$i++) {
	if ($ARGV[$i] eq '-mergeFiles') {
		print STDERR "\n\tscTCR clonotype files:\n";
		my $bail = 0;
		while ($ARGV[++$i] !~ /^\-/) {
			push(@unionFiles, $ARGV[$i]);
			print STDERR "\t\t$ARGV[$i]\n";
			if ($i>=@ARGV-1) {
				$bail = 1;
				last;
			}
		}
		last if ($bail == 1);
		$i--;
	} elsif ($ARGV[$i] eq '-sampleNames') {
		$namesGiven = 1;
		print STDERR "\n\tsample names:\n";
		my $bail = 0;
		while ($ARGV[++$i] !~ /^\-/) {
			push(@sampleNames, $ARGV[$i]);
			print STDERR "\t\t$ARGV[$i]\n";
			if ($i>=@ARGV-1) {
				$bail = 1;
				last;
			}
		}
		last if ($bail == 1);
		$i--;
	} elsif ($ARGV[$i] eq '-groupNames') {
		$groupsGiven = 1;
		print STDERR "\n\tgroup names:\n";
		my $bail = 0;
		while ($ARGV[++$i] !~ /^\-/) {
			push(@groupNames, $ARGV[$i]);
			print STDERR "\t\t$ARGV[$i]\n";
			if ($i>=@ARGV-1) {
				$bail = 1;
				last;
			}
		}
		last if ($bail == 1);
		$i--;
 		} elsif ($ARGV[$i] eq '-norm') {
		$norm = $ARGV[++$i] ;
	}
}

if ($namesGiven == 0) {
	print STDERR "\n\tsample names:\n";
	for ($i = 0; $i < @unionFiles ; $i++) {
	$sampleNames[$i] = "sample" . ($i+1);
	print STDERR "\t\t$sampleNames[$i]\n";
	}
}


if (scalar(@unionFiles) != scalar(@sampleNames)) {
die " number of sample names and files don't match\n";
}

#sorting files for joining and replace whitespace with §

foreach $file ( @unionFiles ) {
#	$file =~ s/\R//g;
	$sortedUnionFiles[$filecount] = $filecount . $rand . ".bg.tmp" ;
   	`tail -n +2 $file | sort -k 1,1 > $sortedUnionFiles[$filecount] `;
   	$filecount++;
}

#join tables sequentially
	
	print STDERR "\n\tjoining files:\n";

	`cp -f $sortedUnionFiles[0] $tmpFileC1`;
	for ($i = 0; $i < (@sortedUnionFiles -1) ; $i++) {
	$o=$o . " -o 1." . ($i+2);
	$fileno = $i+2;
	print STDERR "\t\tadding file $fileno\n";
	if ($i==0){
	`join -a 1 -a 2 -e \"0\" -1 1 -2 1 -o 0 -o 1.2 -o 2.2 -t \"$tab\" $tmpFileC1 $sortedUnionFiles[($i+1)] > $tmpFileC`;
	} else {
	`join -a 1 -a 2 -e \"0\" -1 1 -2 1 -o 0 $o -o 2.2 -t \"$tab\" $tmpFileC1 $sortedUnionFiles[($i+1)] > $tmpFileC`;
	}
	`cp -f $tmpFileC $tmpFileC1`;
   	}

# add column with count sum


	print STDERR "\n\tadd count sum:\n";

open OUT, ">$tmpFileA1";
open IN, $tmpFileC1 or die "Could not open file: \"$tmpFileC1\"\n";


while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	$sum= 0;
 		print OUT $line[0];
 		for ($i = 1; $i <= ($filecount) ; $i++) {
 			print OUT "\t$line[$i]";
			$sum = $sum + $line[$i] ;
		}
	print OUT "\t$sum\n";
}
close IN;
close OUT;

	print STDERR "\n\tsorting and adding header\n";
	
$sortcolumn = $filecount +2 ;

   	`sort -k \"$sortcolumn\",\"$sortcolumn\"nr $tmpFileA1 > $tmpFileA1s `;

open OUT, ">$outfile";
open IN, $tmpFileA1s or die "Could not open file: \"$tmpFileA1s\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	print OUT "ID";
		for ($i = 1; $i <= ($filecount) ; $i++) {
				print OUT "\t$sampleNames[$i-1]";
			}
		print OUT "\ttotal\n";
	}
 	print OUT $line[0];
 	for ($i = 1; $i < ($sortcolumn) ; $i++) {
 			print OUT "\t$line[$i]";
		}
	print OUT "\n";
}
close IN;
close OUT;

if ($groupsGiven == 1) {

	print STDERR "\n\tgenerating group file\n";


my $outfile2 = $outDir . "/" . $outfileName . ".clonotypeTable.groups.txt";

open OUT, ">$outfile2";
open IN, $outfile or die "Could not open file: \"$outfile\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
		print OUT "ID";
		print OUT "\t$groupNames[0]";
		for ($i = 1; $i < ($filecount) ; $i++) {
			if ($groupNames[$i] ne $groupNames[$i-1]) {
				print OUT "\t$groupNames[$i]";
			}
		}
		print OUT "\ttotal\n";
	} else {
		print OUT "$line[0]";
		$gsum=$line[1];
		$sum=$line[1];
		for ($i = 1; $i < ($filecount) ; $i++) {
			if ($groupNames[$i] eq $groupNames[$i-1]) {
		    	$gsum = $gsum + $line[$i+1];
				$sum=$sum + $line[$i+1];
			} else {
				print OUT "\t$gsum";
				$sum=$sum + $line[$i+1];
		    	$gsum = $line[$i+1];
			}
		}
		print OUT "\t$gsum";
		print OUT "\t$sum\n";

	}
}
close IN;
close OUT;

}

if ($norm > 0) {

# normalizing table to 5K cells per sample

my $outfile3 = $outDir . "/scTCRcountTable." . $outfileName . ".norm5K.txt";


open IN, $outfile or die "Could not open file: \"$outfile\"\n";
while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	} else {
 		for ($i = 1; $i < @line ; $i++) {
 			$sums[$i] += $line[$i];
 				}
	}
}
close IN;


open OUT, ">$outfile3";
open IN, $outfile or die "Could not open file: \"$outfile\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	print OUT "ID";
		for ($i = 1; $i < @line ; $i++) {
				print OUT "\t$line[$i]";
			}
		print OUT "\n";
	} else {
 		$sum = 0;
 		print OUT $line[0];
		for ($i = 1; $i < (@line -1) ; $i++) {
		$value = $line[$i] / $sums[$i] * $norm * 1000;
			print OUT "\t$value";
			$sum = $sum + $value ;
		}
	print OUT "\t$sum\n";
	}
}
close IN;
close OUT;

}


if ($norm > 0 && $groupsGiven == 1) {

# normalizing table to $norm cells per sample

my $outfile4 = $outDir . "/" . $outfileName . ".clonotypeTable.groups.norm" . $norm . "K.txt";
my $outfile2 = $outDir . "/" . $outfileName . ".clonotypeTable.groups.txt";


open IN, $outfile2 or die "Could not open file: \"$outfile2\"\n";
while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	} else {
 		for ($i = 1; $i < @line ; $i++) {
 			$sums[$i] += $line[$i];
 				}
	}
}
close IN;


open OUT, ">$outfile4";
open IN, $outfile2 or die "Could not open file: \"$outfile2\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	print OUT "ID";
		for ($i = 1; $i < @line ; $i++) {
				print OUT "\t$line[$i]";
			}
		print OUT "\n";
	} else {
 		$sum = 0;
 		print OUT $line[0];
		for ($i = 1; $i < (@line -1) ; $i++) {
		$value = $line[$i] / $sums[$i] * $norm * 1000;
			print OUT "\t$value";
			$sum = $sum + $value ;
		}
	print OUT "\t$sum\n";
	}
}
close IN;
close OUT;

}















#removing temporary files
	`rm *$rand.* `;

exit;

