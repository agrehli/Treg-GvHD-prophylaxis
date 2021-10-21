#!/usr/bin/perl -w 

# This script creates circos plots from clonotype Tables comparing exactly four samples.
# This is tailored for our three animal/one donor design. 


if (@ARGV < 2) {
	print STDERR "\nbulkTCRCirculizeFreq4Samples.pl <tableFile> -outDir <outputDir> -name <output file name>\\\n";
	print STDERR "-color <r,g,b r,g,b r,g,b r,g,b> \\\n";
	print STDERR "-shortNames <name1 name2 name3 name4>\n\n";
	print STDERR "-dvt (generates two plots for donor versus tissues and between tissues - requires donor as sample1)";
	exit;
}

# define default variables and user input

my $dataTable = $ARGV[0];
my @sums = '';
my $col = 0;
my $value = 0;
my $outDir = '';
my $counter = 0;
my $length = 0;
my @colors = ();
my @snames =();
push(@snames, "na");
my $dvt = 0;
my $rScript ="";
my $outfileName = "test";


for (my $i=0;$i<@ARGV;$i++) {
	if ($ARGV[$i] eq '-outDir') {
		$outDir = $ARGV[++$i] ;
		$outDir .= '/' unless $outDir =~ m(/$);
	} elsif ($ARGV[$i] eq '-dvt') {
		$dvt = 1 ;
	} elsif ($ARGV[$i] eq '-colors') {
		print STDERR "\n\tcolors:\n";
		my $bail = 0;
		while ($ARGV[++$i] !~ /^\-/) {
			push(@colors, $ARGV[$i]);
			print STDERR "\t\t$ARGV[$i]\n";
			if ($i>=@ARGV-1) {
				$bail = 1;
				last;
			}
		}
		last if ($bail == 1);
		$i--;
	} elsif ($ARGV[$i] eq '-shortNames') {
		print STDERR "\n\tshort names:\n";
		my $bail = 0;
		while ($ARGV[++$i] !~ /^\-/) {
			push(@snames, $ARGV[$i]);
			print STDERR "\t\t$ARGV[$i]\n";
			if ($i>=@ARGV-1) {
				$bail = 1;
				last;
			}
		}
		last if ($bail == 1);
		$i--;
 	} elsif ($ARGV[$i] eq '-name') {
		$outfileName = $ARGV[++$i] ;
	}
}

if ($dvt == 0) {
	print STDERR "\t\tprinting all interactions in one plot\n\n";
	$rScript =  $outDir . $outfileName  . "_circlizeDiagram4.R";
} else {
	print STDERR "\t\tprinting two plots\n\n";
	$rScript =  $outDir . $outfileName  . "_circlizeDiagram4dvt.R";
}

my @colRing = ();
my @colRib = ();
for (my $i=0;$i<@colors;$i++) {
$colRing[$i+1] = "rgb(" . $colors[$i] . ",max = 255)";
$colRib[$i+1] = "rgb(" . $colors[$i] . ",alpha=150, max = 255)";
}
#print STDERR join "\t",

my $out1 = $outDir .  $outfileName  . "_frequencyTable.txt";
my $out2 = $outDir .  $outfileName  . "_frequencyTableReduced.txt";
#my $out3 = $outDir . "frequencyTableFinal.txt";


open IN, $ARGV[0] ;
open OUT1, ">$out1";

#generating the frequency table and marking single entries

while (<IN>) {
	chomp;
	s/\r//g;
	my @line= split /\t/;

	if ($. == 1) {
		for (my $i=1;$i<(@line-1);$i++) {
		$col = $i + 1;
		$sums[$i] =  `LC_NUMERIC=\"en_US.UTF-8\" awk 'BEGIN {FS="\t"} {s+=\$$col} END {print s}' $ARGV[0]`;
	    print STDERR "\tSum column $col = $sums[$i]";
	    }
		print OUT1 $line[0];
		for (my $i=1;$i<(@line-1);$i++) {
	    print OUT1 "\t$line[$i]";
	    }
		print OUT1 "\n";
	    
	} else {
		print OUT1 $line[0];
		$counter = 0;
		for (my $i=1;$i<(@line-1);$i++) {
			
			$value = ($line[$i]/$sums[$i]) ;
			if ($value > 0) { $counter++; }
			print OUT1 "\t$value";
	    }
		if ($counter ==1) {
		print OUT1 "\t1\n"; 
		} else {
		print OUT1 "\t2\n"; 
		} 
	}
}	
close IN;

s/\R\z// for @sums;

my $S1total=0;
my $S2total=0;
my $S3total=0;
my $S4total=0;
my $S1S2_1=0;
my $S1S2_2=0;
my $S1S3_1=0;
my $S1S3_3=0;
my $S1S4_1=0;
my $S1S4_4=0;
my $S2S3_2=0;
my $S2S3_3=0;
my $S2S4_2=0;
my $S2S4_4=0;
my $S3S4_3=0;
my $S3S4_4=0;
my $S1S2S3_1=0;
my $S1S2S3_2=0;
my $S1S2S3_3=0;
my $S1S2S4_1=0;
my $S1S2S4_2=0;
my $S1S2S4_4=0;
my $S1S3S4_1=0;
my $S1S3S4_3=0;
my $S1S3S4_4=0;
my $S2S3S4_2=0;
my $S2S3S4_3=0;
my $S2S3S4_4=0;
my $S1S2S3S4_1=0;
my $S1S2S3S4_2=0;
my $S1S2S3S4_3=0;
my $S1S2S3S4_4=0;


#counting the frequency table 

open IN, $out1;
open OUT2, ">$out2";

while (<IN>) {
	chomp;
	s/\r//g;
	my @line= split /\t/;
	if ($. == 1) { # basic preparation when loading the first line
		$length = scalar(@line);
		# moving headers to @sample
		@sample = @line;
		print OUT2 "Shared repertoires between sampes:\n";
		print OUT2 "$sample[1]\n";
		print OUT2 "$sample[2]\n";
		print OUT2 "$sample[3]\n";
		print OUT2 "$sample[4]\n\n\n";
	
	} elsif ($line[($length)] > 1) { # counting frequencies for all combinations
		$S1total=$S1total+$line[1];
		$S2total=$S2total+$line[2];
		$S3total=$S3total+$line[3];	
		$S4total=$S4total+$line[4];	
		if ($line[1] == 0  && $line[4] == 0) {
		$S2S3_2=$S2S3_2+$line[2];
		$S2S3_3=$S2S3_3+$line[3];
		} elsif ($line[2] == 0  && $line[4] == 0) {
		$S1S3_1=$S1S3_1+$line[1];
		$S1S3_3=$S1S3_3+$line[3];
		} elsif ($line[3] == 0  && $line[4] == 0) {
		$S1S2_1=$S1S2_1+$line[1];
		$S1S2_2=$S1S2_2+$line[2];
		} elsif ($line[2] == 0  && $line[3] == 0) {
		$S1S4_1=$S1S4_1+$line[1];
		$S1S4_4=$S1S4_4+$line[4];
		} elsif ($line[1] == 0  && $line[3] == 0) {
		$S2S4_2=$S2S4_2+$line[2];
		$S2S4_4=$S2S4_4+$line[4];
		} elsif ($line[1] == 0  && $line[2] == 0) {
		$S3S4_3=$S3S4_3+$line[3];
		$S3S4_4=$S3S4_4+$line[4];
		} elsif ($line[4] == 0) {
		$S1S2S3_1=$S1S2S3_1+$line[1];
		$S1S2S3_2=$S1S2S3_2+$line[2];
		$S1S2S3_3=$S1S2S3_3+$line[3];
		} elsif ($line[3] == 0) {
		$S1S2S4_1=$S1S2S4_1+$line[1];
		$S1S2S4_2=$S1S2S4_2+$line[2];
		$S1S2S4_4=$S1S2S4_4+$line[4];
		} elsif ($line[2] == 0) {
		$S1S3S4_1=$S1S3S4_1+$line[1];
		$S1S3S4_3=$S1S3S4_3+$line[3];
		$S1S3S4_4=$S1S3S4_4+$line[4];
		} elsif ($line[1] == 0) {
		$S2S3S4_2=$S2S3S4_2+$line[2];
		$S2S3S4_3=$S2S3S4_3+$line[3];
		$S2S3S4_4=$S2S3S4_4+$line[4];
		} else {
		$S1S2S3S4_1=$S1S2S3S4_1+$line[1];
		$S1S2S3S4_2=$S1S2S3S4_2+$line[2];
		$S1S2S3S4_3=$S1S2S3S4_3+$line[3];
		$S1S2S3S4_4=$S1S2S3S4_4+$line[4];
		}
		
	}
}
#define initial ranges
# for (my $i=1;$i<$length;$i++) {
# 	$range2[$i] = 0;
# 	$range1[$i] = 0;
# 	}

print OUT2 "$sample[1] total in overlap: $S1total\n";
print OUT2 "$sample[2] total in overlap: $S2total\n";
print OUT2 "$sample[3] total in overlap: $S3total\n";
print OUT2 "$sample[4] total in overlap: $S4total\n\n";

# one way
print OUT2 "$sample[1] $sample[2] in overlap: $S1S2_1,$S1S2_2\n";
print OUT2 "$sample[1] $sample[3] in overlap: $S1S3_1,$S1S3_3\n";
print OUT2 "$sample[1] $sample[4] in overlap: $S1S4_1,$S1S4_4\n";
print OUT2 "$sample[2] $sample[3] in overlap: $S2S3_2,$S2S3_3\n";
print OUT2 "$sample[2] $sample[4] in overlap: $S2S4_2,$S2S4_4\n";
print OUT2 "$sample[3] $sample[4] in overlap: $S3S4_3,$S3S4_4\n";

#two way
print OUT2 "$sample[1] $sample[2] and $sample[3] in overlap: $S1S2S3_1,$S1S2S3_2,$S1S2S3_3\n";
print OUT2 "$sample[1] $sample[2] and $sample[4] in overlap: $S1S2S4_1,$S1S2S4_2,$S1S2S4_4\n";
print OUT2 "$sample[1] $sample[3] and $sample[4] in overlap: $S1S3S4_1,$S1S3S4_3,$S1S3S4_4\n";
print OUT2 "$sample[2] $sample[3] and $sample[4] in overlap: $S2S3S4_2,$S2S3S4_3,$S2S3S4_4\n";

#three way
print OUT2 "common in $sample[1], $sample[2], $sample[3] and $sample[4]: $S1S2S3S4_1,$S1S2S3S4_2,$S1S2S3S4_3,$S1S2S3S4_4\n";

close IN;
close OUT2;



if ($dvt == 0) {

my $outpdf = $outDir .  $outfileName  . "_circlizeDiagram4.pdf";
my $outpng = $outDir .  $outfileName  . "_circlizeDiagram4.png";

open SCRIPT, ">$rScript";
	print SCRIPT "library(circlize)\n";
	print SCRIPT "library(RColorBrewer)\n";
	print SCRIPT "library(gridExtra)\n";
	print SCRIPT "library(grid)\n";
	print SCRIPT "setwd(\"$outDir\")\n";
	#defining the names
	print SCRIPT "factors = c(\"$sample[1]\",\"$sample[2]\",\"$sample[3]\",\"$sample[4]\")\n";
	print SCRIPT "snames = c(\"$snames[1]\",\"$snames[2]\",\"$snames[3]\",\"$snames[4]\")\n";
	print SCRIPT "numbers = c(\"$sums[1]\",\"$sums[2]\",\"$sums[3]\",\"$sums[4]\")\n";
	print SCRIPT "numbers\n";
	print SCRIPT "snames\n";
	print SCRIPT "numbers\n";
	
	#creating the table with cell numbers
	print SCRIPT "table <- data.frame(snames,numbers)\n";
	print SCRIPT "colnames(table) <- c(\"Cell type\",\"Clone number\")\n";
	
	#defining the colors
	print SCRIPT "bg.col = c($colRing[1],$colRing[2],$colRing[3],$colRing[4])\n";
	#initialize the plot
	
for (my $i=1;$i<3;$i++) {
	if ($i == 1) {	
	print SCRIPT "pdf(file=\"$outpdf\", height = 6, width = 4)\n";
	} elsif ($i == 2) {
	print SCRIPT "png(filename=\"$outpng\", height = 600, width = 400)\n";
	}
	print SCRIPT "par(fig=c(0,1,0.33,1))\n";
	
	print SCRIPT "circos.initialize(factors, xlim = c(0, 1))\n";
	print SCRIPT "circos.trackPlotRegion(ylim = c(0, 1), track.index = 1, track.height = 0.2, bg.col = \"white\", bg.border = \"white\")\n";
	print SCRIPT "circos.trackPlotRegion(ylim = c(0, 1), track.index = 2, track.height = 0.1, bg.col = bg.col, bg.border = NA)\n";

	#define ranges for ribbons	
	my $rng11 = $S1total - $S1S2_1 ;
	my $rng12 = $rng11 - $S1S2S3_1 ;
	my $rng13 = $rng12 - $S1S2S4_1 ;
	my $rng14 = $rng13 - $S1S2S3S4_1 ;
	my $rng15 = $rng14 - $S1S3_1 ;
	my $rng16 = $rng15 - $S1S3S4_1 ;
	my $rng17 = $rng16 - $S1S4_1 ;
	
	my $rng21 = $S1S2_2;
	my $rng22 = $rng21 + $S1S2S3_2 ;
	my $rng23 = $rng22 + $S1S2S4_2;
	my $rng24 = $rng23 + $S1S2S3S4_2;
	my $rng25 = $rng24 + $S2S4_2;
	my $rng26 = $rng25 + $S2S3S4_2;
	my $rng27 = $rng26 + $S2S3_2;

	my $rng31 = $S3total - $S3S4_3 ;
	my $rng32 = $rng31 - $S2S3S4_3 ;
	my $rng33 = $rng32 - $S1S3S4_3 ;
	my $rng34 = $rng33 - $S1S2S3S4_3 ;
	my $rng35 = $rng34 - $S1S3_3 ;
	my $rng36 = $rng35 - $S1S2S3_3 ;
	my $rng37 = $rng36 - $S2S3_3 ;
	
	my $rng41 = $S3S4_4;
	my $rng42 = $rng41 + $S2S3S4_4 ;
	my $rng43 = $rng42 + $S1S3S4_4;
	my $rng44 = $rng43 + $S1S2S3S4_4;
	my $rng45 = $rng44 + $S2S4_4;
	my $rng46 = $rng45 + $S1S2S4_4;	
	my $rng47 = $rng46 + $S1S4_4;
	
	
	
	#Sample 1 interactions
	print SCRIPT "circos.link(\"$sample[1]\", c($rng11,$S1total),\"$sample[2]\", c(0,$rng21),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng12,$rng11),\"$sample[2]\", c($rng21,$rng22),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng12,$rng11),\"$sample[3]\", c($rng36,$rng35),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng13,$rng12),\"$sample[2]\", c($rng22,$rng23),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng13,$rng12),\"$sample[4]\", c($rng45,$rng46),col = $colRib[4], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[2]\", c($rng23,$rng24),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[3]\", c($rng34,$rng33),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[4]\", c($rng43,$rng44),col = $colRib[4], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng15,$rng14),\"$sample[3]\", c($rng35,$rng34),col = $colRib[1], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng16,$rng15),\"$sample[3]\", c($rng33,$rng32),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng16,$rng15),\"$sample[4]\", c($rng42,$rng43),col = $colRib[4], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[1]\", c($rng17,$rng16),\"$sample[4]\", c($rng46,$rng47),col = $colRib[4], border = NA)\n";
	
	#Sample 2 interactions
	print SCRIPT "circos.link(\"$sample[2]\", c($rng21,$rng22),\"$sample[3]\", c($rng36,$rng35),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng22,$rng23),\"$sample[4]\", c($rng45,$rng46),col = $colRib[2], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng23,$rng24),\"$sample[3]\", c($rng34,$rng33),col = $colRib[2], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng23,$rng24),\"$sample[4]\", c($rng43,$rng44),col = $colRib[2], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng24,$rng25),\"$sample[4]\", c($rng44,$rng45),col = $colRib[2], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng25,$rng26),\"$sample[3]\", c($rng32,$rng31),col = $colRib[2], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng25,$rng26),\"$sample[4]\", c($rng41,$rng42),col = $colRib[4], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[2]\", c($rng26,$rng27),\"$sample[3]\", c($rng37,$rng36),col = $colRib[2], border = NA)\n";
	
	#Sample 3 interactions
	print SCRIPT "circos.link(\"$sample[3]\", c($rng31,$S3total),\"$sample[4]\", c(0,$rng41),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[3]\", c($rng32,$rng31),\"$sample[4]\", c($rng41,$rng42),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[3]\", c($rng33,$rng32),\"$sample[4]\", c($rng42,$rng43),col = $colRib[3], border = NA)\n";
	print SCRIPT "circos.link(\"$sample[3]\", c($rng34,$rng33),\"$sample[4]\", c($rng43,$rng44),col = $colRib[4], border = NA)\n";
	

	#label samples
	
	print SCRIPT "for (i in 1:4) {\n";
	print SCRIPT "circos.updatePlotRegion(sector.index = factors[i], track.index = 1, bg.col = NA)\n";
	print SCRIPT "circos.text(x = 0.5, y = 0.5, labels = snames[i], facing = \"bending\", cex = 1.5)\n";
	print SCRIPT "}\n";
	print SCRIPT "circos.clear()\n";

	#printing the table below the circos
	print SCRIPT "blankPanel<-rectGrob(gp=gpar(fill=\"white\",col=\"white\",alpha=0))\n";
	print SCRIPT "gt <- tableGrob(table,rows = NULL)\n";	
	print SCRIPT "grid.arrange(blankPanel,gt,nrow=2,heights=c(3,2),newpage = FALSE)\n";
	print SCRIPT "dev.off()\n";
}
close SCRIPT;

`R --no-save < "$rScript"`;

} else {

my $out1pdf = $outDir .  $outfileName  . "_circlizeDiagram4donor.pdf";
my $out2pdf = $outDir .  $outfileName  . "_circlizeDiagram4tissues.pdf";


	open SCRIPT, ">$rScript";
		print SCRIPT "library(circlize)\n";
		print SCRIPT "library(RColorBrewer)\n";
		print SCRIPT "library(gridExtra)\n";
		print SCRIPT "library(grid)\n";
		print SCRIPT "setwd(\"$outDir\")\n";
		#defining the names
		print SCRIPT "factors = c(\"$sample[1]\",\"$sample[2]\",\"$sample[3]\",\"$sample[4]\")\n";
		print SCRIPT "snames = c(\"$snames[1]\",\"$snames[2]\",\"$snames[3]\",\"$snames[4]\")\n";
		print SCRIPT "numbers = c(\"$sums[1]\",\"$sums[2]\",\"$sums[3]\",\"$sums[4]\")\n";
	
		#creating the table with cell numbers
		print SCRIPT "table <- data.frame(snames,numbers)\n";
		print SCRIPT "colnames(table) <- c(\"Cell type\",\"Clone number\")\n";
	
		#defining the colors
		print SCRIPT "bg.col = c($colRing[1],$colRing[2],$colRing[3],$colRing[4])\n";
		#initialize the plot
	
	for (my $i=1;$i<3;$i++) {
		if ($i == 1) {	
		print SCRIPT "pdf(file=\"$out1pdf\", height = 6, width = 4)\n";
		} elsif ($i == 2) {
		print SCRIPT "pdf(file=\"$out2pdf\", height = 6, width = 4)\n";
		}
		print SCRIPT "par(fig=c(0,1,0.33,1))\n";
	
		print SCRIPT "circos.initialize(factors, xlim = c(0, 1))\n";
		print SCRIPT "circos.trackPlotRegion(ylim = c(0, 1), track.index = 1, track.height = 0.2, bg.col = \"white\", bg.border = \"white\")\n";
		print SCRIPT "circos.trackPlotRegion(ylim = c(0, 1), track.index = 2, track.height = 0.1, bg.col = bg.col, bg.border = NA)\n";

		#define ranges for ribbons	
		my $rng11 = $S1total - $S1S2_1 ;
		my $rng12 = $rng11 - $S1S2S3_1 ;
		my $rng13 = $rng12 - $S1S2S4_1 ;
		my $rng14 = $rng13 - $S1S2S3S4_1 ;
		my $rng15 = $rng14 - $S1S3_1 ;
		my $rng16 = $rng15 - $S1S3S4_1 ;
		my $rng17 = $rng16 - $S1S4_1 ;
	
		my $rng21 = $S1S2_2;
		my $rng22 = $rng21 + $S1S2S3_2 ;
		my $rng23 = $rng22 + $S1S2S4_2;
		my $rng24 = $rng23 + $S1S2S3S4_2;
		my $rng25 = $rng24 + $S2S4_2;
		my $rng26 = $rng25 + $S2S3S4_2;
		my $rng27 = $rng26 + $S2S3_2;

		my $rng31 = $S3total - $S3S4_3 ;
		my $rng32 = $rng31 - $S2S3S4_3 ;
		my $rng33 = $rng32 - $S1S3S4_3 ;
		my $rng34 = $rng33 - $S1S2S3S4_3 ;
		my $rng35 = $rng34 - $S1S3_3 ;
		my $rng36 = $rng35 - $S1S2S3_3 ;
		my $rng37 = $rng36 - $S2S3_3 ;
	
		my $rng41 = $S3S4_4;
		my $rng42 = $rng41 + $S2S3S4_4 ;
		my $rng43 = $rng42 + $S1S3S4_4;
		my $rng44 = $rng43 + $S1S2S3S4_4;
		my $rng45 = $rng44 + $S2S4_4;
		my $rng46 = $rng45 + $S1S2S4_4;	
		my $rng47 = $rng46 + $S1S4_4;
	
		if ($i == 1) {	
	
		#Sample 1 interactions
		print SCRIPT "circos.link(\"$sample[1]\", c($rng11,$S1total),\"$sample[2]\", c(0,$rng21),col = $colRib[2], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng12,$rng11),\"$sample[2]\", c($rng21,$rng22),col = $colRib[2], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng12,$rng11),\"$sample[3]\", c($rng36,$rng35),col = $colRib[3], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng13,$rng12),\"$sample[2]\", c($rng22,$rng23),col = $colRib[2], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng13,$rng12),\"$sample[4]\", c($rng45,$rng46),col = $colRib[4], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[2]\", c($rng23,$rng24),col = $colRib[2], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[3]\", c($rng34,$rng33),col = $colRib[3], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng14,$rng13),\"$sample[4]\", c($rng43,$rng44),col = $colRib[4], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng15,$rng14),\"$sample[3]\", c($rng35,$rng34),col = $colRib[3], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng16,$rng15),\"$sample[3]\", c($rng33,$rng32),col = $colRib[3], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng16,$rng15),\"$sample[4]\", c($rng42,$rng43),col = $colRib[4], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[1]\", c($rng17,$rng16),\"$sample[4]\", c($rng46,$rng47),col = $colRib[4], border = NA)\n";

		} elsif ($i == 2) {
	
		#Sample 2 interactions
		print SCRIPT "circos.link(\"$sample[2]\", c($rng21,$rng22),\"$sample[3]\", c($rng36,$rng35),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng22,$rng23),\"$sample[4]\", c($rng45,$rng46),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng23,$rng24),\"$sample[3]\", c($rng34,$rng33),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng23,$rng24),\"$sample[4]\", c($rng43,$rng44),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng24,$rng25),\"$sample[4]\", c($rng44,$rng45),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng25,$rng26),\"$sample[3]\", c($rng32,$rng31),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng25,$rng26),\"$sample[4]\", c($rng41,$rng42),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[2]\", c($rng26,$rng27),\"$sample[3]\", c($rng37,$rng36),col = $colRib[1], border = NA)\n";
	
		#Sample 3 interactions
		print SCRIPT "circos.link(\"$sample[3]\", c($rng31,$S3total),\"$sample[4]\", c(0,$rng41),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[3]\", c($rng32,$rng31),\"$sample[4]\", c($rng41,$rng42),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[3]\", c($rng33,$rng32),\"$sample[4]\", c($rng42,$rng43),col = $colRib[1], border = NA)\n";
		print SCRIPT "circos.link(\"$sample[3]\", c($rng34,$rng33),\"$sample[4]\", c($rng43,$rng44),col = $colRib[1], border = NA)\n";
	
		}
		#label samples
	
		print SCRIPT "for (i in 1:4) {\n";
		print SCRIPT "circos.updatePlotRegion(sector.index = factors[i], track.index = 1, bg.col = NA)\n";
		print SCRIPT "circos.text(x = 0.5, y = 0.5, labels = snames[i], facing = \"bending\", cex = 1.5)\n";
		print SCRIPT "}\n";
		print SCRIPT "circos.clear()\n";

		#printing the table below the circos
		print SCRIPT "blankPanel<-rectGrob(gp=gpar(fill=\"white\",col=\"white\",alpha=0))\n";
		print SCRIPT "gt <- tableGrob(table,rows = NULL)\n";	
		print SCRIPT "grid.arrange(blankPanel,gt,nrow=2,heights=c(3,2),newpage = FALSE)\n";
		print SCRIPT "dev.off()\n";
	}
	close SCRIPT;

	`R --no-save < "$rScript"`;

	
}

exit;
	
