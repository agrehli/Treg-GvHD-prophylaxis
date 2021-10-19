#!/bin/bash
# by MR, originally February 2021, modified to focus on paper-relevant analyses in Oct. 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###					            TCR repertoire analyses for                            ###
###					     resident Treg isolated from donor mice                        ###
###                                                                                    ###
##########################################################################################
##########################################################################################
##########################################################################################


# setting basic path and linux OS

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
MAPPINGDIR="${DIR_DATA}/processedData/mapping/RNA/RepSeq/MIXCRv3"

# working directories
PROJECTDIR="${DIR_DATA}/analysis/project_TregProphylaxis"
WORKDIR_TCR="${PROJECTDIR}/bulkTCRrepertoire"
FIGURESDIR="${WORKDIR_TCR}/figures"
ANALYSISDIR="${WORKDIR_TCR}/analysis"
MIXDATA="${WORKDIR_TCR}/MixcrData"
IADATA="${WORKDIR_TCR}/immunArchData"
DATAREFORM="${IADATA}/reformated"



# creating directories

mkdir -p ${IADATA}/reformated
mkdir ${ANALYSISDIR}








                   ###############################################
                   ##         preparing the noBMT data          ##
                   ###############################################




# Create data folders for further analysis 

mkdir ${MIXDATA}/Treg_TRA_noTX_merged
mkdir ${MIXDATA}/Treg_TRB_noTX_merged



declare a FIRST_SET=(201_d0_S_Cd62lpos_A \
203_d0_S_Cd62lpos_A \
205_d0_S_Cd62lpos_A)

declare a SECOND_SET=(202-002-S-rn-neg_A \
204-003-S-rn-neg_A \
206-004-S-rn-neg_A \
258-010-S-rn-neg_A \
257-010-S-rn-pos_A \
214-004-L-rn-neg_A \
208-001-L-rn-neg_A \
210-002-L-rn-neg_A \
260-010-L-rn-neg_A \
209-002-L-rn-pos_A \
259-010-L-rn-pos_A \
207-001-L-rn-pos_A \
213-004-L-rn-pos_A \
261-007-C-rn-neg_A \
262-008-C-rn-neg_A \
263-009-C-rn-neg_A \
264-010-C-rn-neg_A)

declare a FIRST_NAMES=(spleen_pos_1 spleen_pos_2 spleen_pos_3)

declare a SECOND_NAMES=(spleen_neg_1 spleen_neg_2 spleen_neg_3 spleen_neg_4 \
spleen_pos_4 liver_neg_1 liver_neg_2 liver_neg_3 liver_neg_4 liver_pos_1 \
liver_pos_2 liver_pos_3 liver_pos_4 colon_neg_1 colon_neg_2 colon_neg_3 \
colon_neg_4)


# create symlink and introduce simple names for samples


COUNT=0
for DIR in "${FIRST_SET[@]}"
do
NAME=${FIRST_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_noTX_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_noTX_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done

COUNT=0
for DIR in "${SECOND_SET[@]}"
do
NAME=${SECOND_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_noTX_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_noTX_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done


# creating metadata tables for TRA and TRB data in each directory


TAB=$(echo -e "\t")
cat >"${MIXDATA}/Treg_TRB_noTX_merged/metadata.txt" <<EOF
Sample${TAB}Sell${TAB}type
spleen_neg_1${TAB}neg${TAB}spleen
spleen_neg_2${TAB}neg${TAB}spleen
spleen_neg_3${TAB}neg${TAB}spleen
spleen_neg_4${TAB}neg${TAB}spleen
spleen_pos_1${TAB}pos${TAB}spleen
spleen_pos_2${TAB}pos${TAB}spleen
spleen_pos_3${TAB}pos${TAB}spleen
spleen_pos_4${TAB}pos${TAB}spleen
liver_neg_1${TAB}neg${TAB}liver
liver_neg_2${TAB}neg${TAB}liver
liver_neg_3${TAB}neg${TAB}liver
liver_neg_4${TAB}neg${TAB}liver
liver_pos_1${TAB}pos${TAB}liver
liver_pos_2${TAB}pos${TAB}liver
liver_pos_3${TAB}pos${TAB}liver
liver_pos_4${TAB}pos${TAB}liver
colon_neg_1${TAB}neg${TAB}colon
colon_neg_2${TAB}neg${TAB}colon
colon_neg_3${TAB}neg${TAB}colon
colon_neg_4${TAB}neg${TAB}colon
EOF
cp ${MIXDATA}/Treg_TRB_noTX_merged/metadata.txt ${MIXDATA}/Treg_TRA_noTX_merged/metadata.txt



# analysis of selected TRBV chains "TRBV12-1","TRBV12-2","TRBV26" in R

cd ${WORKDIR_TCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure5g_residentTreg-TRBVgeneUsage_TRB.Rmd", "html_document")
q()















