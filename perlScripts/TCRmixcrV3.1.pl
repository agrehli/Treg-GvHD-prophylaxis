#!/usr/bin/perl -w 

# by Michael Rehli, last modified Oct. 2021

# Perl script to map TCR repertoires derived from our RACE-PCR approach.
# Sequencing data (usually MiSeq 300bp PE) are initially assembled (paired) using the
# software PEAR. UMI should be standard in our protocol, but the pipeline can also be
# used for non-barcoded RNAs (when -UMI option is omitted). MIGs are called using MIGEC 
# before mapping with MIXCR (version 3). We usually run two libraries for each sample
# (replicate) and work with the combined repertoire from both technical replicate runs.
# Individual runs are kept for quality controls.

# The pipeline is setup for our server and deploys folders for each experiment on the 
# misc/data volume under processedData//mapping/RNA/RepSeq/MIXCRv3/

# Dependencies: PEAR (v0.9.11), MIGEC (v1.2.9), MIXCR (v3.0.13), R version 4.0.3 (rbioc_3-12)


use warnings;

# show help message if less than 5 arguments are given

if (@ARGV < 5) {
	print STDERR "\nUsage: TCRmixcr.pl <runA fastqR1> <runA fastqR2> <runB fastqR1> <runB fastqR2> <sample name> [options]\n";
	print STDERR "Program using MIXCR pipeline to align tcr sequences of replicate runs (if using single run, type na na for runB fastq files)\n";
	print STDERR "Configured for MiXCR v3.0.1.13 \n";
	print STDERR "\tOptions:\n";
	print STDERR "\t-species <mmu or mouse> (default hsa or human) \n";
	print STDERR "\t-badQualityThreshold <Minimal value of sequencing quality score> (default 20) \n";
	print STDERR "\t-t <number of available CPU cores> (default 1) \n";
	print STDERR "\t-nopear don't use default assembly of PE reads with PEAR \n";
	print STDERR "\toptional parameters for PEAR\n";
    print STDERR "\t-p <p value> (default: 1 to disable statistical test) \n";
	print STDERR "\t-v <value> (default: 2 as a minimal overlap) \n";
	print STDERR "\t-b <value> (default: 15 as a minimal base phred score) \n";
	print STDERR "\t-UMI read 2 contains our UMI in template-switch oligo \n";
	print STDERR "\toptional parameters for UMI\n";
    print STDERR "\t-estA <group size cut-off> (default: use recommended value) \n";
	print STDERR "\t-estB <group size cut-off> (default: use recommended value) \n";
	print STDERR "\t-preassembled <fastq files are preassembled. Use fastqA na fastqB na> \n";
	print STDERR "\t-TRA <map to TRA instead of TRB (default)> \n";
	print STDERR "\t\n";
	print STDERR "Will OVERWRITE existing directories!\n";
	print STDERR "\t\n";

	exit;
}


# define path to software 

my $MIXCR ="/misc/software/ngs/mixcr/mixcr-3.0.13/mixcr";
my $PEARPROG="/misc/software/ngs/pear/src/pear_2018-03-12/pear-0.9.11-linux-x86_64/bin/pear";
my $MIGEC="/misc/software/ngs/migec/src/v1.2.9/migec.sh" ;
my $R="rbioc_3-12";


# define default variables and user input
  
my $rand = rand();
my $sum = 0;
my $maxsum = 0;
my $fastqR1A = $ARGV[0];
my $fastqR2A = $ARGV[1];
my $fastqR1B = $ARGV[2];
my $fastqR2B = $ARGV[3];
my $name = $ARGV[4];
my $outDir = "/misc/data/processedData/mapping/RNA/RepSeq/MIXCRv3/" . $name ;
my $plotDir = "/misc/data/processedData/mapping/RNA/RepSeq/MIXCRv3/" ;
my $species = "hsa";
my $badQualityThreshold = 20;
my $threads = 1;
my $tempDir = "/loctmp/tmp" . $rand . "/";
my $pear = 1 ;
my $runmode = 2;
my $TCR = "TRB" ;
my $preass = 0 ;
my $umi = 0;

my $PEARpvalue="1.0" ;
my $PEARoverlap=2 ;
my $PEARphred=15 ;
my $estimateA=0 ;
my $estimateB=0 ;
my $estimateC=0 ;


# look for user-given optional input

for (my $i=1;$i<@ARGV;$i++) {
	if ($ARGV[$i] eq '-species') {
		$species = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-badQualityThreshold') {
		$badQualityThreshold = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-t') {
		$threads = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-nopear') {
		$pear = 0 ;
	} elsif ($ARGV[$i] eq '-preassembled') {
		$preass = 1 ;
		$pear = 0 ;
	} elsif ($ARGV[$i] eq '-TRA') {
		$TCR = "TRA" ;
	} elsif ($ARGV[$i] eq '-p') {
		$PEARpvalue = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-v') {
		$PEARoverlap = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-b') {
		$PEARphred = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-UMI') {
		$umi = 1 ;
	} elsif ($ARGV[$i] eq '-estA') {
		$estimateA = $ARGV[++$i] ;
	} elsif ($ARGV[$i] eq '-estB') {
		$estimateB = $ARGV[++$i] ;
	}
}


# set species argument

if ($species eq "human") {$species = "hsa"}
elsif ($species eq "mouse") {$species = "mmu"}


# test if just a single replicate is provided - if yes $runmode is set to 1

if ($fastqR1B eq "na" && $fastqR2B eq "na") {
	$runmode = 1;
}
if ($fastqR1B eq "NA" && $fastqR2B eq "NA") {
	$runmode = 1;
}
my @arrR1B=split /\//,$fastqR1B;
my @arrR2B=split /\//,$fastqR2B;

if ($arrR1B[-1] eq "na" && $arrR2B[-1] eq "na") {
	$runmode = 1;
}
if ($arrR1B[-1] eq "NA" && $arrR2B[-1] eq "NA") {
	$runmode = 1;
}

# define file names and directories

my $fastqR1C = $tempDir . $rand . ".1C.fastq";
my $fastqR2C = $tempDir . $rand . ".2C.fastq";

my $R1A = $tempDir . $rand . ".1A.fastq";
my $R2A = $tempDir . $rand . ".2A.fastq";
my $R1B = $tempDir . $rand . ".1B.fastq";
my $R2B = $tempDir . $rand . ".2B.fastq";

my $RA = $tempDir . $rand . ".1.pear";
my $RB = $tempDir . $rand . ".2.pear";

my $RAf = $tempDir . $rand . ".1.pear.assembled.fastq";
my $RBf = $tempDir . $rand . ".2.pear.assembled.fastq";
my $RCf = $tempDir . $rand . ".AB.pear.assembled.fastq";

my $Avdjca = $tempDir . $rand . ".A.vdjca";
my $Bvdjca = $tempDir . $rand . ".B.vdjca";
my $Cvdjca = $tempDir . $rand . ".C.vdjca";
my $Aclns = $tempDir . $rand . ".A.clns";
my $Bclns = $tempDir . $rand . ".B.clns";
my $Cclns = $tempDir . $rand . ".C.clns";
my $Atxt = $outDir . "/". $name . ".RunA.clonotypes." . $TCR . ".txt";
my $Btxt = $outDir . "/". $name . ".RunB.clonotypes." . $TCR . ".txt";
my $Ctxt = $outDir . "/". $name . ".RunAB.clonotypes." . $TCR . ".txt";
my $Cversion = $outDir . "/". $name . ".software.version.txt";

my $PEARoutA = $outDir . "/". $name . ".RunA.pear_assembly_report.txt";
my $PEARoutB = $outDir . "/". $name . ".RunB.pear_assembly_report.txt";

my $barcodesA = $tempDir . $rand . ".RunA.barcodes.txt";
my $barcodesB = $tempDir . $rand . ".RunB.barcodes.txt";
my $barcodesC = $tempDir . $rand . ".RunAB.barcodes.txt";

my $checkoutA = $tempDir . $rand . ".RunA.checkout/";
my $checkoutB = $tempDir . $rand . ".RunB.checkout/";
my $checkoutC = $tempDir . $rand . ".RunAB.checkout/";

my $UMIstatsA = $outDir . "/". $name . ".RunA.UMI_statistics_report/";
my $UMIstatsB = $outDir . "/". $name . ".RunB.UMI_statistics_report/";
my $UMIstatsC = $outDir . "/". $name . ".RunAB.UMI_statistics_report/";

my $UMIfastqA = $checkoutA . $name . "_RunA_R0.fastq.gz";
my $UMIfastqB = $checkoutB . $name . "_RunB_R0.fastq.gz";
my $UMIfastqC = $checkoutC . $name . "_RunAB_R0.fastq.gz";

my $rScript = $tempDir . $rand . ".script.R";
my $overseqA = $UMIstatsA . "/overseq.txt";
my $overseqAhist = $outDir . "/". $name . ".RunA.UMIcoverage.png";
my $overseqB = $UMIstatsB . "/overseq.txt";
my $overseqBhist = $outDir . "/". $name . ".RunB.UMIcoverage.png";
my $overseqC = $UMIstatsC . "/overseq.txt";
my $overseqChist = $outDir . "/". $name . ".RunAB.UMIcoverage.png";

# generate output directory - if existing, delete old version

if (-d $outDir) {
	`rm -r $outDir/*.*`;

} else {
	`mkdir $outDir`;
}

# generate temporary directory

`mkdir $tempDir`;

print STDERR "\n\tSpecies: $species\n";
print STDERR "\n\tUMI: $umi\n";



##########################################################################################
#               read assembly with PEAR (default: -p 1.0 -v 2 -b 15)                     #
##########################################################################################


# implements assembly before merging

if ($pear == 1) {

	if (index($fastqR1A,',') == -1) {
		# assembly of first replicate
		print STDERR "\n\tPE read assembly with PEAR - one each\n";
		`$PEARPROG -f $fastqR2A -r $fastqR1A -o $RA -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred > $PEARoutA`;	
	} else {
		my @fastqR1=split /,/,$fastqR1A;
		my @fastqR2=split /,/,$fastqR2A;
		if ( @fastqR1 != @fastqR2 ) {
			print STDERR "\n\tnumber of sequencing files don't match\n";
			exit;
		}
		my $RAtmp1 = $tempDir . $rand . ".1.temp1.pear";
		my $RAftmp1 = $tempDir . $rand . ".1.temp1.pear.assembled.fastq";
		my $RAftmp2 = $tempDir . $rand . ".1.temp2.pear.assembled.fastq";

		print STDERR "\n\tPE read assembly with PEAR - sample 0\n";
		`$PEARPROG -f $fastqR2[0] -r $fastqR1[0] -o $RA -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred > $PEARoutA`;	

		for (my $i=1;$i<@fastqR1;$i++) {
			print STDERR "\n\tPE read assembly with PEAR - sample $i\n";
			`$PEARPROG -f $fastqR2[$i] -r $fastqR1[$i] -o $RAtmp1 -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred >> $PEARoutA`;	
			`cp $RAf $RAftmp2 ; cat $RAftmp2 $RAftmp1 >$RAf`;
		}
	}
	if ($runmode == 2) {
		if (index($fastqR1B,',') == -1) {
			# assembly of second replicate
			print STDERR "\n\tPE read assembly with PEAR - one each\n";
			`$PEARPROG -f $fastqR2B -r $fastqR1B -o $RB -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred > $PEARoutB`;
		} else {
			@fastqR1=split /,/,$fastqR1B;
			@fastqR2=split /,/,$fastqR2B;
			if ( @fastqR1 != @fastqR2 ) {
				print STDERR "\n\tnumber of sequencing files don't match\n";
				exit;
			}

			my $RBtmp1 = $tempDir . $rand . ".1.temp1.pear";
			my $RBftmp1 = $tempDir . $rand . ".1.temp1.pear.assembled.fastq";
			my $RBftmp2 = $tempDir . $rand . ".1.temp2.pear.assembled.fastq";

			print STDERR "\n\tPE read assembly with PEAR - sample 0\n";
			`$PEARPROG -f $fastqR2[0] -r $fastqR1[0] -o $RB -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred > $PEARoutB`;	

			for (my $i=1;$i<@fastqR1;$i++) {
				print STDERR "\n\tPE read assembly with PEAR - sample $i\n";
				`$PEARPROG -f $fastqR2[$i] -r $fastqR1[$i] -o $RBtmp1 -j $threads -p $PEARpvalue -v $PEARoverlap -b $PEARphred >> $PEARoutB`;	
				`cp $RBf $RBftmp2 ; cat $RBftmp2 $RBftmp1 >$RBf`;
			}
		}
		
		# combining data of both experiments		
		`cat $RAf $RBf >$RCf`;
	}
} elsif ($runmode == 2) {
	# generating merged fastq for combined analysis
		`cat $fastqR2A $fastqR2B >$fastqR2C`;
		`cat $fastqR1A $fastqR1B >$fastqR1C`;
}	


# if preassembled data is provided reset $pear to 1 (treat like PEAR assembled) and set paths to user-given assembled fastqs

if ($preass == 1) {
	$pear = 1 ;
	$RAf = $fastqR1A ;
	if ($runmode == 2) {
		$RBf = $fastqR1B ;
		# generating merged fastq for combined analysis
		`cat $RAf $RBf >$RCf`;

	}
}



##########################################################################################
#           running Migec on preassembled data if UMI option is chosen                   #
##########################################################################################

if ($umi == 1) {
print STDERR "\n\trunning MIGEC\n";


	open OUTA, ">$barcodesA";
	print OUTA $name ."_RunA\tTNNNNTNNNNTNNNNTGGG\n" ;
	close OUTA ;
	`mkdir $checkoutA`;
	if ($runmode == 2) {
		open OUTB, ">$barcodesB";
		print OUTB $name . "_RunB\tTNNNNTNNNNTNNNNTGGG\n" ;
		close OUTB ;
		`mkdir $checkoutB`;
		open OUTC, ">$barcodesC";
		print OUTC $name . "_RunAB\tTNNNNTNNNNTNNNNTGGG\n" ;
		close OUTC ;
		`mkdir $checkoutC`;
	}	
	#run MIGEC om RunA
	`$MIGEC Checkout -cute $barcodesA $RAf . $checkoutA`;
	`mkdir $UMIstatsA`;
	`$MIGEC Histogram $checkoutA $UMIstatsA`;
	# if no cut-off is given by user, extract the estimated from MIGEC	
		if ($estimateA == 0) {
			open IN, "$UMIstatsA/estimates.txt" ;
			while ( <IN> ) {
				chomp;
				s/\r//g;
				my @line= split /[\t]+/;
				if ($. == 2) {
				$estimateA = $line[4];
				} 
			}
			close IN;
			# printing barplot for UMI coverage of RunA 	
			open SCRIPT, ">$rScript";
				print SCRIPT "data <- read.delim(\"$overseqA\", header=F)\n";
				print SCRIPT "td <- t(data.frame(data[-1,3:19]))\n";
				print SCRIPT "l <- data.frame(data[1,3:19])\n";
				print SCRIPT "png(filename=\"$overseqAhist\", height=400, width=400)\n";
				print SCRIPT "barplot(td, main=\"UMI coverage (MIG size)\", xlab=\"UMI coverage\",ylab=\"total read counts\",beside=T,names.arg=l,las=2,cex.names=.8,cex.lab=1.2,cex.axis=.8)\n";
				print SCRIPT "dev.off()\n";
			close SCRIPT;
			`$R --no-save < "$rScript"`;
			`rm $rScript`;
		}
	print STDERR "\n\trunning MIGEC on RunA using cut-off of $estimateA\n";
	`$MIGEC Assemble -cm $estimateA $UMIfastqA . $checkoutA`;
	$RAf=$checkoutA . $name . "_RunA_R0.t" . $estimateA . ".fastq.gz";
	
	# if 2 replicate samples are given proceed with Run B and combined fastq
	if ($runmode == 2) {
	# run MIGEC om RunB
		`$MIGEC Checkout -cute $barcodesB $RBf . $checkoutB`;
		`mkdir $UMIstatsB`;
		`$MIGEC Histogram $checkoutB $UMIstatsB`;
	# if no cut-off is given by user, extract the estimated from MIGEC	
		if ($estimateB == 0) {
			open IN, "$UMIstatsB/estimates.txt" ;
			while ( <IN> ) {
				chomp;
				s/\r//g;
				my @line= split /[\t]+/;
				if ($. == 2) {
				$estimateB = $line[4];
				} 
			}
			close IN;
			# printing barplot for UMI coverage of RunB
			open SCRIPT, ">$rScript";
				print SCRIPT "data <- read.delim(\"$overseqB\", header=F)\n";
				print SCRIPT "td <- t(data.frame(data[-1,3:19]))\n";
				print SCRIPT "l <- data.frame(data[1,3:19])\n";
				print SCRIPT "png(filename=\"$overseqBhist\", height=400, width=400)\n";
				print SCRIPT "barplot(td, main=\"UMI coverage (MIG size)\", xlab=\"UMI coverage\",ylab=\"total read counts\",beside=T,names.arg=l,las=2,cex.names=.8,cex.lab=1.2,cex.axis=.8)\n";
				print SCRIPT "dev.off()\n";
			close SCRIPT;
			`$R --no-save < "$rScript"`;
			`rm $rScript`;
		}
		print STDERR "\n\trunning MIGEC on RunB using cut-off of $estimateB\n";
		`$MIGEC Assemble -cm $estimateB $UMIfastqB . $checkoutB`;
		$RBf=$checkoutB . $name . "_RunB_R0.t" . $estimateB . ".fastq.gz";
		# run MIGEC on combined RunAB
		`$MIGEC Checkout -cute $barcodesC $RCf . $checkoutC`;
		`mkdir $UMIstatsC`;
		`$MIGEC Histogram $checkoutC $UMIstatsC`;
		# if no cut-off is given by user, extract the estimated from MIGEC	
		if ($estimateC == 0) {
			open IN, "$UMIstatsC/estimates.txt" ;
			while ( <IN> ) {
				chomp;
				s/\r//g;
				my @line= split /[\t]+/;
				if ($. == 2) {
				$estimateC = $line[4];
				} 
			}
			close IN;
			# printing barplot for UMI coverage of combined RunA & B 
			open SCRIPT, ">$rScript";
				print SCRIPT "data <- read.delim(\"$overseqC\", header=F)\n";
				print SCRIPT "td <- t(data.frame(data[-1,3:19]))\n";
				print SCRIPT "l <- data.frame(data[1,3:19])\n";
				print SCRIPT "png(filename=\"$overseqChist\", height=400, width=400)\n";
				print SCRIPT "barplot(td, main=\"UMI coverage (MIG size)\", xlab=\"UMI coverage\",ylab=\"total read counts\",beside=T,names.arg=l,las=2,cex.names=.8,cex.lab=1.2,cex.axis=.8)\n";
				print SCRIPT "dev.off()\n";
			close SCRIPT;
			`$R --no-save < "$rScript"`;
			`rm $rScript`;
		}
		print STDERR "\n\trunning MIGEC on combined RunAB using cut-off of $estimateC\n";
		`$MIGEC Assemble -cm $estimateC $UMIfastqC . $checkoutC`;
		$RCf=$checkoutC . $name . "_RunAB_R0.t" . $estimateC . ".fastq.gz";
	}
}


##########################################################################################
#  fastq are either assembled (default) or unassembled from here and either represent    #
#  UMI (or MIG) groups, or just reads. in the following, MIXCR is used to align fastq    #
#  data to TCR genes.                                                                    #
##########################################################################################


# if using replicate data

if ($runmode == 2) {
	
	if ($pear == 1) {
	print STDERR "\tprocessing replicates\n";

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $RAf $Avdjca 1> $outDir/$name.RunA.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Avdjca $Aclns 1>> $outDir/$name.RunA.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Aclns $Atxt 1>> $outDir/$name.RunA.report.log`;

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $RBf $Bvdjca 1> $outDir/$name.RunB.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Bvdjca $Bclns 1>> $outDir/$name.RunB.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Bclns $Btxt 1>> $outDir/$name.RunB.report.log`;

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $RCf $Cvdjca 1> $outDir/$name.RunAB.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Cvdjca $Cclns 1>> $outDir/$name.RunAB.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Cclns $Ctxt 1>> $outDir/$name.RunAB.report.log`;
	
	} else {
	print STDERR "\tprocessing replicates\n";

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $fastqR2A $fastqR1A $Avdjca 1> $outDir/$name.RunA.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Avdjca $Aclns 1>> $outDir/$name.RunA.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Aclns $Atxt 1>> $outDir/$name.RunA.report.log`;

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $fastqR2B $fastqR1B $Bvdjca 1> $outDir/$name.RunB.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Bvdjca $Bclns 1>> $outDir/$name.RunB.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Bclns $Btxt 1>> $outDir/$name.RunB.report.log`;

 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $fastqR2C $fastqR1C $Cvdjca 1> $outDir/$name.RunAB.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Cvdjca $Cclns 1>> $outDir/$name.RunAB.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Cclns $Ctxt 1>> $outDir/$name.RunAB.report.log`;

	}

# if using single data set

} elsif ($runmode == 1) {
	
	if ($pear == 1) {
	print STDERR "\n\taligning single sample\n";
 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $RAf $Avdjca 1> $outDir/$name.RunA.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Avdjca $Aclns 1>> $outDir/$name.RunA.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Aclns $Atxt 1>> $outDir/$name.RunA.report.log`;

	} else {

	print STDERR "\n\taligning single sample\n";
 		`$MIXCR align -f -s $species -t $threads -OvParameters.geneFeatureToAlign=VTranscript $fastqR2A $fastqR1A $Avdjca 1> $outDir/$name.RunA.report.log`;
 		`$MIXCR assemble -f -t $threads -ObadQualityThreshold=\"$badQualityThreshold\" $Avdjca $Aclns 1>> $outDir/$name.RunA.report.log`;
 		`$MIXCR exportClones -f -o -t --chains $TCR $Aclns $Atxt 1>> $outDir/$name.RunA.report.log`;
	}

}

# document software version in text file
open OUT, ">$Cversion";
my $version = `$MIXCR --version 2>&1` ;
print OUT "$version\n";
close OUT;


if ($runmode == 2) {
print STDERR "\n\tprinting summary ;\)\n";

my $logAal = $outDir . "/". $name . ".RunA.report.log";
my $logBal = $outDir . "/". $name . ".RunB.report.log";
my $logCal = $outDir . "/". $name . ".RunAB.report.log";
my $summary = $outDir . "/". $name . ".summary.txt";

my $logA = int(`awk '{if(/Total sequencing reads:/) print \$4}' < $logAal`);
my $logB = int(`awk '{if(/Total sequencing reads:/) print \$4}' < $logBal`);
my $logAr = int(`awk '{if(/Successfully aligned reads:/) print \$4}' < $logAal`);
my $logBr = int(`awk '{if(/Successfully aligned reads:/) print \$4}' < $logBal`);
my $logAa = int(`awk '{if(/Reads used in clonotypes, percent of total:/) print \$8}' < $logAal`);
my $logBa = int(`awk '{if(/Reads used in clonotypes, percent of total:/) print \$8}' < $logBal`);
my $logAc = int(`awk '{if(/Final clonotype count:/) print \$4}' < $logAal`);
my $logBc = int(`awk '{if(/Final clonotype count:/) print \$4}' < $logBal`);
my $logM = int(`awk '{if(/Final clonotype count:/) print \$4}' < $logCal`);

open OUT, ">$summary" or die "Could not open file: \"$summary\"\n";   
print OUT "sample\tprocessed_runA\tprocessed_runB\taligned_runA\taligned_runB\tassembled_runA\tassembled_runB\tclonotypes_runA\tclonotypes_runB\tclonotypes_merged\n";
print OUT "$name\t$logA\t$logB\t$logAr\t$logBr\t$logAa\t$logBa\t$logAc\t$logBc\t$logM\n";

}


#removing temporary files

 	`rm -r $tempDir`;

exit;
