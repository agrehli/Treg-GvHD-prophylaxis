#!/usr/local/bin/rbioc_3-11_Rscript
# function to remove doublets from sc libraries
# and cellrangeratac


libs="/misc/data/user/userID/R/R4.0.0"
suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("plyr"))
suppressPackageStartupMessages(library("Seurat",lib.loc=libs))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("future"))
suppressPackageStartupMessages(library("DoubletFinder",lib.loc=libs))

suppressPackageStartupMessages(library("PCAtools",lib.loc=libs))


# option parser

option_list <- list(
    make_option(c("-i", "--inputname"), type="character",
                default=NULL,
                help="supply an input file"),
    make_option(c("-d","--outdir"),action="store_true",
                default=".",
                help="specify output dir"),
    make_option(c("-c","--nCount_RNAmin"),action="store_true",
                default="1000",
                help="specify minimal counts"),
    make_option(c("-C","--nCount_RNAmax"),action="store_true",
                default="15000",
                help="specify minimal counts"),
    make_option(c("-r","--nFeature_RNAmin"),action="store_true",
                default="200",
                help="specify output dir"),
    make_option(c("-R","--nFeature_RNAmax"),action="store_true",
                default="2500",
                help="specify output dir"),
    make_option(c("-R","--nFeature_RNAmax"),action="store_true",
                default="2500",
                help="specify output dir"),
    make_option(c("-o","--ribosome"),action="store_true",
                default="5",
                help=paste("specify the lower threshold to exclude",
                          "cells with less ribo content",sep=" ")),
    make_option(c("-n","--nCells10X_Input"),action="store_true",
                default="NULL",
                help="give the number of cells from sorting")
opt <- parse_args(OptionParser(option_list=option_list))


# Check on file existance
RUN <- FALSE
input <- opt$input
if (file.exists(input)){
    RUN <- TRUE       
}else if(dir.exists(input)){
    RUN <- TRUE    
}else{
    print(paste("the input ", input,"can not be found",sep=""))
    RUN <- FALSE
}
outdir <- opt$outdir
if (dir.exists(outdir)&RUN){
    RUN <- TRUE       
}else{
    print(paste("the file ", filename,"can not be found",sep=""))
    RUN <- FALSE
}


if(RUN){
# Processing data

## Parallel setup
plan("multiprocess",workers=4)
options(future.globals.maxSize= 1500*1024^2)
set.seed(100)

## Seurat analysis
input="/misc/data/processedData/mapping/RNA/GRCm38/singleCell/5prime/mouseTcells/RNA_3_L_ra_run_1_2_3_4/outs/filtered_feature_bc_matrix" 
opt<-list("nFeature_RNAmin"=200,
          "nFeature_RNAmax"=2500,
          "nCount_RNAmin"=500,
          "nCount_RNAmax"=15000)

umidat<-Read10X(input)
cellnumInit<-dim(umidat)[2]
SObj<-CreateSeuratObject(counts=umidat,min.cells=5,min.features=200)

#free memory
rm(umidat)
# run garbage collection
gc()

rn<-rownames(SObj)
if(length(grep("^mt-",rn))>0){
    species="mm"
    mtSel="^mt-"
    riboSel="^Rp[sl]"
}else if(length(grep("^MT-",rn))>0){
    species="hs"
    mtSel="^MT-"
    riboSel="^RP[SL]"
}else{
    print("species unknown")
    quit(save="ask")
}

SObj[["percent.mt"]] <- PercentageFeatureSet(SObj, pattern = mtSel)
SObj[["percent.rb"]] <- PercentageFeatureSet(SObj, pattern = riboSel)

### Filtering

#Filter Mitochondria to contain less then 5 % Mito,but less then 20% or regress 
#percent.mt would be ok if no cells would be left otherwise.
#Filter Cell to contain at least 5 % ribosomal
keepM<-SObj[["percent.mt"]]<5
keepR<-SObj[["percent.rb"]]>5 ##This filter is very good. Maybe 10% is better
keepnCR<-SObj[["nCount_RNA"]]<20000
keepnFR<-(SObj[["nFeature_RNA"]]>200&SObj[["nFeature_RNA"]]<4000)
keepall<-keepM&keepR&keepnCR&keepnFR
keepnCRlow<-SObj[["nCount_RNA"]]>2400

SObj@meta.data$keepall<-keepall
SObj@meta.data$keepnCRlow<-keepnCRlow
SObj@meta.data$keepM<-keepM
SObj@meta.data$keepR<-keepR

FeatureScatter(SObj, "nCount_RNA", "nFeature_RNA", group.by = "orig.ident", pt.size = 0.5)+geom_abline(slope=1)
FeatureScatter(SObj, "nCount_RNA", "nFeature_RNA", group.by = "keepall", pt.size = 0.5)+geom_abline(slope=1)
FeatureScatter(SObj, "nCount_RNA", "nFeature_RNA", group.by = "keepR", pt.size = 0.5)+geom_abline(slope=1)

FeatureScatter(SObj, "nCount_RNA","Ftl1",group.by="keepall")

FeatureScatter(SObj, "nCount_RNA", "nFeature_RNA", group.by = "orig.ident", pt.size = 0.5)+geom_abline(slope=1)+geom_point(alpha = 0.3, shape = 16)+geom_density_2d(size = 0.3)

SObj <- subset(SObj, subset = nFeature_RNA > opt$nFeature_RNAmin & 
               nFeature_RNA < opt$nFeature_RNAmax &
               percent.mt < 5 &
               percent.rb > 10 &
               nCount_RNA > opt$nCount_RNAmin &
               nCount_RNA < opt$nCount_RNAmax)
### Normalizing Scaling
    SObj <- NormalizeData(object = SObj, verbose = FALSE)
    SObj <- FindVariableFeatures(object = SObj,
                                 selection.method = "vst", nfeatures = 2000, verbose = FALSE)
    SObj <- ScaleData(SObj)
    
### PCA
    SObj <- RunPCA(SObj, features = VariableFeatures(object = SObj))
    pd<-ElbowPlot(SObj)
    ElbPlxy<-data.frame("x"=pd$data$dims,
                        "y"=pd$dat$stdev)

    write.csv(ElbPlxy,file.path(outdir,"ElbPlxy.txt"))
    #scriptpath<-getSourceEditorContext ()$path
    scriptpath<-"/misc/data/user/userID/helperscripts/scAnalysis"
    #if(file.exists(scriptpath)){
        scriptpath <- sub("/doubletFinder.R","",scriptpath)
        command <- "/usr/local/bin/rbioc_3-11_Rscript"
        args <- c(file.path(scriptpath,"elbowPoint.R"),file.path(outdir,"ElbPlxy.txt"))
    ebPoint<-system2(command,args,stdout=TRUE)
    ebPoint<-as.numeric(strsplit(ebPoint," ")[[1]][2])
    #}else{
    #    ebPoint=10}
    SObj = RunUMAP(SObj, dims = 1:ebPoint, verbose = F)

## plots
    for(i in unique(SObj@meta.data$group)){
        #pd<-DimPlot(SObj, cells=grep(i,th1_raw@meta.data$group),
        pd<-DimPlot(SObj,reduction = "umap",label=TRUE)
        print(pd)
    }

feats <- c("nFeature_RNA", "nCount_RNA", "percent.mt", "percent.rb", "percent_hb")

VlnPlot(SObj, group.by = "orig.ident", features = feats, pt.size = 0.1, ncol = 3) + 
        NoLegend()


## DoubletFinder
nExp <- round(ncol(SObj) * 0.04) #expect 4% doublets
SObj <- doubletFinder_v3(SObj, pN = 0.25, pK = 0.09, nExp = nExp, PCs = 1:10)

#nExp_poi <- round(0.15*length(cellnumInit))

#homotypic.prop <- modelHomotypic(annotations)
#     nExp_poi.adj <- round(nExp_poi*(1-homotypic.prop))

#dubs <-doubletFinder(SObj,PCs=ebPoint,pN = 0.25, pK, nExp, reuse.pANN = FALSE)

DF.name = colnames(SObj@meta.data)[grepl("DF.classification", colnames(SObj@meta.data))]

cowplot::plot_grid(ncol = 2, DimPlot(SObj, group.by = "orig.ident") + NoAxes(), 
                       DimPlot(SObj, group.by = DF.name) + NoAxes())
VlnPlot(SObj, features = "nFeature_RNA", group.by = DF.name, pt.size = 0.1)

# Run refinement
#sweep.res <- paramSweep_v3(SObj)
#sweep.stats <- summarizeSweep(sweep.res,GT = FALSE)
#bcmvn <- find.pK(sweep.stats)
#barplot(bcmvn$BCmetric, names.arg = bcmvn$pK, las=2)

SObj = SObj[, SObj@meta.data[, DF.name] == "Singlet"]
dim(SObj)

outname<-file.path(outdir,paste(basename(outdir),"_SeuratObj_Norm_doubmark_",today,".rds"))
saveRDS(SObj,file=outname)
