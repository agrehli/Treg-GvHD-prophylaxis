#!/bin/bash
# by MR, February 2021

##########################################################################################
##########################################################################################
##########################################################################################
###					                                                                   ###
###			      bulk TCR repertoire analyses - mapping of paired end                 ###
###                                   REPseq reads                                     ###
###                                                                                    ###
##########################################################################################
##########################################################################################
##########################################################################################

# setting basic path

DIR_DATA="/misc/data"

# defining directories
RAWDATADIR="${DIR_DATA}/rawData/RNA/RepSeq"
MAPPINGDIR="${DIR_DATA}/processedData/mapping/RNA/RepSeq/MIXCRv3" #(automatically set in TCRmixcrV3.1.pl)





                         ###############################################
                         ###############################################
                         ##     donor Treg (expansion cultures)       ##
                         ###############################################
                         ###############################################


# TRA
#=========================================================================================
# sample name: alloTreg_1_donor
# sample ID: 196_Treg_d14_allo
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_112018/mk196_r14-1A_S41_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-1A_S41_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-2A_S43_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-2A_S43_L001_R2_001.fastq.gz mTRA_196_Treg_d14_allo_A -species mouse -t 12 -TRA -UMI ; 
# sample name: alloTreg_2_donor
# sample ID: Tx198-1-d13-ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-1A_S1_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-1A_S1_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-1A_S1_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-1A_S1_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-2A_S3_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-2A_S3_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-2A_S3_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-2A_S3_L001_R2_001.fastq.gz mTRA_Tx198-1-d13-ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: alloTreg_3_donor
# sample ID: Tx198-2-d12-ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-1A_S1_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-1A_S49_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-1A_S1_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-1A_S49_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-2A_S3_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-2A_S51_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-2A_S3_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-2A_S51_L001_R2_001.fastq.gz mTRA_Tx198-2-d12-ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: alloTreg_4_donor
# sample ID: 102_Tx198-4-208_d11_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-1A_S1_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-1A_S1_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-2A_S2_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-2A_S2_L001_R2_001.fastq.gz mTRA_102_Tx198-4-208_d11_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: alloTreg_6_donor
# sample ID: 217_Tx198-10-241_d12_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-1A_S1_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-1A_S1_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-2A_S2_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-2A_S2_L001_R2_001.fastq.gz mTRA_217_Tx198-10-241_d12_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: alloTreg_7_donor
# sample ID: 237_Tx198-12-245_d12_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/237-245-d12-ra-1A_S23_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/237-245-d12-ra-1A_S23_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/237-245-d12-ra-2-A_S16_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/237-245-d12-ra-2-A_S16_L001_R2_001.fastq.gz mTRA_237_Tx198-12-245_d12_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: polyTreg_1_donor
# sample ID: 176_Treg_d14_poly
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_082018/176_c14-1A_21_S37_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_082018/176_c14-1A_21_S37_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_082018/176_c14-2A_22_S39_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_082018/176_c14-2A_22_S39_L001_R2_001.fastq.gz mTRA_176_Treg_d14_poly_A -species mouse -t 12 -TRA -UMI ; 
# sample name: polyTreg_2_donor
# sample ID: Tx198-1-d13-rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-1A_S5_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-1A_S5_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-1A_S5_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-1A_S5_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-2A_S7_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-2A_S7_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-2A_S7_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-2A_S7_L001_R2_001.fastq.gz mTRA_Tx198-1-d13-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: polyTreg_3_donor
# sample ID: Tx198-2-d12-rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-1A_S5_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-1A_S53_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-1A_S5_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-1A_S53_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-2A_S7_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-2A_S55_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-2A_S7_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-2A_S55_L001_R2_001.fastq.gz mTRA_Tx198-2-d12-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: polyTreg_4_donor
# sample ID: 103_Tx198-4-208_d11_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-1A_S3_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-1A_S3_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-2A_S4_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-2A_S4_L001_R2_001.fastq.gz mTRA_103_Tx198-4-208_d11_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: polyTreg_6_donor
# sample ID: 218_Tx198-10-241_d12_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-1A_S3_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-1A_S3_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-2A_S4_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-2A_S4_L001_R2_001.fastq.gz mTRA_218_Tx198-10-241_d12_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: polyTreg_7_donor
# sample ID: 238_Tx198-12-245_d12_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-1-A_S17_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-1-A_S17_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-2-A_S18_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-2-A_S18_L001_R2_001.fastq.gz mTRA_238_Tx198-12-245_d12_rp_A -species mouse -t 24 -TRA -UMI ; 


# TRB 
#=========================================================================================
# sample name: alloTreg_1_donor
# sample ID: 196_Treg_d14_allo
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_112018/mk196_r14-1B_S42_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-1B_S42_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-2B_S44_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_112018/mk196_r14-2B_S44_L001_R2_001.fastq.gz mTRB_196_Treg_d14_allo_A -species mouse -t 12 -UMI ; 
# sample name: alloTreg_2_donor
# sample ID: Tx198-1-d13-ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-1B_S2_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-1B_S2_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-1B_S2_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-1B_S2_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-2B_S4_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-2B_S4_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/26-198-d13-ra-2B_S4_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/26-198-d13-ra-2B_S4_L001_R2_001.fastq.gz mTRB_Tx198-1-d13-ra_AB -species mouse -t 24 -UMI ; 
# sample name: alloTreg_3_donor
# sample ID: Tx198-2-d12-ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-1B_S2_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-1B_S50_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-1B_S2_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-1B_S50_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-2B_S4_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-2B_S52_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/64-199-d12-ra-2B_S4_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/64-199-d12-ra-2B_S52_L001_R2_001.fastq.gz mTRB_Tx198-2-d12-ra_AB -species mouse -t 24 -UMI ; 
# sample name: alloTreg_4_donor
# sample ID: 102_Tx198-4-208_d11_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-1B_S35_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-1B_S35_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-2B_S36_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/102-208-d11-ra-2B_S36_L001_R2_001.fastq.gz mTRB_102_Tx198-4-208_d11_ra_A -species mouse -t 24 -UMI ; 
# sample name: alloTreg_6_donor
# sample ID: 217_Tx198-10-241_d12_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-1B_S51_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-1B_S51_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-2B_S52_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/217-241-d12-ra-2B_S52_L001_R2_001.fastq.gz mTRB_217_Tx198-10-241_d12_ra_A -species mouse -t 24 -UMI ; 
# sample name: alloTreg_7_donor
# sample ID: 237_Tx198-12-245_d12_ra
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/237-245-d12-ra-1B_S57_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/237-245-d12-ra-1B_S57_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/237-245-d12-ra-2-B_S51_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/237-245-d12-ra-2-B_S51_L001_R2_001.fastq.gz mTRB_237_Tx198-12-245_d12_ra_A -species mouse -t 24 -UMI ; 
# sample name: polyTreg_1_donor
# sample ID: 176_Treg_d14_poly
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_102018/9_176_r14-B1_S9_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_102018/9_176_r14-B1_S9_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_102018/10_176_r14-B2_S10_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_102018/10_176_r14-B2_S10_L001_R2_001.fastq.gz mTRB_176_Treg_d14_poly_A -species mouse -t 12 -UMI ; 
# sample name: polyTreg_2_donor
# sample ID: Tx198-1-d13-rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-1B_S6_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-1B_S6_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-1B_S6_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-1B_S6_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-2B_S8_L001_R1_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-2B_S8_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_122018-2/27-198-d13-rp-2B_S8_L001_R2_001-RS.fastq.gz,${RAWDATADIR}/MiSeq_122018/27-198-d13-rp-2B_S8_L001_R2_001.fastq.gz mTRB_Tx198-1-d13-rp_AB -species mouse -t 24 -UMI ; 
# sample name: polyTreg_3_donor
# sample ID: Tx198-2-d12-rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-1B_S6_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-1B_S54_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-1B_S6_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-1B_S54_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-2B_S8_L001_R1_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-2B_S56_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042019-1/65-199-d12-rp-2B_S8_L001_R2_001.fastq.gz,${RAWDATADIR}/MiSeq_052019-1/65-199-d12-rp-2B_S56_L001_R2_001.fastq.gz mTRB_Tx198-2-d12-rp_AB -species mouse -t 24 -UMI ; 
# sample name: polyTreg_4_donor
# sample ID: 103_Tx198-4-208_d11_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-1B_S37_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-1B_S37_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-2B_S38_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_042021_1/103-208-d11-rp-2B_S38_L001_R2_001.fastq.gz mTRB_103_Tx198-4-208_d11_rp_A -species mouse -t 24 -UMI ; 
# sample name: polyTreg_6_donor
# sample ID: 218_Tx198-10-241_d12_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-1B_S53_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-1B_S53_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-2B_S54_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_1/218-241-d12-rp-2B_S54_L001_R2_001.fastq.gz mTRB_218_Tx198-10-241_d12_rp_A -species mouse -t 24 -UMI ; 
# sample name: polyTreg_7_donor
# sample ID: 238_Tx198-12-245_d12_rp
TCRmixcrV3.1.pl ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-1-B_S52_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-1-B_S52_L001_R2_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-2-B_S53_L001_R1_001.fastq.gz ${RAWDATADIR}/MiSeq_032021_2/238-245-d12-rp-2-B_S53_L001_R2_001.fastq.gz mTRB_238_Tx198-12-245_d12_rp_A -species mouse -t 24 -UMI ; 


                         ###############################################
                         ###############################################
                         ##         re-isolated Treg (GvHD)           ##
                         ###############################################
                         ###############################################


# TRA
#=========================================================================================
# sample name: colonTreg_2-1_GvHD
# sample ID: Tx198-1-293-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-1A_S13_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-1A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-1A_S13_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-1A_S35_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-2A_S15_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-2A_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-2A_S15_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-2A_S36_L001_R2_001.fastq.gz mTRA_Tx198-1-293-C-ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_2-2_GvHD
# sample ID: Tx198-1-294-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-1A_S25_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-1A_S37_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-1A_S25_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-1A_S37_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-2A_S27_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-2A_S38_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-2A_S27_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-2A_S38_L001_R2_001.fastq.gz mTRA_Tx198-1-294-C-ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_2-3_GvHD
# sample ID: Tx198-1-296-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-1A_S37_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-1A_S39_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-1A_S37_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-1A_S39_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-2A_S39_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-2A_S40_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-2A_S39_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-2A_S40_L001_R2_001.fastq.gz mTRA_Tx198-1-296-C-ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_2-4_GvHD
# sample ID: Tx198-1-297-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-1A_S13_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-1A_S13_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-2A_S15_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/38-297-C-rp-2A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-2A_S15_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/38-297-C-rp-2A_S33_L001_R2_001.fastq.gz mTRA_Tx198-1-297-C-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_2-5_GvHD
# sample ID: Tx198-1-298-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-1A_S25_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/41-298-C-rp-1A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-1A_S25_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/41-298-C-rp-1A_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-2A_S27_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/41-298-C-rp-2A_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-2A_S27_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/41-298-C-rp-2A_S41_L001_R2_001.fastq.gz mTRA_Tx198-1-298-C-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_2-6_GvHD
# sample ID: Tx198-1-299-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-1A_S37_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/44-299-C-rp-1A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-1A_S37_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/44-299-C-rp-1A_S35_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-2A_S39_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-2A_S39_L001_R2_001.fastq.gz mTRA_Tx198-1-299-C-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-1_GvHD
# sample ID: Tx198-2-341-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-1A_S13_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-1A_S13_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-2A_S15_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-2A_S15_L001_R2_001.fastq.gz mTRA_Tx198-2-341-C-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-2_GvHD
# sample ID: Tx198-2-346-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-1A_S25_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-1A_S61_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-1A_S25_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-1A_S61_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-2A_S27_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-2A_S63_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/70-346-C-ra-2A_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-2A_S27_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-2A_S63_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/70-346-C-ra-2A_S36_L001_R2_001.fastq.gz mTRA_Tx198-2-346-C-ra_ABC -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-3_GvHD
# sample ID: Tx198-2-348-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-1A_S5_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-1A_S5_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-2A_S7_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-2A_S7_L001_R2_001.fastq.gz mTRA_Tx198-2-348-C-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-4_GvHD
# sample ID: Tx198-2-343-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-2A_S19_L001_R2_001.fastq.gz mTRA_Tx198-2-343-C-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-5_GvHD
# sample ID: Tx198-2-347-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-1A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-1A_S29_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-2A_S31_L001_R2_001.fastq.gz mTRA_Tx198-2-347-C-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3-6_GvHD
# sample ID: Tx198-2-349-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-1A_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-1A_S41_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-2A_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-2A_S43_L001_R2_001.fastq.gz mTRA_Tx198-2-349-C-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-1_GvHD
# sample ID: Tx198-1-293-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-2A_S11_L001_R2_001.fastq.gz mTRA_Tx198-1-293-L-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-2_GvHD
# sample ID: Tx198-1-294-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-1A_S21_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-1A_S21_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-2A_S23_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-2A_S23_L001_R2_001.fastq.gz mTRA_Tx198-1-294-L-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-3_GvHD
# sample ID: Tx198-1-296-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-1A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-1A_S33_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-2A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-2A_S35_L001_R2_001.fastq.gz mTRA_Tx198-1-296-L-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-4_GvHD
# sample ID: Tx198-1-297-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-2A_S11_L001_R2_001.fastq.gz mTRA_Tx198-1-297-L-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-5_GvHD
# sample ID: Tx198-1-298-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-1A_S21_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-1A_S21_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-2A_S23_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-2A_S23_L001_R2_001.fastq.gz mTRA_Tx198-1-298-L-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_2-6_GvHD
# sample ID: Tx198-1-299-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-1A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-1A_S33_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-2A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-2A_S35_L001_R2_001.fastq.gz mTRA_Tx198-1-299-L-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-1_GvHD
# sample ID: Tx198-2-341-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-2A_S11_L001_R2_001.fastq.gz mTRA_Tx198-2-341-L-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-2_GvHD
# sample ID: Tx198-2-346-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-1A_S21_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-1A_S57_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-1A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-1A_S21_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-1A_S57_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-1A_S33_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-2A_S23_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-2A_S59_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-2A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-2A_S23_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-2A_S59_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-2A_S34_L001_R2_001.fastq.gz mTRA_Tx198-2-346-L-ra_ABC -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-3_GvHD
# sample ID: Tx198-2-348-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-1A_S1_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-1A_S1_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-2A_S3_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-2A_S3_L001_R2_001.fastq.gz mTRA_Tx198-2-348-L-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-4_GvHD
# sample ID: Tx198-2-343-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-1A_S13_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-1A_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-1A_S13_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-1A_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-2A_S15_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-2A_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-2A_S15_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-2A_S43_L001_R2_001.fastq.gz mTRA_Tx198-2-343-L-rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-5_GvHD
# sample ID: Tx198-2-347-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-1A_S25_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-1A_S25_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-2A_S27_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-2A_S27_L001_R2_001.fastq.gz mTRA_Tx198-2-347-L-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_3-6_GvHD
# sample ID: Tx198-2-349-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-1A_S37_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-1A_S37_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-2A_S39_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-2A_S39_L001_R2_001.fastq.gz mTRA_Tx198-2-349-L-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-1_GvHD
# sample ID: Tx198-1-293-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-2A_S19_L001_R2_001.fastq.gz mTRA_Tx198-1-293-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-2_GvHD
# sample ID: Tx198-1-294-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-1A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-1A_S29_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-2A_S31_L001_R2_001.fastq.gz mTRA_Tx198-1-294-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-3_GvHD
# sample ID: Tx198-1-296-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-1A_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-1A_S41_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-2A_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-2A_S43_L001_R2_001.fastq.gz mTRA_Tx198-1-296-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-4_GvHD
# sample ID: Tx198-1-297-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-2A_S19_L001_R2_001.fastq.gz mTRA_Tx198-1-297-S-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-5_GvHD
# sample ID: Tx198-1-298-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-1A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-1A_S29_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-2A_S31_L001_R2_001.fastq.gz mTRA_Tx198-1-298-S-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_2-6_GvHD
# sample ID: Tx198-1-299-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-1A_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-1A_S41_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-2A_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-2A_S43_L001_R2_001.fastq.gz mTRA_Tx198-1-299-S-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-1_GvHD
# sample ID: Tx198-2-341-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-2A_S19_L001_R2_001.fastq.gz mTRA_Tx198-2-341-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-2_GvHD
# sample ID: Tx198-2-346-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-1A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-1A_S29_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-2A_S31_L001_R2_001.fastq.gz mTRA_Tx198-2-346-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-3_GvHD
# sample ID: Tx198-2-348-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-2A_S11_L001_R2_001.fastq.gz mTRA_Tx198-2-348-S-ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-4_GvHD
# sample ID: Tx198-2-343-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-1A_S21_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-1A_S21_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-2A_S23_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-2A_S23_L001_R2_001.fastq.gz mTRA_Tx198-2-343-S-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-5_GvHD
# sample ID: Tx198-2-347-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-1A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-1A_S33_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-2A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-2A_S35_L001_R2_001.fastq.gz mTRA_Tx198-2-347-S-rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_3-6_GvHD
# sample ID: Tx198-2-349-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-1A_S45_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-1A_S45_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-2A_S47_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-2A_S47_L001_R2_001.fastq.gz mTRA_Tx198-2-349-S-rp_A -species mouse -t 24 -TRA -UMI ; 

# TRB 
#=========================================================================================
# sample name: colonTreg_2-1_GvHD
# sample ID: Tx198-1-293-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-1B_S14_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-1B_S78_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-1B_S14_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-1B_S78_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-2B_S16_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-2B_S79_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/29-293-C-ra-2B_S16_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/29-293-C-ra-2B_S79_L001_R2_001.fastq.gz mTRB_Tx198-1-293-C-ra_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_2-2_GvHD
# sample ID: Tx198-1-294-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-1B_S26_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-1B_S80_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-1B_S26_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-1B_S80_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-2B_S28_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-2B_S81_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/32-294-C-ra-2B_S28_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/32-294-C-ra-2B_S81_L001_R2_001.fastq.gz mTRB_Tx198-1-294-C-ra_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_2-3_GvHD
# sample ID: Tx198-1-296-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-1B_S38_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-1B_S82_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-1B_S38_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-1B_S82_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-2B_S40_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-2B_S83_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/35-296-C-ra-2B_S40_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/35-296-C-ra-2B_S83_L001_R2_001.fastq.gz mTRB_Tx198-1-296-C-ra_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_2-4_GvHD
# sample ID: Tx198-1-297-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-1B_S14_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-1B_S14_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-2B_S16_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/38-297-C-rp-2B_S16_L001_R2_001.fastq.gz mTRB_Tx198-1-297-C-rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_2-5_GvHD
# sample ID: Tx198-1-298-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-1B_S26_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/41-298-C-rp-1B_S72_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-1B_S26_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/41-298-C-rp-1B_S72_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-2B_S28_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/41-298-C-rp-2B_S84_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/41-298-C-rp-2B_S28_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/41-298-C-rp-2B_S84_L001_R2_001.fastq.gz mTRB_Tx198-1-298-C-rp_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_2-6_GvHD
# sample ID: Tx198-1-299-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-1B_S38_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/44-299-C-rp-1B_S73_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-1B_S38_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/44-299-C-rp-1B_S73_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-2B_S40_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/44-299-C-rp-2B_S40_L001_R2_001.fastq.gz mTRB_Tx198-1-299-C-rp_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-1_GvHD
# sample ID: Tx198-2-341-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-1B_S14_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-1B_S14_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-2B_S16_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/67-341-C-ra-2B_S16_L001_R2_001.fastq.gz mTRB_Tx198-2-341-C-ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-2_GvHD
# sample ID: Tx198-2-346-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-1B_S26_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-1B_S62_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-1B_S26_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-1B_S62_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-2B_S28_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-2B_S64_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/70-346-C-ra-2B_S74_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/70-346-C-ra-2B_S28_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/70-346-C-ra-2B_S64_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/70-346-C-ra-2B_S74_L001_R2_001.fastq.gz mTRB_Tx198-2-346-C-ra_ABC -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-3_GvHD
# sample ID: Tx198-2-348-C-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-1B_S6_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-1B_S6_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-2B_S8_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/73-348-C-ra-2B_S8_L001_R2_001.fastq.gz mTRB_Tx198-2-348-C-ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-4_GvHD
# sample ID: Tx198-2-343-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-1B_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-1B_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-2B_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/76-343-C-rp-2B_S20_L001_R2_001.fastq.gz mTRB_Tx198-2-343-C-rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-5_GvHD
# sample ID: Tx198-2-347-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-1B_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-1B_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-2B_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/79-347-C-rp-2B_S32_L001_R2_001.fastq.gz mTRB_Tx198-2-347-C-rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3-6_GvHD
# sample ID: Tx198-2-349-C-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-1B_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-1B_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-2B_S44_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/82-349-C-rp-2B_S44_L001_R2_001.fastq.gz mTRB_Tx198-2-349-C-rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-1_GvHD
# sample ID: Tx198-1-293-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-1B_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-1B_S10_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-2B_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/28-293-L-ra-2B_S12_L001_R2_001.fastq.gz mTRB_Tx198-1-293-L-ra_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-2_GvHD
# sample ID: Tx198-1-294-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-1B_S22_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-1B_S22_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-2B_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/31-294-L-ra-2B_S24_L001_R2_001.fastq.gz mTRB_Tx198-1-294-L-ra_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-3_GvHD
# sample ID: Tx198-1-296-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-1B_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-1B_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-2B_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/34-296-L-ra-2B_S36_L001_R2_001.fastq.gz mTRB_Tx198-1-296-L-ra_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-4_GvHD
# sample ID: Tx198-1-297-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-1B_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-1B_S10_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-2B_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/37-297-L-rp-2B_S12_L001_R2_001.fastq.gz mTRB_Tx198-1-297-L-rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-5_GvHD
# sample ID: Tx198-1-298-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-1B_S22_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-1B_S22_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-2B_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/40-298-L-rp-2B_S24_L001_R2_001.fastq.gz mTRB_Tx198-1-298-L-rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_2-6_GvHD
# sample ID: Tx198-1-299-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-1B_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-1B_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-2B_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/43-299-L-rp-2B_S36_L001_R2_001.fastq.gz mTRB_Tx198-1-299-L-rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-1_GvHD
# sample ID: Tx198-2-341-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-1B_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-1B_S10_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-2B_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/66-341-L-ra-2B_S12_L001_R2_001.fastq.gz mTRB_Tx198-2-341-L-ra_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-2_GvHD
# sample ID: Tx198-2-346-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-1B_S22_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-1B_S58_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-1B_S67_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-1B_S22_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-1B_S58_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-1B_S67_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-2B_S24_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-2B_S60_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-2B_S68_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/69-346-L-ra-2B_S24_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/69-346-L-ra-2B_S60_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/69-346-L-ra-2B_S68_L001_R2_001.fastq.gz mTRB_Tx198-2-346-L-ra_ABC -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-3_GvHD
# sample ID: Tx198-2-348-L-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-1B_S2_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-1B_S2_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-2B_S4_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/72-348-L-ra-2B_S4_L001_R2_001.fastq.gz mTRB_Tx198-2-348-L-ra_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-4_GvHD
# sample ID: Tx198-2-343-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-1B_S14_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-1B_S85_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-1B_S14_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-1B_S85_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-2B_S16_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-2B_S86_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/75-343-L-rp-2B_S16_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/75-343-L-rp-2B_S86_L001_R2_001.fastq.gz mTRB_Tx198-2-343-L-rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-5_GvHD
# sample ID: Tx198-2-347-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-1B_S26_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-1B_S26_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-2B_S28_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/78-347-L-rp-2B_S28_L001_R2_001.fastq.gz mTRB_Tx198-2-347-L-rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_3-6_GvHD
# sample ID: Tx198-2-349-L-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-1B_S38_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-1B_S38_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-2B_S40_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/81-349-L-rp-2B_S40_L001_R2_001.fastq.gz mTRB_Tx198-2-349-L-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-1_GvHD
# sample ID: Tx198-1-293-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-1B_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-1B_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-2B_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/30-293-S-ra-2B_S20_L001_R2_001.fastq.gz mTRB_Tx198-1-293-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-2_GvHD
# sample ID: Tx198-1-294-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-1B_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-1B_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-2B_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/33-294-S-ra-2B_S32_L001_R2_001.fastq.gz mTRB_Tx198-1-294-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-3_GvHD
# sample ID: Tx198-1-296-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-1B_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-1B_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-2B_S44_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018/36-296-S-ra-2B_S44_L001_R2_001.fastq.gz mTRB_Tx198-1-296-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-4_GvHD
# sample ID: Tx198-1-297-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-1B_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-1B_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-2B_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/39-297-S-rp-2B_S20_L001_R2_001.fastq.gz mTRB_Tx198-1-297-S-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-5_GvHD
# sample ID: Tx198-1-298-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-1B_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-1B_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-2B_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/42-298-S-rp-2B_S32_L001_R2_001.fastq.gz mTRB_Tx198-1-298-S-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_2-6_GvHD
# sample ID: Tx198-1-299-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-1B_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-1B_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-2B_S44_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_122018-2/45-299-S-rp-2B_S44_L001_R2_001.fastq.gz mTRB_Tx198-1-299-S-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-1_GvHD
# sample ID: Tx198-2-341-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-1B_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-1B_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-2B_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/68-341-S-ra-2B_S20_L001_R2_001.fastq.gz mTRB_Tx198-2-341-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-2_GvHD
# sample ID: Tx198-2-346-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-1B_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-1B_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-2B_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_042019-1/71-346-S-ra-2B_S32_L001_R2_001.fastq.gz mTRB_Tx198-2-346-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-3_GvHD
# sample ID: Tx198-2-348-S-ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-1B_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-1B_S10_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-2B_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/74-348-S-ra-2B_S12_L001_R2_001.fastq.gz mTRB_Tx198-2-348-S-ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-4_GvHD
# sample ID: Tx198-2-343-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-1B_S22_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-1B_S22_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-2B_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/77-343-S-rp-2B_S24_L001_R2_001.fastq.gz mTRB_Tx198-2-343-S-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-5_GvHD
# sample ID: Tx198-2-347-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-1B_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-1B_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-2B_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/80-347-S-rp-2B_S36_L001_R2_001.fastq.gz mTRB_Tx198-2-347-S-rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_3-6_GvHD
# sample ID: Tx198-2-349-S-rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-1B_S46_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-1B_S46_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-2B_S48_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_052019-1/83-349-S-rp-2B_S48_L001_R2_001.fastq.gz mTRB_Tx198-2-349-S-rp_A -species mouse -t 24 -UMI ; 



                         ###############################################
                         ###############################################
                         ##        re-isolated Treg (noGvHD)          ##
                         ###############################################
                         ###############################################


# TRA
#=========================================================================================
# sample name: colonTreg_6-1_noGvHD
# sample ID: 221_Tx198-10-4181_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-2A_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-2A_S10_L001_R2_001.fastq.gz mTRA_221_Tx198-10-4181_C_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_6-2_noGvHD
# sample ID: 224_Tx198-10-4183_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-1A_S15_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/224-4183-C-ra-1A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-1A_S15_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/224-4183-C-ra-1A_S29_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-2A_S16_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/224-4183-C-ra-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-2A_S16_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/224-4183-C-ra-2A_S11_L001_R2_001.fastq.gz mTRA_224_Tx198-10-4183_C_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_6-3_noGvHD
# sample ID: 227_Tx198-10-4190_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-1A_S20_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-1A_S13_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-1A_S20_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-1A_S13_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-2A_S21_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-2A_S14_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-2A_S21_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-2A_S14_L001_R2_001.fastq.gz mTRA_227_Tx198-10-4190_C_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_6-4_noGvHD
# sample ID: 230_Tx198-10-4192_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-1-A_S1_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-1-A_S1_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-2-A_S2_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-2-A_S2_L001_R2_001.fastq.gz mTRA_230_Tx198-10-4192_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_6-5_noGvHD
# sample ID: 233_Tx198-10-4193_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-1-A_S7_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-1-A_S7_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-2-A_S8_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-2-A_S8_L001_R2_001.fastq.gz mTRA_233_Tx198-10-4193_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_6-6_noGvHD
# sample ID: 236_Tx198-10-4196_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-1-A_S13_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-1-A_S13_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-2-A_S14_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-2-A_S14_L001_R2_001.fastq.gz mTRA_236_Tx198-10-4196_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-1_noGvHD
# sample ID: 247_Tx198-12-400_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-1A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-1A_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-2A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-2A_S35_L001_R2_001.fastq.gz mTRA_247_Tx198-12-400_C_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-2_noGvHD
# sample ID: 241_Tx198-12-4208_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-1-A_S23_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-1-A_S23_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-2-A_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-2-A_S24_L001_R2_001.fastq.gz mTRA_241_Tx198-12-4208_C_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-3_noGvHD
# sample ID: 244_Tx198-12-4209_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-1A_S28_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-1A_S28_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-2A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-2A_S29_L001_R2_001.fastq.gz mTRA_244_Tx198-12-4209_C_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-4_noGvHD
# sample ID: 256_Tx198-12-4205_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-1-A_S28_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-1-A_S28_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-2-A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-2-A_S29_L001_R2_001.fastq.gz mTRA_256_Tx198-12-4205_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-5_noGvHD
# sample ID: 250_Tx198-12-4214_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-1A_S40_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-1A_S40_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-2A_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-2A_S41_L001_R2_001.fastq.gz mTRA_250_Tx198-12-4214_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_7-6_noGvHD
# sample ID: 253_Tx198-12-4216_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-1A_S46_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-1A_S46_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-2A_S47_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-2A_S47_L001_R2_001.fastq.gz mTRA_253_Tx198-12-4216_C_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-1_noGvHD
# sample ID: 220_Tx198-10-4181_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-1A_S7_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-1A_S7_L001_R1_001-RS.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-1A_S7_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-1A_S7_L001_R2_001-RS.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-2A_S8_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-2A_S8_L001_R1_001-RS.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-2A_S8_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-2A_S8_L001_R2_001-RS.fastq.gz mTRA_220_Tx198-10-4181_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-2_noGvHD
# sample ID: 223_Tx198-10-4183_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-1A_S13_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-1A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-1A_S13_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-1A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-2A_S14_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-2A_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-2A_S14_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-2A_S10_L001_R2_001.fastq.gz mTRA_223_Tx198-10-4183_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-3_noGvHD
# sample ID: 226_Tx198-10-4190_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-1A_S18_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/226-4190-L-ra-1A_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-1A_S18_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/226-4190-L-ra-1A_S12_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-2A_S19_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/226-4190-L-ra-2A_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-2A_S19_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/226-4190-L-ra-2A_S32_L001_R2_001.fastq.gz mTRA_226_Tx198-10-4190_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-4_noGvHD
# sample ID: 229_Tx198-10-4192_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-1A_S24_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-1A_S24_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-2A_S25_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-2A_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-2A_S25_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-2A_S18_L001_R2_001.fastq.gz mTRA_229_Tx198-10-4192_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-5_noGvHD
# sample ID: 232_Tx198-10-4193_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-1-A_S5_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-1A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-1-A_S5_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-1A_S19_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-2-A_S6_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-2A_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-2-A_S6_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-2A_S20_L001_R2_001.fastq.gz mTRA_232_Tx198-10-4193_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_6-6_noGvHD
# sample ID: 235_Tx198-10-4196_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-1-A_S11_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-1A_S21_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-1-A_S11_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-1A_S21_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-2-A_S12_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-2A_S22_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-2-A_S12_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-2A_S22_L001_R2_001.fastq.gz mTRA_235_Tx198-10-4196_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-1_noGvHD
# sample ID: 246_Tx198-12-400_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-1A_S32_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-1A_S26_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-1A_S32_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-1A_S26_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-2A_S33_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-2A_S27_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-2A_S33_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-2A_S27_L001_R2_001.fastq.gz mTRA_246_Tx198-12-400_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-2_noGvHD
# sample ID: 240_Tx198-12-4208_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-1-A_S21_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-1A_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-1-A_S21_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-1A_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-2-A_S22_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-2-A_S22_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-2A_S31_L001_R2_001.fastq.gz mTRA_240_Tx198-12-4208_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-3_noGvHD
# sample ID: 243_Tx198-12-4209_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-1A_S26_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-1A_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-1A_S26_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-1A_S24_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-2A_S27_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-2A_S25_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-2A_S27_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-2A_S25_L001_R2_001.fastq.gz mTRA_243_Tx198-12-4209_L_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-4_noGvHD
# sample ID: 255_Tx198-12-4205_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-1A_S50_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/255-4205-L-rp-1A_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-1A_S50_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/255-4205-L-rp-1A_S32_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-2-A_S27_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/255-4205-L-rp-2A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-2-A_S27_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/255-4205-L-rp-2A_S34_L001_R2_001.fastq.gz mTRA_255_Tx198-12-4205_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-5_noGvHD
# sample ID: 249_Tx198-12-4214_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-1A_S38_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-1A_S28_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-1A_S38_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-1A_S28_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-2A_S39_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-2A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-2A_S39_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-2A_S29_L001_R2_001.fastq.gz mTRA_249_Tx198-12-4214_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: liverTreg_7-6_noGvHD
# sample ID: 252_Tx198-12-4216_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-1A_S44_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-1A_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-1A_S44_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-1A_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-2A_S45_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-2A_S45_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-2A_S31_L001_R2_001.fastq.gz mTRA_252_Tx198-12-4216_L_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-1_noGvHD
# sample ID: 219_Tx198-10-4181_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-1A_S5_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-1A_S5_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-2A_S6_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-2A_S6_L001_R2_001.fastq.gz mTRA_219_Tx198-10-4181_S_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-2_noGvHD
# sample ID: 222_Tx198-10-4183_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-1A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-1A_S11_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-2A_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-2A_S12_L001_R2_001.fastq.gz mTRA_222_Tx198-10-4183_S_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-3_noGvHD
# sample ID: 225_Tx198-10-4190_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/NA /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/NA /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/225-4190-S-ra-2A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/225-4190-S-ra-2A_S17_L001_R2_001.fastq.gz mTRA_225_Tx198-10-4190_S_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-4_noGvHD
# sample ID: 228_Tx198-10-4192_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-1A_S22_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-1A_S15_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-1A_S22_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-1A_S15_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-2A_S23_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-2A_S16_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-2A_S23_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-2A_S16_L001_R2_001.fastq.gz mTRA_228_Tx198-10-4192_S_rp_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-5_noGvHD
# sample ID: 231_Tx198-10-4193_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-1-A_S3_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-1-A_S3_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-2-A_S4_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-2-A_S4_L001_R2_001.fastq.gz mTRA_231_Tx198-10-4193_S_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_6-6_noGvHD
# sample ID: 234_Tx198-10-4196_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-1-A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-1-A_S9_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-2-A_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-2-A_S10_L001_R2_001.fastq.gz mTRA_234_Tx198-10-4196_S_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-1_noGvHD
# sample ID: 245_Tx198-12-400_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-1A_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-1A_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-2A_S31_L001_R2_001.fastq.gz mTRA_245_Tx198-12-400_S_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-2_noGvHD
# sample ID: 239_Tx198-12-4208_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-1-A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-1-A_S19_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-2-A_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-2-A_S20_L001_R2_001.fastq.gz mTRA_239_Tx198-12-4208_S_ra_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-3_noGvHD
# sample ID: 242_Tx198-12-4209_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-1-A_S25_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-1A_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-1-A_S25_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-1A_S32_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-2-A_S26_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-2A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-2-A_S26_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-2A_S33_L001_R2_001.fastq.gz mTRA_242_Tx198-12-4209_S_ra_AB -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-4_noGvHD
# sample ID: 254_Tx198-12-4205_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-1A_S48_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-1A_S48_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-2A_S49_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-2A_S49_L001_R2_001.fastq.gz mTRA_254_Tx198-12-4205_S_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-5_noGvHD
# sample ID: 248_Tx198-12-4214_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-1A_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-1A_S36_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-2A_S37_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-2A_S37_L001_R2_001.fastq.gz mTRA_248_Tx198-12-4214_S_rp_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenTreg_7-6_noGvHD
# sample ID: 251_Tx198-12-4216_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-1A_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-1A_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-2A_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-2A_S43_L001_R2_001.fastq.gz mTRA_251_Tx198-12-4216_S_rp_A -species mouse -t 24 -TRA -UMI ; 

# TRB 
#=========================================================================================
# sample name: colonTreg_6-1_noGvHD
# sample ID: 221_Tx198-10-4181_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-1B_S59_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-1B_S59_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-2B_S60_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/221-4181-C-ra-2B_S60_L001_R2_001.fastq.gz mTRB_221_Tx198-10-4181_C_ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_6-2_noGvHD
# sample ID: 224_Tx198-10-4183_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-1B_S65_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/224-4183-C-ra-1B_S72_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-1B_S65_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/224-4183-C-ra-1B_S72_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-2B_S66_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/224-4183-C-ra-2B_S45_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/224-4183-C-ra-2B_S66_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/224-4183-C-ra-2B_S45_L001_R2_001.fastq.gz mTRB_224_Tx198-10-4183_C_ra_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_6-3_noGvHD
# sample ID: 227_Tx198-10-4190_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-1B_S70_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-1B_S47_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-1B_S70_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-1B_S47_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-2B_S71_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-2B_S48_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/227-4190-C-ra-2B_S71_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/227-4190-C-ra-2B_S48_L001_R2_001.fastq.gz mTRB_227_Tx198-10-4190_C_ra_AB -species mouse -t 24 -UMI ; 
# sample name: colonTreg_6-4_noGvHD
# sample ID: 230_Tx198-10-4192_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-1-B_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-1-B_S36_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-2-B_S37_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/230-4192-C-rp-2-B_S37_L001_R2_001.fastq.gz mTRB_230_Tx198-10-4192_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_6-5_noGvHD
# sample ID: 233_Tx198-10-4193_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-1-B_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-1-B_S42_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-2-B_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/233-4193-C-rp-2-B_S43_L001_R2_001.fastq.gz mTRB_233_Tx198-10-4193_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_6-6_noGvHD
# sample ID: 236_Tx198-10-4196_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-1-B_S48_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-1-B_S48_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-2-B_S49_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/236-4196-C-rp-2-B_S49_L001_R2_001.fastq.gz mTRB_236_Tx198-10-4196_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-1_noGvHD
# sample ID: 247_Tx198-12-400_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-1B_S84_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-1B_S84_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-2B_S85_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/247-400-C-ra-2B_S85_L001_R2_001.fastq.gz mTRB_247_Tx198-12-400_C_ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-2_noGvHD
# sample ID: 241_Tx198-12-4208_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-1-B_S58_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-1-B_S58_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-2-B_S59_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/241-4208-C-ra-2-B_S59_L001_R2_001.fastq.gz mTRB_241_Tx198-12-4208_C_ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-3_noGvHD
# sample ID: 244_Tx198-12-4209_C_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-1B_S78_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-1B_S78_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-2B_S79_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/244-4209-C-ra-2B_S79_L001_R2_001.fastq.gz mTRB_244_Tx198-12-4209_C_ra_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-4_noGvHD
# sample ID: 256_Tx198-12-4205_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-1-B_S63_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-1-B_S63_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-2-B_S64_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/256-4205-C-rp-2-B_S64_L001_R2_001.fastq.gz mTRB_256_Tx198-12-4205_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-5_noGvHD
# sample ID: 250_Tx198-12-4214_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-1B_S90_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-1B_S90_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-2B_S91_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/250-4214-C-rp-2B_S91_L001_R2_001.fastq.gz mTRB_250_Tx198-12-4214_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_7-6_noGvHD
# sample ID: 253_Tx198-12-4216_C_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-1B_S96_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-1B_S96_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-2B_S97_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/253-4216-C-rp-2B_S97_L001_R2_001.fastq.gz mTRB_253_Tx198-12-4216_C_rp_A -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-1_noGvHD
# sample ID: 220_Tx198-10-4181_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-1B_S57_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-1B_S41_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-1B_S57_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-1B_S41_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-2B_S58_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-2B_S42_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/220-4181-L-ra-2B_S58_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/220-4181-L-ra-2B_S42_L001_R2_001.fastq.gz mTRB_220_Tx198-10-4181_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-2_noGvHD
# sample ID: 223_Tx198-10-4183_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-1B_S63_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-1B_S43_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-1B_S63_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-1B_S43_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-2B_S64_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-2B_S44_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/223-4183-L-ra-2B_S64_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/223-4183-L-ra-2B_S44_L001_R2_001.fastq.gz mTRB_223_Tx198-10-4183_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-3_noGvHD
# sample ID: 226_Tx198-10-4190_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-1B_S68_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/226-4190-L-ra-1B_S46_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-1B_S68_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/226-4190-L-ra-1B_S46_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-2B_S69_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/226-4190-L-ra-2B_S71_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/226-4190-L-ra-2B_S69_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_052021_1/226-4190-L-ra-2B_S71_L001_R2_001.fastq.gz mTRB_226_Tx198-10-4190_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-4_noGvHD
# sample ID: 229_Tx198-10-4192_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-1B_S74_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-1B_S51_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-1B_S74_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-1B_S51_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-2B_S75_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-2B_S52_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/229-4192-L-rp-2B_S75_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/229-4192-L-rp-2B_S52_L001_R2_001.fastq.gz mTRB_229_Tx198-10-4192_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-5_noGvHD
# sample ID: 232_Tx198-10-4193_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-1-B_S40_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-1B_S53_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-1-B_S40_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-1B_S53_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-2-B_S41_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-2B_S54_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/232-4193-L-rp-2-B_S41_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/232-4193-L-rp-2B_S54_L001_R2_001.fastq.gz mTRB_232_Tx198-10-4193_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_6-6_noGvHD
# sample ID: 235_Tx198-10-4196_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-1-B_S46_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-1B_S55_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-1-B_S46_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-1B_S55_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-2-B_S47_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-2B_S56_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/235-4196-L-rp-2-B_S47_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/235-4196-L-rp-2B_S56_L001_R2_001.fastq.gz mTRB_235_Tx198-10-4196_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-1_noGvHD
# sample ID: 246_Tx198-12-400_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-1B_S82_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-1B_S60_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-1B_S82_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-1B_S60_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-2B_S83_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-2B_S61_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/246-400-L-ra-2B_S83_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/246-400-L-ra-2B_S61_L001_R2_001.fastq.gz mTRB_246_Tx198-12-400_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-2_noGvHD
# sample ID: 240_Tx198-12-4208_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-1-B_S56_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-1B_S73_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-1-B_S56_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-1B_S73_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-2-B_S57_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-2B_S74_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/240-4208-L-ra-2-B_S57_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/240-4208-L-ra-2B_S74_L001_R2_001.fastq.gz mTRB_240_Tx198-12-4208_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-3_noGvHD
# sample ID: 243_Tx198-12-4209_L_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-1B_S76_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-1B_S58_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-1B_S76_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-1B_S58_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-2B_S77_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-2B_S59_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/243-4209-L-ra-2B_S77_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/243-4209-L-ra-2B_S59_L001_R2_001.fastq.gz mTRB_243_Tx198-12-4209_L_ra_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-4_noGvHD
# sample ID: 255_Tx198-12-4205_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-1B_S100_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/255-4205-L-rp-1B_S66_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-1B_S100_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/255-4205-L-rp-1B_S66_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-2-B_S62_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/255-4205-L-rp-2B_S77_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/255-4205-L-rp-2-B_S62_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/255-4205-L-rp-2B_S77_L001_R2_001.fastq.gz mTRB_255_Tx198-12-4205_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-5_noGvHD
# sample ID: 249_Tx198-12-4214_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-1B_S88_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-1B_S62_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-1B_S88_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-1B_S62_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-2B_S89_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-2B_S63_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/249-4214-L-rp-2B_S89_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/249-4214-L-rp-2B_S63_L001_R2_001.fastq.gz mTRB_249_Tx198-12-4214_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: liverTreg_7-6_noGvHD
# sample ID: 252_Tx198-12-4216_L_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-1B_S94_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-1B_S64_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-1B_S94_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-1B_S64_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-2B_S95_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-2B_S65_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/252-4216-L-rp-2B_S95_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/252-4216-L-rp-2B_S65_L001_R2_001.fastq.gz mTRB_252_Tx198-12-4216_L_rp_AB -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-1_noGvHD
# sample ID: 219_Tx198-10-4181_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-1B_S55_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-1B_S55_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-2B_S56_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/219-4181-S-ra-2B_S56_L001_R2_001.fastq.gz mTRB_219_Tx198-10-4181_S_ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-2_noGvHD
# sample ID: 222_Tx198-10-4183_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-1B_S61_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-1B_S61_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-2B_S62_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/222-4183-S-ra-2B_S62_L001_R2_001.fastq.gz mTRB_222_Tx198-10-4183_S_ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-3_noGvHD
# sample ID: 225_Tx198-10-4190_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/NA /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/NA /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/225-4190-S-ra-2B_S67_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/225-4190-S-ra-2B_S67_L001_R2_001.fastq.gz mTRB_225_Tx198-10-4190_S_ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-4_noGvHD
# sample ID: 228_Tx198-10-4192_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-1B_S72_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-1B_S49_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-1B_S72_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-1B_S49_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-2B_S73_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-2B_S50_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/228-4192-S-rp-2B_S73_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_1/228-4192-S-rp-2B_S50_L001_R2_001.fastq.gz mTRB_228_Tx198-10-4192_S_rp_AB -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-5_noGvHD
# sample ID: 231_Tx198-10-4193_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-1-B_S38_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-1-B_S38_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-2-B_S39_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/231-4193-S-rp-2-B_S39_L001_R2_001.fastq.gz mTRB_231_Tx198-10-4193_S_rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_6-6_noGvHD
# sample ID: 234_Tx198-10-4196_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-1-B_S44_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-1-B_S44_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-2-B_S45_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/234-4196-S-rp-2-B_S45_L001_R2_001.fastq.gz mTRB_234_Tx198-10-4196_S_rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-1_noGvHD
# sample ID: 245_Tx198-12-400_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-1B_S80_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-1B_S80_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-2B_S81_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/245-400-S-ra-2B_S81_L001_R2_001.fastq.gz mTRB_245_Tx198-12-400_S_ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-2_noGvHD
# sample ID: 239_Tx198-12-4208_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-1-B_S54_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-1-B_S54_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-2-B_S55_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/239-4208-S-ra-2-B_S55_L001_R2_001.fastq.gz mTRB_239_Tx198-12-4208_S_ra_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-3_noGvHD
# sample ID: 242_Tx198-12-4209_S_ra
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-1-B_S60_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-1B_S75_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-1-B_S60_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-1B_S75_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-2-B_S61_L001_R1_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-2B_S76_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/242-4209-S-ra-2-B_S61_L001_R2_001.fastq.gz,/misc/data/rawData/RNA/RepSeq/MiSeq_042021_2/242-4209-S-ra-2B_S76_L001_R2_001.fastq.gz mTRB_242_Tx198-12-4209_S_ra_AB -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-4_noGvHD
# sample ID: 254_Tx198-12-4205_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-1B_S98_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-1B_S98_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-2B_S99_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/254-4205-S-rp-2B_S99_L001_R2_001.fastq.gz mTRB_254_Tx198-12-4205_S_rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-5_noGvHD
# sample ID: 248_Tx198-12-4214_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-1B_S86_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-1B_S86_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-2B_S87_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/248-4214-S-rp-2B_S87_L001_R2_001.fastq.gz mTRB_248_Tx198-12-4214_S_rp_A -species mouse -t 24 -UMI ; 
# sample name: spleenTreg_7-6_noGvHD
# sample ID: 251_Tx198-12-4216_S_rp
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-1B_S92_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-1B_S92_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-2B_S93_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_1/251-4216-S-rp-2B_S93_L001_R2_001.fastq.gz mTRB_251_Tx198-12-4216_S_rp_A -species mouse -t 24 -UMI ; 



                         ###############################################
                         ###############################################
                         ##    resident Treg (noBMT,donor strain)     ##
                         ###############################################
                         ###############################################


# TRA
#=========================================================================================
# sample name: colonTreg_2_resident
# sample ID: 261-007-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-1A_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-1A_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-2A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-2A_S31_L001_R2_001.fastq.gz mTRA_261-007-C-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_3_resident
# sample ID: 262-008-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-1A_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-1A_S32_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-2A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-2A_S33_L001_R2_001.fastq.gz mTRA_262-008-C-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_4_resident
# sample ID: 263-009-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-1A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-1A_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-2A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-2A_S35_L001_R2_001.fastq.gz mTRA_263-009-C-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: colonTreg_5_resident
# sample ID: 264-010-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-1A_S36_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-1A_S36_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-2A_S37_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-2A_S37_L001_R2_001.fastq.gz mTRA_264-010-C-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LnegTreg_1_resident
# sample ID: 208-001-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-1A_S12_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-1A_S12_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-2A_S13_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-2A_S13_L001_R2_001.fastq.gz mTRA_208-001-L-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LnegTreg_2_resident
# sample ID: 210-002-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-1A_S16_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-1A_S16_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-2A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-2A_S17_L001_R2_001.fastq.gz mTRA_210-002-L-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LnegTreg_3_resident
# sample ID: 214-004-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-1A_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-1A_S20_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-2A_S21_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-2A_S21_L001_R2_001.fastq.gz mTRA_214-004-L-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LnegTreg_4_resident
# sample ID: 260-010-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-1A_S28_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-1A_S28_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-2A_S29_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-2A_S29_L001_R2_001.fastq.gz mTRA_260-010-L-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LposTreg_1_resident
# sample ID: 207-001-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-1A_S10_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-1A_S10_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-2A_S11_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-2A_S11_L001_R2_001.fastq.gz mTRA_207-001-L-rn-pos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LposTreg_2_resident
# sample ID: 209-002-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-1A_S14_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-1A_S14_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-2A_S15_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-2A_S15_L001_R2_001.fastq.gz mTRA_209-002-L-rn-pos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LposTreg_4_resident
# sample ID: 213-004-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-1A_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-1A_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-2A_S19_L001_R2_001.fastq.gz mTRA_213-004-L-rn-pos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: liverCD62LposTreg_5_resident
# sample ID: 259-010-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-1A_S26_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-1A_S26_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-2A_S27_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-2A_S27_L001_R2_001.fastq.gz mTRA_259-010-L-rn-pos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LnegTreg_1_resident
# sample ID: 202-002-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-1A_S4_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-1A_S4_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-2A_S5_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-2A_S5_L001_R2_001.fastq.gz mTRA_202-002-S-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LnegTreg_2_resident
# sample ID: 204-003-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-1A_S6_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-1A_S6_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-2A_S7_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-2A_S7_L001_R2_001.fastq.gz mTRA_204-003-S-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LnegTreg_3_resident
# sample ID: 206-004-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-1A_S8_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-1A_S8_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-2A_S9_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-2A_S9_L001_R2_001.fastq.gz mTRA_206-004-S-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LnegTreg_4_resident
# sample ID: 258-010-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-1A_S24_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-1A_S24_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-2A_S25_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-2A_S25_L001_R2_001.fastq.gz mTRA_258-010-S-rn-neg_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_1_resident
# sample ID: 201_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-1-A_S30_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-1-A_S30_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-2-A_S31_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-2-A_S31_L001_R2_001.fastq.gz mTRA_201_d0_S_Cd62lpos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_2_resident
# sample ID: 203_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-1-A_S32_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-1-A_S32_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-2-A_S33_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-2-A_S33_L001_R2_001.fastq.gz mTRA_203_d0_S_Cd62lpos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_3_resident
# sample ID: 205_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-1-A_S34_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-1-A_S34_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-2-A_S35_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-2-A_S35_L001_R2_001.fastq.gz mTRA_205_d0_S_Cd62lpos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_4_resident
# sample ID: 257-010-S-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-1A_S22_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-1A_S22_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-2A_S23_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-2A_S23_L001_R2_001.fastq.gz mTRA_257-010-S-rn-pos_A -species mouse -t 24 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_5_resident
# sample ID: 176_Treg_d0_poly
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_082018/176_r0-1A_11_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_082018/176_r0-1A_11_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_082018/176_r0-2A_12_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_082018/176_r0-2A_12_S19_L001_R2_001.fastq.gz mTRA_176_Treg_d0_poly_A -species mouse -t 12 -TRA -UMI ; 
# sample name: spleenCD62LposTreg_6_resident
# sample ID: 196_Treg_d0_allo
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-1A_S17_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-1A_S17_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-2A_S19_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-2A_S19_L001_R2_001.fastq.gz mTRA_196_Treg_d0_allo_A -species mouse -t 12 -TRA -UMI ; 

# TRB 
#=========================================================================================
# sample name: colonTreg_2_resident
# sample ID: 261-007-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-1B_S71_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-1B_S71_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-2B_S72_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/261-007-C-rn-neg-2B_S72_L001_R2_001.fastq.gz mTRB_261-007-C-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_3_resident
# sample ID: 262-008-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-1B_S73_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-1B_S73_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-2B_S74_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/262-008-C-rn-neg-2B_S74_L001_R2_001.fastq.gz mTRB_262-008-C-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_4_resident
# sample ID: 263-009-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-1B_S75_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-1B_S75_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-2B_S76_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/263-009-C-rn-neg-2B_S76_L001_R2_001.fastq.gz mTRB_263-009-C-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: colonTreg_5_resident
# sample ID: 264-010-C-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-1B_S77_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-1B_S77_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-2B_S78_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/264-010-C-rn-neg-2B_S78_L001_R2_001.fastq.gz mTRB_264-010-C-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LnegTreg_1_resident
# sample ID: 208-001-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-1B_S53_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-1B_S53_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-2B_S54_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/208-001-L-rn-neg-2B_S54_L001_R2_001.fastq.gz mTRB_208-001-L-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LnegTreg_2_resident
# sample ID: 210-002-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-1B_S57_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-1B_S57_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-2B_S58_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/210-002-L-rn-neg-2B_S58_L001_R2_001.fastq.gz mTRB_210-002-L-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LnegTreg_3_resident
# sample ID: 214-004-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-1B_S61_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-1B_S61_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-2B_S62_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/214-004-L-rn-neg-2B_S62_L001_R2_001.fastq.gz mTRB_214-004-L-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LnegTreg_4_resident
# sample ID: 260-010-L-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-1B_S69_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-1B_S69_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-2B_S70_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/260-010-L-rn-neg-2B_S70_L001_R2_001.fastq.gz mTRB_260-010-L-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LposTreg_1_resident
# sample ID: 207-001-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-1B_S51_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-1B_S51_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-2B_S52_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/207-001-L-rn-pos-2B_S52_L001_R2_001.fastq.gz mTRB_207-001-L-rn-pos_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LposTreg_2_resident
# sample ID: 209-002-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-1B_S55_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-1B_S55_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-2B_S56_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/209-002-L-rn-pos-2B_S56_L001_R2_001.fastq.gz mTRB_209-002-L-rn-pos_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LposTreg_4_resident
# sample ID: 213-004-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-1B_S59_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-1B_S59_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-2B_S60_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/213-004-L-rn-pos-2B_S60_L001_R2_001.fastq.gz mTRB_213-004-L-rn-pos_A -species mouse -t 24 -UMI ; 
# sample name: liverCD62LposTreg_5_resident
# sample ID: 259-010-L-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-1B_S67_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-1B_S67_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-2B_S68_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/259-010-L-rn-pos-2B_S68_L001_R2_001.fastq.gz mTRB_259-010-L-rn-pos_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LnegTreg_1_resident
# sample ID: 202-002-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-1B_S45_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-1B_S45_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-2B_S46_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/202-002-S-rn-neg-2B_S46_L001_R2_001.fastq.gz mTRB_202-002-S-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LnegTreg_2_resident
# sample ID: 204-003-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-1B_S47_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-1B_S47_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-2B_S48_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/204-003-S-rn-neg-2B_S48_L001_R2_001.fastq.gz mTRB_204-003-S-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LnegTreg_3_resident
# sample ID: 206-004-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-1B_S49_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-1B_S49_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-2B_S50_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/206-004-S-rn-neg-2B_S50_L001_R2_001.fastq.gz mTRB_206-004-S-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LnegTreg_4_resident
# sample ID: 258-010-S-rn-neg
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-1B_S65_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-1B_S65_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-2B_S66_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/258-010-S-rn-neg-2B_S66_L001_R2_001.fastq.gz mTRB_258-010-S-rn-neg_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LposTreg_1_resident
# sample ID: 201_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-1-B_S65_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-1-B_S65_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-2-B_S66_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/201-002-S-rn-pos-2-B_S66_L001_R2_001.fastq.gz mTRB_201_d0_S_Cd62lpos_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LposTreg_2_resident
# sample ID: 203_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-1-B_S67_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-1-B_S67_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-2-B_S68_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/203-003-S-rn-pos-2-B_S68_L001_R2_001.fastq.gz mTRB_203_d0_S_Cd62lpos_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LposTreg_3_resident
# sample ID: 205_d0_S_Cd62lpos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-1-B_S69_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-1-B_S69_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-2-B_S70_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_032021_2/205-004-S-rn-pos-2-B_S70_L001_R2_001.fastq.gz mTRB_205_d0_S_Cd62lpos_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LposTreg_4_resident
# sample ID: 257-010-S-rn-pos
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-1B_S63_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-1B_S63_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-2B_S64_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_062021_1/257-010-S-rn-pos-2B_S64_L001_R2_001.fastq.gz mTRB_257-010-S-rn-pos_A -species mouse -t 24 -UMI ; 
# sample name: spleenCD62LposTreg_5_resident
# sample ID: 176_Treg_d0_poly
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_102018/1_176_r0-1B_S1_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_102018/1_176_r0-1B_S1_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_102018/2_176_r0-2B_S2_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_102018/2_176_r0-2B_S2_L001_R2_001.fastq.gz mTRB_176_Treg_d0_poly_A -species mouse -t 12 -UMI ; 





# sample name: spleenCD62LposTreg_6_resident
# sample ID: 196_Treg_d0_allo
TCRmixcrV3.1.pl /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-1B_S18_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-1B_S18_L001_R2_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-2B_S20_L001_R1_001.fastq.gz /misc/data/rawData/RNA/RepSeq/MiSeq_112018/mk196_r0-2B_S20_L001_R2_001.fastq.gz mTRB_196_Treg_d0_allo_A -species mouse -t 12 -UMI ; 