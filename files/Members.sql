use  country_club

if OBJECT_ID('members','U') is not null
print('exist')
else
create table members(
					memid			integer primary key,
					surname			varchar(200),
					firstname		varchar(200),
					"address"		varchar(300),
					zipcode			integer,
					telephone		varchar(200),
					recommendedby	integer ,
					joindate		datetime)

select * from members
drop table members
					
bulk insert members
from 'C:\Users\Idea-PC\Desktop\Prepleaf\sql\sql_test\Members.csv'
with 
(format = 'CSV', firstrow = 2)


alter table members
alter column  joindate datetime

ALTER TABLE members ADD CONSTRAINT DF_members DEFAULT current_timestamp FOR joindate
ALTER TABLE Bookings ADD CONSTRAINT DF_Bookings DEFAULT current_timestamp FOR starttime








