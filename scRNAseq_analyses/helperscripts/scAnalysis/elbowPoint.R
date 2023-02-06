#!/usr/local/bin/rbioc_3-11_Rscript


libs="/misc/data/user/userID/R/R4.0.0"

suppressPackageStartupMessages(library("PCAtools",lib.loc=libs))
args = commandArgs(trailingOnly=TRUE)

dat<-read.csv(args[1],header=T,row.names=1)


chosen.elbow <- PCAtools::findElbowPoint(dat$y)
# given that is this rather conservative return +2
print(chosen.elbow+2)
