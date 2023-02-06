from sys import argv
import anndata
import scvelo as scv
import os.path
import os

if len(argv) < 2:
    print("Error: Too view arguments")
    print("Usage: two argument, anndata and outdir")
    exit(1)


programme = argv[0]
myanndp = argv[1]
outdir = argv[2]

os.mkdir(outdir)
figp = os.path.join(outdir,"scVeloFig") 
os.mkdir(figp)
datap = os.path.join(outdir,"scVeloData")
os.mkdir(datap)

annd=anndata.read_h5ad(myanndp)

scv.pp.filter_and_normalize(annd,min_shared_counts=20,n_top_genes=2000)
scv.pp.moments(annd,n_pcs=30,n_neighbors=30)
scv.tl.velocity(annd, mode = "stochastic")
scv.tl.velocity_graph(annd)

scv.pl.velocity_embedding(annd, basis = 'umap',
                          save = os.path.join(figp,"ScRNAVelocity.pdf"))

# 
annd.write(os.path.join(datap,'anndata_colon_p36_scvelo.h5ad'))

# write out embedding standard
scv.pl.velocity_embedding(annd, basis = 'umap',
                          scale = 4,arrow_length=2,xlim=(-6,6),ylim=(-6,6),
                          show=False,
                          save = os.path.join(figp,"ScRNAVelo_embedding1.pdf"))

# nice embedding 
############################
## Fig 7d
############################
scv.pl.velocity_embedding(annd, basis = 'umap',legend_loc="right",xlabel="UMAP1",ylabel="UMAP2",
                          figsize=(7,7),color='clusters',colorbar=False,palette=annd.uns['Cluster_colors'],
                          scale = 4,arrow_length=3,arrow_size=2,dpi=150,show=False,
                          save = os.path.join(figp,"ScRNAVelo_embedding2_sto_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )

# nice stream

scv.set_figure_params('scvelo')
#kwargs = dict(color_map='gnuplot', title='',
#              vmin=-.1, colorbar=False, show=False, dpi=150)
scv.pl.velocity_embedding_stream(annd, basis = 'umap',legend_loc="right",xlabel="UMAP1",
                          ylabel="UMAP2",figsize=(7,7),color='clusters',colorbar=False,
                          palette=annd.uns['Cluster_colors'],
                          dpi=150,show=False,
                          save = os.path.join(figp,"ScRNAVelo_embeddingstream_sto_arrowslong.pdf"),xlim=[-6,6],ylim=[-6,6]
                          )


