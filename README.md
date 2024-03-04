
# TregProphylaxisPaper

Code repository for data processing and plotting included in our study characterizing donor Treg in the prophylactic treatment of acute GvHD.

>Donor regulatory T cells rapidly adapt to recipient tissues to control murine acute graft-versus-host disease.

## Description 

The repository is structured based on data packages that were analysed (mostly) independent from each other. This includes:

* Analysis of bulk RNA sequencing data ([bulkRNAseq_analysis](#bulkRNA) folder)
* Analysis of bulk TCR sequencing data ([bulkTCRseq_analyses](#bulkTCR) folder)
* Analysis of single cell RNA sequencing data ([scRNAseq_analysis](#scRNA) folder)
* Analysis of single cell TCR sequencing data ([scTCRseq_analysis](#scRNA) folder)
* Plotting of additional data (FACS, etc.) ([Rscripts](#R) & [data](#data) folder)
* Perl scripts used for processing or plotting ([perlScripts](#perl) folder)

<h2 id="bulkRNA">1. bulkRNAseq_analyses</h2>

This directory contains **data** and **code** for the analyses underlying the **bulkRNAseq** experiments of re-isolated Treg and the corresponding expanded donor Treg cells.  
The following figures are covered:  

* **Figure 1 e, f**
* **Supplementary Figure 1 d**
* **Supplementary Figure 2 e**
* **Figure 3 a - c, e, f**
* **Supplementary Figure 3 c - m**
* **Figure 4 a - d**
* **Supplementary Figure 4 a - d**

<h4>Initial Steps (OPTIONAL)</h4>

Before running the first **.Rmd** file for the initial setup (**bulkRNAseq_analyses_initial_setup.Rmd**), all relevant **...ReadsPerGene.txt** files have to be retrieved from GEO and locally stored in a directory called **"RPGDIR"** within the **"bulkRNAseq_analyses"** directory within the project directory **"tregprophylaxispaper"** **(/.../tregprophylaxispaper/bulkRNAseq_analyses/RPGDIR)**. All relevant **.rds** files for annotation, metadata and read counts are **supplied** as well. However, in case you want to **reproduce** metadata and read count data objects, above steps are recommended.

<h4>General Usage</h4>

All **.Rmd** files were successfully run on the system build supplied in the respective **SessionInfo.txt** files. **RStudio** is recommended for running the markdown files. Using **knitr**, a html report can be generated. The code will result in the figure(s) specified. Make sure your project working directory is set two levels above the **"RScripts"** directory within the **"bulkRNAseq_analyses"** directory. When using **git** to **clone** the repository, this should be the case by default and the **"tregprophylaxispaper"** directory should be specified as your project working directory.

<h4>Running Order</h4>

A certain order of running the markdown files is recommended as some analyses rely on previous analyses' results, e.g. "Figure3_TregDGEScatter_GSEA_cvnc.pc_BMT.Rmd" requires results from "Figure3_TregDGEScatter_GSEA_Heatmap_Metascape_cvnc.b.Cd62Lneg.Rmd" for a GSEA. Hereafter, the **recommended running order** is lined out.

1. **bulkRNAseq_analyses_initial_setup.Rmd**
2. **Figure1_TregDGEScatter_GSEA_avp_invitro**
3. **Figure1_TregSigHeatmap_fresh.allo.poly.Rmd**
4. **FigureS2e_additionalBarplots_pro.don.Rmd**
5. **Figure3_TregDGEScatter_GSEA_Heatmap_Metascape_cvnc.b.Cd62Lneg.Rmd**
6. **Figure3_GSEA_prc.pro_avp.c.l.s.indiv.Rmd**
7. **Figure3_TregDGEScatter_GSEA_cvnc.pc_BMT.Rmd**
8. **Figure3and4_UMAP_Heatmaps_GSEA_Barplots_pro.prc.bas.don.Rmd**
9. **Figure4_TregDGEScatter_GSEA_pvc.cls.Rmd**

Of note, for scripts **2., 3., 4., 5., 6.,** the order is arbitrary. As long as they have been run after **1.** and before **7.**. Also, for .Rmd files **8., 9.** can be run as soon as **1.** has been executed.


<h2 id="bulkTCR">2. bulkTCRseq_analyses</h2>

The code for processing and analysis of the TCR data is provided in several bash scripts, which either call perl or R scripts for analyses and plotting.
The following figures are covered:  

* **Figure 1 c**
* **Supplementary Figure 1 a**
* **Supplementary Figure 1 c**
* **Figure 5 a - f**
* **Supplementary Figure 5 a - l, n, o**

<h4>Commands_bulkTCR_mapping.sh</h4>
Includes the code for mapping the TCRseq data using the MIXCR pipeline. This is required for all other analyses.

<h4>Commands_bulkTCR_TregExpansion.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of in vitro expansions of Treg cells. Calls two Rscripts to generate Figures 1c and S1a.

<h4>Commands_bulkTCR_GvHD.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of Treg reisolated from transplantations in the prophylaxis (GvHD) setting. It generates circos plots of clonotype overlaps (Figures 5a & S5a) and triangular presentations of clonotype weights in barycentric coordinates (Figures 5b,c & S5d,e).

<h4>Commands_bulkTCR_noGvHD.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of Treg reisolated from transplantations in the control (no Tconv, noGvHD) setting. It generates circos plots of clonotype overlaps (Figures S5b-c) and triangular presentations of clonotype weights in barycentric coordinates (Figures S5f-i).

<h4>Commands_bulkTCR_noBMT.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of resident Treg isolated from wildtype donor mice. Calls an Rscripts to generate Figure 5f.

<h4>Commands_bulkTCR_BMT.sh</h4>
Includes the code for the analysing combined TRA/TRB clonotype data of Treg reisolated from transplantations in the noGvHD & GvHD settings. Generates barcode plots for TRB clonotype distributions shown in Figures 5d, and Figures S5j,k,l. Also provides code for Figures related to TRBV segment analyses including plots shown in Figure 5e & S5n (generated using Rscript) as well as additional barcode plots shown in Figure S5o.

<h4>Rscripts folder</h4>
Contains R markdown scripts (*.rmd) that are rendered as part of the analyses commands described above as well as corresponding Session Infos.


<h2 id="scRNA">3. scRNAseq_analyses</h2>


The code for processing and analysis of the scRNA data and scTCR data mapped to scRNA data is provided in a bash script, which either call to .R or .Rmd scripts for analyses, or directly by .Rmd scripts.
The following figures are covered:  

* **Figure 6 a - d**
* **Figure 6 g - h**
* **Supplementary Figure 6 a - f**
* **Figure 7 a - f**
* **Supplementary Figure 7 a - b**

<h4>RcallDoubletfinder.R</h4>
Removing of doublets per dataset.
Depends on: `helperscripts/scAnalysis/.`

* cellranger_doublets.csv
* doubletFinder.R
* elbowPoint.R
* doubletFinder.html (example plus session info)	 
* doubletFinder.Rmd
* ElbPlxy.txt


<h4>Analysis_Seurat_20210212_S4_noDoub_fin.Rmd</h4>
Primary processing of data processed through `doubletfinder`, QC, quality filtering and clustering of 10x data processed by cellranger count. Depends on `scAnalysis_function2_b.R` to load functions.


<h4>Analysis_Seurat_20210212_S4_noDoub_Pub_fin.Rmd</h4>
Code for figures of the publication, merging with scTCR data and clustering and figures of the colon subset of the data. Depends on `loadLibandObjects_Seurat3.1.0.R` and `scAnalysis_function2_b.R` to load libraries,functions and .rds data object.


<h4>RNAvelocity</h4>
Code for primary processing of scRNA data for RNA velocity analysis and figure creation:

* environment_kb-python_0.26.4.yml (conda environment)
* kb_tools_RNAVelocityanalysis.ipynb (kb_tools_RNAVelocityanalysis.py)
* velofigure.sh (depends on: `scVelo.py`) 


<h2 id="scTCR">4. scTCRseq_analyses</h2>

The code for processing and analysis of the TCR data is provided in a bash script, which either call perl or R scripts for analyses.
The following figures are covered:  

* **Figure 6 e - i**
* **Supplementary Figure 6 c - f**
* **Figure 7 e, f**

<h4>Commands_scTCR_GvHD.sh</h4>
Includes the code for the processing of TRA/TRB clonotype data of Treg reisolated from transplantations in the prophylaxis (GvHD) setting. It generates circos plots of clonotype overlaps (Figures 6e) and triangular presentations of clonotype weights in barycentric coordinates (Figure 6f). It generates the barplots showing examples clonotype counts across samples (Figure 6i), calculates diversities (Figure S6c), plots the Morisita's overlap indices (Figure S6d), and Trvb segment distributions (FigureS6e). 

<h4>Rscripts folder</h4>
Contains R markdown scripts (*.rmd) that are rendered as part of the **Commands_scTCR_GvHD.sh** script described above as well as corresponding Session Infos.


<h2 id="R">5. Rscripts</h2>

Contains R markdown scripts (*.rmd) that are rendered locally using data provided in the [data](#data) folder as well as corresponding Session Infos. 
The following figures are covered:  

* **Figure 1 b, d**
* **Figure 2 b - e**
* **Supplementary Figure 1 c**
* **Supplementary Figure 2 b, c**

<h2 id="data">6. data</h2>

Contains data for Figures 1b,d & 2b-e & Supplemental Figures 2b,c.

<h2 id="perl">7. perlScripts</h2>

*<h5>related to bulk TCR repertoire aligning:</h5>*

<h4>TCRmixcrV3.1.pl</h4>
Perl script to map TCR repertoires derived from our RACE-PCR approach. Sequencing data (usually MiSeq 300bp PE) are initially assembled (paired) using the software PEAR. UMI should be standard in our protocol, but the pipeline can also be used for non-barcoded RNAs (when -UMI option is omitted). MIGs are called using MIGEC before mapping with MIXCR (version 3). We usually run two libraries for each sample (replicate) and work with the combined repertoire from both technical replicate runs. Individual runs are kept for quality controls.
The pipeline is setup for our server and deploys folders for each experiment on the misc/data volume under processedData//mapping/RNA/RepSeq/MIXCRv3/. ***Dependencies:*** PEAR (v0.9.11), MIGEC (v1.2.9), MIXCR (v3.0.13), R version 4.0.3 (rbioc_3-12).


*<h5>related to bulk TCR repertoire analyses:</h5>*

Many analyses are done in R, but for two types of presentations (Circos plot of clonotype overlap, and barycentric distributions of clonotype weights), we have a set of  Perl scripts that perform preprocessing/reformating of the data (bulkTCRparseImmunArch.pl, bulkTCRcreateJoinedCountTable.pl) and one each for the plotting (bulkTCRCirculizeFreq4Samples.pl, bulkTCRtriangle.pl)

<h4>bulkTCRparseImmunArch.pl</h4>
Perl script to reformat the data table generated by the immunoarch R package to fit into our count table joining script.

<h4>bulkTCRcreateJoinedCountTable.pl</h4>
Perl script generating joined clonotype tables from several samples. Accepts files generated by the bulkTCRparseImmunArch.pl script.

<h4>bulkTCRCirculizeFreq4Samples.pl</h4>
Perl script that generates a circos plot for clonotype overlaps in exactly four samples. This is tailored for our three animal/one donor design and shows how much overlap there is between donors and recipient organs. ***Dependencies:*** R version 4.0.3 (rbioc_3-12), R packages: circlize, RColorBrewer, gridExtra, grid 

<h4>bulkTCRtriangle.pl</h4>
Perl script that calculates weights of clonotype counts for three sample comparisons and  generates a bubble plot using barycentric coordinates by generating and calling a R script. This is a nice way to demonstrate the contribution of each of the three samples to the top clonotypes in the comparison. It accepts clonotypeTable files generated with the bulkTCRcreateJoinedCountTable.pl (best to restrict to some 100 top clones). ***Dependencies:*** R version 4.0.3 (rbioc_3-12), ggplot2 R package


*<h5>related to sc TCR repertoire analyses</h5>*

<h4>scTCRparseImmunArch.pl, scTCRcreateJoinedCountTable.pl, scTCRCirculizeFreq4Samples.pl, scTCRtriangle.pl</h4>
Perl scripts equivalent to the corresponding bulkTCR script set - set up to work with cell ranger data.

<h4>scTCRcreateTRBVCountTable.pl</h4>
Script to extract only TRB information from scTCRseq data. 
