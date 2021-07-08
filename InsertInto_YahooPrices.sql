if OBJECT_ID('yahooprices') is not null
	drop table yahooprices

create table yahooprices (
	[Date] date null
	,[Open] numeric(38, 6) null
	,[High] numeric(38, 6) null
	,[Low] numeric(38, 6) null
	,[Close] numeric(38, 6) null
	,[Adj Close] numeric(38, 6) null
	,Volumne numeric(38, 6) null
	,[ticker] varchar(100) null
	) on [PRIMARY]

bulk insert yahooprices
from 'c:\users\jshakely\Desktop\BTC-USD.csv' with (
		fieldterminator = ','
		,firstrow = 2
		,FORMAT = 'CSV'
		,ROWTERMINATOR = '0x0a'
		);

alter table yahooprices add [HMY] numeric(18, 0) IDENTITY (
	1
	,1
	);

alter table yahooprices add constraint [PK_yahooprices] primary key nonclustered ([HMY] asc);

select *
from yahooprices;
