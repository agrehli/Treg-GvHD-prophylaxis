#!/bin/bash
# by MR, originally February 2021, modified to focus on paper-relevant analyses in Oct. 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###					          scTCR repertoire analyses for                            ###
###			         reisolated Treg from the prophylaxis experiment                   ###
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
PATH_R=${DIR_SOFT}/package/RBioC/stretch_R-4.0.3_Bioc-3.12_intel-mkl-64bit-2020.1-102/lib/R/bin
export PATH=${PATH_PERL}:${PATH_SAMTOOLS}:${PATH_HOMER}:${PATH_R}:${PATH}
export PATH

# processed data directory
DATAPATH="${DIR_DATA}/processedData/mapping/RNA/GRCm38/singleCell/vdj/pr036_TCR_1_10"


# directories

PROJECTDIR="${DIR_DATA}/analysis/project_TregProphylaxis"
WORKDIR_scTCR="${PROJECTDIR}/scTCRrepertoire"
WORKDIR_scRNA="${PROJECTDIR}/scRNAseq"
FIGURESDIR="${WORKDIR_scTCR}/figures"
ANALYSISDIR="${WORKDIR_scTCR}/analysis"
CRDATA="${WORKDIR_scTCR}/cellRangerData"
CRDATATRB="${WORKDIR_scTCR}/TRBcellRangerData"
IADATA="${WORKDIR_scTCR}/immunArchData"
DATAREFORM="${IADATA}/reformated"



# creating directories

mkdir -p ${WORKDIR_scTCR}/figures
mkdir ${CRDATA}
mkdir ${CRDATATRB}
mkdir -p ${IADATA}/reformated
mkdir ${ANALYSISDIR}

                          ###############################
                          #  parsing data for analysis  #
                          ###############################


# extract data from server

declare a TCRDIRS=(TCR_2_C_ra_run_1_cr5 \
TCR_2_L_ra_run_1_cr5 \
TCR_2_S_ra_run_1_cr5 \
TCR_3_C_ra_run_1_cr5 \
TCR_3_L_ra_run_1_cr5 \
TCR_3_S_ra_run_1_cr5 \
TCR_4_C_ra_run_1_cr5 \
TCR_4_L_ra_run_1_cr5 \
TCR_4_S_ra_run_1_cr5 \
TCR_235_d12_ra_2_run_1_cr5 \
TCR_235_d12_ra_run_1_cr5)

declare a NAMES=(colon_1 liver_1 spleen_1 colon_2 liver_2 spleen_2 colon_3 liver_3 spleen_3 adonor_2 adonor_1)

COUNT=0
for DIR in "${TCRDIRS[@]}"
do
NAME=${NAMES[$COUNT]}
ln -s ${DATAPATH}/${DIR}/outs/filtered_contig_annotations.csv ${CRDATA}/${NAME}.csv
COUNT=$((COUNT+=1))                       
done

# focus on TRB

COUNT=0
for DIR in "${TCRDIRS[@]}"
do
NAME=${NAMES[$COUNT]}
grep -E 'TRB' ${DATAPATH}/${DIR}/outs/filtered_contig_annotations.csv > ${CRDATATRB}/${NAME}.csv
COUNT=$((COUNT+=1))                       
done


# creating metadata table 

TAB=$(echo -e "\t")
cat >"${CRDATA}/metadata.txt" <<EOF
Sample${TAB}Names${TAB}Type${TAB}Rep
donor_1${TAB}adonor_1${TAB}adonor${TAB}1
donor_2${TAB}adonor_2${TAB}adonor${TAB}2
colon_1${TAB}colon_1${TAB}colon${TAB}1
colon_2${TAB}colon_2${TAB}colon${TAB}2
colon_3${TAB}colon_3${TAB}colon${TAB}3
liver_1${TAB}liver_1${TAB}liver${TAB}1
liver_2${TAB}liver_2${TAB}liver${TAB}2
liver_3${TAB}liver_3${TAB}liver${TAB}3
spleen_1${TAB}spleen_1${TAB}spleen${TAB}1
spleen_2${TAB}spleen_2${TAB}spleen${TAB}2
spleen_3${TAB}spleen_3${TAB}spleen${TAB}3
EOF

cp ${CRDATA}/metadata.txt ${CRDATATRB}/metadata.txt


# extract data tables after import into immunarch

_DATE=$(date +%s)
cat >"${TMPDIR}/R.immunarch.${_DATE}.R" <<EOF
library("immunarch")
file_path = "${CRDATA}"
immdata <- repLoad(file_path)
EOF
for NAME in ${NAMES[@]}
do
cat >>"${TMPDIR}/R.immunarch.${_DATE}.R" <<EOF
write.table(immdata\$data\$${NAME}, file = "${IADATA}/${NAME}.immunarch.txt", sep = "\t", col.names=NA, quote=FALSE)
EOF
done
R < "${TMPDIR}/R.immunarch.${_DATE}.R"  --no-save
rm "${TMPDIR}/R.immunarch.${_DATE}.R"


# reformat data for circos plots and triangles

for NAME in ${NAMES[@]}
do
scTCRparseImmunArch.pl ${IADATA}/${NAME}.immunarch.txt ${DATAREFORM} ${NAME}
done


                          ###############################
                          #  Overlap via Circos plots   #
                          ###############################

# creating merged count table

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregDCLS \
-mergeFiles \
scTCR_IAcountTable.adonor_1.txt \
scTCR_IAcountTable.adonor_2.txt \
scTCR_IAcountTable.colon_1.txt \
scTCR_IAcountTable.colon_2.txt \
scTCR_IAcountTable.colon_3.txt \
scTCR_IAcountTable.liver_1.txt \
scTCR_IAcountTable.liver_2.txt \
scTCR_IAcountTable.liver_3.txt \
scTCR_IAcountTable.spleen_1.txt \
scTCR_IAcountTable.spleen_2.txt \
scTCR_IAcountTable.spleen_3.txt \
-sampleNames \
donor1 \
donor2 \
colon1 \
colon2 \
colon3 \
liver1 \
liver2 \
liver3 \
spleen1 \
spleen2 \
spleen3 \
-groupNames \
donor \
donor \
colon \
colon \
colon \
liver \
liver \
liver \
spleen \
spleen \
spleen 

# Circos plots (devided)

cd ${ANALYSISDIR}
scTCRCirculizeFreq4Samples.pl scTCRxTregDCLS.clonotypeTable.groups.txt \
-name scTCRxTregDCLS.groups \
-outDir ${FIGURESDIR} \
-colors 255,0,0 160,82,45 70,130,180 255,20,147 \
-shortNames donor colon liver spleen -dvt 2>/dev/null




                      ####################################
                      #  Overlap via barycentric plots   #
                      ####################################

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregCLS -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.txt \
scTCR_IAcountTable.colon_2.txt \
scTCR_IAcountTable.colon_3.txt \
scTCR_IAcountTable.liver_1.txt \
scTCR_IAcountTable.liver_2.txt \
scTCR_IAcountTable.liver_3.txt \
scTCR_IAcountTable.spleen_1.txt \
scTCR_IAcountTable.spleen_2.txt \
scTCR_IAcountTable.spleen_3.txt \
-sampleNames \
colon1 \
colon2 \
colon3 \
liver1 \
liver2 \
liver3 \
spleen1 \
spleen2 \
spleen3 \
-groupNames \
colon \
colon \
colon \
liver \
liver \
liver \
spleen \
spleen \
spleen

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRxTregCLS.clonotypeTable.groups.norm5K.txt ${FIGURESDIR} scTCRxTregCLS.norm5K -top 500 -color red

# analysis for individual organs

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregC -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.txt \
scTCR_IAcountTable.colon_2.txt \
scTCR_IAcountTable.colon_3.txt \
-sampleNames \
colon1 \
colon2 \
colon3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregC.norm5K.txt ${FIGURESDIR} scTCRxTregC.norm5K -top 250 -color sienna

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregL -norm 5 \
-mergeFiles \
scTCR_IAcountTable.liver_1.txt \
scTCR_IAcountTable.liver_2.txt \
scTCR_IAcountTable.liver_3.txt \
-sampleNames \
liver1 \
liver2 \
liver3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregL.norm5K.txt ${FIGURESDIR} scTCRxTregL.norm5K -top 250 -color steelblue

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregS -norm 5 \
-mergeFiles \
scTCR_IAcountTable.spleen_1.txt \
scTCR_IAcountTable.spleen_2.txt \
scTCR_IAcountTable.spleen_3.txt \
-sampleNames \
spleen1 \
spleen2 \
spleen3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregS.norm5K.txt ${FIGURESDIR} scTCRxTregS.norm5K -top 250 -color deeppink


                      ####################################
                      #         TRBV gene usage          #
                      ####################################


declare a TCRDIRS=(TCR_2_C_ra_run_1_cr5 \
TCR_2_L_ra_run_1_cr5 \
TCR_2_S_ra_run_1_cr5 \
TCR_3_C_ra_run_1_cr5 \
TCR_3_L_ra_run_1_cr5 \
TCR_3_S_ra_run_1_cr5 \
TCR_4_C_ra_run_1_cr5 \
TCR_4_L_ra_run_1_cr5 \
TCR_4_S_ra_run_1_cr5 \
TCR_235_d12_ra_2_run_1_cr5 \
TCR_235_d12_ra_run_1_cr5)

declare a NAMES=(colon_1 liver_1 spleen_1 colon_2 liver_2 spleen_2 colon_3 liver_3 spleen_3 adonor_2 adonor_1)

COUNT=0
for DIR in "${TCRDIRS[@]}"
do
NAME=${NAMES[$COUNT]}
scTCRcreateTRBVCountTable.pl ${DATAPATH}/${DIR}/outs ${CRDATATRB} ${NAME}
COUNT=$((COUNT+=1))                       
done

cd ${CRDATATRB}
paste scTRBVcountTable.adonor_1.txt \
scTRBVcountTable.adonor_2.txt \
scTRBVcountTable.colon_1.txt \
scTRBVcountTable.colon_2.txt \
scTRBVcountTable.colon_3.txt \
scTRBVcountTable.liver_1.txt \
scTRBVcountTable.liver_2.txt \
scTRBVcountTable.liver_3.txt \
scTRBVcountTable.spleen_1.txt \
scTRBVcountTable.spleen_2.txt \
scTRBVcountTable.spleen_3.txt | cut -f1,2,4,6,8,10,12,14,16,18,20,22 \
> ${TMPDIR}/scTRBVcountTable.txt

echo $'vGene\tadonor_1\tadonor_2\tcolon_1\tcolon_2\tcolon_3\tliver_1\tliver_2\tliver_3\tspleen_1\tspleen_2\tspleen_3' | cat - <(tail -n+2 ${TMPDIR}/scTRBVcountTable.txt) > scTRBVcountTable.txt




# analysis of selected TRBV chains "TRBV12-1","TRBV12-2","TRBV26" in R

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure6j_Treg_GvHD_TRBVanalysis_10x_TRB.Rmd", "html_document")
q()















                      ####################################
                      #     sequential analysis in R     #
                      ####################################

#FIGURESDIR=/misc/data/analysis/project_B07/scTCRrepertoire/figures
#ANALYSISDIR=/misc/data/analysis/project_B07/scTCRrepertoire/analysis
#CRDATA=/misc/data/analysis/project_B07/scTCRrepertoire/cellRangerData






rbioc_3-12


# load data

library("immunarch")
file_path = "/misc/data/analysis/project_B07/scTCRrepertoire/cellRangerData"
immdata <- repLoad(file_path)

head(immdata$data[[1]][c(1:5)])



# basic stuff

exp_umi <- repExplore(immdata$data, .method = "clones")
exp_umi
#            Sample Clones
# adonor_1 adonor_1   5125
# adonor_2 adonor_2  19316
# colon_1   colon_1   6878
# colon_2   colon_2   5908
# colon_3   colon_3   5734
# liver_1   liver_1   5294
# liver_2   liver_2   4330
# liver_3   liver_3   3491
# spleen_1 spleen_1   6287
# spleen_2 spleen_2   6918
# spleen_3 spleen_3   5528

p <- vis(exp_umi, .test = FALSE)
p <- p + scale_fill_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_cells.pdf", height=4, width=5)
plot(p)
dev.off()

exp_vol <- repExplore(immdata$data, .method = "volume")
p <- vis(exp_vol, .by = c("Names"), .meta = immdata$meta, .test = FALSE)
p <- vis(exp_vol, .test = FALSE)
p <- p + scale_fill_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_volume.pdf", height=4, width=5)
plot(p)
dev.off()


# imm_top <- repClonality(immdata$data, .method = "top", .head = c(10, 100, 1000, 5000, 25000))
# imm_top
# p <- vis(imm_top), .by = c("Names"), .meta = immdata$meta)
# p <- p + scale_fill_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
# pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_top.pdf", height=4, width=5)
# plot(p)
# dev.off()

imm_hom <- repClonality(immdata$data,
  .method = "homeo",
  .clone.types = c(Small = .0001, Medium = .001, Large = .01, Hyperexpanded = 1)
)
imm_hom
#p <- vis(imm_hom, .order= c(4,5,1,2,3,6,7,8,9,10,11))
#p <- vis(imm_hom, .order= c("donor_1","donor_2","colon_1","colon_2","colon_3","liver_1","liver_2","liver_3","spleen_1","spleen_2","spleen_3" ))
p <- vis(imm_hom)
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_clonesizes.pdf", height=4, width=6)
plot(p)
dev.off()

# visualize repertoire overlap
imm_ov1 <- repOverlap(immdata$data, .method = "public", .verbose = F)
imm_ov2 <- repOverlap(immdata$data, .method = "morisita", .verbose = F)

p <- vis(imm_ov1, .text.size = 2)
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_overlap_public.pdf", height=4, width=4)
plot(p)
dev.off()

pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_overlap_public_circos.pdf", height=4, width=4)
vis(imm_ov1, "circos")
dev.off()

pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_overlap_morista_heatmap.pdf", height=4, width=4)
vis(imm_ov2, "heatmap2", .color = colorRampPalette(c("navy", "white", "red3"))(50))
dev.off()


# gene usage

# does not work currently, because data is paired - could try to split....


















# Compute statistics and visualise them
# Chao1 diversity measure
div_chao <- repDiversity(immdata$data, "chao1")
div_chao
p <- vis(div_chao, .by = c("Type"), .meta = immdata$meta, .test = FALSE)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_chao1.pdf", height=4, width=4)
plot(p)
dev.off()

# Simpson diversity measure
div_simp <- repDiversity(immdata$data, "inv.simp")
div_simp
p <- vis(div_simp, .by = c("Type"), .meta = immdata$meta, .test = FALSE)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_invSimp.pdf", height=4, width=4)
plot(p)
dev.off()

# D50 diversity measure
div_D50 <- repDiversity(immdata$data, "d50")
div_D50
p <- vis(div_D50, .by = c("Type"), .meta = immdata$meta, .test = FALSE)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_D50.pdf", height=4, width=4)
plot(p)
dev.off()


# Rarefaction analysis
imm_raref <- repDiversity(immdata$data, "raref", .verbose = F)
p <- vis(imm_raref) 
p <- p + scale_fill_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
p <- p + scale_colour_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_raref.pdf", height=8, width=8)
plot(p)
dev.off()

#same after downsampling

down <- repSample(immdata$data, .method = "downsample", .n = 3400)
div_chao <- repDiversity(down, "chao1")
div_simp <- repDiversity(down, "inv.simp")
div_D50 <- repDiversity(down, "d50")
imm_raref <- repDiversity(down, "raref", .verbose = F)

p <- vis(div_chao, .by = c("Type"), .meta = immdata$meta, .test = FALSE)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_chao1_3.4K.pdf", height=3, width=2)
plot(p)
dev.off()

p <- vis(div_simp, .by = c("Type"), .meta = immdata$meta, .test = FALSE, .points = FALSE, .errorbar.width = 1)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
p <- p + ggtitle("Clonotype\nDiversity",subtitle = "")
p <- p + geom_jitter(width = 0.25, height = 0, color="black", size=1)
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_invSimp_3.4K.pdf", height=3, width=2)
plot(p)
dev.off()

p <- vis(div_D50, .by = c("Type"), .meta = immdata$meta, .test = FALSE)
p <- p + scale_fill_manual(values = c("red","sienna", "steelblue", "deeppink"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_D50_3.4K.pdf", height=3, width=2)
plot(p)
dev.off()

p <- vis(imm_raref) 
p <- p + scale_fill_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
p <- p + scale_colour_manual(values = c("indianred2","red1","sandybrown","tan2","sienna","skyblue1","steelblue1","steelblue","hotpink1","hotpink2","hotpink3"))
pdf(file="/misc/data/analysis/project_B07/scTCRrepertoire/figures/scTCRxTregDCLS_diversity_raref_3.4K.pdf", height=8, width=8)
plot(p)
dev.off()













# extracting barcodes for visualization in UMAP etc.

# TOP clonotypes in tissues:

declare a TOPCLONES=("TGTGCAGCAAGCGACTATGCCCAGGGATTAACCTTC;TGTGCCAGCGGCCGGGACAGATCCTATGAACAGTACTTC" "TGTGCTATGAGAGAGGGGAATGCCAATACAGGCAAATTAACCTTT;TGTGCCAGCAGCTCCGCGGGAGGCACCCAGTACTTT" "TGTGCTGCTGCATCTTCTGGCAGCTGGCAACTCATCTTT;TGTGCCAGCAGGGGACAGAACACAGAAGTCTTCTTT")
declare a CLONOTYPES=("TRAV10D_TRBV13-1" "TRAV16D-DV11_TRBV3" "TRAV4D-4_TRBV15")
declare a FILENAMES=(donor_1 \
donor_2 \
colon_1 \
colon_2 \
colon_3 \
liver_1 \
liver_2 \
liver_3 \
spleen_1 \
spleen_2 \
spleen_3)

COUNT=0
for CLONE in "${TOPCLONES[@]}"
do
TYPE=${CLONOTYPES[$COUNT]}
echo $'sample\tbarcodes'> ${ANALYSISDIR}/${TYPE}.barcodes.txt
	for NAME in "${FILENAMES[@]}" ; do
	awk -v "key=$NAME" 'BEGIN{OFS="\t"}{print key, $18}' <(grep -w ${CLONE} ${IADATA}/${NAME}.immunarch.txt) >> ${ANALYSISDIR}/${TYPE}.barcodes.txt
	done
COUNT=$((COUNT+=1))                       
done









# paired data

library("immunarch")
file_path = "/misc/data/analysis/project_B07/scTCRrepertoire/cellRangerData"
tcrdata <- repLoad(file_path, .mode = "paired")






