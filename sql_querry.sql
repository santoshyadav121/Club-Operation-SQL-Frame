use country_club

select * from members
select * from facilities
select * from bookings

--Q.1
select *
from bookings 
where memid in (select memid from members where firstname = 'Darren' and surname = 'Smith')

--Q.2
select * from members
where memid in (select distinct recommendedby from members)
order by surname, firstname

--Q.3
select  distinct a.firstname+a.surname+'_'+c.name as tenisplayer from 
members a inner join bookings b
on a.memid = b.memid inner join facilities c
on b.facid = c.facid
where c.name in ('Tennis Court 1','Tennis Court 2')

--Q.4
select count(*) total_facility_guestcost from facilities
where guestcost >=9

--Q.5
select b.facid, b.name, sum(a.no_of_slots_booked) as total_no_of_slots_booked_per_facility
from bookings a inner join facilities b
on a.facid = b.facid
where month(starttime) = 07 and year(starttime) = 2012
group by b.facid, b.name
order by sum(a.no_of_slots_booked) desc

--Q.6
select memid,facid,no_of_slots_booked,starttime 
from (select *,ROW_NUMBER() over (partition by memid order by memid,starttime)as row
from bookings
where starttime >= '2012-09-02 00:00:00')tmp
where row =1

--Q.7
select facid, sum(no_of_slots_booked) as total_slots_booked
from bookings 
group by facid
order by sum(no_of_slots_booked) desc
--facility 4 has highest no of slots booked

--Q.8
select a.firstname,a.surname,cast(((sum(b.no_of_slots_booked) + 10)/20)*10  as float) no_of_hours,
rank() over (order by a.firstname,a.surname) rnk
from members a inner join bookings b
on a.memid = b.memid 
group by a.firstname,a.surname

--Q.9

select  name facility_name, sum( case when memid = 0 then guestcost*slot else membercost*slot end ) as total_revenue,
row_number() over (order by sum( case when memid = 0 then guestcost*slot else membercost*slot end) desc) ranking
from (select a.name, b.memid,a.membercost,a.guestcost,sum(b.no_of_slots_booked) slot
from facilities a inner join bookings b
on a.facid = b.facid 
group by a.name, b.memid,a.membercost,a.guestcost)tmp
group by name
--top 3 revenue generating facilities are msg_room1,msg_room2 and tennis_court2

--Q.10
select * from (select dates, total_revenue, 
cast(round(avg(total_revenue) over (order by dates rows between 15 preceding and current row),2) as float) "15_days_rolling_average"
from (select dates , sum( case when memid = 0 then guestcost*slot else membercost*slot end ) as total_revenue
from (select cast(b.starttime as date)dates,a.facid,b.memid,a.membercost,a.guestcost,sum(b.no_of_slots_booked) slot
from facilities a inner join bookings b
on a.facid = b.facid 
group by cast(b.starttime as date),a.facid,b.memid,a.membercost,a.guestcost)t1
group by dates)t2)t3
where month(dates) = 08


