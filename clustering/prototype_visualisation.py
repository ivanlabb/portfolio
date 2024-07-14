# -*- coding: utf-8 -*-
"""
Created on Sun Apr 28 23:12:37 2024

@author: ilabu
"""
#Загрузка библиотек
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
#Визуализация прототипа 1 кластера
tt=pd.read_csv('TTLK.csv', sep=',', decimal=',')
tt['begin']=pd.to_datetime(tt['begin']).dt.date
tt['aligned']=pd.to_numeric(tt['aligned'])
plt.subplot(2,2,1)
plt.plot(tt[tt['begin'] < pd.to_datetime('2022-02-26')]['begin'],
         tt[tt['begin'] < pd.to_datetime('2022-02-26')]['aligned'], color='b')
plt.xticks([])
plt.title('Прототип 1 кластера')
plt.plot(tt[tt['begin'] > pd.to_datetime('2022-03-20')]['begin'],
         tt[tt['begin'] > pd.to_datetime('2022-03-20')]['aligned'], color='b')
plt.title('Прототип 1 кластера')
#Визуализация прототипа 2 кластера
bl=pd.read_csv('MSRS.csv', sep=',', decimal=',')
bl['begin']=pd.to_datetime(bl['begin']).dt.date
bl['aligned']=pd.to_numeric(bl['aligned'])
plt.subplot(2,2,2)
plt.plot(bl[bl['begin'] < pd.to_datetime('2022-02-26')]['begin'], bl[bl['begin'] < pd.to_datetime('2022-02-26')]['aligned'], color='b')
plt.xticks([])
plt.title('Прототип 2 кластера')
plt.plot(bl[bl['begin'] > pd.to_datetime('2022-03-20')]['begin'], bl[bl['begin'] > pd.to_datetime('2022-03-20')]['aligned'], color='b')
#Визуализация прототипа 3 кластера
gz=pd.read_csv('NSVZ.csv', sep=',', decimal=',')
gz['begin']=pd.to_datetime(gz['begin']).dt.date
gz['aligned']=pd.to_numeric(gz['aligned'])
plt.subplot(2,2,3)
plt.plot(gz[gz['begin'] < pd.to_datetime('2022-02-26')]['begin'], gz[gz['begin'] < pd.to_datetime('2022-02-26')]['aligned'], color='b')
plt.xticks([])
plt.title('Прототип 3 кластера')
plt.plot(gz[gz['begin'] > pd.to_datetime('2022-03-20')]['begin'], gz[gz['begin'] > pd.to_datetime('2022-03-20')]['aligned'], color='b')
#Визуализация прототипа 4 кластера
to=pd.read_csv('KMAZ.csv', sep=',', decimal=',')
to['begin']=pd.to_datetime(to['begin']).dt.date
to['aligned']=pd.to_numeric(to['aligned'])
plt.subplot(2,2,4)
plt.plot(to[to['begin'] < pd.to_datetime('2022-02-26')]['begin'], to[to['begin'] < pd.to_datetime('2022-02-26')]['aligned'], color='b')
plt.xticks([])
plt.title('Прототип 4 кластера')
plt.plot(to[to['begin'] > pd.to_datetime('2022-03-20')]['begin'], to[to['begin'] > pd.to_datetime('2022-03-20')]['aligned'], color='b')
plt.show()