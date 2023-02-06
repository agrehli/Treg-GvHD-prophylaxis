myDimPlot<-function(object, dims = c(1, 2), cells = NULL, cols = NULL, 
    pt.size = NULL, reduction = NULL, group.by = NULL, split.by = NULL, 
    shape.by = NULL, order = NULL, shuffle = FALSE, seed = 1, 
    label = FALSE, label.size = 4, label.color = "black", label.box = FALSE, 
    repel = FALSE, cells.highlight = NULL, cols.highlight = "#DE2D26", 
    sizes.highlight = 1, na.value = "grey50", ncol = NULL, combine = TRUE, 
    raster = NULL) 
{
    if (length(x = dims) != 2) {
        stop("'dims' must be a two-length vector")
    }
    reduction <- reduction %||% DefaultDimReduc(object = object)
    cells <- cells %||% colnames(x = object)
    if (isTRUE(x = shuffle)) {
        set.seed(seed = seed)
        cells <- sample(x = cells)
    }
    data <- Embeddings(object = object[[reduction]])[cells, dims]
    data <- as.data.frame(x = data)
    dims <- paste0(Key(object = object[[reduction]]), dims)
    object[["ident"]] <- Idents(object = object)
    orig.groups <- group.by
    group.by <- group.by %||% "ident"
    data <- cbind(data, object[[group.by]][cells, , drop = FALSE])
    group.by <- colnames(x = data)[3:ncol(x = data)]
    for (group in group.by) {
        if (!is.factor(x = data[, group])) {
            data[, group] <- factor(x = data[, group])
        }
    }
    if (!is.null(x = shape.by)) {
        data[, shape.by] <- object[[shape.by, drop = TRUE]]
    }
    if (!is.null(x = split.by)) {
        data[, split.by] <- object[[split.by, drop = TRUE]]
    }
    plots <- lapply(X = group.by, FUN = function(x) {
        plot <- mySingleDimPlot(data = data[, c(dims, x, split.by, 
            shape.by)], dims = dims, col.by = x, cols = cols, 
            pt.size = pt.size, shape.by = shape.by, order = order, 
            label = FALSE, cells.highlight = cells.highlight, 
            cols.highlight = cols.highlight, sizes.highlight = sizes.highlight, 
            na.value = na.value)
        if (label) {
            plot <- LabelClusters(plot = plot, id = x, repel = repel, 
                size = label.size, split.by = split.by, box = label.box, 
                color = label.color)
        }
        if (!is.null(x = split.by)) {
            plot <- plot + FacetTheme() + facet_wrap(facets = vars(!!sym(x = split.by)), 
                ncol = if (length(x = group.by) > 1 || is.null(x = ncol)) {
                  length(x = unique(x = data[, split.by]))
                }
                else {
                  ncol
                })
        }
        plot <- if (is.null(x = orig.groups)) {
            plot + labs(title = NULL)
        }
        else {
            plot + CenterTitle()
        }
    })
    if (!is.null(x = split.by)) {
        ncol <- 1
    }
    if (combine) {
        plots <- wrap_plots(plots, ncol = orig.groups %iff% ncol)
    }
    return(plots)
}



# Set highlight information
#
# @param cells.highlight Cells to highlight
# @param cells.all A character vector of all cell names
# @param sizes.highlight Sizes of cells to highlight
# @param cols.highlight Colors to highlight cells as
# @param col.base Base color to use for unselected cells
# @param pt.size Size of unselected cells
#
# @return A list will cell highlight information
# \describe{
#   \item{plot.order}{An order to plot cells in}
#   \item{highlight}{A vector giving group information for each cell}
#   \item{size}{A vector giving size information for each cell}
#   \item{color}{Colors for highlighting in the order of plot.order}
# }
#
mySetHighlight <- function(
  cells.highlight,
  cells.all,
  sizes.highlight,
  cols.highlight,
  col.base = 'black',
  pt.size = 1
) {
  if (is.character(x = cells.highlight)) {
    cells.highlight <- list(cells.highlight)
  } else if (is.data.frame(x = cells.highlight) || !is.list(x = cells.highlight)) {
    cells.highlight <- as.list(x = cells.highlight)
  }
  cells.highlight <- lapply(
    X = cells.highlight,
    FUN = function(cells) {
      cells.return <- if (is.character(x = cells)) {
        cells[cells %in% cells.all]
      } else {
        cells <- as.numeric(x = cells)
        cells <- cells[cells <= length(x = cells.all)]
        cells.all[cells]
      }
      return(cells.return)
    }
  )
  cells.highlight <- Filter(f = length, x = cells.highlight)
  names.highlight <- if (is.null(x = names(x = cells.highlight))) {
    paste0('Group_', 1L:length(x = cells.highlight))
  } else {
    names(x = cells.highlight)
  }
  sizes.highlight <- rep_len(
    x = sizes.highlight,
    length.out = length(x = cells.highlight)
  )
  cols.highlight <- c(col.base,
    rep_len(x = cols.highlight, length.out = length(x = cells.highlight))
  )
  size <- rep_len(x = pt.size, length.out = length(x = cells.all))
  highlight <- rep_len(x = NA_character_, length.out = length(x = cells.all))
  if (length(x = cells.highlight) > 0) {
    for (i in 1:length(x = cells.highlight)) {
      cells.check <- cells.highlight[[i]]
      index.check <- match(x = cells.check, cells.all)
      highlight[index.check] <- names.highlight[i]
      size[index.check] <- sizes.highlight[i]
    }
  }
  #plot.order <- sort(x = as.numeric(unique(x = highlight)), na.last = TRUE)
  #plot.order[is.na(x = plot.order)] <- 'Unselected'
  highlight[is.na(x = highlight)] <- 'Unselected'
  #highlight.length <- length(unique(highlight))-1
  highlight.order <- c(rev(names(cells.highlight)),"Unselected")
  highlight <- as.character(factor(x = highlight, levels = highlight.order))
  plot.order <- highlight.order #rev(as.character(sort(x = unique(x = highlight), na.last = TRUE)))
  #plot.order[is.na(x = plot.order)] <- 'Unselected'
  return(list(
    plot.order = plot.order,
    highlight = highlight,
    size = size,
    color = cols.highlight
  ))
}


# Plot a single dimension
#
# @param data Data to plot
# @param dims A two-length numeric vector with dimensions to use
# @param pt.size Adjust point size for plotting
# @param col.by ...
# @param cols Vector of colors, each color corresponds to an identity class. This may also be a single character
# or numeric value corresponding to a palette as specified by \code{\link[RColorBrewer]{brewer.pal.info}}.
# By default, ggplot2 assigns colors
# @param shape.by If NULL, all points are circles (default). You can specify any cell attribute
# (that can be pulled with FetchData) allowing for both different colors and different shapes on
# cells.
# @param alpha.by Mapping variable for the point alpha value
# @param order Specify the order of plotting for the idents. This can be useful for crowded plots if
# points of interest are being buried. Provide either a full list of valid idents or a subset to be
# plotted last (on top).
# @param label Whether to label the clusters
# @param repel Repel labels
# @param label.size Sets size of labels
# @param cells.highlight A list of character or numeric vectors of cells to
# highlight. If only one group of cells desired, can simply
# pass a vector instead of a list. If set, colors selected cells to the color(s)
# in \code{cols.highlight} and other cells black (white if dark.theme = TRUE);
#  will also resize to the size(s) passed to \code{sizes.highlight}
# @param cols.highlight A vector of colors to highlight the cells as; will
# repeat to the length groups in cells.highlight
# @param sizes.highlight Size of highlighted cells; will repeat to the length
# groups in cells.highlight
# @param na.value Color value for NA points when using custom scale.
#
#' @importFrom cowplot theme_cowplot
#' @importFrom RColorBrewer brewer.pal.info
#' @importFrom ggplot2 ggplot aes_string labs geom_text guides
#'  scale_color_brewer scale_color_manual element_rect guide_legend discrete_scale
#'
mySingleDimPlot <- function(
  data,
  dims,
  col.by = NULL,
  cols = NULL,
  pt.size = NULL,
  shape.by = NULL,
  alpha.by = NULL,
  order = NULL,
  label = FALSE,
  repel = FALSE,
  label.size = 4,
  cells.highlight = NULL,
  cols.highlight = '#DE2D26',
  sizes.highlight = 1,
  na.value = 'grey50'
) {
  pt.size <- pt.size %||% myAutoPointSize(data = data)
  if (length(x = dims) != 2) {
    stop("'dims' must be a two-length vector")
  }
  if (!is.data.frame(x = data)) {
    data <- as.data.frame(x = data)
  }
  if (is.character(x = dims) && !all(dims %in% colnames(x = data))) {
    stop("Cannot find dimensions to plot in data")
  } else if (is.numeric(x = dims)) {
    dims <- colnames(x = data)[dims]
  }
  if (!is.null(x = cells.highlight)) {
    highlight.info <- mySetHighlight(
      cells.highlight = cells.highlight,
      cells.all = rownames(x = data),
      sizes.highlight = sizes.highlight %||% pt.size,
      cols.highlight = cols.highlight,
      col.base = cols[1] %||% '#C3C3C3',
      pt.size = pt.size
    )
    order <- highlight.info$plot.order
    data$highlight <- highlight.info$highlight
    col.by <- 'highlight'
    pt.size <- highlight.info$size
    cols <- highlight.info$color
  }
  if (!is.null(x = order) && !is.null(x = col.by)) {
    if (typeof(x = order) == "logical") {
      if (order) {
        data <- data[order(data[, col.by]), ]
      }
    } else {
      order <- rev(x = c(
        order,
        setdiff(x = unique(x = data[, col.by]), y = order)
      ))
      data[, col.by] <- factor(x = data[, col.by], levels = order)
      new.order <- order(x = data[, col.by])
      data <- data[new.order, ]
      if (length(x = pt.size) == length(x = new.order)) {
        pt.size <- pt.size[new.order]
      }
    }
  }
  if (!is.null(x = col.by) && !col.by %in% colnames(x = data)) {
    warning("Cannot find ", col.by, " in plotting data, not coloring plot")
    col.by <- NULL
  } else {
    # col.index <- grep(pattern = col.by, x = colnames(x = data), fixed = TRUE)
    col.index <- match(x = col.by, table = colnames(x = data))
    if (grepl(pattern = '^\\d', x = col.by)) {
      # Do something for numbers
      col.by <- paste0('x', col.by)
    } else if (grepl(pattern = '-', x = col.by)) {
      # Do something for dashes
      col.by <- gsub(pattern = '-', replacement = '.', x = col.by)
    }
    colnames(x = data)[col.index] <- col.by
  }
  if (!is.null(x = shape.by) && !shape.by %in% colnames(x = data)) {
    warning("Cannot find ", shape.by, " in plotting data, not shaping plot")
  }
  if (!is.null(x = alpha.by) && !alpha.by %in% colnames(x = data)) {
    warning(
      "Cannot find alpha variable ",
      alpha.by,
      " in data, setting to NULL",
      call. = FALSE,
      immediate. = TRUE
    )
    alpha.by <- NULL
  }
  plot <- ggplot(data = data) +
    geom_point(
      mapping = aes_string(
        x = dims[1],
        y = dims[2],
        color = paste0("`", col.by, "`"),
        shape = shape.by,
        alpha = alpha.by
      ),
      size = pt.size
    ) +
    guides(color = guide_legend(override.aes = list(size = 3))) +
    labs(color = NULL)
  if (label && !is.null(x = col.by)) {
    plot <- LabelClusters(
      plot = plot,
      id = col.by,
      repel = repel,
      size = label.size
    )
  }
  if (!is.null(x = cols)) {
    if (length(x = cols) == 1 && (is.numeric(x = cols) || cols %in% rownames(x = brewer.pal.info))) {
      scale <- scale_color_brewer(palette = cols, na.value = na.value)
    } else if (length(x = cols) == 1 && (cols %in% c('alphabet', 'alphabet2', 'glasbey', 'polychrome', 'stepped'))) {
      colors <- DiscretePalette(length(unique(data[[col.by]])), palette = cols)
      scale <- scale_color_manual(values = colors, na.value = na.value)
    } else {
      scale <- scale_color_manual(values = cols, na.value = na.value)
    }
    plot <- plot + scale
  }
  plot <- plot + theme_cowplot()
  return(plot)
}


#
myAutoPointSize <- function(data) {
  return(min(1583 / nrow(x = data), 1))
}

###################################################################################
## FGSEA

require(fgsea,lib.loc=libs) #>1.14.0

# parallel computing
library(BiocParallel)
    NCORES <-6
    mysystem = Sys.info()[["sysname"]]
            if (mysystem == "Darwin"){
                registerDoParallel(NCORES)
                register(DoparParam())
            }else if (mysystem == "Linux"){
                register(bpstart(MulticoreParam(workers=NCORES)))
            }else{
                print("Please change this to allow parallel
                     computing on your computer.")
                register(SerialParam())
           }

# msigdbr
    
    #https://cran.r-project.org/web/packages/msigdbr/vignettes/msigdbr-intro.html
    require("msigdbr",lib.loc=libs) # >7.4.1


    #genesetMsig<-c("H","C2","C3","C7")
    
    collect_genesets<-function(genesetcategory,usedspecies,geneidentifier){
         # genesetcategory: "H","C2","C3","C7"
         # see https://www.gsea-msigdb.org/gsea/msigdb/
         # usedspecies: "mouse","human"
         # geneidentfier: "gene_symbol","ensembl_gene"
         msigdbr_df= msigdbr(species = usedspecies, category = genesetcategory)%>%as.data.frame()
         msigdbr_list = split(x = msigdbr_df[,geneidentifier], f = msigdbr_df$gs_name)
    return(msigdbr_list)
    }

    #gmt.file<-"/misc/rci/genomes/AnnotationHub/GSEA/msigdb_v7.0_GMTs/h.all.v7.0.entrez.gmt"
    #pathways<-gmtPathways(gmt.file)
    fgseaanal<-function(data,pathwayset,fdr=fgseafdr,makeplot=TRUE){
        data<-na.omit(data)
        # use the log10 transformed pvalue,
        ranksu<-sign(data$avg_log2FC)*-(log10(data$p_val))
        if(length(which(data$p_val==0))>0){
           indx=which(data$p_val==0)
           val<-308+0.01*rev(indx)
           ranksu[indx]<-val}
        names(ranksu)<-sapply(strsplit(rownames(data),"[.]"),"[",1)
        declength<-max(nchar(sapply(strsplit(as.character(ranksu),"[.]"),"[",2)),na.rm=TRUE)
        addvalu<-1*10^(-(declength))

        ## genes with same rank values are made different by an added value, to get rid of warning message.
        valuesdup<-ranksu[which(duplicated(ranksu))]
        if(length(valuesdup)!=0){
        for(i in valuesdup){
            indexu<-which(ranksu==i)
            ranksint<-ranksu[indexu]
            rankorder<-order(abs(data$avg_log2FC[indexu]),decreasing=T)
            ranknew<-ranksint+rankorder*addvalu
            ranksu[indexu]<-ranknew
        }}

       #plotEnrichment(hmsigdbr_list[["HALLMARK_TNFA_SIGNALING_VIA_NFKB"]],
        #                              ranksu) + labs(title="HALLMARK_TNFA_SIGNALING_VIA_NFKB")

        fgseaRes<-fgsea(pathways=pathwayset,
                        stats=ranksu,
                        minSize=1,
                        maxSize=500,
                        eps=0)
        if(length(fgseaRes$pathway)>0){
            sigPathways<-fgseaRes[padj<fdr][head(order(pval),
                                               n=length(fgseaRes$pathway)), pathway]
        sigPathwaysOut<-fgseaRes[padj<fdr][head(order(pval),
                                                       n=min(15,length(sigPathways))),
                                                    pathway]
        if(length(sigPathwaysOut)>0&makeplot==TRUE){
             #pdl<-lapply(sigPathwaysOut,
             #            function(x) plotEnrichment(pathwayset[[x]],
             #            ranksu) + labs(title=x))
             #pdl<-lapply(pdl,function(x) x+ylab("ES"))
             #for(i in pdl){
             #   print(i)}
        
        #plotGseaTable(pathwayset[sigPathwaysOut], ranksu, fgseaRes,
        #                            gseaParam=0.5)

        }}
        fgseaRes<-fgseaRes[padj<fdr][order(pval),]
        return(fgseaRes)
        #plotEnrichment(C7msigdbr_list[[]])
    }


##example usage:

##    usedspecies="mouse"
##    #load genesets
##    genesetMsig<-c("H","C2","C3")
##    genesetMsigDB<-lapply(genesetMsig,
##                          function(x) collect_genesets(
##                                                       genesetcategory=x,
##                                                       usedspecies=usedspecies,
##                                                       geneidentifier="gene_symbol"))
##    names(genesetMsigDB)<-genesetMsig
##    # run fgsa
##    for(j in 1:length(genesetMsigDB)){
##            print(paste("pathways:" ,names(genesetMsigDB)[j]," for: ",namedatset,sep=""))
##            outd<-fgseaanal(datset,genesetMsigDB[[j]],fdr=0.1)
##            outl<-list()
##            if(length(outd[,1])>0){
##                                   outl<-list()
##                                   outl<-outd}}
##    fgsea_res<-outl
##
##

##################################



DEresfun<-function(datset,namedatset,tablepath,vispath,dayuse=today,dbs=NULL,fgseafdr=0.05){
    print("Writing datset")

    print(namedatset)
    write.csv(datset,
              file=file.path(tablepath,
                             paste("DEgenes_",
                                   namedatset,
                                   today,
                                   ".csv",sep="")),
              row.names=TRUE
              )
    WriteXLS(datset,
             ExcelFileName=file.path(tablepath,
                             paste("DEgenes_",
                                   namedatset,
                                   today,
                                   ".xlsx",sep="")),
             row.names=TRUE
            )

    ## use EdgeR version if possible to feed them with matrix only.

    #goana(de<-character vector of EntresIDs,
    #     universe<- all gene ids
    #     FDR=0.05
    #     species="Hs" or "Mm",
    #     gene.pathway: data.frame linking genes to pathways
    #     pathway.names: data.frame linking pwID to fullnames
    #     trend=i.e. gene-length correction
    #     #pvalues are unadjusted

    #usage
    #          go.fisher <- goana(fit, species="Hs")
    #          topGO(go.fisher, sort = "up")

    ## split enrichr and fgsea into UP and Down separate list, or fuse them.
    ## report pvalues padjust and number of genes per category.
    ## enrichR
    print("Enrichr")
    if(is.null(dbs)){
    dbs <-  c("Elsevier_Pathway_Collection",
             "KEGG_2019_Mouse",
             "MSigDB_Hallmark_2020",
             "WikiPathway_2019_Mouse",
             "GO_Biological_Process_2021",
             "GO_Cellular_Component_2021",
             "GO_Molecular_Function_2021",
             "Reactome_2016",
             "MGI_Mammalian_Phenotype_Level_4_2021",
             "GWAS_Catalog_2019")
            }

    addcoltolistofDF<-function(x,columnname,value){
    # add column to a data frame, for lapply functionality
            datDF<-x
            if(length(datDF[,1])>0){
            datDF[,columnname]<-value
            }else{
                ncolDF=length(datDF)+1
            datDF<-setNames(data.frame(matrix(ncol=ncolDF,nrow=0)),
                            c(names(datDF),columnname))    
            }
            return(datDF)
    }

    # run enrichR

    require("enrichR")
    dbsl <- listEnrichrDbs()
    setEnrichrSite("Enrichr")
    if (is.null(dbsl)){ websiteLive <- FALSE}else{websiteLive<-TRUE}
    if (websiteLive) {
           # separate results into up and down regulated genes
           DEstates <- c(1,-1)
           names(DEstates) <- c("UP","Down")
           thresholdlFC=0.5
           enrichedl<-list()
           for(i in names(DEstates)){
               datsetu<-datset
               datsetu<-datsetu[(datsetu$avg_log2FC*DEstates[i])>thresholdlFC,]
               enrichedl[[i]] <- enrichr(rownames(datsetu),dbs)
               enrichedl[[i]]<-lapply(enrichedl[[i]],function(x) addcoltolistofDF(x,"DEState",i))
    }
    enrichedout<-list()
    for(k in 1:length(enrichedl[[1]])){
        enrichedout[[k]]<-rbind(enrichedl[[1]][[k]],
                             enrichedl[[2]][[k]])
        enrichedout[[k]]<-enrichedout[[k]][order(enrichedout[[k]]$Adjusted.P.value,decreasing=FALSE),]}
    names(enrichedout)<-names(enrichedl[[1]])    
    print("Writing Enrichr output for")
    print(namedatset)
    
    names(enrichedout)<-substr(names(enrichedout),1,30)}

    WriteXLS(enrichedout,
             ExcelFileName=file.path(tablepath,
                             paste("EnrichR_DEgenes_",
                                   namedatset,
                                   today,
                                   ".xlsx",sep="")),
             SheetNames=names(enrichedout)
            )
    print("Plotting Enrichr output")
    for(j in names(enrichedout)){
       # pd<-plotEnrich(enriched[[j]],
        pd<-plotEnrich(enrichedout[[j]],
                       showTerms=5,
                       numChar=40,
                       y="Count",
                       orderBy="P.value")

        ggsave(pd,
               file=file.path(vispath,
                             paste("EnrichR_",j,
                                   "_DEgenes_",
                                   namedatset,
                                   today,
                                   ".pdf",sep="")
                              ),
                device="pdf")

    }

    # fgsea
    source("scAnalysis_function.R")
        usedspecies="mouse"
        #load genesets
        genesetMsig<-c("H","C2","C3","C7")
        genesetMsigDB<-lapply(genesetMsig,
                              function(x) collect_genesets(
                                                           genesetcategory=x,
                                                           usedspecies=usedspecies,
                                                           geneidentifier="gene_symbol"))
        names(genesetMsigDB)<-genesetMsig
        # run fgsea
        print("run fgsea for sample")
        print(namedatset)
        outl<-list()
        for(j in 1:length(genesetMsigDB)){
                print(paste("pathways:" ,names(genesetMsigDB)[j]," for: ",namedatset,sep=""))
                outd<-fgseaanal(datset,genesetMsigDB[[j]],fdr=fgseafdr)
                if(length(outd[,1])>0){
                                       outl[[j]]<-outd}}
        names(outl)<-names(genesetMsigDB)



            WriteXLS(outl,
                     ExcelFileName=file.path(tablepath,
                     paste("fgsea_DEgenes_",
                           namedatset,
                           today,
                           ".xlsx",sep="")),
                     SheetNames=names(outl)
                     )


}
   



clustercontrib_fun<-function(obj,clusterCol="seurat_clusters",spCol,cellnum=FALSE){
        # obj: Seurat Object
        # clusterCol: charcter vector specifing the cluster colname
        # spCol: character vector specifing the category to count for
        # https://stackoverflow.com/questions/59178124/problem-with-count-dplyr-within-function
        # solution if: With tidyverse, we can make use of {{}} if we pass an unquoted argument
        #          else if: we need to pass a quoted string as variable name, convert it to symbol with ensym and evaluate (!!)
        var1 <- rlang::ensym(clusterCol)
        var2 <- rlang::ensym(spCol)
        dat<-obj@meta.data[,c(clusterCol,spCol)]
        require(tidyverse)
        ## tidyverse code
          datt<-as_tibble(dat)
          df<-datt %>%
          count(!!var1,!!var2)
          dfo<-as.data.frame(pivot_wider(df,names_from=!!var2,values_from=n))
        ##
        rownames(dfo)<-dfo[,1]
        dfo<-dfo[,-1]
        ordvec<-levels(dat[,spCol])[which(levels(dat[,spCol])%in%colnames(dfo))]
        dfo<-dfo[,ordvec]
        dfoprc<-(apply(dfo,2,function(x) round(x*100/rowSums(dfo,na.rm=T),2)))
        if(cellnum){
            dfout<-sapply(colnames(dfo),function(x) paste(dfo[,x],paste(dfoprc[,x],"%",sep=""),sep="\n"))
        }else{
            dfout<-dfoprc
        }  
        return(dfout)
}
#################
#MultiFeature Violin
################


# stagged violin plot


##source: Ming Tang
##https://divingintogeneticsandgenomics.rbind.io/post/stacked-violin-plot-for-visualizing-single-cell-data-in-seurat/
## remove the x-axis text and tick
## plot.margin to adjust the white space between each plot.
## ... pass any arguments to VlnPlot in Seurat
modify_vlnplot<- function(obj,
                          feature,
                          pt.size = 0,
                          plot.margin = unit(c(-0.75, 0, -0.75, 0), "cm"),
                          ...) {
  p<- VlnPlot(obj, features = feature, pt.size = pt.size, ... )  +
    xlab("") + ylab(feature) + ggtitle("") +
    theme(legend.position = "none",
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.y = element_text(size = rel(1), angle = 0),
          axis.text.y = element_text(size = rel(1)),
          plot.margin = plot.margin )
  return(p)
}

## extract the max value of the y axis
extract_max<- function(p){
  ymax<- max(ggplot_build(p)$layout$panel_scales_y[[1]]$range$range)
  return(ceiling(ymax))
}

## main function
StackedVlnPlot<- function(obj, features,
                          pt.size = 0,
                          plot.margin = unit(c(-0.75, 0, -0.75, 0), "cm"),
                          ...) {

  plot_list<- purrr::map(features, function(x) modify_vlnplot(obj = obj,feature = x, ...))

  # Add back x-axis title to bottom plot. patchwork is going to support this?
  plot_list[[length(plot_list)]]<- plot_list[[length(plot_list)]] +
    theme(axis.text.x=element_text(), axis.ticks.x = element_line())

  # change the y-axis tick to only max value
  ymaxs<- purrr::map_dbl(plot_list, extract_max)
  plot_list<- purrr::map2(plot_list, ymaxs, function(x,y) x +
                            scale_y_continuous(breaks = c(y)) +
                            expand_limits(y = y))

  p<- patchwork::wrap_plots(plotlist = plot_list, ncol = 1)
  return(p)
}








