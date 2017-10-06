setwd("C:/Users/u94132/Desktop/bonifici/")
source("libs.R")

### Read the results of the bonifico table, 
### qery file with the rows of the database
dat=readRDS("files/data.rds")
importo=readRDS("files/importo.rds")
numero=readRDS("files/numero.rds")
# change the rowIdexes of the dataFrames
rownames(dat)=c(1:nrow(dat))
impo=data.frame()
dat_mutuo=dat[grep("MUTUO",str_to_upper(dat$X_CAUSALE)),]
dat_mutuo=unique(dat_mutuo$L_IBAN_ORDINANTE)
numMutuo=data.frame()
for (i in 1:length(dat_mutuo)){
  t=numero[which(numero$IBAN %in% dat_mutuo[i]),]
  if(sum(t[,19:22])>0){
    numMutuo=rbind(numMutuo, t) #3061
  } else if(sum(t[,13:18])>2){
    numMutuo=rbind(numMutuo, t) #259
  } 
  else (t[,13]>0 && sum(t[,2:13])>6)
   numMutuo=rbind(numMutuo, t) #94
}

out=numero[which(dat_mutuo[(!dat_mutuo%in%numMutuo$IBAN)] %in% numero$IBAN),]
#sum(numero[10,19:22])>0
