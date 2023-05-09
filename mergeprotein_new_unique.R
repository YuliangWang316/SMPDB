setwd("D:/smpdb/")
a = list.files("smpdb_proteins.csv")
dir = paste("./smpdb_proteins.csv/",a,sep = "")
n = length(dir)
merge.data = read.csv(file = dir[1],sep = ",")
for (i in 2:n) {
  merge.data2 = read.csv(file = dir[i],sep = ",")
  merge.data = rbind(merge.data,merge.data2)
}
remove(a,dir,merge.data2,i,n)
a<-unique(merge.data$Pathway.Name)
merge.data<-merge.data[,c(2,9)]
merge.data<-na.omit(merge.data)
for (i in 1:length(rownames(merge.data))) {
  if(merge.data[i,2]==""){
    merge.data[i,2]<- NA
  }
}
remove(i)
merge.data<-na.omit(merge.data)
kegg2GeneID_list<<- tapply(merge.data[,2],as.factor(merge.data[,1]),function(x) x)
for (i in 1:length(kegg2GeneID_list)) {
  kegg2GeneID_list[[i]]<-unique(kegg2GeneID_list[[i]])
}
remove(i,a)
setwd("c:/Users/xjmik/Documents/")
write.gmt <- function(geneSet=kegg2symbol_list,gmt_file='smpdb.gmt'){
  sink(gmt_file)
  for (i in 1:length(geneSet)){
    cat(names(geneSet)[i])
    cat('\tNA\t')
    cat(paste(geneSet[[i]],collapse = '\t'))
    cat('\n')
  }
  sink()
}
write.gmt(geneSet = kegg2GeneID_list,gmt_file = "smpdb.gmt")
