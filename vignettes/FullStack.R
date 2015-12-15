###########################################################################
##
## Basic Data Manipulation
##
###########################################################################

## ----echo=FALSE----------------------------------------------------------
fname <- "vignettes/ALLphenoData.tsv"
stopifnot(file.exists(fname))
pdata <- read.delim(fname)

## ----ALL-properties------------------------------------------------------
class(pdata)
colnames(pdata)
dim(pdata)
head(pdata)
summary(pdata$sex)
summary(pdata$cyto.normal)

## ----ALL-subset----------------------------------------------------------
pdata[1:5, 3:4]
pdata[1:5, ]
head(pdata[, 3:5])
tail(pdata[, 3:5], 3)
head(pdata$age)
head(pdata$sex)
head(pdata[pdata$age > 21,])

## ----ALL-subset-NA-------------------------------------------------------
idx <- pdata$sex == "F" & pdata$age > 40
table(idx)
dim(pdata[idx,])

## ----ALL-BCR/ABL-subset--------------------------------------------------
bcrabl <- pdata[pdata$mol.biol %in% c("BCR/ABL", "NEG"),]

## ----ALL-BCR/ABL-drop-unused---------------------------------------------
bcrabl$mol.biol <- factor(bcrabl$mol.biol)

## ----ALL-BT--------------------------------------------------------------
levels(bcrabl$BT)

## ----ALL-BT-recode-------------------------------------------------------
table(bcrabl$BT)
levels(bcrabl$BT) <- substring(levels(bcrabl$BT), 1, 1)
table(bcrabl$BT)

## ----ALL-BCR/ABL-BT------------------------------------------------------
xtabs(~ BT + mol.biol, bcrabl)

## ----ALL-aggregate-------------------------------------------------------
aggregate(age ~ mol.biol + sex, bcrabl, mean)

## ----ALL-age-------------------------------------------------------------
t.test(age ~ mol.biol, bcrabl)
boxplot(age ~ mol.biol, bcrabl)

##########################################################################
##
## Annotation and sequence data
##
##########################################################################

library(airway)
data(airway)
airway
class(airway)
colData(airway)
rowRanges(airway)
library(org.Hs.eg.db)
ensid <- head(rownames(airway))
mapIds(org.Hs.eg.db, ensid, "SYMBOL", "ENSEMBL")
keytypes(org.Hs.eg.db)

## ----txdb----------------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb
exons(txdb)
exonsBy(txdb, "tx")
p <- promoters(txdb)

## ----BSgenome------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
bsgenome <- BSgenome.Hsapiens.UCSC.hg19
ps <- getSeq(bsgenome, p)
ps
gccontent = letterFrequency(ps,'GC',as.prob=TRUE)
hist(gccontent)


###########################################################################
##
## GEOquery and gene expression dataset
##
###########################################################################


browseURL('http://www.ncbi.nlm.nih.gov/geo/')

browseURL('http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE2553')

## ----geoquery,eval=FALSE-------------------------------------------------
## source('http://bioconductor.org/biocLite.R')
## biocLite('GEOquery')


## ----geoqueryget, eval=FALSE---------------------------------------------
## require(GEOquery)
## eset = getGEO('GSE2553')[[1]]
## eset


## ----realgeoqueryget, echo=FALSE-----------------------------------------
require(GEOquery)
eset = getGEO('GSE2553',destdir=getwd())[[1]]
eset


## ----eset1---------------------------------------------------------------
class(eset)
dim(eset)


## ----assaydata,eval=FALSE------------------------------------------------
## head(exprs(eset))
## dim(exprs(eset))


## ----assaydata10,echo=FALSE----------------------------------------------
exprs(eset)[1:10,1:6]
dim(exprs(eset))


## ----corr----------------------------------------------------------------
# two samples of different histologies
cor(exprs(eset)[,1],exprs(eset)[,2],use='complete.obs')
# two samples of the same histology
cor(exprs(eset)[,2],exprs(eset)[,14],use='complete.obs')


## ----heatmap-------------------------------------------------------------
# calculate gene-wise standard deviations
sds = apply(exprs(eset),1,sd)
library(ComplexHeatmap)
annotation = HeatmapAnnotation(df = data.frame(histotype = pData(eset)$source_name_ch1))
png('heatmap.png',width=1500,height=900)
Heatmap(exprs(eset)[order(sds,decreasing=TRUE)[1:800],],top_annotation = annotation)
dev.off()
system('open heatmap.png')

###########################################################################
##
## FASTQ exercises
##
###########################################################################

## ----bioclite,eval=FALSE-------------------------------------------------
## source('http://bioconductor.org/biocLite.R')
## biocLite('ShortRead')


## ----loadshortread,warning=FALSE,message=FALSE---------------------------
library(ShortRead)


## ----findfastq-----------------------------------------------------------
# I just know from previous looking that the fastq files are here
fastqDir = system.file(package='ShortRead','extdata/E-MTAB-1147')


## ----readfastq-----------------------------------------------------------
fq = readFastq(dirPath = fastqDir,pattern='*.fastq.gz')
fq


## ----examinequals--------------------------------------------------------
quality(fq)


## ----matrixquals---------------------------------------------------------
m = as(quality(fq),'matrix')
head(m)


## ----heatmap-------------------------------------------------------------
boxplot(m[1:5000,],col=c('red','blue'))


## ----alphabetbycycle-----------------------------------------------------
m = alphabetByCycle(sread(fq))
head(m[,1:8])


## ----matplot-------------------------------------------------------------
ms = t(m[c('A','C','G','T','N'),])
matplot(ms,type='l',xlab='cycle',ylab='count',main='Alphabet by Cycle')



##########################################################################
##
## GVIZ
##
##########################################################################

library(Gviz)
data(cpgIslands)
chr <- as.character(unique(seqnames(cpgIslands)))
gen <- genome(cpgIslands)
atrack <- AnnotationTrack(cpgIslands, name = "CpG")
gtrack <- GenomeAxisTrack()
itrack <- IdeogramTrack(genome = gen, chromosome = chr)
data(geneModels)
grtrack <- GeneRegionTrack(geneModels, genome = gen,
                          chromosome = chr, name = "Gene Model")
plotTracks(list(itrack, gtrack, atrack, grtrack))


