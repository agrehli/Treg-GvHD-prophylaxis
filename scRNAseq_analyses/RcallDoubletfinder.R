library(rmarkdown)

metainfo="/misc/data/user/abc12345/projects/userID/metainfo/SampleInfo.csv"
outdirdoubF=file.path("your/path","doubletFindout")
Input_scriptsPATH="/misc/data/user/userID/helperscripts/scAnalysis/"
CellrangerOutP="cellranger/processed/path"

# input:
 # metainfo.csv file
 # comma separated info file containing two columns:
 # 
 # 1. sampleIDs=filenameIDs  
 # 2. cellcounts put into 10X Preparation
 
 # outdirdoubF: path were the doubletFinder output should be saved
 # Input_scriptsPATH: where RcallDoubletfinder.R, doubletFinder.Rmd,cellragner_doublets.csv are located
 # CellrangerOutP: path where the cellragner output folder are found. One folder per sample is expected,
 #                 this should contain the folder: "/outs/filtered_feature_bc_matrix"
 #                 otherwise modify the path below.

 info<-read.delim(metainfo,
                 sep=",",
                 header=TRUE)
 #info<-info[-2,]

# output directory:

# Creation of doubletfinder folder
if(!dir.exists(outdirdoubF)){
    dir.create(outdirdoubF)}


# Creation of outdir for each sample
for(i in 1:length(info[,1])){
     #i=1
     
     outdir=file.path(outdirdoubF,
                 info[i,1])

     dir.create(outdir)
     # Copy Parameterized Report and dependent files to each outdir
     file.copy(file.path(Input_scriptsPATH,"cellranger_doublets.csv"),
               file.path(outdir,
                         "cellranger_doublets.csv"),
               overwrite=T)
     file.copy(file.path(Input_scriptsPATH,"doubletFinder.Rmd"),
               file.path(outdir,
                         "doubletFinder.Rmd"),
               overwrite=T)

# render the parameterized Report
  render(file.path(outdir,"doubletFinder.Rmd"), params = list(
  input=file.path(CellrangerOutP,
             paste(info[i,1],"/outs/filtered_feature_bc_matrix",sep="")),
  outdir=outdir,
  nCount_RNAmin=1000,
  nCount_RNAmax=15000,
  nFeature_RNAmin=200,
  nFeature_RNAmax=2500,
  ribosome_pct=5,
  nCells10X_Input=info[i,2]
  ))
}

