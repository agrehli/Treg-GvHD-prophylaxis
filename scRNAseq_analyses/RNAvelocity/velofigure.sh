## RNA VelocityAnalysis overview

# create environment:
# scripts/environment_kb-python_0.26.4.yml

# preprocessing of data
# kb_tools_RNAVelocityanalysis.ipynb
# python export: kb_tools_RNAVelocityanalysis.py


#Figures with:
conda activate /data/software/kb-python/kb-python_0.26.4


ANDATA="Seurat_Sel_anndata_02062022.h5ad"
OUTDIR="test"

scripts/scVelo.py ${ANDATA} ${OUTDIR}
