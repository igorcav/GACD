library("dplyr")

setwd("C:\\Users\\Igor\\Desktop\\Ciencia de Dados\\Coursera R\\Getting and Cleaning Data\\Project")

##Lendo dados
features        <- read.table("UCI HAR Dataset\\features.txt",header=FALSE)
activity_type   <- read.table("UCI HAR Dataset\\activity_labels.txt",header=FALSE)
##Lendo dados - treino
subject_train   <- read.table("UCI HAR Dataset\\train\\subject_train.txt",header=FALSE)
x_train         <- read.table("UCI HAR Dataset\\train\\X_train.txt",header=FALSE)
y_train         <- read.table("UCI HAR Dataset\\train\\y_train.txt",header=FALSE)
##Lendo dados - teste
subject_test    <- read.table("UCI HAR Dataset\\test\\subject_test.txt",header=FALSE)
x_test          <- read.table("UCI HAR Dataset\\test\\X_test.txt",header=FALSE)
y_test          <- read.table("UCI HAR Dataset\\test\\y_test.txt",header=FALSE)

##4. COLOCANDO NOMES NAS TABELAS
colnames(activity_type)   <- c('act_id','act_type')
##Colocando nomes nas tabelas - TREINO
colnames(subject_train)   <- "sub_id"
colnames(x_train)         <- features[,2]
colnames(y_train)         <- "act_id"
##Colocando nomes nas tabelas - TESTE
colnames(subject_test)    <- "sub_id"
colnames(x_test)          <- features[,2]
colnames(y_test)          <- "act_id"

##1. MESCLANDO TABELAS DE TESTE E TREINO
dados     <- rbind(cbind(y_train,subject_train,x_train),cbind(y_test,subject_test,x_test))

##2. EXTRAINDO APENAS MEAN E STANDARD DEVIATION 
dadosMean <- dados[,grep("-mean", colnames(dados))]
dadosStd  <- dados[,grep("-std", colnames(dados))]  
dados     <- dados[,c(1,2)] ##act_id e sub_id
dados     <- cbind(dados, dadosMean)
dados     <- cbind(dados, dadosStd)

##3. USANDO DESCRIÇÃO DAS ATIVIDADES
dados     <- merge(dados, activity_type, by="act_id", all.x=TRUE)

##5. CRIANDO OUTRO TIDY DATA COM MÉDIAS
dados$act_id <- as.factor(dados$act_id)
dados$sub_id <- as.factor(dados$sub_id)

dados2 <- aggregate(dados2, by=list(sub = dados2$sub_id, act = dados2$act_id), FUN=mean, na.rm=TRUE)
write.table(dados2, "tidy.txt", sep="\t", row.name=FALSE)




