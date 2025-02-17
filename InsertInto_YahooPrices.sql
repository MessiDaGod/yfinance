IF OBJECT_ID('spInsertYahooPrices') IS NOT NULL 
DROP PROC spInsertYahooPrices
GO

CREATE PROC spInsertYahooPrices
AS 
BEGIN 
set nocount on;

if OBJECT_ID('yahooprices') is null
	create table yahooprices (
		id int IDENTITY(1, 1) not null
		,[Date] date null
		,[Open] numeric(38, 6) null
		,[High] numeric(38, 6) null
		,[Low] numeric(38, 6) null
		,[Close] numeric(38, 6) null
		,[Adj Close] numeric(38, 6) null
		,Volumne numeric(38, 6) null
		,[ticker] varchar(100) null constraint [PK_yahooprices] primary key nonclustered ([id] asc)
		) on [PRIMARY];

if OBJECT_ID('tempdb..#yahooprices') is not null
	drop table #yahooprices

create table #yahooprices (
	[Date] date null
	,[Open] numeric(38, 6) null
	,[High] numeric(38, 6) null
	,[Low] numeric(38, 6) null
	,[Close] numeric(38, 6) null
	,[Adj Close] numeric(38, 6) null
	,Volumne numeric(38, 6) null
	,[ticker] varchar(100) null
	) on [PRIMARY]

bulk insert #yahooprices
from 'C:\Users\jshakely\source\repos\yfinance\BTC-USD.csv' with (
		fieldterminator = ','
		,firstrow = 2
		,FORMAT = 'CSV'
		,ROWTERMINATOR = '0x0a'
		);

insert into yahooprices (
	[Date]
	,[Open]
	,[High]
	,[Low]
	,[Close]
	,[Adj Close]
	,[Volumne]
	,[ticker]
	)
select ya.[Date]
	,ya.[Open]
	,ya.[High]
	,ya.[Low]
	,ya.[Close]
	,ya.[Adj Close]
	,ya.[Volumne]
	,ya.[ticker]
from #yahooprices ya
where 1 = 1

END
GO