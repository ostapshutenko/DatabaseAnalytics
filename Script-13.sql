use db;
-- (select  count(distinct o_date) from orders3) ;

-- (select datediff((select max(o_date) from orders3), (select min(o_date) from orders3))+1); 
-- update orders3 set o_date = date_add(o_date, interval 1 DAy)  ;

-- 2. Проанализировать, какой период данных выгружен
select (select min(o_date) from orders3) as start_date, (select max(o_date) from orders3) as finish_date;
select ((select  count(distinct o_date) from orders3) - (select datediff((select max(o_date) from orders3), (select min(o_date) from orders3))+1)) as intervall_OK_0;
-- 3. Посчитать кол-во строк, кол-во заказов и кол-во уникальных пользователей, кот совершали заказы.

select (select count(*) from orders3) as list_count, (select count(distinct id_o) from orders3 where id_o is not null) as unique_id_order_count, (select count(distinct user_id) from orders3 where user_id is not null) as unique_id_client_count;

-- select count(*) from orders3;
-- select count(distinct id_o) from orders3 where id_o is not null;
-- select count(distinct user_id) from orders3 where user_id is not null;

-- 6. Найти ID самого активного по кол-ву покупок пользователя.
select user_id as id, count(*) as check_count from orders3 group by user_id order by  check_count desc limit 1;
select user_id as id, count(*) as check_count from orders3 group by user_id order by  check_count desc limit 100;

-- 4. По годам посчитать средний чек, среднее кол-во заказов на пользователя, сделать вывод , как изменялись это показатели Год от года.
select (select avg(price) from orders3 where year(o_date) = 2016) as avg_price_2016,
((select count(*)  from orders3 where year(o_date) = 2016)/(select count(distinct user_id) from orders3 where user_id is not null)) as avg_orders_in_person_2016, 
(select avg(price) from orders3 where year(o_date) = 2017) as avg_priece_2017,
((select count(*)  from orders3 where year(o_date) = 2017)/(select count(distinct user_id) from orders3 where user_id is not null)) as avg_orders_in_person_2017; 

--  5 Найти кол-во пользователей, кот покупали в одном году и перестали покупать в следующем.
-- and (select count(*) from orders3 where user_id = orders3.user_id )>0
select  count(distinct user_id) from orders3 where (year(o_date) = 2016) and user_id not in (select  user_id from orders3 where (year(o_date) = 2017) );

-- 7. Найти коэффициенты сезонности по месяцам.

select sum(price) as month_sum_price, (select sum(price)/12 from orders3 where year(o_date) = 2016 ) as year_midle_priece, (sum(price) / (select sum(price)/12 from orders3 where year(o_date) = 2016 )) as season_coefficient from orders3 where year(o_date) = 2016 group by month(o_date);

select sum(price) as month_sum_price, (select sum(price)/12 from orders3 where year(o_date) = 2017 ) as year_midle_priece, (sum(price) / (select sum(price)/12 from orders3 where year(o_date) = 2017 )) as season_coefficient from orders3 where year(o_date) = 2017 group by month(o_date);
