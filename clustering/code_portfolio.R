#Загрузка библиотек
library(dtwclust)
library(ggplot2)
library(dplyr)
library(tseries)
setwd('C:/Users/ilabu/Desktop/Конкурс портфолио/Код со статьи/data_loading.py')
#Чтение и предобработка данных
d=read.csv('mydata.csv', sep=',', header=T)
data=c()
t=distinct(d, d$ticker) 
for (i in 1:159){
  df=d$aligned[d$ticker == t$`d$ticker`[i]]
  df=data.frame(df)
  colnames(df)[1] = sprintf("%s", t$`d$ticker`[i])
  data=append(data, df)
} 
data=tslist(data) 
set.seed(2024)
names(t)[1]="name"
#Идентификация и удаление выбросов
model1=tsclust(series=data, type="partitional", k=4, distance="dtw", 
               window.size=10, centroid="pam",  control = partitional_control(nrep = 20))
tt=data.frame(t$name)
colnames(tt)='name'
tt$outlier=0
for (i in 1:20){ #Пометка всех рядов, отстоящих от прототипов в разбиениях больше, чем на 1000
  tt$dist=model1[[i]]@cldist
  tt$cluster=model1[[i]]@cluster
  ggplot(data = tt, aes(x = cluster, y = dist))+  geom_point()
  ggplot(data = tt, aes(x = cluster, y = dist, label=name))+  geom_text(size=1.5) 
  tt$outlier[tt$dist>1000]=tt$outlier[tt$dist>1000]+1
}
tt$name[tt$outlier>8]#Пометка всех рядов, более 8 раз отстоящих на 1000
t1=data.frame(t$name[-c(17, 26, 38, 55, 58, 106, 122, 137)])#Удаление этих рядов из дальнейшего датасета
#Подбор оптимального разбиения
model1=tsclust(series=data[-c(17, 26, 38, 55, 58, 106, 122, 137)], type="partitional", k=4, distance="dtw", 
               window.size=70, centroid="pam",  control = partitional_control(nrep = 20))
cvis=c()
dists=c()
for (i in 1:20){
  cvis=c(cvis, cvi(model1[[i]], b=NULL, type='Sil'))
  dists=c(dists, mean(model1[[i]]@cldist))
}
df=data.frame(cvis, dists)#Датафрейм со средними расстояниями до прототипов и индексами Силуэтов
#Для каждого разбиения, далее каждое из разбиений, от большего индекса Силуэтта к меньшему, просматривается и вручную отбирается оптимальное
plot(model1[[8]], type="series") #Графики оптимального разбиения
plot(model1[[8]], type="centroids")
t1$cluster=model1[[8]]@cluster
t1$dist=model1[[8]]@cldist
model1[[8]]@clusinfo$size
model1[[8]]@centroids
ggplot(data = t1, aes(x = cluster, y = dist))+  geom_point()
names(t1)=c("name", "clust", "dist")
#Запись оптимального разбиения в файл
write.csv(t1,'results_itog_1.csv')
#Проведение тестов на коинтеграцию для сравнение с традиционными методами поиска схожих рядов
TS = data.frame(data$TTLK,data$KMEZ)
beta = coef(lm(TS[,1]~TS[,2]+0,data=TS))[1]
(adf.test(TS[,1]-beta*TS[,2], alternative="stationary", k=0))$p.value
TS = data.frame(data$MSRS,data$MRKZ)
beta = coef(lm(TS[,1]~TS[,2]+0,data=TS))[1]
(adf.test(TS[,1]-beta*TS[,2], alternative="stationary", k=0))$p.value
TS = data.frame(data$KMAZ,data$GCHE)
beta = coef(lm(TS[,1]~TS[,2]+0,data=TS))[1]
(adf.test(TS[,1]-beta*TS[,2], alternative="stationary", k=0))$p.value
TS = data.frame(data$NMTP,data$NSVZ)
beta = coef(lm(TS[,1]~TS[,2]+0,data=TS))[1]
(adf.test(TS[,1]-beta*TS[,2], alternative="stationary", k=0))$p.value

#Построение фазовых портретов прототипов
tt=read.csv('TTLK.csv')
time <- 1:nrow(tt)
tt$time=time
tt$begin=as.Date(tt$begin, "%Y-%m-%d")
#Фазовый портрет 1 кластера
ss50=smooth.spline(tt[,"time"], tt[,"aligned"], df =30) #Сглаживание ряда для получения более интерпретируемого графика
xx=seq(1, 840, by = 0.1)
predCV=predict(ss50, xx)
Delta=predCV$y[-1]-predCV$y[-8391]
Date=seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=8390)
ggplot(data.frame(predCV$y[-8391],Delta), 
       aes(predCV$y[-8391], y=Delta)) + geom_path(aes(colour=Date))+
  scale_colour_gradientn(colours = rainbow(7),n.breaks=6,labels=format(seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=6), "%Y-%m"))+
  labs(x = "Значение",
       y = "Изменение", title="Фазовый портрет прототипа 1 кластера"
       ,colour = "Дата")+ theme_bw()#Рисование портрета
#Фазовый портрет 2 кластера
tt=read.csv('MSRS.csv')
time <- 1:nrow(tt)
tt$time=time
tt$begin=as.Date(tt$begin, "%Y-%m-%d")
ss50=smooth.spline(tt[,"time"], tt[,"aligned"], df =30)
xx=seq(1, 840, by = 0.1)
predCV=predict(ss50, xx)
Delta=predCV$y[-1]-predCV$y[-8391]
Date=seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=8390)
ggplot(data.frame(predCV$y[-8391],Delta), 
       aes(predCV$y[-8391], y=Delta)) + geom_path(aes(colour=Date))+
  scale_colour_gradientn(colours = rainbow(7),n.breaks=6,labels=format(seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=6), "%Y-%m"))+
  labs(x = "Значение",
       y = "Изменение", title="Фазовый портрет прототипа 2 кластера"
       ,colour = "Дата")+ theme_bw()
#Фазовый портрет 3 кластера
tt=read.csv('NSVZ.csv')
time <- 1:nrow(tt)
tt$time=time
tt$begin=as.Date(tt$begin, "%Y-%m-%d")
ss50=smooth.spline(tt[,"time"], tt[,"aligned"], df =30)
xx=seq(1, 840, by = 0.1)
predCV=predict(ss50, xx)
Delta=predCV$y[-1]-predCV$y[-8391]
Date=seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=8390)
ggplot(data.frame(predCV$y[-8391],Delta), 
       aes(predCV$y[-8391], y=Delta)) + geom_path(aes(colour=Date))+
  scale_colour_gradientn(colours = rainbow(7),n.breaks=6,labels=format(seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=6), "%Y-%m"))+
  labs(x = "Значение",
       y = "Изменение", title="Фазовый портрет прототипа 3 кластера"
       ,colour = "Дата")+ theme_bw()
#Фазовый портрет 4 кластера
tt=read.csv('KMAZ.csv')
time <- 1:nrow(tt)
tt$time=time
tt$begin=as.Date(tt$begin, "%Y-%m-%d")
ss50=smooth.spline(tt[,"time"], tt[,"aligned"], df =30)
xx=seq(1, 840, by = 0.1)
predCV=predict(ss50, xx)
Delta=predCV$y[-1]-predCV$y[-8391]
Date=seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=8390)
ggplot(data.frame(predCV$y[-8391],Delta), 
       aes(predCV$y[-8391], y=Delta)) + geom_path(aes(colour=Date))+
  scale_colour_gradientn(colours = rainbow(7),n.breaks=6,labels=format(seq.Date(as.Date("2019-11-01"),as.Date("2023-03-31"), length.out=6), "%Y-%m"))+
  labs(x = "Значение",
       y = "Изменение", title="Фазовый портрет прототипа 4 кластера"
       ,colour = "Дата")+ theme_bw()
