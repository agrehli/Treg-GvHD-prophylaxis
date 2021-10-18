#!/bin/bash
# by MR, originally February 2021, modified to focus on paper-relevant analyses in Oct. 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###					            TCR repertoire analyses for                            ###
###					     reisolated Treg in no GvHD experiments                        ###
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
                   ##         preparing the noGvHD data         ##
                   ###############################################


# Create data folders for further analysis

mkdir ${MIXDATA}/Treg_TRA_Tx1c_allo_merged
mkdir ${MIXDATA}/Treg_TRB_Tx1c_allo_merged
mkdir ${MIXDATA}/Treg_TRA_Tx1c_poly_merged
mkdir ${MIXDATA}/Treg_TRB_Tx1c_poly_merged
mkdir ${MIXDATA}/Treg_TRA_Tx2c_allo_merged
mkdir ${MIXDATA}/Treg_TRB_Tx2c_allo_merged
mkdir ${MIXDATA}/Treg_TRA_Tx2c_poly_merged
mkdir ${MIXDATA}/Treg_TRB_Tx2c_poly_merged

# for convenience, create an alias for MIXCR data into the analysis directory

# first experiment (three mice each...)
declare a FIRST_ALLO=(217_Tx198-10-241_d12_ra_A \
221_Tx198-10-4181_C_ra_A \
224_Tx198-10-4183_C_ra_AB \
227_Tx198-10-4190_C_ra_AB \
220_Tx198-10-4181_L_ra_AB \
223_Tx198-10-4183_L_ra_AB \
226_Tx198-10-4190_L_ra_AB \
219_Tx198-10-4181_S_ra_A \
222_Tx198-10-4183_S_ra_A \
225_Tx198-10-4190_S_ra_A)

declare a FIRST_POLY=(218_Tx198-10-241_d12_rp_A \
230_Tx198-10-4192_C_rp_A \
233_Tx198-10-4193_C_rp_A \
236_Tx198-10-4196_C_rp_A \
229_Tx198-10-4192_L_rp_AB \
232_Tx198-10-4193_L_rp_AB \
235_Tx198-10-4196_L_rp_AB \
228_Tx198-10-4192_S_rp_AB \
231_Tx198-10-4193_S_rp_A \
234_Tx198-10-4196_S_rp_A)

# second experiment (three mice each...)
declare a SECOND_ALLO=(237_Tx198-12-245_d12_ra_A \
247_Tx198-12-400_C_ra_A \
241_Tx198-12-4208_C_ra_A \
244_Tx198-12-4209_C_ra_A \
246_Tx198-12-400_L_ra_AB \
240_Tx198-12-4208_L_ra_AB \
243_Tx198-12-4209_L_ra_AB \
245_Tx198-12-400_S_ra_A \
239_Tx198-12-4208_S_ra_A \
242_Tx198-12-4209_S_ra_AB)

declare a SECOND_POLY=(238_Tx198-12-245_d12_rp_A \
256_Tx198-12-4205_C_rp_A \
250_Tx198-12-4214_C_rp_A \
253_Tx198-12-4216_C_rp_A \
255_Tx198-12-4205_L_rp_AB \
249_Tx198-12-4214_L_rp_AB \
252_Tx198-12-4216_L_rp_AB \
254_Tx198-12-4205_S_rp_A \
248_Tx198-12-4214_S_rp_A \
251_Tx198-12-4216_S_rp_A)


declare a FIRST_NAMES=(adonor_1 colon_1 colon_2 colon_3 \
liver_1 liver_2 liver_3 spleen_1 spleen_2 spleen_3)

declare a SECOND_NAMES=(adonor_2 colon_4 colon_5 colon_6 \
liver_4 liver_5 liver_6 spleen_4 spleen_5 spleen_6)


# create symlink and introduce simple names for samples


COUNT=0
for DIR in "${FIRST_ALLO[@]}"
do
NAME=${FIRST_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_Tx1c_allo_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_Tx1c_allo_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done


COUNT=0
for DIR in "${FIRST_POLY[@]}"
do
NAME=${FIRST_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_Tx1c_poly_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_Tx1c_poly_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done

COUNT=0
for DIR in "${SECOND_ALLO[@]}"
do
NAME=${SECOND_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_Tx2c_allo_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_Tx2c_allo_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done

COUNT=0
for DIR in "${SECOND_POLY[@]}"
do
NAME=${SECOND_NAMES[$COUNT]}
ln -s ${MAPPINGDIR}/mTRA_${DIR}/mTRA_${DIR}.RunAB.clonotypes.TRA.txt ${MIXDATA}/Treg_TRA_Tx2c_poly_merged/${NAME}.txt
ln -s ${MAPPINGDIR}/mTRB_${DIR}/mTRB_${DIR}.RunAB.clonotypes.TRB.txt ${MIXDATA}/Treg_TRB_Tx2c_poly_merged/${NAME}.txt
COUNT=$((COUNT+=1))                       
done

# creating metadata tables for TRA and TRB data in each directory

TAB=$(echo -e "\t")
cat >"${MIXDATA}/Treg_TRA_Tx1c_allo_merged/metadata.txt" <<EOF
Sample${TAB}Type
adonor_1${TAB}adonor
colon_1${TAB}colon
colon_2${TAB}colon
colon_3${TAB}colon
liver_1${TAB}liver
liver_2${TAB}liver
liver_3${TAB}liver
spleen_1${TAB}spleen
spleen_2${TAB}spleen
spleen_3${TAB}spleen
EOF
cp ${MIXDATA}/Treg_TRA_Tx1c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRB_Tx1c_allo_merged/metadata.txt
cp ${MIXDATA}/Treg_TRA_Tx1c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRB_Tx1c_poly_merged/metadata.txt
cp ${MIXDATA}/Treg_TRA_Tx1c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRA_Tx1c_poly_merged/metadata.txt

TAB=$(echo -e "\t")
cat >"${MIXDATA}/Treg_TRA_Tx2c_allo_merged/metadata.txt" <<EOF
Sample${TAB}Type
adonor_2${TAB}adonor
colon_4${TAB}colon
colon_5${TAB}colon
colon_6${TAB}colon
liver_4${TAB}liver
liver_5${TAB}liver
liver_6${TAB}liver
spleen_4${TAB}spleen
spleen_5${TAB}spleen
spleen_6${TAB}spleen
EOF
cp ${MIXDATA}/Treg_TRA_Tx2c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRB_Tx2c_allo_merged/metadata.txt
cp ${MIXDATA}/Treg_TRA_Tx2c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRB_Tx2c_poly_merged/metadata.txt
cp ${MIXDATA}/Treg_TRA_Tx2c_allo_merged/metadata.txt ${MIXDATA}/Treg_TRA_Tx2c_poly_merged/metadata.txt


# two types of analyses are performed using perl-wrappers that require a condensed, processed data format:
# 1. Circos plots for Clonotype overlap between animals and tissues 
# 2. Triangular plots showing barycentric distributions of clonotypes
# other analyses are done in R, mostly with all BMT data sets included (s. Commands_bulkTCR_BMT.sh)
# processing involves import of the MIXCR data into the immunoarch package (R) and storing the data table as a text file.
# In a second step, the data is parsed to fit requirements for the perl-wrapper scripts

# extract data tables for merged samples after import into immunarch

mkdir ${IADATA}/Treg_TRA_Tx1c_allo_merged
mkdir ${IADATA}/Treg_TRB_Tx1c_allo_merged
mkdir ${IADATA}/Treg_TRA_Tx1c_poly_merged
mkdir ${IADATA}/Treg_TRB_Tx1c_poly_merged
mkdir ${IADATA}/Treg_TRA_Tx2c_allo_merged
mkdir ${IADATA}/Treg_TRB_Tx2c_allo_merged
mkdir ${IADATA}/Treg_TRA_Tx2c_poly_merged
mkdir ${IADATA}/Treg_TRB_Tx2c_poly_merged

mkdir ${DATAREFORM}/Treg_TRA_Tx1c_allo_merged
mkdir ${DATAREFORM}/Treg_TRB_Tx1c_allo_merged
mkdir ${DATAREFORM}/Treg_TRA_Tx1c_poly_merged
mkdir ${DATAREFORM}/Treg_TRB_Tx1c_poly_merged
mkdir ${DATAREFORM}/Treg_TRA_Tx2c_allo_merged
mkdir ${DATAREFORM}/Treg_TRB_Tx2c_allo_merged
mkdir ${DATAREFORM}/Treg_TRA_Tx2c_poly_merged
mkdir ${DATAREFORM}/Treg_TRB_Tx2c_poly_merged


declare a DIRS=(Treg_TRA_Tx1c_allo_merged \
Treg_TRB_Tx1c_allo_merged \
Treg_TRA_Tx1c_poly_merged \
Treg_TRB_Tx1c_poly_merged)

for DIR in "${DIRS[@]}"
do
_DATE=$(date +%s)
cat >"${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R" <<EOF
library("immunarch")
file_path = "${MIXDATA}/${DIR}"
immdata <- repLoad(file_path)
EOF
for NAME in ${FIRST_NAMES[@]}
do
cat >>"${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R" <<EOF
write.table(immdata\$data\$${NAME}, file = "${IADATA}/${DIR}/${NAME}.immunarch.txt", sep = "\t", col.names=NA, quote=FALSE)
EOF
done
R < "${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R"  --no-save
done


declare a DIRS=(Treg_TRA_Tx2c_allo_merged \
Treg_TRB_Tx2c_allo_merged \
Treg_TRA_Tx2c_poly_merged \
Treg_TRB_Tx2c_poly_merged)

for DIR in "${DIRS[@]}"
do
_DATE=$(date +%s)
cat >"${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R" <<EOF
library("immunarch")
file_path = "${MIXDATA}/${DIR}"
immdata <- repLoad(file_path)
EOF
for NAME in ${SECOND_NAMES[@]}
do
cat >>"${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R" <<EOF
write.table(immdata\$data\$${NAME}, file = "${IADATA}/${DIR}/${NAME}.immunarch.txt", sep = "\t", col.names=NA, quote=FALSE)
EOF
done
R < "${TMPDIR}/R.immunarch.${DIR}.${_DATE}.R"  --no-save
done




# parsing the IA data for downstream usage


declare a DIRS=(Treg_TRA_Tx1c_allo_merged \
Treg_TRB_Tx1c_allo_merged \
Treg_TRA_Tx1c_poly_merged \
Treg_TRB_Tx1c_poly_merged)

for DIR in "${DIRS[@]}"
do
	for NAME in "${FIRST_NAMES[@]}"
	do
	bulkTCRparseImmunArch.pl ${IADATA}/${DIR}/${NAME}.immunarch.txt ${DATAREFORM}/${DIR} ${NAME}
	done
done

declare a DIRS=(Treg_TRA_Tx2c_allo_merged \
Treg_TRB_Tx2c_allo_merged \
Treg_TRA_Tx2c_poly_merged \
Treg_TRB_Tx2c_poly_merged)

for DIR in "${DIRS[@]}"
do
	for NAME in "${SECOND_NAMES[@]}"
	do
	bulkTCRparseImmunArch.pl ${IADATA}/${DIR}/${NAME}.immunarch.txt ${DATAREFORM}/${DIR} ${NAME}
	done
done






                          ###############################
                          #  Overlap via Circos plots   #
                          ###############################


declare a DIRS=(Treg_TRA_Tx1c_allo_merged \
Treg_TRB_Tx1c_allo_merged \
Treg_TRA_Tx1c_poly_merged \
Treg_TRB_Tx1c_poly_merged)

for DIR in "${DIRS[@]}"
do

# creating merged count table
cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR} \
-mergeFiles \
bulkTCR_IAcountTable.adonor_1.txt \
bulkTCR_IAcountTable.colon_1.txt \
bulkTCR_IAcountTable.colon_2.txt \
bulkTCR_IAcountTable.colon_3.txt \
bulkTCR_IAcountTable.liver_1.txt \
bulkTCR_IAcountTable.liver_2.txt \
bulkTCR_IAcountTable.liver_3.txt \
bulkTCR_IAcountTable.spleen_1.txt \
bulkTCR_IAcountTable.spleen_2.txt \
bulkTCR_IAcountTable.spleen_3.txt \
-sampleNames \
donor1 \
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
bulkTCRCirculizeFreq4Samples.pl ${DIR}.clonotypeTable.groups.txt \
-name ${DIR}.groups \
-outDir ${FIGURESDIR} \
-colors 255,0,0 160,82,45 70,130,180 255,20,147 \
-shortNames donor colon liver spleen -dvt 2>/dev/null

done

declare a DIRS=(Treg_TRA_Tx2c_allo_merged \
Treg_TRB_Tx2c_allo_merged \
Treg_TRA_Tx2c_poly_merged \
Treg_TRB_Tx2c_poly_merged)

for DIR in "${DIRS[@]}"
do

# creating merged count table
cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR} \
-mergeFiles \
bulkTCR_IAcountTable.adonor_2.txt \
bulkTCR_IAcountTable.colon_4.txt \
bulkTCR_IAcountTable.colon_5.txt \
bulkTCR_IAcountTable.colon_6.txt \
bulkTCR_IAcountTable.liver_4.txt \
bulkTCR_IAcountTable.liver_5.txt \
bulkTCR_IAcountTable.liver_6.txt \
bulkTCR_IAcountTable.spleen_4.txt \
bulkTCR_IAcountTable.spleen_5.txt \
bulkTCR_IAcountTable.spleen_6.txt \
-sampleNames \
donor2 \
colon4 \
colon5 \
colon6 \
liver4 \
liver5 \
liver6 \
spleen4 \
spleen5 \
spleen6 \
-groupNames \
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
bulkTCRCirculizeFreq4Samples.pl ${DIR}.clonotypeTable.groups.txt \
-name ${DIR}.groups \
-outDir ${FIGURESDIR} \
-colors 255,0,0 160,82,45 70,130,180 255,20,147 \
-shortNames donor colon liver spleen -dvt 2>/dev/null

done







                      ####################################
                      #  Overlap via barycentric plots   #
                      ####################################


declare a DIRS=(Treg_TRA_Tx1c_allo_merged \
Treg_TRB_Tx1c_allo_merged \
Treg_TRA_Tx1c_poly_merged \
Treg_TRB_Tx1c_poly_merged)

for DIR in "${DIRS[@]}"
do

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.CLS -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.colon_1.txt \
bulkTCR_IAcountTable.colon_2.txt \
bulkTCR_IAcountTable.colon_3.txt \
bulkTCR_IAcountTable.liver_1.txt \
bulkTCR_IAcountTable.liver_2.txt \
bulkTCR_IAcountTable.liver_3.txt \
bulkTCR_IAcountTable.spleen_1.txt \
bulkTCR_IAcountTable.spleen_2.txt \
bulkTCR_IAcountTable.spleen_3.txt \
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
bulkTCRtriangle.pl ${DIR}.CLS.clonotypeTable.groups.norm5K.txt ${FIGURESDIR} ${DIR}.CLS.250clonotypes.norm5K -top 250 -color red

# analysis for individual organs

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.C -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.colon_1.txt \
bulkTCR_IAcountTable.colon_2.txt \
bulkTCR_IAcountTable.colon_3.txt \
-sampleNames \
colon1 \
colon2 \
colon3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.C.norm5K.txt ${FIGURESDIR} ${DIR}.C.norm5K -top 250 -color sienna

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.L -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.liver_1.txt \
bulkTCR_IAcountTable.liver_2.txt \
bulkTCR_IAcountTable.liver_3.txt \
-sampleNames \
liver1 \
liver2 \
liver3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.L.norm5K.txt ${FIGURESDIR} ${DIR}.L.norm5K -top 250 -color steelblue

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.S -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.spleen_1.txt \
bulkTCR_IAcountTable.spleen_2.txt \
bulkTCR_IAcountTable.spleen_3.txt \
-sampleNames \
spleen1 \
spleen2 \
spleen3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.S.norm5K.txt ${FIGURESDIR} ${DIR}.S.norm5K -top 250 -color deeppink

done



declare a DIRS=(Treg_TRA_Tx2c_allo_merged \
Treg_TRB_Tx2c_allo_merged \
Treg_TRA_Tx2c_poly_merged \
Treg_TRB_Tx2c_poly_merged)

for DIR in "${DIRS[@]}"
do

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.CLS -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.colon_4.txt \
bulkTCR_IAcountTable.colon_5.txt \
bulkTCR_IAcountTable.colon_6.txt \
bulkTCR_IAcountTable.liver_4.txt \
bulkTCR_IAcountTable.liver_5.txt \
bulkTCR_IAcountTable.liver_6.txt \
bulkTCR_IAcountTable.spleen_4.txt \
bulkTCR_IAcountTable.spleen_5.txt \
bulkTCR_IAcountTable.spleen_6.txt \
-sampleNames \
colon4 \
colon5 \
colon6 \
liver4 \
liver5 \
liver6 \
spleen4 \
spleen5 \
spleen6 \
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
bulkTCRtriangle.pl ${DIR}.CLS.clonotypeTable.groups.norm5K.txt ${FIGURESDIR} ${DIR}.CLS.250clonotypes.norm5K -top 500 -color red

# analysis for individual organs

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.C -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.colon_4.txt \
bulkTCR_IAcountTable.colon_5.txt \
bulkTCR_IAcountTable.colon_6.txt \
-sampleNames \
colon1 \
colon2 \
colon3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.C.norm5K.txt ${FIGURESDIR} ${DIR}.C.norm5K -top 250 -color sienna

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.L -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.liver_4.txt \
bulkTCR_IAcountTable.liver_5.txt \
bulkTCR_IAcountTable.liver_6.txt \
-sampleNames \
liver1 \
liver2 \
liver3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.L.norm5K.txt ${FIGURESDIR} ${DIR}.L.norm5K -top 250 -color steelblue

cd ${DATAREFORM}/${DIR}
bulkTCRcreateJoinedCountTable.pl ${ANALYSISDIR} ${DIR}.S -norm 5 \
-mergeFiles \
bulkTCR_IAcountTable.spleen_4.txt \
bulkTCR_IAcountTable.spleen_5.txt \
bulkTCR_IAcountTable.spleen_6.txt \
-sampleNames \
spleen1 \
spleen2 \
spleen3

cd ${ANALYSISDIR}
bulkTCRtriangle.pl bulkTCRcountTable.${DIR}.S.norm5K.txt ${FIGURESDIR} ${DIR}.S.norm5K -top 250 -color deeppink

done


