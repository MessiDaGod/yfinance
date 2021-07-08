import yfinance as yf
import pandas as pd
import pandas as pandas
import numpy as numpy
import pyodbc as pyodbc


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



# conn = pyodbc.connect(
#     'Driver={SQL Server};'
#     'Server=localhost;'
#     'Database=yahoo;'
#     'Trusted_Connection=yes;'
#     )


# if conn.is_connected():
#     db_Info = conn.get_server_info()
#     print("Connected to MySQL Server version ", db_Info)
#     cursor = conn.cursor()
#     cursor.execute("select database();")
#     record = cursor.fetchone()
#     print("You're connected to database: ", record)

# cursor = conn.cursor()


# def read(conn):
#        print("Read")
# cursor = conn.cursor()
# cursor.execute("select * from yahooprices")
# allrows = cursor.fetchall()
# for row in allrows:
#       print(f'row = {row}')
#       print()

# read(conn) #to execute
