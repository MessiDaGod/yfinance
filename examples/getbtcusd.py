import yfinance as yf
import pandas as pd
import pandas as pandas
import numpy as numpy
import pyodbc as pyodbc
import os


tickerStrings = ['BTC-USD']
df_list = list()
for ticker in tickerStrings:
    data = yf.download(ticker, group_by="Ticker", period='20y')
    # add this column becasue the dataframe doesn't contain a column with the ticker
    data['ticker'] = ticker
    df_list.append(data)

# combine all dataframes into a single dataframe
df = pd.concat(df_list)

# save to csv
df.to_csv('BTC-USD.csv')

# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'tcp:localhost' 
database = 'yahoo' 
username = 'sa' 
password = 'log-onCp9' 
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

dir_path = os.path.dirname(os.path.realpath(__file__))

cursor.execute("exec spInsertYahooPrices;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()
