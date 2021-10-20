
# TregProphylaxisPaper

Code repository for data processing and plotting included in our paper on the prophylactic use of Treg in murine BMT models.


## Description 

The repository is structured based on data packages that were analysed (mostly) independent from each other. This includes:

* Analysis of bulk RNA sequencing data ([bulkRNAseq_analysis](#bulkRNA) folder)
* Analysis of bulk TCR sequencing data ([bulkTCRseq_analyses](#bulkTCR) folder)
* Analysis of single cell RNA sequencing data ([scRNAseq_analysis](#scRNA) folder)
* Analysis of single cell TCR sequencing data ([scTCRseq_analysis](#scRNA) folder)
* Plotting of additional data (FACS, etc.) ([Rscripts](#other) & [data](#data) folder)

<h3 id="bulkRNA">1. bulkRNAseq_analyses</h3>

Description provided by David....

<h3 id="bulkTCR">2. bulkTCRseq_analyses</h3>

The code for processing and analysis of the TCR data is provided in several bash scripts, which either call perl or R scripts for analyses and plotting.

<h4>Commands\_bulkTCR\_mapping.sh</h4>
Includes the code for mapping the TCRseq data using the MIXCR pipeline.

<h4>Commands\_bulkTCR\_TregExpansion.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of in vitro expansions of Treg cells. Calls two Rscripts to generate Figures 1c and S1a.

<h4>Commands\_bulkTCR\_GvHD.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of Treg reisolated from transplantations in the prophylaxis (GvHD) setting. It generates circos plots of clonotype overlaps (Figures 5a & S5a)and triangular presentations of clonotype weights in barycentric coordinates (Figures 5b,c & S5d,e).

<h4>Commands\_bulkTCR\_noGvHD.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of Treg reisolated from transplantations in the control (no Tconv, noGvHD) setting. It generates circos plots of clonotype overlaps (Figures S5b-c) and triangular presentations of clonotype weights in barycentric coordinates (Figures S5f-i).

<h4>Commands\_bulkTCR\_noBMT.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of resident Treg isolated from wildtype donor mice. Calls an Rscripts to generate Figure 5g.

<h4>Commands\_bulkTCR\_BMT.sh</h4>
Includes the code for the analysing combined TRA/TRB clonotype data of Treg reisolated from transplantations in the noGvHD & GvHD settings. Generates barcode plots for TRB clonotype distributions shown in Figures 5d, and Figures S5j,k,l. Also provides code for Figures related to TRBV segment analyses including plots shown in Figure 5e,f & S5m (generated using Rscript) as well as additional barcode plots shown in Figure S5n.

####Rscripts folder
Contains .rds files that are rendered as part of the analyses commands described above as well as corresponding Session Infos. 


<h3 id="scRNA">3. scRNAseq_analyses</h3>

Description provided by Nick....

<h3 id="scTCR">4. scTCRseq_analyses</h3>

Description provided by Michael....

<h3 id="other">5. Rscripts</h3>

Description provided by Michael....

<h3 id="data">6. data</h3>

Description provided by Michael....


