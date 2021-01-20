use db

select avg(n.M_C) from (select user_id,sum(price) as M_C from orders3 group by user_id ) n; -- вычислил сумму среднего чека

select user_id,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
,
datediff('2018-01-01' ,max(o_date)) as R_C, 
count(id_o) as F_C, 
sum(price) as M_C
from orders3
group by user_id
;
select 
case when (n.R=3 or n.R=2) and n.M = 3 and n.F = 3 then n.user_id end as VIP,
case when n.R!=1 and !((n.R=3 or n.R=2) and n.M = 3 and n.F = 3) then user_id end as Lost,
case when n.R=1 then user_id end as Lost
from
(
select user_id,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
,
datediff('2018-01-01' ,max(o_date)) as R_C, 
count(id_o) as F_C, 
sum(price) as M_C
from orders3
group by user_id
) n
;





-- 3. Вводим группировку, к примеру, 333 и 233 – это Vip, 1XX – это Lost, остальные Regular ( можете ввести боле глубокую сегментацию)

select user_id as VIP,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having ((R=3 or R=2) and M = 3 and F = 3)
;

select user_id as Regular,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R!=1 and !((R=3 or R=2) and M = 3 and F = 3)
;
select user_id as Lost,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R=1
;



-- 4. Для каждой группы из п. 3 находим кол-во пользователей, кот. попали в них и % товарооборота, которое они сделали на эти 2 года.
select 
(select count(n.VIP) from 
(select user_id as VIP,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having ((R=3 or R=2) and M = 3 and F = 3)
) n
) as VIP_count
,
(select sum(n.prices)from
(select user_id as VIP,sum(price) as prices,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having ((R=3 or R=2) and M = 3 and F = 3)
) n)/sum(price) as part_in_all
,
(select count(n.Regular) from 
(select user_id as Regular,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R!=1 and !((R=3 or R=2) and M = 3 and F = 3)) n
) as Regular_count
,
(select sum(n.prices)from
(
select user_id as Regular,sum(price) as prices,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R!=1 and !((R=3 or R=2) and M = 3 and F = 3))
n)/sum(price) as part_in_all
,
(select count(n.Lost) from 
(select user_id as Lost,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R=1
) n) as Lost_count
,
(select sum(n.prices)from
(
select user_id as Lost,sum(price) as prices,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
group by user_id
having R=1
) n
)/sum(price) as part_in_all
from orders3  ;

-- |VIP_count|part_in_all        |Regular_count|part_in_all        |Lost_count|part_in_all       |
-- |---------|-------------------|-------------|-------------------|----------|------------------|
-- |35066    |0.21735429081700178|189415       |0.12510785966420973|790638    |0.6575378495152647|
-- 5. Проверяем, что общее кол-во пользователей бьется с суммой кол-во пользователей по группам из п. 3 (если у вас есть логические ошибки в создании групп, у вас не собьются цифры). То же самое делаем и по деньгам.
select(
((select count(n.VIP) from 
(select user_id as VIP,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
where price>0
group by user_id
having ((R=3 or R=2) and M = 3 and F = 3)
) n
))
+
(select count(n.Regular) from 
(select user_id as Regular,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
where price>0
group by user_id
having R!=1 and !((R=3 or R=2) and M = 3 and F = 3)) n
)
+
((select count(n.Lost) from 
(select user_id as Lost,
case
when datediff('2018-01-01' ,max(o_date))>0 and datediff('2018-01-01' ,max(o_date))<=30 then '3'
when datediff('2018-01-01' ,max(o_date))>30 and datediff('2018-01-01' ,max(o_date))<=60 then '2'
else '1' 
end as R, 
case 
when count(id_o) > 3 then '3' 
when count(id_o) >= 2  and count(id_o) <= 3 then '2' 
else '1'
end as F,
case 
when sum(price) >= 4500 then '3'
when sum(price) > 2999 and sum(price) < 4500  then '2'
else '1'
end as M
from orders3
where price>0
group by user_id
having R=1
) n))
)/ count(distinct user_id) from orders3 ;

-- ответ 1
-- проверку  ТО   не проверял так как если сложить part_int_all из прошлого задания будет 0,99999999999 - это 1 про сто проблема в машинном счете