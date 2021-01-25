use db;

-- select id_o_c, Count(*), av from (select user_id, avg(price) as av, count(id_o) as id_o_c from orders3 group by user_id) n group by id_o_c order by id_o_c;
-- R 0-30 30-60 60<
-- F 1 2-3 3+
-- m <800 800-2000 >2000
-- o-date <=60 >60

-- losst o_date >60 
-- new date < now - 30day
-- vip o_date 0 - 60 , f 3+, m >2000
-- Regular o_date 0-60, f 1-3,m 0-2000



/*
drop table t01;
drop table t02;
drop table t03;
create table t01(user_id BIGINT,R int,F int,M int,kogorts int,last_date date,first_date date);
create table t02(user_id BIGINT,R int,F int,M int,kogorts int,last_date date,first_date date);
create table t03(user_id BIGINT,R int,F int,M int,kogorts int,last_date date,first_date date);
*/




/*
select distinct user_id as user_id,
case
when datediff(date('2017-01-01') ,max(o_date))>0 and datediff(date('2017-01-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-01-01') ,max(o_date))>30 and datediff(date('2017-01-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date),'2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-01-01')
group by user_id
;
select distinct user_id as kogorts_in_2017_02_01,
case
when datediff(date('2017-02-01') ,max(o_date))>0 and datediff(date('2017-02-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-02-01') ,max(o_date))>30 and datediff(date('2017-02-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date), '2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-02-01')
group by user_id
;
select distinct user_id as kogorts_in_2017_03_01,
case
when datediff(date('2017-03-01') ,max(o_date))>0 and datediff(date('2017-03-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-03-01') ,max(o_date))>30 and datediff(date('2017-03-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date), '2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-03-01')
group by user_id
;
*/
/*
insert  t01(user_id,R,F,M,kogorts,last_date,first_date) select distinct user_id as user_id,
case
when datediff(date('2017-01-01') ,max(o_date))>0 and datediff(date('2017-01-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-01-01') ,max(o_date))>30 and datediff(date('2017-01-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date),'2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-01-01')
group by user_id
;
*/




/*
insert  t02(user_id,R,F,M,kogorts,last_date,first_date)
select distinct user_id as user_id,
case
when datediff(date('2017-02-01') ,max(o_date))>0 and datediff(date('2017-02-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-02-01') ,max(o_date))>30 and datediff(date('2017-02-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date), '2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-02-01')
group by user_id
;
*/




/*
insert  t03(user_id,R,F,M,kogorts,last_date,first_date)
select distinct user_id as user_id,
case
when datediff(date('2017-03-01') ,max(o_date))>0 and datediff(date('2017-03-01') ,max(o_date))<=30 then '3'
when datediff(date('2017-03-01') ,max(o_date))>30 and datediff(date('2017-03-01') ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when avg(price) >= 4500 then '3'
when avg(price) > 2999 and avg(price) < 4500  then '2'
else '1'
end as M,
TIMESTAMPDIFF(month,min(o_date), '2017-04-01') as kogorts,
max(o_date) as last_date,
min(o_date) as first_date
from orders3
where o_date < date('2017-03-01')
group by user_id
;

*/



/*


-- 2017-01-01
select user_id as NEWS from t01 where datediff('2017-01-01',first_date)<=30 ;
select user_id as VIP from t01 where datediff('2017-01-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  ;
select user_id as REGULAR from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3);
select user_id as LOST from t01 where datediff('2017-01-01',last_date)>180;


-- 2017-02-01
select user_id as NEWS from t02 where datediff('2017-02-01',first_date)<=30 ;
select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  ;
select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3);
select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180;



-- 2017-03-01
select user_id as NEWS from t03 where datediff('2017-03-01',first_date)<=30 ;
select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  ;
select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3);
select user_id as LOST from t03 where datediff('2017-03-01',last_date)>180;

*/

select
(select count(user_id) from t01 where datediff('2017-01-01',first_date)<=30) as NEWS,
(select count(user_id) from t01 where datediff('2017-01-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3) ) as VIP,
(select count(user_id) from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3)) as REGULAR,
(select count(user_id) from t01 where datediff('2017-01-01',last_date)>180) as LOST;
select 
(select count(user_id) from t02 where datediff('2017-02-01',first_date)<=30) as NEWS,
(select count(user_id) from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3))  as VIP ,
(select count(user_id) from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3) )as REGULAR ,
(select count(user_id) from t02 where datediff('2017-02-01',last_date)>180)  as LOST;
select
(select count(user_id) from t03 where datediff('2017-03-01',first_date)<=30 ) as NEWS ,
(select count(user_id) from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)) as VIP  ,
(select count(user_id) from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))as REGULAR,
(select count(user_id) from t03 where datediff('2017-03-01',last_date)>180) as LOST;

-- анализ  2017 02 01

select user_id as NEWS from t02 where datediff('2017-02-01',first_date)<=30 ;


-- input 

select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3) and user_id not in (select user_id as VIP from t01 where datediff('2017-01-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3));
select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3) and user_id not in (select user_id as REGULAR from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3));
select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180 and user_id not in(select user_id as LOST from t01 where datediff('2017-01-01',last_date)>180);

-- output

select user_id as VIP from t01 where datediff('2017-01-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  and user_id not in(select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3));
select user_id as REGULAR from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3) and user_id not in(select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3));
select user_id as LOST from t01 where datediff('2017-01-01',last_date)>180 and user_id not in(select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180);

select
(select count(t.VIP) from (select user_id as VIP from t01 where datediff('2017-01-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)) t where t.VIP in (select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))) as vip_to_regular, 
(select count(t.REGULAR)from (select user_id as REGULAR from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))t where t.REGULAR in (select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3))) as regular_to_vip,
(select count(t.REGULAR)from (select user_id as REGULAR from t01 where  datediff('2017-01-01',first_date)>30 and datediff('2017-01-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))t where t.REGULAR in (select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180) )as regular_to_lost,
(select count(t.NEWS) from (select user_id as NEWS from t01 where datediff('2017-01-01',first_date)<=30 )t where t.NEWS in (select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))) as new_to_regular,
(select count(t.NEWS) from (select user_id as NEWS from t01 where datediff('2017-01-01',first_date)<=30 )t where t.NEWS in (select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3))) as new_to_VIP,
(select count(t.LOST)  from (select user_id as LOST from t01 where datediff('2017-01-01',last_date)>180) t where t.LOST in(select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3)))as lost_to_Regular,
(select count(t.LOST)  from (select user_id as LOST from t01 where datediff('2017-01-01',last_date)>180) t where t.LOST in(select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)))as lost_to_VIP;




-- анализ  2017 03 01

select user_id as NEWS from t03 where datediff('2017-03-01',first_date)<=30 ;


-- input 

select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  and user_id not in (select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3));
select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3)  and user_id not in (select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3));
select user_id as LOST from t03 where datediff('2017-03-01',last_date)>180  and user_id not in(select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180);

-- output

select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)  and user_id not in(select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3));
select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2012-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3) and user_id not in(select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3));
select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180 and user_id not in(select user_id as LOST from t03 where datediff('2017-03-01',last_date)>180);

select
(select count(t.VIP) from (select user_id as VIP from t02 where datediff('2017-02-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)) t where t.VIP in (select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))) as vip_to_regular, 
(select count(t.REGULAR)from (select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))t where t.REGULAR in (select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3))) as regular_to_vip,
(select count(t.REGULAR)from (select user_id as REGULAR from t02 where  datediff('2017-02-01',first_date)>30 and datediff('2017-02-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))t where t.REGULAR in (select user_id as LOST from t03 where datediff('2017-03-01',last_date)>180) )as regular_to_lost,
(select count(t.NEWS) from (select user_id as NEWS from t02 where datediff('2017-02-01',first_date)<=30 )t where t.NEWS in (select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3))) as new_to_regular,
(select count(t.NEWS) from (select user_id as NEWS from t02 where datediff('2017-02-01',first_date)<=30 )t where t.NEWS in (select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3))) as new_to_VIP,
(select count(t.LOST)  from (select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180) t where t.LOST in(select user_id as REGULAR from t03 where  datediff('2017-03-01',first_date)>30 and datediff('2017-03-01',last_date)<=180 and !((R=3 or R=2) and M = 3 and F = 3)))as lost_to_Regular,
(select count(t.LOST)  from (select user_id as LOST from t02 where datediff('2017-02-01',last_date)>180) t where t.LOST in(select user_id as VIP from t03 where datediff('2017-03-01',first_date)>30 and ((R=3 or R=2) and M = 3 and F = 3)))as lost_to_VIP;

