use country_club

if OBJECT_ID('facilities','U') is not null
print('exist')
else
create table facilities(
					facid	integer primary key,
					"name"	varchar(200),
					membercost	numeric,
					guestcost	numeric,
					initialcost	numeric,
					monthlymaintenance	numeric
					)


select * from facilities
drop table facilities
					
bulk insert facilities
from 'C:\Users\Idea-PC\Desktop\Prepleaf\sql\sql_test\Facilities.csv'
with 
(format = 'CSV', firstrow = 2)










