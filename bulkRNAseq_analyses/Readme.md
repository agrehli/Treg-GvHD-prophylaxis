# bulkRNAseq_analyses

This folder contains **data** and **code** for the analyses underlying **the bulkRNAseq** experiments of re-isolated Treg and the corresponding expanded donor Treg cells.

## Order of Execution

Before you run any of the other .Rmd files, the "RCT&metadata.assembly.Rmd" should be run. Before "Figure3_TregDGEScatter_GSEA_cvnc.pc_BMT.Rmd" is run, "Figure3_TregDGEScatter_GSEA_Heatmap_cvnc.b_noBMT.Rmd" should be run.

## Genaral Usage

All .Rmd files were successfully run on the system build supplied in the respective SessionInfo.txt files. Using knitr, a html report can be generated. The code will result in the figure(s) specified. Make sure your project working directory is set two levels above the "RScripts" directory within the "bulkRNAseq_analyses" directory. By default, this should be the case and the "tregprophylaxispaper" directory should be specified as your project working directory.
