---
title: Bulk RNA-Seq Analyses
output:
  html_document:
    number_sections: yes
---

***

This directory contains **data** and **code** for the analyses underlying the **bulkRNAseq** experiments of re-isolated Treg and the corresponding expanded donor Treg cells.  
In the following, all figures within the manuscript that are covered herein are listed:  

* **Figure 1 e, f**
* **Supplementary Figure 1 b**
* **Figure 3 a, b, c, e, f, g**
* **Supplementary Figure 3 a, b, c, d, e, f, g, h, i**
* **Figure 4 a, b, c, d**
* **Supplementary Figure a, b, c, d**

# Initial Steps (OPTIONAL)

Before running the first **.Rmd** file for the initial setup (**bulkRNAseq_analyses_initial_setup.Rmd**), all relevant **...ReadsPerGene.txt** files have to be retrieved (**GEOXXXXX**) and locally stored in a directory called **"RPGDIR"** within the **"bulkRNAseq_analyses"** directory within the project directory **"tregprophylaxispaper"** **(/.../tregprophylaxispaper/bulkRNAseq_analyses/RPGDIR)**. All relevant **.rds** files for annotation, metadata and read counts are **supplied** as well. However, in case you want to **reproduce** metadata and read count data objects, above steps are recommended.

# Genaral Usage

All **.Rmd** files were successfully run on the system build supplied in the respective **SessionInfo.txt** files. **RStudio** is recommended for running the markdown files. Using **knitr**, a html report can be generated. The code will result in the figure(s) specified. Make sure your project working directory is set two levels above the **"RScripts"** directory within the **"bulkRNAseq_analyses"** directory. When using **git** to **clone** the repository, this should be the case by default and the **"tregprophylaxispaper"** directory should be specified as your project working directory.

# Running Order

A certain order of running the markdown files is recommended as some analyses rely on previous analyses' results, e.g. "Figure3_TregDGEScatter_GSEA_cvnc.pc_BMT.Rmd" requires results from "Figure3_TregDGEScatter_GSEA_Heatmap_Metascape_cvnc.b.Cd62Lneg.Rmd" for a GSEA. Hereafter, the **recommended running order** is lined out.

1. **bulkRNAseq_analyses_initial_setup.Rmd**
2. **Figure1_TregDGEScatter_GSEA_avp_invitro**
3. **Figure1_TregSigHeatmap_fresh.allo.poly.Rmd**
4. **Figure3_TregDGEScatter_GSEA_Heatmap_Metascape_cvnc.b.Cd62Lneg.Rmd**
5. **Figure3_GSEA_prc.pro_avp.c.l.s.indiv.Rmd**
6. **Figure3_TregDGEScatter_GSEA_cvnc.pc_BMT.Rmd**
7. **Figure3and4_UMAP_Heatmaps_GSEA_Barplots_pro.prc.bas.don.Rmd**
8. **Figure4_TregDGEScatter_GSEA_pvc.cls.Rmd**

Of note, for scripts **2., 3., 4., 5.,** the order is arbitrary. As long as they have been run after **1.** and before **6.**. Also, for .Rmd files **7., 8.** can be run as soon as **1.** has been executed.


