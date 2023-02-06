#!/usr/bin/env python3.8
# coding: utf-8

# # RNA Velocity analysis of p036 colon

# to run activate conda environment
# conda activate kb-python_0.26.4
# In[1]:

# Install packages
#pip3 install matplotlib
#pip3 install scikit-learn
#pip3 install numpy
#pip3 install scipy
#pip3 install anndata
#pip3 install mizani
#pip3 install plotnine
#pip3 install requests
#pip3 install -U scvelo

# Import packages
import numpy as np
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import matplotlib.colors as mplcol
import matplotlib.font_manager
import matplotlib as mpl
import pandas as pd
import io
import anndata
import os
import json

from scipy.stats import binom
from scipy.stats import poisson
from scipy.sparse import csr_matrix
from scipy.io import mmread
from sklearn import linear_model
from IPython.display import HTML
from mizani.breaks import date_breaks
from mizani.formatters import date_format
# Only pandas >= v0.25.0 supports column names with spaces in querys
import plotnine as p
import requests
import warnings
import colorsys
warnings.filterwarnings("ignore")  
# plotnine has a lot of MatplotlibDeprecationWarning\'s
import seaborn as sns
#sns.set_context("notebook", font_scale=1.5, rc={"lines.linewidth": 2.5})
#fsize=20\n\nplt.rcParams.update({\'font.size\': fsize})
#%config InlineBackend.figure_format = \'retina\'
## following: https://github.com/basilkhuder/Seurat-to-RNA-Velocity\n')
##


# In[ ]:


#%load_ext rpy2.ipython


# ## Loading data

# In[3]:


# define path as csv file to all input files
rawdir = "/misc/data/rawData/RNA/singleCell/5prime/"
projectloc="~/Desktop/Urgent/p036/RNAVelocity/"
#projectloc="/misc/data/user/pun06483/projects/pr036_dd_10x/analysispy/RNAVelocity"
samples = os.path.join(projectloc,"metainfo/samples.txt")
fqsj =os.path.join(projectloc,"metainfo/output.json")
outdir = projectloc
#outdir2 = os.path.join(projectloc2"
#gtf = "/misc/software/ngs/cellranger/refdata/refdata-gex-mm10-2020-A/genes/genes.gtf"
#fasta = "/misc/software/ngs/cellranger/refdata/refdata-gex-mm10-2020-A/fasta/genome.fa"




#paths
indx = os.path.join(outdir,"transcriptome.idx")
t2genes = os.path.join(outdir,"t2g.txt")
cdna = os.path.join(outdir,"cdna.fa")
intron = os.path.join(outdir,"intron.fa")
# transcript to capture
cdnat2c = os.path.join(outdir, "cdna_t2c.txt")
intron_t2c = os.path.join(outdir,"intron_t2c.txt")


# Index creation for kallisto



print(indx)
print(cdna)




# shell calls must start with "!" and variables are passed via "{variable}"
#!kb ref -i {indx} -g {t2genes} -f1 {cdna} -f2 {intron} -c1 {cdnat2c} -c2 {intron_t2c} --workflow lamanno {fasta} {gtf} 
#$ kb count -i index.idx -g t2g.txt -x 10xv2 --h5ad -t 2 read_1.fastq.gz read_2.fastq.gz


# In[ ]:


print(indx)
os.path.exists(indx)


# In[ ]:


########################
## DO NOT RUN
#################


#%%R -i rawdir -i samples #-w 5 -h 5 --units in -r 200
# import df from global environment: -i df
# make default figure size 5 by 5 inches with 200 dpi resolution
# handle multiple input files
# rbioc_3-14
#library(rjson)

#rawdir <- "/misc/data/rawData/RNA/singleCell/5prime"
#samples <- "/misc/data/user/pun06483/projects/pr036_dd_10x/analysispy/RNAVelocity/metainfo/samples.txt"
#samples <- read.delim(samples,header=F)[,1]

# find all fastq.gz and select the sample respectively
#fls <- list.files(rawdir,pattern="fastq.gz",full.names=T,recursive=T)
#fls <- fls[grep("_I[1,2]_",fls,invert=T)]
#indx<-lapply(samples,function(x) grep(x,fls))
#flsl <- lapply(indx,function(x) fls[x])

# get samples paired for R1 and R2
#flsl <- lapply(flsl,function(x) split(x,dirname(x)))
#names(flsl) <- samples
#library(rjson)               
# read list ot json
#jsonData <- toJSON(flsl)
 
# write json object to file
#write(jsonData, "/misc/data/user/pun06483/projects/pr036_dd_10x/analysispy/RNAVelocity/metainfo/output.json")



# check for samples
projectloc="/home/nicholas/Desktop/Urgent/p036/RNAVelocity"
fqsj=os.path.join(projectloc,"metainfo/output.json")

with open(fqsj,"rb") as fqsh:
    fqs = json.load(fqsh)

samples=list()

for sample in fqs.keys():
    samples.append(sample)

print(samples)








##############################
## DO NOT RERUN##########
##########################


# merge reads into one file for each sample
#!kb count -h
#!kb --list

# kb velocity command,
# lamanno: calculation of RNA velocity
# loom: special file type H5a is also fine, loom needed for interaction with oterh programms
# x: for which technology: select from kb --list
# # zcat your.fastq.gz|head -n 4|tail -n 1|wc -c # minus 1 as line end is counted!!!
## in our case R1 has length 28 so 10xv3

import json


from subprocess import check_call



samples=list()
for sample in fqs.keys():
    samples.append(sample)
    outdirSample = os.path.join(outdir2,sample)
    outstr = ""
    skeys = fqs.get(sample).keys()
    fqsu=fqs.get(sample)
    for sk in skeys:
        #print(fqsu.get(sk))
        outstr = " ".join([outstr]+fqsu.get(sk))
        outstr = outstr.lstrip()
    
    print(outstr)
    print("Processing: ",sample)
    cmd=" ".join(["kb","count",
               "-i",indx,
               "-t", "12",
               "-x", "10xv3",
               "-o", outdirSample,
               "--workflow","lamanno",
               "--loom",
               "-g",t2genes,
               "-c1",cdnat2c,
               "-c2", intron_t2c,
               outstr])
    check_call(cmd,shell=True)
    
    #           "kb","count",
    #           "-i",indx,
    #          "-t", "12",
    #           "-x", "10xv3",
    #           "-o", outdirSample,
    #           "--workflow","lamanno",
    #           "--loom",
    #           "-g",t2genes,
    #           "-c1",cdnat2c,
    #           "-c2", intron_t2c,
    #           outstr],shell=False,check=True)




# ## Extrackting Meta-data

# In[ ]:


######################
## DO NOT RERUN ###
#######################


# in r
#metadir="os.path.join(projectlocmetainfo"
##write.csv(Cells(Seurat_object), file = "cellID_obs.csv", row.names = FALSE)
#write.csv(Cells(SOcol), file = file.path(metadir,"cellID_colon.csv"), row.names = FALSE)
##write.csv(Embeddings(seurat_object, reduction = "umap"), file = "cell_embeddings.csv")
#write.csv(Embeddings(SOcol, reduction = "umap"), file = file.path(metadir,"cell_colon_embeddings.csv"))
##write.csv(seurat_object@meta.data$seurat_clusters, file = "clusters.csv")
#outf<-SOcol@meta.data$seurat_clusters
#
#ggplotColours <- function(n = 6, h = c(0, 360) + 15){
#  if ((diff(h) %% 360) < 1) h[2] <- h[2] - 360/n
#  hcl(h = (seq(h[1], h[2], length = n)), c = 100, l = 65)
#}
#
#color_list <- ggplotColours(n=8)
##source: https://stackoverflow.com/questions/8197559/emulate-ggplot2-default-color-palette
## source: https://github.com/satijalab/seurat/issues/2366
#outdf=data.frame("cluster"=outf,
#                "col"=outf)
#levels(outdf$col)=color_list
#write.csv(outdf, file = file.path(metadir,"colon_clusters.csv"))
#
#
## In[ ]:


import scvelo as scv
#%load_ext rpy2.ipython

print(samples)
sample_two = anndata.read_loom(os.path.join(projectloc,"RNA_3_C_ra/counts_unfiltered/adata.loom"))

metadir=os.path.join(projectloc,"metainfo")
sample_obs = pd.read_csv(os.path.join(metadir,"cellID_colon.csv"))
umap_cord = pd.read_csv(os.path.join(metadir,"cell_colon_embeddings.csv"))
cell_clusters = pd.read_csv(os.path.join(metadir,"colon_clusters.csv"))



# In[ ]:


dir(sample_one)
print(type(sample_one))
print(type(sample_one.obs.barcode))
print(sample_one.obs.loc[:,"barcode"])
#"".join(["2C_",sample_one.obs.loc[:,"barcode","-1"])
#df['prod_type'] = 
B=[''.join(['3C_',item,'-1']) for item in sample_one.obs['barcode']]
#C=deepcopy(sample_one)
#C.obs["barcode"]=B
#print(C.obs["barcode"])


# In[ ]:


IDs=[x.replace('RNA_','') for x in samples]
IDs=["".join([x[0:1],"C"]) for x in IDs]
sample_pddf = {'names':samples,
               'IDs':IDs}
sample_pddf = pd.DataFrame(sample_pddf)


print(str(sample_pddf.loc[sample_pddf['names']=='RNA_2_C_ra',"IDs"]))
print(sample_pddf)
sample_obs


# In[ ]:


print(samples)
anndatl = list()
sample_obs[1:10]
for sample in samples:
    spath = os.path.join(projectloc,sample,"counts_unfiltered/adata.loom")
    print(spath)
    ind = anndata.read_loom(spath)
    print(ind)
    pattern = sample_pddf.loc[sample_pddf['names'] == sample,'IDs'].item()
    print(pattern)
    ind.obs['barcode']=[''.join([pattern,'_',item,'-1']) for item in ind.obs['barcode']]
    cellID_obs = sample_obs[sample_obs['x'].str.contains(pattern,regex=False)]
    ##cellID_obs['x'] = cellID_obs['x'].replace("".join([pattern,"_"]),"",regex=True)
    ##cellID_obs['x'] = cellID_obs['x'].replace('-1',"",regex=True)                                     
    print(len(cellID_obs))
    outf = ind[np.isin(ind.obs.barcode,cellID_obs)]
    print(len(outf))
    anndatl.append(outf)




# In[ ]:


annd=anndatl[0].concatenate(anndatl[1:])


# In[ ]:


annd.obs.barcode
print(len(annd.obs.barcode))


# Now the velocity data is filtered based upon the Seurat object. We end up with only 1515 cells of 14780 in the seurat data set. Is this due to barcode correction errors between cellrange and kb tools?
# Now we ad umap coordinates
# 

# In[ ]:


umap_cord[:2]


# In[ ]:


annd_index = pd.DataFrame(annd.obs.barcode)
annd_index = annd_index.rename(columns={'barcode':'Cell ID'})
annd_index[:2]


# In[ ]:


umap_cord = umap_cord.rename(columns = {'Unnamed: 0':'Cell ID'})
umap_cord[:2]


# In[ ]:


umap_ordered = annd_index.merge(umap_cord, on = "Cell ID")
umap_ordered[:2]
print(umap_ordered.max())
print(umap_ordered.min())


# In[ ]:


now the order of the umap is correct, add it now without the cell ID to the annd


# In[ ]:


umap_ordered = umap_ordered.iloc[:,1:]
print(umap_ordered.values)
annd.obsm['X_umap'] = umap_ordered.values


# In[ ]:


cell_clustersn = cell_clusters.join(umap_cord)
cell_clustersn = cell_clustersn[["Cell ID","cluster","col"]]
cell_cluster_ordered = annd_index.merge(cell_clustersn, on = "Cell ID")
cell_cluster_ordered[:2]
colors_ord = cell_cluster_ordered.iloc[:,2]
cluster_ord = cell_cluster_ordered.iloc[:,1]


# In[ ]:


cell_cluster_ordered.astype("object").dtypes
cell_cluster_ordered.astype({'cluster': 'object'}).dtypes
cell_cluster_ordered.dtypes


# In[ ]:


annd.uns['Cluster_colors'] = colors_ord.values
annd.uns['clusters'] = pd.Categorical(cluster_ord.values.astype(str))
annd.uns['clusters']


# In[ ]:


annd.obs['clusters']=pd.Categorical(cluster_ord.values.astype(str))


# In[ ]:





# Run RNA Verlocity
# 

# In[ ]:


annd
annd.write(filename=os.path.join(projectloc,"Seurat_Sel_anndata_02062022.h5ad"))
# In[ ]:


scv.pl.proportions(annd,save=os.path.join(projectloc,"scVelo_Figs","spliced_unspliced_proportions.pdf"))


# In[ ]:
scv.settings.verbosity = 3  # show errors(0), warnings(1), info(2), hints(3)
scv.settings.presenter_view = True  # set max width size for presenter view
scv.settings.set_figure_params('scvelo')





scv.pp.filter_and_normalize(annd,min_shared_counts=20, n_top_genes=1000)
scv.pp.moments(annd,n_pcs=30,n_neighbors=30)
scv.tl.velocity(annd, mode = "stochastic",vkey="sto")
scv.tl.velocity_graph(annd,vkey="sto")
scv.tl.recover_dynamics(annd)
scv.tl.velocity(annd,mode="dynamical",vkey="dyn")
scv.tl.velocity_graph(annd,vkey="dyn")
scv.pl.velocity_embedding(annd, basis = 'umap',vkey="sto",
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_stocastic.pdf"))

scv.pl.velocity_embedding(annd, basis = 'umap',vkey="dyn",
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_dynamical.pdf"))

# In[ ]:


annd.write(os.path.join(projectloc,"scVelo_Data",'anndata_colon_p36_scvelo.h5ad'))

# Identify important genes

### todo need gene names
scv.tl.rank_velocity_genes(annd,vkey="sto", groupby='clusters', min_corr=.3)

dfsto = scv.DataFrame(annd.uns['rank_velocity_genes']['names'])
dfsto.head()

# Kinetic rate paramters

df = annd.var
df = df[(df['fit_likelihood'] > .1) & df['velocity_genes'] == True]

kwargs = dict(xscale='log', fontsize=16)
with scv.GridSpec(ncols=3) as pl:
    pl.hist(df['fit_alpha'], xlabel='transcription rate', **kwargs)
    pl.hist(df['fit_beta'] * df['fit_scaling'], xlabel='splicing rate', xticks=[.1, .4, 1], **kwargs)
    pl.hist(df['fit_gamma'], xlabel='degradation rate', xticks=[.1, .4, 1], **kwargs)

scv.get_df(annd, 'fit*', dropna=True).head()

top_genes = annd.var['fit_likelihood'].sort_values(ascending=False).index
scv.pl.scatter(annd, basis=top_genes[:15], ncols=5, frameon=False)

# Cluster specific top genes
scv.tl.rank_dynamical_genes(annd, groupby='clusters')
df = scv.get_df(annd, 'rank_dynamical_genes/names')
df.head(5)

for cluster in ['1', '2', '3', '4','5','6','7','8']:
    scv.pl.scatter(annd, df[cluster][:5], ylabel=cluster, frameon=False)

# In[ ]:

## latent time
scv.tl.latent_time(annd,vkey="dyn")
scv.pl.scatter(annd, vkey="dyn",color='latent_time', color_map='gnuplot', size=80)


annd.obs


# In[ ]:


annd.uns['Cluster_colors']


# In[ ]:


print(np.max(annd.obsm["X_umap"],axis=0))
print(np.min(annd.obsm["X_umap"],axis=0))


# In[ ]:


scv.pl.velocity_embedding(annd, basis = 'umap',
                          scale = 4,arrow_length=2,xlim=(-6,6),ylim=(-6,6),
                          show=True,
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_embedding1.pdf"))


# In[ ]:


scv.pl.velocity_embedding


# In[ ]:


#kwargs={"xlim":(-6,6),"ylim":(-6,6)}
#print(kwargs)
scv.pl.velocity_embedding(annd,vkey="sto", basis = 'umap',legend_loc="right",xlabel="UMAP1",ylabel="UMAP2",
                          figsize=(7,7),color='clusters',colorbar=False,palette=annd.uns['Cluster_colors'],
                          scale = 4,arrow_length=3,arrow_size=2,dpi=150,show=True,
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_embedding2_sto_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )


scv.pl.velocity_embedding(annd,vkey="dyn", basis = 'umap',legend_loc="right",xlabel="UMAP1",ylabel="UMAP2",
                          figsize=(7,7),color='clusters',colorbar=False,palette=annd.uns['Cluster_colors'],
                          scale = 4,arrow_length=3,arrow_size=2,dpi=150,show=True,
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_embedding2_dyn_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )

                          
                          


# In[ ]:


scv.set_figure_params('scvelo') 
kwargs = dict(color_map='gnuplot', title='',
              vmin=-.1, colorbar=False, show=False, dpi=150)
scv.pl.velocity_embedding_stream(annd,vkey="sto", basis = 'umap',legend_loc="right",xlabel="UMAP1",ylabel="UMAP2",
                          figsize=(7,7),color='clusters',colorbar=False,palette=annd.uns['Cluster_colors'],
                          dpi=150,show=True,
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_embeddingstream_sto_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )


scv.pl.velocity_embedding_stream(annd,vkey="dyn", basis = 'umap',legend_loc="right",xlabel="UMAP1",ylabel="UMAP2",
                          figsize=(7,7),color='clusters',colorbar=False,palette=annd.uns['Cluster_colors'],
                          dpi=150,show=True,
                          save = os.path.join(projectloc,"scVelo_Figs","ScRNAVelo_embeddingstream_dyn_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )


                          xlim=(-6,6),ylim=(-6,6),
                          save = os.path.join(projectloc,"scVelo_Figs,"ScRNAVelo_stream.pdf"),**kwargs)


# In[ ]:




