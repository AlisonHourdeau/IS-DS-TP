#----------------------------------------------------------------------
#-------------------- TP 4 : CAH -----------------------
#----------------------------------------------------------------------

#Importation des packages
library("FactoMineR")
library("psych")
library("Hmisc")
library(factoextra)
library(readxl)
library(plyr)
#install.packages("philentropy")
library(philentropy)
library(ggplot2)

#----------Lecture et préparation des données----------
mydata=read.table("Race-canine.txt",sep="\t", head=T,encoding = "latin1", colClasses = "factor" )
rownames(mydata)<-mydata$Race
mydata<-mydata[,-1]
head(mydata)

#----------Realisation de l'ACH----------
mydata.mca = MCA(mydata,quali.sup=7,ncp=4)
hcpc=HCPC(mydata.mca,nb.clust=4,proba=1)

tab1=hcpc$call
plot(hcpc,choice="bar")
plot(hcpc,choice="tree")
plot(hcpc,choice="map",draw.tree = F)
plot(hcpc,choice="3D.map")

png("plot11.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="bar")
dev.off()
png("plot12.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="tree")
dev.off()
png("plot13.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="map",draw.tree = F)
dev.off()
png("plot14.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="3D.map")
dev.off()

#mydata.mca = MCA(mydata,quali.sup=7,ncp=10)
#hcpc=HCPC(mydata.mca,nb.clust=6)
tab2=hcpc$call

hcpc$data.clust
hcpc$desc.ind
hcpc$desc.var

pl1=fviz_cluster(hcpc, ellipse=F)
fviz_add(pl1,mydata.mca$quali.sup$coord)

mydata1<-cbind(mydata,hcpc$call$X[,5][match(rownames(mydata), rownames(hcpc$call$X))])
colnames(mydata1)<-c(colnames(mydata),"Classe")

for( i in 1:4)
{for (j in 1:7)
{ cl = as.data.frame(mydata1[which(mydata1["Classe"]==i),])
barplot(table(factor(cl[,j]))/sum(table(factor(cl[,j]))), main= paste("classe ", as.character(i), colnames(cl)[j]))}
}

#install.packages("xlsx")

library(xlsx)
write.xlsx(hcpc$data.clust,file="TP4-4facteurs-RC.xlsx",sheetName="clust")
for (i in 1:4)
{
  write.xlsx(hcpc$desc.axes$quanti[i],file="TP4-4facteurs-RC.xlsx",sheetName=paste("axe",as.character(i)),append=T)
  write.xlsx(hcpc$desc.var$category[i],file="TP4-4facteurs-RC.xlsx",sheetName=paste("var",as.character(i)),append=T)
  write.xlsx(hcpc$desc.ind$para[i],file="TP4-4facteurs-RC.xlsx",sheetName=paste("distances",as.character(i)),append=T)
}
#write.xlsx(poids,file="TP4.xlsx",sheetName="",append=T)

#avec 10 facteurs

mydata.mca = MCA(mydata,quali.sup=7,ncp=10)
hcpc=HCPC(mydata.mca,nb.clust=4,proba=1)


tab1=hcpc$call
plot(hcpc,choice="bar")
plot(hcpc,choice="tree")
plot(hcpc,choice="map",draw.tree = F)
plot(hcpc,choice="3D.map")
tab2=hcpc$call

hcpc$data.clust
hcpc$desc.ind
hcpc$desc.var

pl1=fviz_cluster(hcpc, ellipse=F)
fviz_add(pl1,mydata.mca$quali.sup$coord)

mydata1<-cbind(mydata,hcpc$call$X[,11][match(rownames(mydata), rownames(hcpc$call$X))])
colnames(mydata1)<-c(colnames(mydata),"Classe")

par(mfrow=c(3,4))
for( i in 1:4)
{for (j in 1:7)
{ cl = as.data.frame(mydata1[which(mydata1["Classe"]==i),])
barplot(table(factor(cl[,j]))/sum(table(factor(cl[,j]))), main= paste("classe ", as.character(i), colnames(cl)[j]))}
}

write.xlsx(hcpc$data.clust,file="TP4-10facteurs-RC.xlsx",sheetName="clust")
for (i in 1:4)
{
  write.xlsx(hcpc$desc.axes$quanti[i],file="TP4-10facteurs-RC.xlsx",sheetName=paste("axe",as.character(i)),append=T)
  write.xlsx(hcpc$desc.var$category[i],file="TP4-10facteurs-RC.xlsx",sheetName=paste("var",as.character(i)),append=T)
  write.xlsx(hcpc$desc.ind$para[i],file="TP4-10facteurs-RC.xlsx",sheetName=paste("distances",as.character(i)),append=T)
}
#write.xlsx(poids,file="TP4.xlsx",sheetName="",append=T)

png("plot21.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="bar")
dev.off()
png("plot22.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="tree")
dev.off()
png("plot23.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="map",draw.tree = F)
dev.off()
png("plot24.png", height=1200, width=1200, res=250, pointsize=8)
plot(hcpc,choice="3D.map")
dev.off()
