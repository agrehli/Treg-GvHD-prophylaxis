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
CRDATACSUB="${WORKDIR_scTCR}/colonCellRangerData"

# tab

TAB=$(echo -e "\t")


# creating directories

mkdir -p ${WORKDIR_scTCR}/figures/downsampled
mkdir ${CRDATA}
mkdir ${CRDATATRB}
mkdir -p ${IADATA}/reformated/downsampled
mkdir -p ${ANALYSISDIR}/downsampled
mkdir ${CRDATACSUB}

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
adonor_1${TAB}adonor_1${TAB}adonor${TAB}1
adonor_2${TAB}adonor_2${TAB}adonor${TAB}2
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

cat >"${CRDATATRB}/metadata.txt" <<EOF
Sample${TAB}Names${TAB}Type${TAB}Rep
adonor_1${TAB}adonor_1${TAB}adonor${TAB}1
adonor_2${TAB}adonor_2${TAB}adonor${TAB}2
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


# extract data tables after import into immunarch

# downsampling to prophylaxis numbers
#           thr     pro
# donor:    4190    13667  
# colon :   3029    12482   
# spleen:   3328    12989
# liver:    3618     8627

cd ${DATAREFORM}

# number of clones in each sample
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.adonor_1.pairedChainsOnly.txt #3172
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.adonor_2.pairedChainsOnly.txt #10495
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.colon_1.pairedChainsOnly.txt #4607
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.colon_2.pairedChainsOnly.txt #4021
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.colon_3.pairedChainsOnly.txt #3854
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.liver_1.pairedChainsOnly.txt #3409
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.liver_2.pairedChainsOnly.txt #2907
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.liver_3.pairedChainsOnly.txt #2311
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.spleen_1.pairedChainsOnly.txt #4375
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.spleen_2.pairedChainsOnly.txt #4779
awk -F'\t' '{sum+=$2;} END{print sum;}' scTCR_IAcountTable.spleen_3.pairedChainsOnly.txt #3835


# include downsampling to therapy-samples (output 3 random drawings)
declare a CLONES=(1118 1430 1121 976 1219 1224 935 969 983 3218 972)
COUNT=0
_DATE=$(date +%s)
cat >"${TMPDIR}/R.immunarch.${_DATE}.R" <<EOF
library("immunarch")
file_path = "${CRDATA}"
immdata <- repLoad(file_path)
EOF
for NAME in ${NAMES[@]}; do
CLONE=${CLONES[$COUNT]}
cat >>"${TMPDIR}/R.immunarch.${_DATE}.R" <<EOF
write.table(immdata\$data\$${NAME}, file = "${IADATA}/${NAME}.immunarch.txt", sep = "\t", col.names=NA, quote=FALSE)
tmp <- immdata\$data\$${NAME} %>% dplyr::filter(chain == "TRA;TRB")
${NAME} <- repSample(tmp, .n = $CLONE)
write.table(${NAME}, file = "${IADATA}/${NAME}.immunarch.pdown1.txt", sep = "\t", col.names=NA, quote=FALSE)
${NAME} <- repSample(tmp, .n = $CLONE)
write.table(${NAME}, file = "${IADATA}/${NAME}.immunarch.pdown2.txt", sep = "\t", col.names=NA, quote=FALSE)
${NAME} <- repSample(tmp, .n = $CLONE)
write.table(${NAME}, file = "${IADATA}/${NAME}.immunarch.pdown3.txt", sep = "\t", col.names=NA, quote=FALSE)
EOF
COUNT=$((COUNT+=1))  
done
R < "${TMPDIR}/R.immunarch.${_DATE}.R"  --no-save
rm "${TMPDIR}/R.immunarch.${_DATE}.R"


# reformat data for circos plots and triangles

for NAME in ${NAMES[@]}
do
scTCRparseImmunArch.pl ${IADATA}/${NAME}.immunarch.txt ${DATAREFORM} ${NAME}
done

for NAME in ${NAMES[@]}
do
scTCRparseImmunArch.pl ${IADATA}/${NAME}.immunarch.pdown1.txt ${DATAREFORM}/downsampled ${NAME}.pdown1
scTCRparseImmunArch.pl ${IADATA}/${NAME}.immunarch.pdown2.txt ${DATAREFORM}/downsampled ${NAME}.pdown2
scTCRparseImmunArch.pl ${IADATA}/${NAME}.immunarch.pdown3.txt ${DATAREFORM}/downsampled ${NAME}.pdown3
done
rm ${DATAREFORM}/downsampled/*.pairedChainsOnly.txt # removes duplicated files  


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

# ran same analysis with exactly paired clonotypes 

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregDCLS.pairedChainsOnly \
-mergeFiles \
scTCR_IAcountTable.adonor_1.pairedChainsOnly.txt \
scTCR_IAcountTable.adonor_2.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_1.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_2.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_3.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_1.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_2.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_3.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_1.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_2.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_3.pairedChainsOnly.txt \
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
scTCRCirculizeFreq4Samples.pl scTCRxTregDCLS.pairedChainsOnly.clonotypeTable.groups.txt \
-name scTCRxTregDCLS.pairedChainsOnly.groups \
-outDir ${FIGURESDIR} \
-colors 255,0,0 160,82,45 70,130,180 255,20,147 \
-shortNames donor colon liver spleen -dvt 2>/dev/null


# downsampled to prophylaxis (three versions)

# creating merged count table

for i in {1..3} ; do

cd ${DATAREFORM}/downsampled
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR}/downsampled scTCRxTregDCLS.pdown${i} \
-mergeFiles \
scTCR_IAcountTable.adonor_1.pdown${i}.txt \
scTCR_IAcountTable.adonor_2.pdown${i}.txt \
scTCR_IAcountTable.colon_1.pdown${i}.txt \
scTCR_IAcountTable.colon_2.pdown${i}.txt \
scTCR_IAcountTable.colon_3.pdown${i}.txt \
scTCR_IAcountTable.liver_1.pdown${i}.txt \
scTCR_IAcountTable.liver_2.pdown${i}.txt \
scTCR_IAcountTable.liver_3.pdown${i}.txt \
scTCR_IAcountTable.spleen_1.pdown${i}.txt \
scTCR_IAcountTable.spleen_2.pdown${i}.txt \
scTCR_IAcountTable.spleen_3.pdown${i}.txt \
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

cd ${ANALYSISDIR}/downsampled
scTCRCirculizeFreq4Samples.pl scTCRxTregDCLS.pdown${i}.clonotypeTable.groups.txt \
-name scTCRxTregDCLS.pdown${i}.groups \
-outDir ${FIGURESDIR}/downsampled \
-colors 255,0,0 160,82,45 70,130,180 255,20,147 \
-shortNames donor colon liver spleen -dvt 2>/dev/null

done









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





# ran same analysis with exactly paired clonotypes 

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregCLS.pairedChainsOnly -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_2.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_3.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_1.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_2.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_3.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_1.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_2.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_3.pairedChainsOnly.txt \
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
scTCRtriangle.pl scTCRxTregCLS.pairedChainsOnly.clonotypeTable.groups.norm5K.txt ${FIGURESDIR} scTCRxTregCLS.pairedChainsOnly.norm5K -top 500 -color red

# analysis for individual organs

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregC.pairedChainsOnly -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_2.pairedChainsOnly.txt \
scTCR_IAcountTable.colon_3.pairedChainsOnly.txt \
-sampleNames \
colon1 \
colon2 \
colon3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregC.pairedChainsOnly.norm5K.txt ${FIGURESDIR} scTCRxTregC.pairedChainsOnly.norm5K -top 250 -color sienna

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregL.pairedChainsOnly -norm 5 \
-mergeFiles \
scTCR_IAcountTable.liver_1.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_2.pairedChainsOnly.txt \
scTCR_IAcountTable.liver_3.pairedChainsOnly.txt \
-sampleNames \
liver1 \
liver2 \
liver3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregL.pairedChainsOnly.norm5K.txt ${FIGURESDIR} scTCRxTregL.pairedChainsOnly.norm5K -top 250 -color steelblue

cd ${DATAREFORM}
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR} scTCRxTregS.pairedChainsOnly -norm 5 \
-mergeFiles \
scTCR_IAcountTable.spleen_1.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_2.pairedChainsOnly.txt \
scTCR_IAcountTable.spleen_3.pairedChainsOnly.txt \
-sampleNames \
spleen1 \
spleen2 \
spleen3

cd ${ANALYSISDIR}
scTCRtriangle.pl scTCRcountTable.scTCRxTregS.pairedChainsOnly.norm5K.txt ${FIGURESDIR} scTCRxTregS.pairedChainsOnly.norm5K -top 250 -color deeppink


# ... and for downsampled data


for i in {1..3} ; do

cd ${DATAREFORM}/downsampled
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR}/downsampled scTCRxTregCLS.pdown${i} -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.pdown${i}.txt \
scTCR_IAcountTable.colon_2.pdown${i}.txt \
scTCR_IAcountTable.colon_3.pdown${i}.txt \
scTCR_IAcountTable.liver_1.pdown${i}.txt \
scTCR_IAcountTable.liver_2.pdown${i}.txt \
scTCR_IAcountTable.liver_3.pdown${i}.txt \
scTCR_IAcountTable.spleen_1.pdown${i}.txt \
scTCR_IAcountTable.spleen_2.pdown${i}.txt \
scTCR_IAcountTable.spleen_3.pdown${i}.txt \
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

cd ${ANALYSISDIR}/downsampled
scTCRtriangle.pl scTCRxTregCLS.pdown${i}.clonotypeTable.groups.norm5K.txt ${FIGURESDIR}/downsampled scTCRxTregCLS.pdown${i}.norm5K -top 500 -color red

# analysis for individual organs

cd ${DATAREFORM}/downsampled
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR}/downsampled scTCRxTregC.pdown${i} -norm 5 \
-mergeFiles \
scTCR_IAcountTable.colon_1.pdown${i}.txt \
scTCR_IAcountTable.colon_2.pdown${i}.txt \
scTCR_IAcountTable.colon_3.pdown${i}.txt \
-sampleNames \
colon1 \
colon2 \
colon3

cd ${ANALYSISDIR}/downsampled
scTCRtriangle.pl scTCRcountTable.scTCRxTregC.pdown${i}.norm5K.txt ${FIGURESDIR}/downsampled scTCRxTregC.pdown${i}.norm5K -top 250 -color sienna

cd ${DATAREFORM}/downsampled
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR}/downsampled scTCRxTregL.pdown${i} -norm 5 \
-mergeFiles \
scTCR_IAcountTable.liver_1.pdown${i}.txt \
scTCR_IAcountTable.liver_2.pdown${i}.txt \
scTCR_IAcountTable.liver_3.pdown${i}.txt \
-sampleNames \
liver1 \
liver2 \
liver3

cd ${ANALYSISDIR}/downsampled
scTCRtriangle.pl scTCRcountTable.scTCRxTregL.pdown${i}.norm5K.txt ${FIGURESDIR}/downsampled scTCRxTregL.pdown${i}.norm5K -top 250 -color steelblue

cd ${DATAREFORM}/downsampled
scTCRcreateJoinedCountTable.pl ${ANALYSISDIR}/downsampled scTCRxTregS.pdown${i} -norm 5 \
-mergeFiles \
scTCR_IAcountTable.spleen_1.pdown${i}.txt \
scTCR_IAcountTable.spleen_2.pdown${i}.txt \
scTCR_IAcountTable.spleen_3.pdown${i}.txt \
-sampleNames \
spleen1 \
spleen2 \
spleen3

cd ${ANALYSISDIR}/downsampled
scTCRtriangle.pl scTCRcountTable.scTCRxTregS.pdown${i}.norm5K.txt ${FIGURESDIR}/downsampled scTCRxTregS.pdown${i}.norm5K -top 250 -color deeppink

done













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




# diversity (inverse Simpson) (Figure S6c)

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("FigureS6cS6d_Treg_GvHD_TRBdiversity-singleClones_10x_TRB.Rmd", "html_document")
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

# frequency of selected clones across tissues (Figure S6d)

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure6i_Treg_GvHD_examplesCloneDistribution_10x_TRB.Rmd", "html_document")
q()

# analysis of selected TRVB segments in R (Figure S6e)

cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("FigureS6e_Treg_GvHD_TRBVanalysis_10x_TRB.Rmd", "html_document")
q()






                      ####################################
                      #      Colon-centric analysis      #
                      ####################################

# splitting up the original CellRanger data into colon clusters

# barcode/cluster matching

cd ${WORKDIR_scTCR}

declare -a SETS=("C2" "C3" "C4")
declare a NAMES=(colon_1 colon_2 colon_3)

COUNT=0
for SET in "${SETS[@]}" ; do
    NAME=${NAMES[$COUNT]}
    for (( c=1; c<=8; c++ )); do
        awk -v "key=$c" '$2 == key' ${SET}barcodesClustered.txt | cut -f1 >${TMPDIR}/${SET}.${c}.txt
        join -1 1 -2 1 -t ',' <(sort ${TMPDIR}/${SET}.${c}.txt) <(sort ${CRDATA}/${NAME}.csv) > ${TMPDIR}/tmp.${SET}.${c}.txt
        cat <(head -n1 ${CRDATA}/${NAME}.csv) ${TMPDIR}/tmp.${SET}.${c}.txt > ${CRDATACSUB}/${NAME}.cluster${c}.csv
    done
COUNT=$((COUNT+=1))                       
done

# creating metadata table 

cat >"${CRDATACSUB}/metadata.txt" <<EOF
Sample${TAB}Name${TAB}Type${TAB}Rep
colon_1.cluster1${TAB}c1.1${TAB}cluster1${TAB}1
colon_1.cluster2${TAB}c1.2${TAB}cluster2${TAB}1
colon_1.cluster3${TAB}c1.3${TAB}cluster3${TAB}1
colon_1.cluster4${TAB}c1.4${TAB}cluster4${TAB}1
colon_1.cluster5${TAB}c1.5${TAB}cluster5${TAB}1
colon_1.cluster6${TAB}c1.6${TAB}cluster6${TAB}1
colon_1.cluster7${TAB}c1.7${TAB}cluster7${TAB}1
colon_1.cluster8${TAB}c1.8${TAB}cluster8${TAB}1
colon_2.cluster1${TAB}c2.1${TAB}cluster1${TAB}2
colon_2.cluster2${TAB}c2.2${TAB}cluster2${TAB}2
colon_2.cluster3${TAB}c2.3${TAB}cluster3${TAB}2
colon_2.cluster4${TAB}c2.4${TAB}cluster4${TAB}2
colon_2.cluster5${TAB}c2.5${TAB}cluster5${TAB}2
colon_2.cluster6${TAB}c2.6${TAB}cluster6${TAB}2
colon_2.cluster7${TAB}c2.7${TAB}cluster7${TAB}2
colon_2.cluster8${TAB}c2.8${TAB}cluster8${TAB}2
colon_3.cluster1${TAB}c3.1${TAB}cluster1${TAB}3
colon_3.cluster2${TAB}c3.2${TAB}cluster2${TAB}3
colon_3.cluster3${TAB}c3.3${TAB}cluster3${TAB}3
colon_3.cluster4${TAB}c3.4${TAB}cluster4${TAB}3
colon_3.cluster5${TAB}c3.5${TAB}cluster5${TAB}3
colon_3.cluster6${TAB}c3.6${TAB}cluster6${TAB}3
colon_3.cluster7${TAB}c3.7${TAB}cluster7${TAB}3
colon_3.cluster8${TAB}c3.8${TAB}cluster8${TAB}3
EOF

cat >"${WORKDIR_scTCR}/topFrequentClonotypesColon.txt" <<EOF
CDR3.aa${TAB}V.name
CAALVGDNSKLIW;CAWSLAWGAYAEQFF${TAB}TRAV7D-2;TRBV31
CAVSRTGGYKVVF;CAWSLPTNSDYTF${TAB}TRAV7N-6;TRBV31
CALGEANYNVLYF;CASSSTGGYEQYF${TAB}TRAV6-6;TRBV14
CAAASSGSWQLIF;CASRGQNTEVFF${TAB}TRAV4D-4;TRBV15
CAAEATGGYKVVF;CASSWGGQNTLYF${TAB}TRAV4D-4;TRBV15
CAALYQGGRALIF;CASSLLGGQEQYF${TAB}TRAV14N-3;TRBV15
CALGEGNYNQGKLIF;CASSLRGRGNTLYF${TAB}TRAV6-6;TRBV12-1
CAVRDQGGRALIF;CASSLLGGVFF${TAB}TRAV1;TRBV26
CAAEVSGSFNKLTF;CASSDALDWGSSAETLYF${TAB}TRAV4D-4;TRBV13-3
CAASMIGSNAKLTF;CASSWDNTGQLYF${TAB}TRAV10;TRBV15
CAQITGNTGKLIF;CASSFSGTGRNEQYF${TAB}TRAV13-1;TRBV16
CAAKGNMGYKLTF;CASSRDNQDTQYF${TAB}TRAV10N;TRBV14
CAATSNMGYKLTF;CASSLTGGPYEQYF${TAB}TRAV10D;TRBV10
CAAITGNTGKLIF;CASSLDREQYF${TAB}TRAV10D;TRBV16
CIVTDGNNRIFF;CASSRRGQDTQYF${TAB}TRAV2;TRBV26
CAASGGSALGRLHF;CASSLLGGYEQYF${TAB}TRAV14N-3;TRBV15
CAAISNYQLIW;CTCSADPGGQNTLYF${TAB}TRAV7-4;TRBV1
CAASMSNYNVLYF;CASSRTSSQNTLYF${TAB}TRAV7D-4;TRBV12-1
CAVSMGNTNKVVF;CASSLDSEQYF${TAB}TRAV7-3;TRBV16
CAMRELGYQNFYF;CASRHLNQDTQYF${TAB}TRAV16;TRBV19
EOF


cd ${WORKDIR_scTCR}
R --no-restore --no-save
library(rmarkdown)
render("FigureS7x_Treg_GvHD_diversity-singleClones_10x.Rmd", "html_document")
q()
