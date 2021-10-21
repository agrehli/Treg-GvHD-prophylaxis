#!/usr/bin/perl 

use warnings;

if (@ARGV < 2) {
	print STDERR "\nUsage: bulkTCRtriangle.pl <input table> <output directory> <analysis name>\n";
	print STDERR "Program filtering and combining the information of clonotype tables\n";
	print STDERR "generated with the bulkTCRcreateJoinedCountTable.pl script\n";
	print STDERR "optional:\n";
	print STDERR "-top <value> Restrict graph to number of top clonotypes \n";
	print STDERR "-color <name> R color for blobs \n";
	
	print STDERR "\t\n";
	exit;
}

my $rand = rand();
my $inFile = $ARGV[0];
my $outDir = $ARGV[1];
my $analysisName = $ARGV[2];
my $colour = "blue";
my $top=0;

for (my $i=0;$i<@ARGV;$i++) {
	if ($ARGV[$i] eq '-top') {
		$top = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-color') {
		$colour = $ARGV[++$i] ;
	} 
}

my $outTable = $outDir . "/" . $analysisName . ".barycentric.table.txt" ;
my $rScript = $outDir . "/" . $analysisName . ".barycentric.triangle.R" ;
my $pdfOut = $outDir . "/" . $analysisName . ".barycentric.triangle.pdf" ;

my $X1=8.66;
my $Y1=-5;
my $X2=-8.66;
my $Y2=-5;
my $X3=0;
my $Y3=10;
my $sample1 = "";
my $sample2 = "";
my $sample3 = "";

open OUT, ">$outTable";
open IN, $inFile or die "Could not open file: \"$inFile\"\n";

while ( <IN> ) {
	chomp;
	s/\r//g;
 	my @line= split /[\t]+/;
 	if ($. == 1) {
 	 	print OUT $line[0];
 		print OUT "\tX\tY\tweight\n";
 		$sample1 =  $line[1];
  		$sample2 =  $line[2];
 		$sample3 =  $line[3];
		
	} else {
		$X = ($X1 * $line[1] + $X2 * $line[2] + $X3 * $line[3]) / $line[4] ;
		$Y = ($Y1 * $line[1] + $Y2 * $line[2] + $Y3 * $line[3]) / $line[4] ;
 	 	print OUT $line[0];
 		print OUT "\t$X\t$Y\t$line[4]\n";
	}
}
close IN;
close OUT;


# Generating R script for plotting


open SCRIPT, ">$rScript";
print SCRIPT "library(ggplot2)\n";
if ($top > 0) {
	my $tmpFile1 = $rand . ".file1.txt" ;
	$top++;
	`head  -n $top $outTable > $tmpFile1`;
	print SCRIPT "data <- read.delim(\"$tmpFile1\", header=T)\n";
} else {
	print SCRIPT "data <- read.delim(\"$outTable\", header=T)\n";
}
print SCRIPT "top <- max(data\$weight)\n";
print SCRIPT "break1 <- floor(top/10)*10\n";
print SCRIPT "break2 <- break1/2\n";
print SCRIPT "break3 <- break2/2\n";
print SCRIPT "p <- ggplot(data, aes(X, Y)) \n";
print SCRIPT "p <- p + geom_point(aes(size = weight, alpha=weight), color=\"$colour\")\n";
print SCRIPT "p <- p + scale_size_continuous(range = c(.5, 10), name = expression(\"clone size\"), breaks=c(break1,break2,break3)) \n";
print SCRIPT "p <- p + scale_alpha_continuous(range = c(0.05, 0.5), name = expression(\"clone size\"), breaks=c(break1,break2,break3)) \n";
print SCRIPT "p <- p + geom_point(aes(x=8.66, y=-5), colour=\"black\", size= 1)\n";
print SCRIPT "p <- p + geom_point(aes(x=-8.66, y=-5), colour=\"black\", size= 1)\n";
print SCRIPT "p <- p + geom_point(aes(x=0, y=10), colour=\"black\", size= 1)\n";
print SCRIPT "p <- p + annotate(\"segment\", x = 0, y = 11.5, xend = 0, yend = 10.5, color=\"black\", arrow = arrow(length = unit(0.2, \"cm\")))\n";
print SCRIPT "p <- p + annotate(\"segment\", x = -10, y = -6, xend = -9, yend = -5.2, color=\"black\", arrow = arrow(length = unit(0.2, \"cm\")))\n";
print SCRIPT "p <- p + annotate(\"segment\", x = 10, y = -6, xend = 9, yend = -5.2, color=\"black\", arrow = arrow(length = unit(0.2, \"cm\")))\n";
print SCRIPT "p <- p + geom_text(x=0, y=13, label=\"$sample3\", size =6, check_overlap = TRUE)\n";
print SCRIPT "p <- p + geom_text(x=13, y=-7, label=\"$sample1\", size =6, check_overlap = TRUE)\n";
print SCRIPT "p <- p + geom_text(x=-13, y=-7, label=\"$sample2\", size =6, check_overlap = TRUE)\n";
print SCRIPT "p <- p + geom_text(x=0, y=-0, label=\"x\", color=\"black\", check_overlap = TRUE)\n";
print SCRIPT "p <- p + xlim(-15, 15) + ylim(-9, 15) + theme_void()\n";
print SCRIPT "p <- p + geom_curve(aes(x = -.5, y = 10, xend = -9.014, yend = -4.646), color=\"gray85\", size = .25, curvature=0.33)\n";
print SCRIPT "p <- p + geom_curve(aes(x = .5, y = 10, xend = 9.014, yend = -4.646), color=\"gray85\", size = .25 , curvature=-0.33)\n";
print SCRIPT "p <- p + geom_curve(aes(x = 8.306, y = -5.354, xend = -8.306, yend = -5.354), color=\"gray85\", size = .25, curvature=-0.33)\n";
print SCRIPT "pdf(file=\"$pdfOut\", height=3, width=4.5)\n";
print SCRIPT "plot(p)\n";
print SCRIPT "dev.off()\n";
close SCRIPT;
 `R --no-save < "$rScript"`;

#removing temporary files
	`rm $rand.* `;

exit;