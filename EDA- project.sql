
-- how many rows in dataset
select count(*) as total_count
from abandonment_dataset;

-- check for duplicates
select User_ID,	User_Location,	Gender,	Cart_Contents,
		Cart_Value,	Session_Date,	Session_Duration,
		Abandonment_Reason,	Purchase_Category,	Referral_Medium	,
		Device_Type	,Cart_Status, count(*)
from abandonment_dataset
group by User_ID,	User_Location,	Gender,	Cart_Contents,
		Cart_Value,	Session_Date,	Session_Duration,
		Abandonment_Reason,	Purchase_Category,	Referral_Medium	,
		Device_Type	,Cart_Status
having count(*) > 1;

-- sum of cart value
select sum(Cart_Value) as total_value
from abandonment_dataset;
-- sum of cart value completed
select sum(Cart_Value) as total_value
from abandonment_dataset
where Cart_Status = 'Paid'
-- sum of cart value
select sum(Cart_Value) as total_value
from abandonment_dataset
where Cart_Status = 'Abandoned';

-- number of people that abandoned and paid
select Cart_Status, count(*)
from abandonment_dataset
group by Cart_Status;

-- how many male and female we have
select Gender, count(*)
from abandonment_dataset
group by Gender;

-- check the gender that abandoned more
select Gender, count(*)
from abandonment_dataset
where Cart_Status = 'Abandoned'
group by Gender;
-- check the gender that paid more
select Gender, count(*)
from abandonment_dataset
where Cart_Status = 'Paid'
group by Gender;

-- users by location
select User_Location, Cart_Status, count(*) as Count_Location
from abandonment_dataset
group by User_Location,Cart_Status
order by Cart_Status desc, 3 desc;

-- users by cart content
select Cart_Contents, Cart_Status, count(*) as Count_cont
from abandonment_dataset
group by Cart_Contents,Cart_Status
order by Cart_Status desc, 3 desc;

-- users by abandonmet reason
select Abandonment_Reason, count(*) as abandonment_count
from abandonment_dataset
where Cart_Status = 'Abandoned'
group by Abandonment_Reason
order by 2 desc;

-- users by purchase category
select Purchase_Category, Cart_Status, count(*) as purchase_count
from abandonment_dataset
group by Purchase_Category, Cart_Status
order by 2 desc;

-- users by referral medium
select Referral_Medium, count(*) as referral_count
from abandonment_dataset
group by Referral_Medium
order by 2 desc;

-- users by device type
select Device_Type, count(*) as device_count
from abandonment_dataset
group by Device_Type
order by 2 desc;

-- create range for sesson duration
select session_range, count(*) as total_number
from
	(select 
		case
			when Session_Duration >= 5 and Session_Duration <= 28  then '5-28'
			when Session_Duration >= 29 and Session_Duration  <= 52  then '29-52'
			when Session_Duration >= 53 and Session_Duration <= 76  then '53-76'
			when Session_Duration >= 77 and Session_Duration <= 100  then '77-100'
			else '101-120'
		end as session_range
	from abandonment_dataset
	where Cart_Status = 'Abandoned'
	) as ranges
group by session_range
order by 2 desc;