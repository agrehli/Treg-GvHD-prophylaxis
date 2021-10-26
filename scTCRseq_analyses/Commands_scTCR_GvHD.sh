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

# tab

TAB=$(echo -e "\t")


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

# diversity (inverse Simpson) & 

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("FigureS6x_Treg_GvHD_TRBdiversity-singleClones_10x_TRB.Rmd", "html_document")
q()


# extracting particular clones from clone table

declare -a CLONES=("TGTGCAGCAAGCGACTATGCCCAGGGATTAACCTTC;TGTGCCAGCGGCCGGGACAGATCCTATGAACAGTACTTC_CAASDYAQGLTF;CASGRDRSYEQYF_TRAV10D;TRBV13-1_NA;NA" \
"TGTGCTATGAGAGAGGGGAATGCCAATACAGGCAAATTAACCTTT;TGTGCCAGCAGCTCCGCGGGAGGCACCCAGTACTTT_CAMREGNANTGKLTF;CASSSAGGTQYF_TRAV16D-DV11;TRBV3_NA;NA" \
"TGTGCTGCTGCATCTTCTGGCAGCTGGCAACTCATCTTT;TGTGCCAGCAGGGGACAGAACACAGAAGTCTTCTTT_CAAASSGSWQLIF;CASRGQNTEVFF_TRAV4D-4;TRBV15_NA;NA" \
"TGTGCTGTGAGGGACCAGGGAGGCAGAGCTCTGATATTT;TGTGCCAGCAGTCTGTTGGGAGGAGTCTTCTTT_CAVRDQGGRALIF;CASSLLGGVFF_TRAV1;TRBV26_NA;NA" \
"TGTGCTATGGAACGTAATTCTGGGACTTACCAGAGGTTT;TGTGCCAGCAGTATGACTGGGTATGAACAGTACTTC_CAMERNSGTYQRF;CASSMTGYEQYF_TRAV13D-1;TRBV19_NA;NA" \
"TGTGCAGCAAGCAGATATAACCAGGGGAAGCTTATCTTT;TGTGCCAGCTCTCTCGACGGGGGTTCCTATGAACAGTACTTC_CAASRYNQGKLIF;CASSLDGGSYEQYF_TRAV10;TRBV12-2_NA;NA")

declare -a CLONENAMES=(TRAV10D/TRBV13-1 TRAV16D-DV11/TRBV3 TRAV4D-4/TRBV15 TRAV1/TRBV26 TRAV13D-1/TRBV19 TRAV10/TRBV12-2)

echo $'Clone\tdonor_1\tdonor_2\tcolon_1\tcolon_2\tcolon_3\tliver_1\tliver_2\tliver_3\tspleen_1\tspleen_2\tspleen_3' > ${ANALYSISDIR}/scTCRxTregDCLS.selected.clonotypeTable.txt
COUNT=0
for CLONE in "${CLONES[@]}"
do
NAME=${CLONENAMES[$COUNT]}
echo $NAME
echo "${NAME}${TAB}$(grep ${CLONE} ${ANALYSISDIR}/scTCRxTregDCLS.clonotypeTable.txt | cut -f 2-12)" >>${ANALYSISDIR}/scTCRxTregDCLS.selected.clonotypeTable.txt
COUNT=$((COUNT+=1))                       
done

# frequency of selected clones across tissues

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure6g_Treg_GvHD_examplesCloneDistribution_10x_TRB.Rmd", "html_document")
q()


