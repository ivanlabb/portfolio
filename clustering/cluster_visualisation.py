# -*- coding: utf-8 -*-
"""
Created on Sun Apr 28 23:02:54 2024

@author: ilabu
"""

import pandas as pd
import matplotlib.pyplot as plt
data=pd.read_csv('mydata.csv',header=0,sep=',') #Чтение датафрейма с временными данными по тикерам
clusts=pd.read_csv('results_itog_1.csv',header=0,sep=',')  #Чтение данных с принадлежностью тикеров к кластерам
#Визуализация рядов из 1 кластера
cl1=clusts[clusts['clust']==1] 
data1=data[data['ticker'].isin(cl1['name'])==True] 
for ticker in pd.unique(data1['ticker']): 
    plt.plot([i for i in range(data1['aligned'][data1['ticker']==ticker].shape[0])],
             data1['aligned'][data1['ticker']==ticker])
x=data1.groupby(['index']).mean()
y=data1.groupby(['index']).std() 
plt.plot([i for i in range(840)], (x['aligned']+y['aligned'])[:840], color='black') 
plt.plot([i for i in range(840)], (x['aligned']-y['aligned'])[:840],color='black')
ax=plt.axes()
ax.set_xticks([120*i for i in range(8)])
ax.set_xticklabels(['Нояб. 19','Апр. 20', 'Окт. 20', 'Апр. 21',
                    'Окт. 21', 'Апр. 22', 'Окт. 22', 'Апр. 23'], rotation=45)
plt.ylabel('Стандартизованная цена')
plt.xlim(left=30) 
plt.title('1 кластер')
plt.show()
#Визуализация рядов из 2 кластера
cl2=clusts[clusts['clust']==2]
data2=data[data['ticker'].isin(cl2['name'])==True]
for ticker in pd.unique(data2['ticker']):
    plt.plot([i for i in range(data2['aligned'][data2['ticker']==ticker].shape[0])], data2['aligned'][data2['ticker']==ticker])
x=data2.groupby(['index']).mean() 
y=data2.groupby(['index']).std() 
plt.plot([i for i in range(830)], (x['aligned']+y['aligned'])[:830], color='black')
plt.plot([i for i in range(830)], (x['aligned']-y['aligned'])[:830],color='black') 
ax=plt.axes()
ax.set_xticks([120*i for i in range(8)])
ax.set_xticklabels(['Нояб. 19','Апр. 20', 'Окт. 20', 'Апр. 21',
                    'Окт. 21', 'Апр. 22', 'Окт. 22', 'Апр. 23'], rotation=45)
plt.ylabel('Стандартизованная цена')
plt.xlim(left=30)
plt.title('2 кластер')
plt.show()
#Визуализация рядов из 3 кластера
cl3=clusts[clusts['clust']==3]
data3=data[data['ticker'].isin(cl3['name'])==True]
for ticker in pd.unique(data3['ticker']):
    plt.plot([i for i in range(data3['aligned'][data3['ticker']==ticker].shape[0])], data3['aligned'][data3['ticker']==ticker])
x=data3.groupby(['index']).mean() 
y=data3.groupby(['index']).std()
plt.plot([i for i in range(840)], (x['aligned']+y['aligned'])[:840], color='black')
plt.plot([i for i in range(840)], (x['aligned']-y['aligned'])[:840],color='black') 
ax=plt.axes()
ax.set_xticks([120*i for i in range(8)])
ax.set_xticklabels(['Нояб. 19','Апр. 20', 'Окт. 20', 'Апр. 21',
                    'Окт. 21', 'Апр. 22', 'Окт. 22', 'Апр. 23'], rotation=45)
plt.ylabel('Стандартизованная цена')
plt.xlim(left=30)
plt.title('3 кластер')
plt.show()
#Визуализация рядов из 4 кластера
cl4=clusts[clusts['clust']==4]
data4=data[data['ticker'].isin(cl4['name'])==True]
for ticker in pd.unique(data4['ticker']):
    plt.plot([i for i in range(data4['aligned'][data4['ticker']==ticker].shape[0])], data4['aligned'][data4['ticker']==ticker])
x=data4.groupby(['index']).mean() 
y=data4.groupby(['index']).std()
plt.plot([i for i in range(840)], (x['aligned']+y['aligned'])[:840], color='black')
plt.plot([i for i in range(840)], (x['aligned']-y['aligned'])[:840],color='black') 
ax=plt.axes()
ax.set_xticks([120*i for i in range(8)])
ax.set_xticklabels(['Нояб. 19','Апр. 20', 'Окт. 20', 'Апр. 21',
                    'Окт. 21', 'Апр. 22', 'Окт. 22', 'Апр. 23'], rotation=45)
plt.ylabel('Стандартизованная цена')
plt.xlim(left=30)
plt.title('4 кластер')
plt.show()