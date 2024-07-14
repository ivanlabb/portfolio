# -*- coding: utf-8 -*-
"""
Created on Sun Apr 28 21:29:44 2024

@author: ilabu
"""
#Загрузка библиотек
import numpy as np
from pyearth import Earth
import pandas as pd
import apimoex
import requests
import matplotlib.pyplot as plt
tickers=pd.read_csv('tickers.csv', sep='\t') 
frames=[] 
#A=[]
#Получение данных с сайта мосбиржи
with requests.Session() as session:
    for i in range(tickers.shape[0]):
            try:
                d=apimoex.get_board_candles(session,security=tickers.iloc[i,0],
                                            interval=24,start="2019-11-01",end='2023-04-02',board="TQBR")
                df=pd.DataFrame(d)[['begin', 'close']] 
                df['begin']=pd.to_datetime(df['begin']).dt.date 
                if df['begin'].iloc[0]<pd.Timestamp('2019-11-22') and df['begin'].iloc[-1]>pd.Timestamp('2023-03-12'): 
                    df.insert(0, 'ticker', tickers.iloc[i,0]) 
                    df['standclose']=(df['close']-df['close'].mean())/df['close'].std() 
                    frames.append(df) 
                    #A.append(tickers.iloc[i,0])
            except KeyError: 
                pass
k=0
#Сглаживание временных рядов адаптивными регрессионными сплайнами
for df in frames:
    x=np.array([i for i in range (df.shape[0])]).reshape(-1,1) 
    y=np.array(df['standclose']).reshape(-1,1) 
    model=Earth(max_degree=4, allow_linear=False, max_terms=40, min_search_points=40, minspan=10) 
    model.fit(x,y)
    df['aligned']=model.predict(x)
    plt.plot(df['begin'], df['standclose']) 
    plt.xlabel('Date')
    plt.ylabel('Standardized price value')
    plt.title(f"{df['ticker'][0]} standardized stock price plot")
    plt.show()
    plt.plot(df['begin'], df['aligned']) 
    plt.xlabel('Date')
    plt.ylabel('Smoothed standardized price value')
    plt.title(f"{df['ticker'][0]} smoothed standardized price plot")
    plt.show() 
    if k==45:#Запись прототипов будущих кластеров в отдельный файл
        df.to_csv('KMAZ.csv', index=False)
    if k==81:
        df.to_csv('MSRS.csv', index=False)
    if k==94:
        df.to_csv('NSVZ.csv', index=False)
    if k==135:
        df.to_csv('TTLK.csv', index=False)
    k+=1
#Объединение данных и их загрузка в csv-файл
data=pd.concat(frames)
data.index.name="index"
data.to_csv('mydata.csv', index=True)
