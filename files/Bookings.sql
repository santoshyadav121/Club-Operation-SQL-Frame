use country_club

if OBJECT_ID('bookings','U') is not null
print('exist')
else
create table bookings(
					memid	integer Foreign key references members(memid),
					facid	integer Foreign key references facilities(facid),
					no_of_slots_booked	integer,
					starttime	datetime default current_timestamp )

select * from bookings
drop table facilities
truncate table bookings
					
bulk insert bookings
from 'C:\Users\Idea-PC\Desktop\Prepleaf\sql\sql_test\Bookings.csv'
with 
(format = 'CSV', firstrow = 2, lastrow = 20)


select * from members

insert into bookings values (39,345,3,default)




					