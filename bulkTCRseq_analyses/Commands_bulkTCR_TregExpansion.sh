#!/bin/bash
# by MR, October 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###					            TCR repertoire analyses for                            ###
###					              Treg expansion cultures                              ###
###                                                                                    ###
##########################################################################################
##########################################################################################
##########################################################################################


# setting basic path

DIR_DATA="/misc/data"
DIR_SOFT="/misc/software"

# setting homer environment

PATH_R=${DIR_SOFT}/package/RBioC/buster_R-4.0.3_Bioc-3.12_intel-mkl-64bit-2020.1-102/lib/R/bin
export PATH=${PATH_R}:${PATH}
#export PATH

# processed data directory
MAPPINGDIR="${DIR_DATA}/processedData/mapping/RNA/RepSeq/MIXCRv3"

# working directories
PROJECTDIR="${DIR_DATA}/analysis/project_TregProphylaxis"
WORKDIR_TCR="${PROJECTDIR}/bulkTCRrepertoire"
FIGURESDIR="${WORKDIR_TCR}/figures"
MIXDATA="${WORKDIR_TCR}/MixcrData"

# creating novel directories 

mkdir -p ${WORKDIR_TCR}/figures
mkdir ${MIXDATA}



                         ##################################
                         ##################################
                         ##     expansion cultures       ##
                         ##################################
                         ##################################


# Create data folders for further analysis (primarily diversity analyses)

mkdir ${MIXDATA}/Treg_TRA_donors_merged
mkdir ${MIXDATA}/Treg_TRB_donors_merged

# for convenience, create an alias for MIXCR data into the analysis directory

declare -a TREGTRAS=(mTRA_176_Treg_d0_poly_A \
mTRA_196_Treg_d0_allo_A \
mTRA_201_d0_S_Cd62lpos_A \
mTRA_203_d0_S_Cd62lpos_A \
mTRA_205_d0_S_Cd62lpos_A \
mTRA_257-010-S-rn-pos_A \
mTRA_196_Treg_d14_allo_A \
mTRA_Tx198-1-d13-ra_AB \
mTRA_Tx198-2-d12-ra_AB \
mTRA_102_Tx198-4-208_d11_ra_A \
mTRA_217_Tx198-10-241_d12_ra_A \
mTRA_237_Tx198-12-245_d12_ra_A \
mTRA_176_Treg_d14_poly_A \
mTRA_Tx198-1-d13-rp_AB \
mTRA_Tx198-2-d12-rp_AB \
mTRA_103_Tx198-4-208_d11_rp_A \
mTRA_218_Tx198-10-241_d12_rp_A \
mTRA_238_Tx198-12-245_d12_rp_A)

declare -a TREGTRBS=(mTRB_176_Treg_d0_poly_A \
mTRB_196_Treg_d0_allo_A \
mTRB_201_d0_S_Cd62lpos_A \
mTRB_203_d0_S_Cd62lpos_A \
mTRB_205_d0_S_Cd62lpos_A \
mTRB_257-010-S-rn-pos_A \
mTRB_196_Treg_d14_allo_A \
mTRB_Tx198-1-d13-ra_AB \
mTRB_Tx198-2-d12-ra_AB \
mTRB_102_Tx198-4-208_d11_ra_A \
mTRB_217_Tx198-10-241_d12_ra_A \
mTRB_237_Tx198-12-245_d12_ra_A \
mTRB_176_Treg_d14_poly_A \
mTRB_Tx198-1-d13-rp_AB \
mTRB_Tx198-2-d12-rp_AB \
mTRB_103_Tx198-4-208_d11_rp_A \
mTRB_218_Tx198-10-241_d12_rp_A \
mTRB_238_Tx198-12-245_d12_rp_A)

declare -a NAMES=(adonor_1 adonor_2 adonor_3 adonor_4 adonor_5 adonor_6 \
allo_1 allo_2 allo_3 allo_4 allo_5 allo_6 \
poly_1 poly_2 poly_3 poly_4 poly_5 poly_6)



COUNT=0
for DIR in "${TREGTRAS[@]}"
do
NAME=${NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/${DIR}/${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_donors_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done

COUNT=0
for DIR in "${TREGTRBS[@]}"
do
NAME=${NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/${DIR}/${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_donors_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done


# creating metadata tables for TRA and TRB data in each directory

TAB=$(echo -e "\t")
cat >"${MIXDATA}/Treg_TRA_donors_merged/metadata.txt" <<EOF
Sample${TAB}Type
allo_1${TAB}allo
poly_1${TAB}poly
allo_2${TAB}allo
poly_2${TAB}poly
allo_3${TAB}allo
poly_3${TAB}poly
allo_4${TAB}allo
poly_4${TAB}poly
allo_5${TAB}allo
poly_5${TAB}poly
allo_6${TAB}allo
poly_6${TAB}poly
adonor_1${TAB}adonor
adonor_2${TAB}adonor
adonor_3${TAB}adonor
adonor_4${TAB}adonor
adonor_5${TAB}adonor
adonor_6${TAB}adonor
EOF
cp ${MIXDATA}/Treg_TRA_donors_merged/metadata.txt ${MIXDATA}/Treg_TRB_donors_merged/metadata.txt


# diversities are calculated in R

# Treg_TRB_donors_merged

cd ${WORKDIR_TCR}
R --no-restore --no-save
library(rmarkdown)
render("Figure1c_TregExpansion-TCRdiversity_TRB.Rmd", "html_document")
q()

# Treg_TRA_donors_merged

cd ${WORKDIR_TCR}
R --no-restore --no-save
library(rmarkdown)
render("FigureS1a_TregExpansion-TCRdiversity_TRA.Rmd", "html_document")
q()



