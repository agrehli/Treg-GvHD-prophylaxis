#!/bin/bash
# by MR, originally February 2021, modified to focus on paper-relevant analyses in Oct. 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###					            TCR repertoire analyses for                            ###
###			    reisolated Treg from all BMT experiments (GvHD & no GvHD)              ###
###                                                                                    ###
##########################################################################################
##########################################################################################
##########################################################################################


# setting basic path

DIR_SOFT="/misc/software"
DIR_PKG="${DIR_SOFT}/ngs"
DIR_DATA="/misc/data"
TMPDIR="/loctmp"

# setting homer environment

PATH_PERL=${DIR_SOFT}/package/perl/perl-5.26.1/bin
PATH_SAMTOOLS=${DIR_PKG}/samtools/samtools-1.6/bin
PATH_HOMER=${DIR_PKG}/homer/v4.11/bin
PATH_R=${DIR_SOFT}/package/RBioC/buster_R-4.0.3_Bioc-3.12_intel-mkl-64bit-2020.1-102/lib/R/bin
export PATH=${PATH_PERL}:${PATH_SAMTOOLS}:${PATH_HOMER}:${PATH_R}:${PATH}
export PATH

# processed data directory
MAPPINGDIR="${DIR_DATA}/processedData/mapping/RNA/RepSeq/MIXCRv3"

# working directories
PROJECTDIR="${DIR_DATA}/analysis/project_TregProphylaxis"
WORKDIR_TCR="${PROJECTDIR}/bulkTCRrepertoire"
FIGURESDIR="${WORKDIR_TCR}/figures"
ANALYSISDIR="${WORKDIR_TCR}/analysis"
MIXDATA="${WORKDIR_TCR}/MixcrData"
IADATA="${WORKDIR_TCR}/immunArchData"
DATAREFORM="${IADATA}/reformated"



                      ########################################
                      #   distribution across ranked donors  #
                      ########################################

# here we use a modified barcodeplot function from the limma package to look at the distribution of 
# tissue clonotypes across the original ranked donor distribution of clonotypes. The barcode plot function 
# was modified to allow a fixed scale for the worms.  

# Plots were rearranged for Figures 5D, and Figures S5J,K,L

declare -a TXS=("Tx1" "Tx2" "Tx1c" "Tx2c") 
declare -a TYPES=("allo" "poly")
declare -a TCRS=("TRB")


for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
    	for TCR in "${TCRS[@]}"
    	do
_DATE=$(date +%s)
cat >"${TMPDIR}/R.barcode.${_DATE}.R" <<EOF
set.seed(42)
library(limma)
barcodeplot2 <- function (statistics, index = NULL, index2 = NULL, gene.weights = NULL, weights.label = "Weight", labels = c("Down", "Up"), quantiles = c(-1,1)*sqrt(2), col.bars = NULL, alpha = 0.4, worm = TRUE, span.worm = 0.45, xlab = "Statistic", max.worm.fix = NULL, ...)
{
	if(!is.vector(statistics, mode = "numeric")) stop("statistics should be a numeric vector")
	nstat <- length(statistics)
	if(is.null(index)) {
		if(is.null(gene.weights)) {
			stop("Must specify at least one of index or gene.weights")
		} else {
			if(length(gene.weights) == nstat) {
				index <- rep_len(TRUE, nstat)
				index2 <- NULL
			} else {
				stop("No index and length(gene.weights) doesn't equal length(statistics)")
			}
		}
	} else {
		if(anyNA(index)) stop("Need to provide index without NAs")
		if(is.logical(index)) if(length(index) != nstat) stop("Length of index disagrees with statistics")
		if(length(index) > nstat) stop("Length of index disagrees with statistics")
	}
	if(!is.null(index2)) {
		if(!is.null(gene.weights)) warning("gene.weights ignored")
		gene.weights <- statistics
		gene.weights[] <- 0
		gene.weights[index] <- 1
		gene.weights[index2] <- -1
		index <- rep_len(TRUE, nstat)
		index2 <- NULL
	}
	if(!is.null(gene.weights)){
		if(!is.vector(gene.weights, mode = "numeric")) stop("gene.weights should be a numeric vector")
		if(anyNA(gene.weights)) stop("Need to provide gene.weights without NAs")
		if(all(gene.weights == 0)) stop("gene.weights equal to zero: no selected genes to plot")
		if(length(gene.weights) != length(statistics[index])) stop("Length of gene.weights disagrees with size of set")
		one <- all(gene.weights >= 0) | all(gene.weights <= 0)
		if(one){
			index2 <- NULL
			gene.weights1 <- rep_len(0, nstat)
			names(gene.weights1) <- names(statistics)
			gene.weights1[index] <- gene.weights
			index <- rep_len(FALSE, nstat)
			names(index) <- names(statistics)
			index[gene.weights1 != 0] <- TRUE
			gene.weights1 <- gene.weights1[gene.weights1 != 0]
			gene.weights <- gene.weights1
		} else {
			gene.weights12 <- rep_len(0, nstat)
			names(gene.weights12) <- names(statistics)
			gene.weights12[index] <- gene.weights
			index <- index2 <- rep_len(FALSE, nstat)
			names(index) <- names(index2) <- names(statistics)
			index[gene.weights12 > 0] <- TRUE
			index2[gene.weights12 < 0] <- TRUE
			gene.weights1 <- gene.weights12[gene.weights12 > 0]
			gene.weights2 <- gene.weights12[gene.weights12 < 0]
			gene.weights <- gene.weights1
		}
	}
	TWO <- !is.null(index2)
	if(is.logical(index))
		idx <- index
	else {
		idx <- rep_len(FALSE,nstat)
		names(idx) <- names(statistics)
		idx[index] <- TRUE
	}
	set1 <- data.frame(idx = idx, weight = NA, wt = NA)
	if(TWO) {
		if(is.logical(index2))
			idx2 <- index2
		else {
			idx2 <- rep_len(FALSE,nstat)
			names(idx2) <- names(statistics)
			idx2[index2] <- TRUE
		}
		set2 <- data.frame(idx = idx2, weight = NA, wt = NA)
	}
	if(length(gene.weights)) {
		set1\$weight <- 0
		set1\$weight[index] <- gene.weights
		set1\$wt <- abs(set1\$weight)/sum(abs(set1\$weight))
		if(TWO) {
			set2\$weight <- 0
			set2\$weight[index2] <- gene.weights2
			SUM <- sum(abs(set1\$weight), abs(set2\$weight))
			set1\$wt <- abs(set1\$weight)/SUM
			set2\$wt <- abs(set2\$weight)/SUM
		}
	}
	ostat <- order(statistics, na.last = TRUE, decreasing=FALSE)
	statistics <- statistics[ostat]
	set1 <- set1[ostat,]
	if(TWO) set2 <- set2[ostat,]
	n <- sum(!is.na(statistics))
	if(n==0L) {
		message("No valid statistics")
		return(invisible())
	}
	if (n < nstat) {
		statistics <- statistics[1:n]
		set1 <- set1[1:n,]
		if (TWO) set2 <- set2[1:n,]
	}
	r <- which(set1\$idx)
	if (TWO) {
		r2 <- which(set2\$idx)
		if(!length(r2)) TWO <- FALSE
	}
	if(!length(r))
		if(TWO) {
			r <- r2
			set1 <- set2
			TWO <- FALSE
		} else {
			message("No selected genes to plot")
			return(invisible())
		}
	WTS <- FALSE
	wt1 <- set1\$wt[r]
	len.up <- 1
	if(!anyNA(wt1)) {
		len.up <- set1\$weight[r]/max(abs(set1\$weight[r]))
		anydifferent <- function(x) {
			if(length(x) < 2) return(FALSE)
			r <- range(x)
			(r[2] > r[1])
		}
		if(!TWO) if(anydifferent(wt1)) WTS <- TRUE
		if(TWO){
			wt12 <- c(set1\$wt[r], abs(set2\$wt[r2]))
			if(anydifferent(wt12)) WTS <- TRUE
			max.wt <- max(set1\$wt[r], set2\$wt[r2])
			len.up <- set1\$wt[r]/max.wt
			len.down <- set2\$wt[r2]/max.wt
		}
	}
	pos.dir <- all(len.up > 0)
	if(WTS) shift <- 0.1 else shift <- 0
	quantiles <- sort(quantiles)
	ALP <- alpha
	ALP <- min(ALP,1)
	ALP <- max(ALP,0.1)
	if (is.null(col.bars)) {
		if (TWO) {
			col.bars <- c("red", "blue")
			if(WTS) col.bars.alpha <- c(rgb(1,0,0,alpha=ALP), rgb(0,0,1,alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			col.bars <- "black"
			if(WTS) col.bars.alpha <- rgb(0,0,0,alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	} else {
		if(TWO) {
			if(length(col.bars) == 1) col.bars <- rep(col.bars, 2)
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			red2 <- RGB[1,2]
			green2 <- RGB[2,2]
			blue2 <- RGB[3,2]
			if(WTS) col.bars.alpha <- c(rgb(red, green, blue, alpha=ALP), rgb(red2, green2, blue2, alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			if(WTS) col.bars.alpha <- rgb(red, green, blue, alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	}
	ylim.worm <- ylim <- c(-1, 1)
	ylab.worm <- ""
	xlab.worm <- xlab
	if(!TWO) ylim.worm <- c(0, 1)
	if(worm) {
		ylim.worm <- c(-2.1, 2.1)
		if(!TWO) ylim.worm <- c(0, 2.1)
	}
	ylim[2] <- ylim[2] + 0.5
	if (TWO) ylim[1] <- ylim[1] - 0.5
	if(TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift, ylim.worm[2]+shift), type="n", axes=FALSE, xlab=xlab.worm, ylab=ylab.worm, ...)
	if(!TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift*(!pos.dir), ylim.worm[2]+shift*pos.dir), type="n", axes=FALSE, xlab=xlab.worm,ylab=ylab.worm, ...)
	npos <- sum(statistics > quantiles[2])
	nneg <- sum(statistics < quantiles[1])
	lwd <- 50/length(r)
	lwd <- min(1.9, lwd)
	lwd <- max(0.2, lwd)
	if(TWO){
		lwd2 <- 50/length(r2)
		lwd2 <- min(1.9, lwd2)
		lwd2 <- max(0.2, lwd2)
		lwd <- lwd2 <- min(lwd, lwd2)
	}
	barlim <- ylim[2] - c(1.5, 0.5)
	if(!pos.dir) {
		rect.yb <- 0.5
		rect.yt <- 1
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[2]/2, r, barlim[2], lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2-shift, r, barlim[2]/2*(1+len.up)-shift, lwd = lwd, col = col.bars[1])
	}
	if(pos.dir) {
		rect.yb <- -0.5
		if(!TWO) rect.yb <- 0
		rect.yt <- 0.5
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[1], r, barlim[2]/2, lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2+shift, r, barlim[2]/2*(1+len.up)+shift, lwd = lwd, col = col.bars[1])
	}
	if(TWO) {
		barlim2 <- ylim[1] + c(0.5, 1.5)
		segments(r2, barlim2[1]/2, r2, barlim2[2], lwd = lwd2, col = col.bars.alpha[2])
		segments(r2, barlim2[1]/2*(1+len.down)-shift, r2, barlim2[1]/2-shift, lwd = lwd2, col = col.bars[2])
	}
	lab.at <- 0
	if(!TWO) lab.at <- 0.5
	axis(side = 2, at = lab.at, padj = 3.8, cex.axis = 0.85, labels = labels[1], tick = FALSE)
	axis(side = 4, at = lab.at, padj = -3.8, cex.axis = 0.85, labels = labels[2], tick = FALSE)
	prob <- (0:10)/10
	axis(at = seq(1,n,len=11), side = 1, cex.axis = 0.7, las = 2, labels = format(quantile(statistics, p = prob), digits = 1))
	if(worm) {
		rescale <- function(x, newrange, oldrange=range(x)) {
			newrange[1] + (x-oldrange[1]) / (oldrange[2]-oldrange[1]) * (newrange[2] - newrange[1])
		}
		if(!WTS){
			ave.enrich1 <- length(r)/n
			worm1 <- tricubeMovingAverage(set1\$idx, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- length(r2)/n
				worm2 <- tricubeMovingAverage(-set2\$idx, span = span.worm)/ave.enrich2
			}
		}
		if(WTS){
			ave.enrich1 <- mean(set1\$wt)
			worm1 <- tricubeMovingAverage(set1\$wt, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- mean(set2\$wt)
				worm2 <- tricubeMovingAverage(-set2\$wt, span = span.worm)/ave.enrich2
			}
		}
		max.worm1 <- max(worm1)
	    if(!is.null(max.worm.fix)){
		max.worm1 <- max.worm.fix
        }
		r.worm1 <- c(0,max.worm1)
		worm1.scale <- rescale(worm1, newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir), oldrange=r.worm1)
		if(TWO) {
			min.worm2 <- min(worm2)
			r.worm2 <- c(min.worm2,0)
			worm2.scale <- rescale(worm2, newrange=c(-2.1-shift,-1.1-shift), oldrange=r.worm2)
		}
		if(!TWO) {
			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir),oldrange=r.worm1), lty=2)
			axis(side = 2, at = c(1.1+shift*pos.dir, 2.1+shift*pos.dir), cex.axis = 0.8, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, labels = "Enrichment", at = 1.6+shift*pos.dir, padj = -0.6, tick = FALSE, cex.axis = 0.8)
		}
		if(TWO) {

			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift,2.1+shift),oldrange=r.worm1), lty=2)

			lines(x = 1:n, y = worm2.scale, col = col.bars[2], lwd = 2)
			abline(h = rescale(-1,newrange=c(-2.1-shift,-1.1-shift),oldrange=r.worm2), lty=2)

			axis(side = 2, at = c(1.1+shift, 2.1+shift), cex.axis = 0.7, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, at = c(-1.1-shift, -2.1-shift), cex.axis = 0.7, labels =  c(0, format(-min.worm2, digits = 2)))

			axis(side = 2, labels = "Enrichment", at = 1.6+shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
			axis(side = 2, labels = "Enrichment", at = -1.6-shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
		}
	}
	if(WTS){
		if(!TWO){
			if(pos.dir){
				axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.48, padj = 1.6, labels = c(0, format(max(set1\$weight[r]), digits = 2)))
				axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
			if(!pos.dir){
				axis(side = 2, at = c(0-shift, 0.5-shift), cex.axis = 0.48, padj = 1.6, labels = c(format(min(set1\$weight[r]), digits = 2), 0))
				axis(side = 2, labels = weights.label[1], at = 0.25-shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
		}
		if(TWO){
			max.weight <- max(set1\$weight[r], abs(set2\$weight[r2]))
			axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.43, labels = c(0, format(max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.46)
			axis(side = 2, at = c(-0.5-shift, -1-shift), cex.axis = 0.43, labels = c(0, format(-max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = -0.75-shift, padj = 1, tick = FALSE, cex.axis = 0.46)
		}
	}
	invisible()
}


table <- read.table("${ANALYSISDIR}/Treg_${TCR}_${TX}_${TYPE}_merged.clonotypeTable.groups.txt", header=T, sep="\t")
rows <- sample(nrow(table))
x <- table[rows, ]
y <- x[order(x\$donor),] 
z <- subset(y, y\$donor > 1)
spl <- subset(z, z\$spleen > 0, select=ID)
liv<- subset(z, z\$liver > 0, select=ID)
col <- subset(z, z\$colon > 0, select=ID)
ind1 <-z\$ID %in% spl[[1]]
ind2 <-z\$ID %in% liv[[1]]
ind3 <-z\$ID %in% col[[1]]
z\$log <- -log10(z\$donor)
range <- seq(1,nrow(z))
head(range)
svg(file="${FIGURESDIR}/TCRdistribution.barcodeplot_${TCR}_${TX}_${TYPE}_merged.min2.svg", height=10, width=4)
layout(matrix(c(1,2,3,4), nrow = 4, ncol = 1), heights=c(2,2,2,1.5))
barcodeplot2(z\$donor, index=ind1, labels=c("low","high"), main="spleen-${TCR}-${TX}-${TYPE}", col.bars="deeppink", max.worm.fix=4.5)
barcodeplot2(z\$donor, index=ind2, labels=c("low","high"), main="liver-${TCR}-${TX}-${TYPE}", col.bars="steelblue", max.worm.fix=4.5)
barcodeplot2(z\$donor, index=ind3, labels=c("low","high"), main="colon-${TCR}-${TX}-${TYPE}", col.bars="sienna", max.worm.fix=4.5)
plot(z\$log,type="n",axes=FALSE,ylim=c(-3,0), ylab = "size")
polygon( c(min(range), range , max(range)) , c(0 , z\$log ,0) , col="gray" , border=F)
axis(2, at=c(-3,0),labels=c(3,0))
dev.off()
EOF
#chmod 750 "${TMPDIR}/R.barcode.${_DATE}.R"
R < ${TMPDIR}/R.barcode.${_DATE}.R  --no-save
rm ${TMPDIR}/R.barcode.${_DATE}.R
		done
	done
done



                          ###################################
                          #   gene usage across replicates  #
                          ###################################

# collecting all samples into one folder

# TRB
mkdir ${MIXDATA}/allTRB
rm -r ${MIXDATA}/allTRB

# loop for all tissue samples

declare -a TXS=("Tx1" "Tx1c") 
declare -a TYPES=("allo" "poly")
declare -a TISSUES=("spleen" "liver" "colon")

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
    	for TISSUE in "${TISSUES[@]}"
    	do
			for ((i=1;i<=3;i++));do
ln -s ${MIXDATA}/Treg_TRB_${TX}_${TYPE}_merged/${TISSUE}_${i}.txt ${MIXDATA}/allTRB/${TX:0:2}${TX:3:1}_${TYPE}_${TISSUE}_${i}
			done
		done
	done
done

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
ln -s ${MIXDATA}/Treg_TRB_${TX}_${TYPE}_merged/adonor_1.txt ${MIXDATA}/allTRB/${TX:0:2}${TX:3:1}_${TYPE}_adonor_1
	done
done



declare -a TXS=("Tx2" "Tx2c") 
declare -a TYPES=("allo" "poly")
declare -a TISSUES=("spleen" "liver" "colon")

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
    	for TISSUE in "${TISSUES[@]}"
    	do
			for ((i=4;i<=6;i++));do
ln -s ${MIXDATA}/Treg_TRB_${TX}_${TYPE}_merged/${TISSUE}_${i}.txt ${MIXDATA}/allTRB/${TX:0:2}${TX:3:1}_${TYPE}_${TISSUE}_${i}
			done
		done
	done
done

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
ln -s ${MIXDATA}/Treg_TRB_${TX}_${TYPE}_merged/adonor_2.txt ${MIXDATA}/allTRB/${TX:0:2}${TX:3:1}_${TYPE}_adonor_2
	done
done


# creating metadata table

TAB=$(echo -e "\t")
cat >"${MIXDATA}/allTRB/metadata.txt" <<EOF
Sample${TAB}Trans${TAB}Expand${TAB}Origin
Tx_allo_adonor_1${TAB}Tx${TAB}allo${TAB}adonor
Tx_allo_adonor_2${TAB}Tx${TAB}allo${TAB}adonor
Tx_poly_adonor_1${TAB}Tx${TAB}poly${TAB}adonor
Tx_poly_adonor_2${TAB}Tx${TAB}poly${TAB}adonor
Tx_allo_colon_1${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_colon_2${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_colon_3${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_colon_4${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_colon_5${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_colon_6${TAB}Tx${TAB}allo${TAB}colon
Tx_allo_liver_1${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_liver_2${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_liver_3${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_liver_4${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_liver_5${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_liver_6${TAB}Tx${TAB}allo${TAB}liver
Tx_allo_spleen_1${TAB}Tx${TAB}allo${TAB}spleen
Tx_allo_spleen_2${TAB}Tx${TAB}allo${TAB}spleen
Tx_allo_spleen_3${TAB}Tx${TAB}allo${TAB}spleen
Tx_allo_spleen_4${TAB}Tx${TAB}allo${TAB}spleen
Tx_allo_spleen_5${TAB}Tx${TAB}allo${TAB}spleen
Tx_allo_spleen_6${TAB}Tx${TAB}allo${TAB}spleen
Tx_poly_colon_1${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_colon_2${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_colon_3${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_colon_4${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_colon_5${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_colon_6${TAB}Tx${TAB}poly${TAB}colon
Tx_poly_liver_1${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_liver_2${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_liver_3${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_liver_4${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_liver_5${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_liver_6${TAB}Tx${TAB}poly${TAB}liver
Tx_poly_spleen_1${TAB}Tx${TAB}poly${TAB}spleen
Tx_poly_spleen_2${TAB}Tx${TAB}poly${TAB}spleen
Tx_poly_spleen_3${TAB}Tx${TAB}poly${TAB}spleen
Tx_poly_spleen_4${TAB}Tx${TAB}poly${TAB}spleen
Tx_poly_spleen_5${TAB}Tx${TAB}poly${TAB}spleen
Tx_poly_spleen_6${TAB}Tx${TAB}poly${TAB}spleen
Txc_allo_adonor_1${TAB}Txc${TAB}allo${TAB}adonor
Txc_allo_adonor_2${TAB}Txc${TAB}allo${TAB}adonor
Txc_poly_adonor_1${TAB}Txc${TAB}poly${TAB}adonor
Txc_poly_adonor_2${TAB}Txc${TAB}poly${TAB}adonor
Txc_allo_colon_1${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_colon_2${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_colon_3${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_colon_4${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_colon_5${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_colon_6${TAB}Txc${TAB}allo${TAB}colon
Txc_allo_liver_1${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_liver_2${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_liver_3${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_liver_4${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_liver_5${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_liver_6${TAB}Txc${TAB}allo${TAB}liver
Txc_allo_spleen_1${TAB}Txc${TAB}allo${TAB}spleen
Txc_allo_spleen_2${TAB}Txc${TAB}allo${TAB}spleen
Txc_allo_spleen_3${TAB}Txc${TAB}allo${TAB}spleen
Txc_allo_spleen_4${TAB}Txc${TAB}allo${TAB}spleen
Txc_allo_spleen_5${TAB}Txc${TAB}allo${TAB}spleen
Txc_allo_spleen_6${TAB}Txc${TAB}allo${TAB}spleen
Txc_poly_colon_1${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_colon_2${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_colon_3${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_colon_4${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_colon_5${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_colon_6${TAB}Txc${TAB}poly${TAB}colon
Txc_poly_liver_1${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_liver_2${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_liver_3${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_liver_4${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_liver_5${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_liver_6${TAB}Txc${TAB}poly${TAB}liver
Txc_poly_spleen_1${TAB}Txc${TAB}poly${TAB}spleen
Txc_poly_spleen_2${TAB}Txc${TAB}poly${TAB}spleen
Txc_poly_spleen_3${TAB}Txc${TAB}poly${TAB}spleen
Txc_poly_spleen_4${TAB}Txc${TAB}poly${TAB}spleen
Txc_poly_spleen_5${TAB}Txc${TAB}poly${TAB}spleen
Txc_poly_spleen_6${TAB}Txc${TAB}poly${TAB}spleen
EOF


# diversity analysis and gene segment distribution (for TRB) done in R

cd ${WORKDIR_TCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure5eS5n_Treg_BMT_analyses_TRB.Rmd", "html_document")
q()
 


# further analyses of colon enriched TRVB segments

# are these frequent or rare clonotypes in the donor populations?
# barcodeplots shown in Figure S5n

# in extra screen

declare -a TXS=("Tx1" "Tx2" "Tx1c" "Tx2c")
declare -a TYPES=("allo" "poly")

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
TCR="TRB"
_DATE=$(date +%s)
cat >"${TMPDIR}/R.barcode.${_DATE}.R" <<EOF
set.seed(42)
library(gplots)
library(limma)
barcodeplot2 <- function (statistics, index = NULL, index2 = NULL, gene.weights = NULL, weights.label = "Weight", labels = c("Down", "Up"), quantiles = c(-1,1)*sqrt(2), col.bars = NULL, alpha = 0.4, worm = TRUE, span.worm = 0.45, xlab = "Statistic", max.worm.fix = NULL, ...)
{
	if(!is.vector(statistics, mode = "numeric")) stop("statistics should be a numeric vector")
	nstat <- length(statistics)
	if(is.null(index)) {
		if(is.null(gene.weights)) {
			stop("Must specify at least one of index or gene.weights")
		} else {
			if(length(gene.weights) == nstat) {
				index <- rep_len(TRUE, nstat)
				index2 <- NULL
			} else {
				stop("No index and length(gene.weights) doesn't equal length(statistics)")
			}
		}
	} else {
		if(anyNA(index)) stop("Need to provide index without NAs")
		if(is.logical(index)) if(length(index) != nstat) stop("Length of index disagrees with statistics")
		if(length(index) > nstat) stop("Length of index disagrees with statistics")
	}
	if(!is.null(index2)) {
		if(!is.null(gene.weights)) warning("gene.weights ignored")
		gene.weights <- statistics
		gene.weights[] <- 0
		gene.weights[index] <- 1
		gene.weights[index2] <- -1
		index <- rep_len(TRUE, nstat)
		index2 <- NULL
	}
	if(!is.null(gene.weights)){
		if(!is.vector(gene.weights, mode = "numeric")) stop("gene.weights should be a numeric vector")
		if(anyNA(gene.weights)) stop("Need to provide gene.weights without NAs")
		if(all(gene.weights == 0)) stop("gene.weights equal to zero: no selected genes to plot")
		if(length(gene.weights) != length(statistics[index])) stop("Length of gene.weights disagrees with size of set")
		one <- all(gene.weights >= 0) | all(gene.weights <= 0)
		if(one){
			index2 <- NULL
			gene.weights1 <- rep_len(0, nstat)
			names(gene.weights1) <- names(statistics)
			gene.weights1[index] <- gene.weights
			index <- rep_len(FALSE, nstat)
			names(index) <- names(statistics)
			index[gene.weights1 != 0] <- TRUE
			gene.weights1 <- gene.weights1[gene.weights1 != 0]
			gene.weights <- gene.weights1
		} else {
			gene.weights12 <- rep_len(0, nstat)
			names(gene.weights12) <- names(statistics)
			gene.weights12[index] <- gene.weights
			index <- index2 <- rep_len(FALSE, nstat)
			names(index) <- names(index2) <- names(statistics)
			index[gene.weights12 > 0] <- TRUE
			index2[gene.weights12 < 0] <- TRUE
			gene.weights1 <- gene.weights12[gene.weights12 > 0]
			gene.weights2 <- gene.weights12[gene.weights12 < 0]
			gene.weights <- gene.weights1
		}
	}
	TWO <- !is.null(index2)
	if(is.logical(index))
		idx <- index
	else {
		idx <- rep_len(FALSE,nstat)
		names(idx) <- names(statistics)
		idx[index] <- TRUE
	}
	set1 <- data.frame(idx = idx, weight = NA, wt = NA)
	if(TWO) {
		if(is.logical(index2))
			idx2 <- index2
		else {
			idx2 <- rep_len(FALSE,nstat)
			names(idx2) <- names(statistics)
			idx2[index2] <- TRUE
		}
		set2 <- data.frame(idx = idx2, weight = NA, wt = NA)
	}
	if(length(gene.weights)) {
		set1\$weight <- 0
		set1\$weight[index] <- gene.weights
		set1\$wt <- abs(set1\$weight)/sum(abs(set1\$weight))
		if(TWO) {
			set2\$weight <- 0
			set2\$weight[index2] <- gene.weights2
			SUM <- sum(abs(set1\$weight), abs(set2\$weight))
			set1\$wt <- abs(set1\$weight)/SUM
			set2\$wt <- abs(set2\$weight)/SUM
		}
	}
	ostat <- order(statistics, na.last = TRUE, decreasing=FALSE)
	statistics <- statistics[ostat]
	set1 <- set1[ostat,]
	if(TWO) set2 <- set2[ostat,]
	n <- sum(!is.na(statistics))
	if(n==0L) {
		message("No valid statistics")
		return(invisible())
	}
	if (n < nstat) {
		statistics <- statistics[1:n]
		set1 <- set1[1:n,]
		if (TWO) set2 <- set2[1:n,]
	}
	r <- which(set1\$idx)
	if (TWO) {
		r2 <- which(set2\$idx)
		if(!length(r2)) TWO <- FALSE
	}
	if(!length(r))
		if(TWO) {
			r <- r2
			set1 <- set2
			TWO <- FALSE
		} else {
			message("No selected genes to plot")
			return(invisible())
		}
	WTS <- FALSE
	wt1 <- set1\$wt[r]
	len.up <- 1
	if(!anyNA(wt1)) {
		len.up <- set1\$weight[r]/max(abs(set1\$weight[r]))
		anydifferent <- function(x) {
			if(length(x) < 2) return(FALSE)
			r <- range(x)
			(r[2] > r[1])
		}
		if(!TWO) if(anydifferent(wt1)) WTS <- TRUE
		if(TWO){
			wt12 <- c(set1\$wt[r], abs(set2\$wt[r2]))
			if(anydifferent(wt12)) WTS <- TRUE
			max.wt <- max(set1\$wt[r], set2\$wt[r2])
			len.up <- set1\$wt[r]/max.wt
			len.down <- set2\$wt[r2]/max.wt
		}
	}
	pos.dir <- all(len.up > 0)
	if(WTS) shift <- 0.1 else shift <- 0
	quantiles <- sort(quantiles)
	ALP <- alpha
	ALP <- min(ALP,1)
	ALP <- max(ALP,0.1)
	if (is.null(col.bars)) {
		if (TWO) {
			col.bars <- c("red", "blue")
			if(WTS) col.bars.alpha <- c(rgb(1,0,0,alpha=ALP), rgb(0,0,1,alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			col.bars <- "black"
			if(WTS) col.bars.alpha <- rgb(0,0,0,alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	} else {
		if(TWO) {
			if(length(col.bars) == 1) col.bars <- rep(col.bars, 2)
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			red2 <- RGB[1,2]
			green2 <- RGB[2,2]
			blue2 <- RGB[3,2]
			if(WTS) col.bars.alpha <- c(rgb(red, green, blue, alpha=ALP), rgb(red2, green2, blue2, alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			if(WTS) col.bars.alpha <- rgb(red, green, blue, alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	}
	ylim.worm <- ylim <- c(-1, 1)
	ylab.worm <- ""
	xlab.worm <- xlab
	if(!TWO) ylim.worm <- c(0, 1)
	if(worm) {
		ylim.worm <- c(-2.1, 2.1)
		if(!TWO) ylim.worm <- c(0, 2.1)
	}
	ylim[2] <- ylim[2] + 0.5
	if (TWO) ylim[1] <- ylim[1] - 0.5
	if(TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift, ylim.worm[2]+shift), type="n", axes=FALSE, xlab=xlab.worm, ylab=ylab.worm, ...)
	if(!TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift*(!pos.dir), ylim.worm[2]+shift*pos.dir), type="n", axes=FALSE, xlab=xlab.worm,ylab=ylab.worm, ...)
	npos <- sum(statistics > quantiles[2])
	nneg <- sum(statistics < quantiles[1])
	lwd <- 50/length(r)
	lwd <- min(1.9, lwd)
	lwd <- max(0.2, lwd)
	if(TWO){
		lwd2 <- 50/length(r2)
		lwd2 <- min(1.9, lwd2)
		lwd2 <- max(0.2, lwd2)
		lwd <- lwd2 <- min(lwd, lwd2)
	}
	barlim <- ylim[2] - c(1.5, 0.5)
	if(!pos.dir) {
		rect.yb <- 0.5
		rect.yt <- 1
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[2]/2, r, barlim[2], lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2-shift, r, barlim[2]/2*(1+len.up)-shift, lwd = lwd, col = col.bars[1])
	}
	if(pos.dir) {
		rect.yb <- -0.5
		if(!TWO) rect.yb <- 0
		rect.yt <- 0.5
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[1], r, barlim[2]/2, lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2+shift, r, barlim[2]/2*(1+len.up)+shift, lwd = lwd, col = col.bars[1])
	}
	if(TWO) {
		barlim2 <- ylim[1] + c(0.5, 1.5)
		segments(r2, barlim2[1]/2, r2, barlim2[2], lwd = lwd2, col = col.bars.alpha[2])
		segments(r2, barlim2[1]/2*(1+len.down)-shift, r2, barlim2[1]/2-shift, lwd = lwd2, col = col.bars[2])
	}
	lab.at <- 0
	if(!TWO) lab.at <- 0.5
	axis(side = 2, at = lab.at, padj = 3.8, cex.axis = 0.85, labels = labels[1], tick = FALSE)
	axis(side = 4, at = lab.at, padj = -3.8, cex.axis = 0.85, labels = labels[2], tick = FALSE)
	prob <- (0:10)/10
	axis(at = seq(1,n,len=11), side = 1, cex.axis = 0.7, las = 2, labels = format(quantile(statistics, p = prob), digits = 1))
	if(worm) {
		rescale <- function(x, newrange, oldrange=range(x)) {
			newrange[1] + (x-oldrange[1]) / (oldrange[2]-oldrange[1]) * (newrange[2] - newrange[1])
		}
		if(!WTS){
			ave.enrich1 <- length(r)/n
			worm1 <- tricubeMovingAverage(set1\$idx, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- length(r2)/n
				worm2 <- tricubeMovingAverage(-set2\$idx, span = span.worm)/ave.enrich2
			}
		}
		if(WTS){
			ave.enrich1 <- mean(set1\$wt)
			worm1 <- tricubeMovingAverage(set1\$wt, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- mean(set2\$wt)
				worm2 <- tricubeMovingAverage(-set2\$wt, span = span.worm)/ave.enrich2
			}
		}
		max.worm1 <- max(worm1)
	    if(!is.null(max.worm.fix)){
		max.worm1 <- max.worm.fix
        }
		r.worm1 <- c(0,max.worm1)
		worm1.scale <- rescale(worm1, newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir), oldrange=r.worm1)
		if(TWO) {
			min.worm2 <- min(worm2)
			r.worm2 <- c(min.worm2,0)
			worm2.scale <- rescale(worm2, newrange=c(-2.1-shift,-1.1-shift), oldrange=r.worm2)
		}
		if(!TWO) {
			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir),oldrange=r.worm1), lty=2)
			axis(side = 2, at = c(1.1+shift*pos.dir, 2.1+shift*pos.dir), cex.axis = 0.8, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, labels = "Enrichment", at = 1.6+shift*pos.dir, padj = -0.6, tick = FALSE, cex.axis = 0.8)
		}
		if(TWO) {

			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift,2.1+shift),oldrange=r.worm1), lty=2)

			lines(x = 1:n, y = worm2.scale, col = col.bars[2], lwd = 2)
			abline(h = rescale(-1,newrange=c(-2.1-shift,-1.1-shift),oldrange=r.worm2), lty=2)

			axis(side = 2, at = c(1.1+shift, 2.1+shift), cex.axis = 0.7, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, at = c(-1.1-shift, -2.1-shift), cex.axis = 0.7, labels =  c(0, format(-min.worm2, digits = 2)))

			axis(side = 2, labels = "Enrichment", at = 1.6+shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
			axis(side = 2, labels = "Enrichment", at = -1.6-shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
		}
	}
	if(WTS){
		if(!TWO){
			if(pos.dir){
				axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.48, padj = 1.6, labels = c(0, format(max(set1\$weight[r]), digits = 2)))
				axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
			if(!pos.dir){
				axis(side = 2, at = c(0-shift, 0.5-shift), cex.axis = 0.48, padj = 1.6, labels = c(format(min(set1\$weight[r]), digits = 2), 0))
				axis(side = 2, labels = weights.label[1], at = 0.25-shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
		}
		if(TWO){
			max.weight <- max(set1\$weight[r], abs(set2\$weight[r2]))
			axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.43, labels = c(0, format(max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.46)
			axis(side = 2, at = c(-0.5-shift, -1-shift), cex.axis = 0.43, labels = c(0, format(-max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = -0.75-shift, padj = 1, tick = FALSE, cex.axis = 0.46)
		}
	}
	invisible()
}


table <- read.table("${ANALYSISDIR}/Treg_${TCR}_${TX}_${TYPE}_merged.clonotypeTable.groups.txt", header=T, sep="\t")
splnames <- unlist(strsplit(as.character(table\$ID),"[_]"))
row.matrix <- matrix( splnames , ncol = 4 , byrow = TRUE )
colnames(row.matrix) <- c("nt","aa","V","J")
ext <- cbind(table, row.matrix)
rows <- sample(nrow(ext))
x <- ext[rows, ]
z <- x[order(x\$donor),] 
donV <- subset(z[with(z, V %in% c("TRBV12-1","TRBV12-2","TRBV26")),], select=ID)
ind1 <-z\$ID %in% donV[[1]]
s <- x[order(x\$spleen),]
spl <- subset(s, s\$spleen > 0)
splV <- subset(spl[with(spl, V %in% c("TRBV12-1","TRBV12-2","TRBV26")),], select=ID)
ind2 <-spl\$ID %in% splV[[1]]

l <- x[order(x\$liver),]
liv <- subset(l, l\$liver > 0)
livV <- subset(liv[with(liv, V %in% c("TRBV12-1","TRBV12-2","TRBV26")),], select=ID)
ind3 <-liv\$ID %in% livV[[1]]

c <- x[order(x\$colon),]
col <- subset(c, c\$colon > 0)
colV <- subset(col[with(col, V %in% c("TRBV12-1","TRBV12-2","TRBV26")),], select=ID)
ind4 <-col\$ID %in% colV[[1]]

svg(file="${FIGURESDIR}/TCRdistribution.barcodeplot_${TCR}_${TX}_${TYPE}_merged.TRBV12-26.svg", height=10, width=4)
layout(matrix(c(1,2,3,4), nrow = 4, ncol = 1), heights=c(2,2,2,2))
barcodeplot2(z\$donor, index=ind1, labels=c("low","high"), main="donor-${TCR}-${TX}-${TYPE}", col.bars="firebrick", max.worm.fix=2)
barcodeplot2(spl\$spleen, index=ind2, labels=c("low","high"), main="spleen-${TCR}-${TX}-${TYPE}", col.bars="deeppink", max.worm.fix=2)
barcodeplot2(liv\$liver, index=ind3, labels=c("low","high"), main="liver-${TCR}-${TX}-${TYPE}", col.bars="steelblue", max.worm.fix=2)
barcodeplot2(col\$colon, index=ind4, labels=c("low","high"), main="colon-${TCR}-${TX}-${TYPE}", col.bars="sienna", max.worm.fix=2)
dev.off()
EOF
R < ${TMPDIR}/R.barcode.${_DATE}.R  --no-save
rm ${TMPDIR}/R.barcode.${_DATE}.R
	done
done

# same plots for donors only

declare -a TXS=("Tx1" "Tx2" "Tx1c" "Tx2c")
declare -a TYPES=("allo" "poly")

for TX in "${TXS[@]}"
    do
	for TYPE in "${TYPES[@]}"
	    do
_DATE=$(date +%s)
cat >"${TMPDIR}/R.barcode.${_DATE}.R" <<EOF
set.seed(42)
library(gplots)
library(edgeR)
barcodeplot2 <- function (statistics, index = NULL, index2 = NULL, gene.weights = NULL, weights.label = "Weight", labels = c("Down", "Up"), quantiles = c(-1,1)*sqrt(2), col.bars = NULL, alpha = 0.4, worm = TRUE, span.worm = 0.45, xlab = "Statistic", max.worm.fix = NULL, ...)
{
	if(!is.vector(statistics, mode = "numeric")) stop("statistics should be a numeric vector")
	nstat <- length(statistics)
	if(is.null(index)) {
		if(is.null(gene.weights)) {
			stop("Must specify at least one of index or gene.weights")
		} else {
			if(length(gene.weights) == nstat) {
				index <- rep_len(TRUE, nstat)
				index2 <- NULL
			} else {
				stop("No index and length(gene.weights) doesn't equal length(statistics)")
			}
		}
	} else {
		if(anyNA(index)) stop("Need to provide index without NAs")
		if(is.logical(index)) if(length(index) != nstat) stop("Length of index disagrees with statistics")
		if(length(index) > nstat) stop("Length of index disagrees with statistics")
	}
	if(!is.null(index2)) {
		if(!is.null(gene.weights)) warning("gene.weights ignored")
		gene.weights <- statistics
		gene.weights[] <- 0
		gene.weights[index] <- 1
		gene.weights[index2] <- -1
		index <- rep_len(TRUE, nstat)
		index2 <- NULL
	}
	if(!is.null(gene.weights)){
		if(!is.vector(gene.weights, mode = "numeric")) stop("gene.weights should be a numeric vector")
		if(anyNA(gene.weights)) stop("Need to provide gene.weights without NAs")
		if(all(gene.weights == 0)) stop("gene.weights equal to zero: no selected genes to plot")
		if(length(gene.weights) != length(statistics[index])) stop("Length of gene.weights disagrees with size of set")
		one <- all(gene.weights >= 0) | all(gene.weights <= 0)
		if(one){
			index2 <- NULL
			gene.weights1 <- rep_len(0, nstat)
			names(gene.weights1) <- names(statistics)
			gene.weights1[index] <- gene.weights
			index <- rep_len(FALSE, nstat)
			names(index) <- names(statistics)
			index[gene.weights1 != 0] <- TRUE
			gene.weights1 <- gene.weights1[gene.weights1 != 0]
			gene.weights <- gene.weights1
		} else {
			gene.weights12 <- rep_len(0, nstat)
			names(gene.weights12) <- names(statistics)
			gene.weights12[index] <- gene.weights
			index <- index2 <- rep_len(FALSE, nstat)
			names(index) <- names(index2) <- names(statistics)
			index[gene.weights12 > 0] <- TRUE
			index2[gene.weights12 < 0] <- TRUE
			gene.weights1 <- gene.weights12[gene.weights12 > 0]
			gene.weights2 <- gene.weights12[gene.weights12 < 0]
			gene.weights <- gene.weights1
		}
	}
	TWO <- !is.null(index2)
	if(is.logical(index))
		idx <- index
	else {
		idx <- rep_len(FALSE,nstat)
		names(idx) <- names(statistics)
		idx[index] <- TRUE
	}
	set1 <- data.frame(idx = idx, weight = NA, wt = NA)
	if(TWO) {
		if(is.logical(index2))
			idx2 <- index2
		else {
			idx2 <- rep_len(FALSE,nstat)
			names(idx2) <- names(statistics)
			idx2[index2] <- TRUE
		}
		set2 <- data.frame(idx = idx2, weight = NA, wt = NA)
	}
	if(length(gene.weights)) {
		set1\$weight <- 0
		set1\$weight[index] <- gene.weights
		set1\$wt <- abs(set1\$weight)/sum(abs(set1\$weight))
		if(TWO) {
			set2\$weight <- 0
			set2\$weight[index2] <- gene.weights2
			SUM <- sum(abs(set1\$weight), abs(set2\$weight))
			set1\$wt <- abs(set1\$weight)/SUM
			set2\$wt <- abs(set2\$weight)/SUM
		}
	}
	ostat <- order(statistics, na.last = TRUE, decreasing=FALSE)
	statistics <- statistics[ostat]
	set1 <- set1[ostat,]
	if(TWO) set2 <- set2[ostat,]
	n <- sum(!is.na(statistics))
	if(n==0L) {
		message("No valid statistics")
		return(invisible())
	}
	if (n < nstat) {
		statistics <- statistics[1:n]
		set1 <- set1[1:n,]
		if (TWO) set2 <- set2[1:n,]
	}
	r <- which(set1\$idx)
	if (TWO) {
		r2 <- which(set2\$idx)
		if(!length(r2)) TWO <- FALSE
	}
	if(!length(r))
		if(TWO) {
			r <- r2
			set1 <- set2
			TWO <- FALSE
		} else {
			message("No selected genes to plot")
			return(invisible())
		}
	WTS <- FALSE
	wt1 <- set1\$wt[r]
	len.up <- 1
	if(!anyNA(wt1)) {
		len.up <- set1\$weight[r]/max(abs(set1\$weight[r]))
		anydifferent <- function(x) {
			if(length(x) < 2) return(FALSE)
			r <- range(x)
			(r[2] > r[1])
		}
		if(!TWO) if(anydifferent(wt1)) WTS <- TRUE
		if(TWO){
			wt12 <- c(set1\$wt[r], abs(set2\$wt[r2]))
			if(anydifferent(wt12)) WTS <- TRUE
			max.wt <- max(set1\$wt[r], set2\$wt[r2])
			len.up <- set1\$wt[r]/max.wt
			len.down <- set2\$wt[r2]/max.wt
		}
	}
	pos.dir <- all(len.up > 0)
	if(WTS) shift <- 0.1 else shift <- 0
	quantiles <- sort(quantiles)
	ALP <- alpha
	ALP <- min(ALP,1)
	ALP <- max(ALP,0.1)
	if (is.null(col.bars)) {
		if (TWO) {
			col.bars <- c("red", "blue")
			if(WTS) col.bars.alpha <- c(rgb(1,0,0,alpha=ALP), rgb(0,0,1,alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			col.bars <- "black"
			if(WTS) col.bars.alpha <- rgb(0,0,0,alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	} else {
		if(TWO) {
			if(length(col.bars) == 1) col.bars <- rep(col.bars, 2)
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			red2 <- RGB[1,2]
			green2 <- RGB[2,2]
			blue2 <- RGB[3,2]
			if(WTS) col.bars.alpha <- c(rgb(red, green, blue, alpha=ALP), rgb(red2, green2, blue2, alpha=ALP))
			else col.bars.alpha <- col.bars
		} else {
			RGB <- col2rgb(col.bars)/255
			red <- RGB[1,1]
			green <- RGB[2,1]
			blue <- RGB[3,1]
			if(WTS) col.bars.alpha <- rgb(red, green, blue, alpha=ALP)
			else col.bars.alpha <- col.bars
		}
	}
	ylim.worm <- ylim <- c(-1, 1)
	ylab.worm <- ""
	xlab.worm <- xlab
	if(!TWO) ylim.worm <- c(0, 1)
	if(worm) {
		ylim.worm <- c(-2.1, 2.1)
		if(!TWO) ylim.worm <- c(0, 2.1)
	}
	ylim[2] <- ylim[2] + 0.5
	if (TWO) ylim[1] <- ylim[1] - 0.5
	if(TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift, ylim.worm[2]+shift), type="n", axes=FALSE, xlab=xlab.worm, ylab=ylab.worm, ...)
	if(!TWO) plot(1:n, xlim=c(0,n), ylim=c(ylim.worm[1]-shift*(!pos.dir), ylim.worm[2]+shift*pos.dir), type="n", axes=FALSE, xlab=xlab.worm,ylab=ylab.worm, ...)
	npos <- sum(statistics > quantiles[2])
	nneg <- sum(statistics < quantiles[1])
	lwd <- 50/length(r)
	lwd <- min(1.9, lwd)
	lwd <- max(0.2, lwd)
	if(TWO){
		lwd2 <- 50/length(r2)
		lwd2 <- min(1.9, lwd2)
		lwd2 <- max(0.2, lwd2)
		lwd <- lwd2 <- min(lwd, lwd2)
	}
	barlim <- ylim[2] - c(1.5, 0.5)
	if(!pos.dir) {
		rect.yb <- 0.5
		rect.yt <- 1
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[2]/2, r, barlim[2], lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2-shift, r, barlim[2]/2*(1+len.up)-shift, lwd = lwd, col = col.bars[1])
	}
	if(pos.dir) {
		rect.yb <- -0.5
		if(!TWO) rect.yb <- 0
		rect.yt <- 0.5
		rect(nneg + 0.5, rect.yb, n - npos + 0.5, rect.yt, col = "lightgray", border = NA)
		if (nneg) rect(0.5, rect.yb, nneg + 0.5, rect.yt, col = "lightblue", border = NA)
		if (npos) rect(n - npos + 0.5, rect.yb, n + 0.5, rect.yt, col = "pink", border = NA)
		segments(r, barlim[1], r, barlim[2]/2, lwd = lwd, col = col.bars.alpha[1])
		segments(r, barlim[2]/2+shift, r, barlim[2]/2*(1+len.up)+shift, lwd = lwd, col = col.bars[1])
	}
	if(TWO) {
		barlim2 <- ylim[1] + c(0.5, 1.5)
		segments(r2, barlim2[1]/2, r2, barlim2[2], lwd = lwd2, col = col.bars.alpha[2])
		segments(r2, barlim2[1]/2*(1+len.down)-shift, r2, barlim2[1]/2-shift, lwd = lwd2, col = col.bars[2])
	}
	lab.at <- 0
	if(!TWO) lab.at <- 0.5
	axis(side = 2, at = lab.at, padj = 3.8, cex.axis = 0.85, labels = labels[1], tick = FALSE)
	axis(side = 4, at = lab.at, padj = -3.8, cex.axis = 0.85, labels = labels[2], tick = FALSE)
	prob <- (0:10)/10
	axis(at = seq(1,n,len=11), side = 1, cex.axis = 0.7, las = 2, labels = format(quantile(statistics, p = prob), digits = 1))
	if(worm) {
		rescale <- function(x, newrange, oldrange=range(x)) {
			newrange[1] + (x-oldrange[1]) / (oldrange[2]-oldrange[1]) * (newrange[2] - newrange[1])
		}
		if(!WTS){
			ave.enrich1 <- length(r)/n
			worm1 <- tricubeMovingAverage(set1\$idx, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- length(r2)/n
				worm2 <- tricubeMovingAverage(-set2\$idx, span = span.worm)/ave.enrich2
			}
		}
		if(WTS){
			ave.enrich1 <- mean(set1\$wt)
			worm1 <- tricubeMovingAverage(set1\$wt, span = span.worm)/ave.enrich1
			if(TWO) {
				ave.enrich2 <- mean(set2\$wt)
				worm2 <- tricubeMovingAverage(-set2\$wt, span = span.worm)/ave.enrich2
			}
		}
		max.worm1 <- max(worm1)
	    if(!is.null(max.worm.fix)){
		max.worm1 <- max.worm.fix
        }
		r.worm1 <- c(0,max.worm1)
		worm1.scale <- rescale(worm1, newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir), oldrange=r.worm1)
		if(TWO) {
			min.worm2 <- min(worm2)
			r.worm2 <- c(min.worm2,0)
			worm2.scale <- rescale(worm2, newrange=c(-2.1-shift,-1.1-shift), oldrange=r.worm2)
		}
		if(!TWO) {
			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift*pos.dir,2.1+shift*pos.dir),oldrange=r.worm1), lty=2)
			axis(side = 2, at = c(1.1+shift*pos.dir, 2.1+shift*pos.dir), cex.axis = 0.8, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, labels = "Enrichment", at = 1.6+shift*pos.dir, padj = -0.6, tick = FALSE, cex.axis = 0.8)
		}
		if(TWO) {

			lines(x = 1:n, y = worm1.scale, col = col.bars[1], lwd = 2)
			abline(h = rescale(1,newrange=c(1.1+shift,2.1+shift),oldrange=r.worm1), lty=2)

			lines(x = 1:n, y = worm2.scale, col = col.bars[2], lwd = 2)
			abline(h = rescale(-1,newrange=c(-2.1-shift,-1.1-shift),oldrange=r.worm2), lty=2)

			axis(side = 2, at = c(1.1+shift, 2.1+shift), cex.axis = 0.7, labels = c(0, format(max.worm1, digits = 2)))
			axis(side = 2, at = c(-1.1-shift, -2.1-shift), cex.axis = 0.7, labels =  c(0, format(-min.worm2, digits = 2)))

			axis(side = 2, labels = "Enrichment", at = 1.6+shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
			axis(side = 2, labels = "Enrichment", at = -1.6-shift, tick = FALSE, padj = -0.6, cex.axis = 0.7)
		}
	}
	if(WTS){
		if(!TWO){
			if(pos.dir){
				axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.48, padj = 1.6, labels = c(0, format(max(set1\$weight[r]), digits = 2)))
				axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
			if(!pos.dir){
				axis(side = 2, at = c(0-shift, 0.5-shift), cex.axis = 0.48, padj = 1.6, labels = c(format(min(set1\$weight[r]), digits = 2), 0))
				axis(side = 2, labels = weights.label[1], at = 0.25-shift, padj = 1, tick = FALSE, cex.axis = 0.5)
			}
		}
		if(TWO){
			max.weight <- max(set1\$weight[r], abs(set2\$weight[r2]))
			axis(side = 2, at = c(0.5+shift, 1+shift), cex.axis = 0.43, labels = c(0, format(max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = 0.75+shift, padj = 1, tick = FALSE, cex.axis = 0.46)
			axis(side = 2, at = c(-0.5-shift, -1-shift), cex.axis = 0.43, labels = c(0, format(-max.weight, digits = 2, scientific = FALSE)), padj = 1.6)
			axis(side = 2, labels = weights.label[1], at = -0.75-shift, padj = 1, tick = FALSE, cex.axis = 0.46)
		}
	}
	invisible()
}


table <- read.table("${ANALYSISDIR}/Treg_${TCR}_${TX}_${TYPE}_merged.clonotypeTable.groups.txt", header=T, sep="\t")
splnames <- unlist(strsplit(as.character(table\$ID),"[_]"))
row.matrix <- matrix( splnames , ncol = 4 , byrow = TRUE )
colnames(row.matrix) <- c("nt","aa","V","J")
ext <- cbind(table, row.matrix)
rows <- sample(nrow(ext))
x <- ext[rows, ]
y <- x[order(x\$donor),] 
z <- subset(y, y\$donor > 0)

donV <- subset(z[with(z, V %in% c("TRBV12-1","TRBV12-2","TRBV26")),], select=ID)
ind1 <-z\$ID %in% donV[[1]]
z\$log <- -log10(z\$donor) #+0.001)
range <- seq(1,nrow(z))

svg(file="${FIGURESDIR}/TCRdistribution.barcodeplot_${TCR}_${TX}_${TYPE}_merged.TRBV12-26.donly.svg", height=5, width=4)
layout(matrix(c(1,2), nrow = 2, ncol = 1), heights=c(2,1.5))
barcodeplot2(z\$donor, index=ind1, labels=c("low","high"), main="donor-${TCR}-${TX}-${TYPE}", col.bars="firebrick", max.worm.fix=2)
plot(z\$log,type="n",axes=FALSE,ylim=c(-3,0), ylab = "size")
polygon( c(min(range), range , max(range)) , c(0 , z\$log ,0) , col="gray" , border=F)
axis(2, at=c(-3,0),labels=c(3,0))
dev.off()
EOF
chmod 750 "${TMPDIR}/R.barcode.${_DATE}.R"
R < ${TMPDIR}/R.barcode.${_DATE}.R  --no-save
rm ${TMPDIR}/R.barcode.${_DATE}.R
	done
done


