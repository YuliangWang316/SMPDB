library(dplyr)
library(patchwork)
library(Seurat)

pbmc<-readRDS("d:/EGEAD397_pbmc.rds")
Idents(pbmc)<-pbmc$celltype
pbmc_new<-subset(pbmc,idents = c("SM_B","USM_B","DN_B","Naive_B","Plasmablast","Tfh"))
Idents(pbmc_new)<-pbmc_new$disease
pbmc_new_new<-subset(pbmc_new,idents = c("SLE","RA","HC"))
Idents(pbmc_new_new)<-pbmc_new_new$celltype
remove(pbmc,pbmc_new)
for (i in unique(Idents(pbmc_new_new))) {
  pbmc_new_new_new<-subset(pbmc_new_new,idents = i)
  Idents(pbmc_new_new_new)<-pbmc_new_new_new$disease
  for (j in c("SLE","RA")) {
    pbmc_new_new_new_disease<-subset(pbmc_new_new_new,idents = j)
    pbmc_new_new_new_new_normal<-subset(pbmc_new_new_new,idents = "HC")
    pbmcdata<-cbind(pbmc_new_new_new_disease@assays$RNA@data,pbmc_new_new_new_new_normal@assays$RNA@data)
    num1<-length(colnames(pbmc_new_new_new_disease))
    num2<-length(colnames(pbmc_new_new_new_new_normal))
    remove(pbmc_new_new_new_disease,pbmc_new_new_new_new_normal)
    write.table(pbmcdata,file = paste("c:/Users/xjmik/Desktop/",i,j,"vsHC.txt",sep = ""),sep = "\t")
    remove(pbmcdata)
    data<-data.frame(c(rep(j,num1),rep("HC",num2)))
    write.table(data,file = paste("c:/Users/xjmik/Desktop/",i,j,"vsHCsample.txt",sep = ""),sep = "\t")
    remove(data)
  }
  remove(pbmc_new_new_new)
}
