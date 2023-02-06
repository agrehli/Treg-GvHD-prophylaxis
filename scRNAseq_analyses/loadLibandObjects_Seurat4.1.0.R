# rhskl27
# rbio3_12
## add douplet finder data

# There was a update to the central rbioc3_12 version which made it incompatible with the current seurat version

## Setup of package paths

  libs="/misc/data/user/userID/R/R4.0.3"
  libs2="/misc/data/user/userID/R/R4.0.3b"
   #library("BiocParallel")
   library("Seurat",lib.loc=libs2)
   library("knitr")
   library("future")
   library("RColorBrewer")
    #BiocManager::install(pkgn, lib =libs,suppressUpdates=TRUE)
    loadlibs<-c("cowplot","ggplot2","patchwork","dplyr","fgsea","slingshot","ggpointdensity")#,"SCnorm")
    libpath<-.libPaths()
    .libPaths<-.libPaths(c(libs,libpath))

    for(i in loadlibs){
       #print(i)
        tryCatch({library(i,character.only=T,lib.loc=libs)
             },warning=function(w){
                  #print(w)
             },error=function(e){
                  #print(e)
                  library(i,character.only=T)
             })
    }

    set.seed(20)
    today<-format(Sys.Date(), "%d_%m_%Y")
    knitr::opts_chunk$set(fig.width = 12)
    featscale<-scale_colour_gradientn(colours = rev(brewer.pal(n = 11, name = "Spectral")))




# tardir
tardir="/misc/data/processedData/mapping/RNA/GRCm38/singleCell/5prime/mouseTcells"
projID="p036"
analpath="/misc/data/user/userID/projects/pr036_dd_10x/RNA/analysis_seurat_nodoub"
datapath=file.path(analpath,"data")
tablepath=file.path(analpath,"table")
vispath=file.path(analpath,"vis")


dday="11_04_2022"

#outfileUMAP<-file.path(datapath,paste("SeuratObj_",projID,"_UMAP_",dday,".rds",sep=""))
#if(file.exists(outfileUMAP)){
#SObj<-readRDS(outfileUMAP)
#}else{stop(paste(outfileUMAP," is missing",sep=""))}
#
#
#print(paste("loaded ",outfileUMAP," available as 'SObj'",sep=""))

loadDatafun<-function(outname){
   if(file.exists(outname)){
   Obj<-readRDS(outname)
   print(paste("loaded ",outname))
   return(Obj)
   }else{stop(paste(outname," is missing",sep=""))}
}


## BAse SObj
dday="11_04_2022"
outfileUMAPTCR<-file.path(datapath,paste("SeuratObj_",projID,"_UMAP_TCRdat",dday,".rds",sep=""))
SObj<-loadDatafun(outfileUMAPTCR)


## DEMarker
dday="15_02_2021"
outfileMarker<-file.path(datapath,paste("Marker_pos_perCluster_logNorm_",projID,"_",dday,".rds",sep=""))
SObj.markers<-loadDatafun(outfileMarker)

## SubColon

dirslist<-c(datapath,vispath,tablepath)
dircreatefun <- function(dirin,newsubfolder){
    subfolder=file.path(dirin,newsubfolder)
    if(!dir.exists(subfolder)){
        dir.create(subfolder)}
    return(subfolder)}

colondirs <- lapply(dirslist,function(x) dircreatefun(x,"sub_cluster_colon"))
names(colondirs) <- c("data","vis","table")

SCdday="11_04_2022"
outfile=file.path(colondirs$data,paste("Colon_UMAP_",SCdday,".rds",sep=""))
SOcol<-loadDatafun(outfile)



