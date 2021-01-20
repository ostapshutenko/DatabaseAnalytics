use db

-- create table orders5(id_o BIGINT,user_id BIGINT,price double,o_date DATE);
-- select id_o, user_id, price, o_date from orders3 where o_date <'2017-05-01' order by o_date desc;
-- insert orders5 (id_o, user_id, price, o_date) values(select id_o, user_id, price, o_date from orders3 where o_date <'2017-05-01');
-- insert into orders5 select * from orders3 where o_date < '2017-05-01';
  
 select id_o, user_id, price, o_date from orders5 order by o_date desc;
 select distinct user_id, sum(price), max(o_date) from orders5 o 
where((select max(o_date) from orders5 o2 where o.user_id = o2.user_id) >'2017-04-01')  
group by user_id;
-- 1. Группа часто покупающих (3 и более покупок) и которые последний раз покупали не так давно. Считаем сколько денег оформленного заказа приходится на 1 день. Умножаем на 30.
select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date >= '2017-02-01'
and 
price_per_month >=0
and 
check_or > 2
;
select sum(n.price_per_month) from
(select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date >= '2017-02-01'
and 
price_per_month >=0
and 
check_or > 2) n
;
-- 2. Группа часто покупающих, но которые не покупали уже значительное время. Так же можем сделать вывод, из такой группы за след месяц сколько купят и на какую сумму. (постараться продумать логику)
select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-02-01' 
and 
price_per_month >=0
and 
check_or > 2
;

select sum(n.price_per_month) from
(
select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-02-01' 
and 
price_per_month >=0
and 
check_or > 2
) n;

-- 3. Отдельно разобрать пользователей с 1 и 2 покупками за все время, прогнозируем их.
select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-05-01'
and 
price_per_month >=0
and 
check_or < 3
;
select sum(n.price_per_month) from
(
select distinct user_id, sum(price)/datediff( '2017-03-01', '2016-01-01')*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-05-01'
and 
price_per_month >=0
and 
check_or < 3
) n
;
-- 4 В итоге у вас будет прогноз ТО и вы сможете его сравнить с фактом и оценить грубо разлет по данным.

-- процент 


select (select (select sum(n.price_per_month) from
(select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date >= '2017-02-01'
and 
price_per_month >=0
and 
check_or > 2) n) 
+
(select sum(n.price_per_month) from
(
select distinct user_id, sum(price)/datediff( max(o_date), min(o_date))*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-02-01' 
and 
price_per_month >=0
and 
check_or > 2
) n) * 0.1
+
(select sum(n.price_per_month) from
(
select distinct user_id, sum(price)/datediff( '2017-05-01', '2016-01-01')*30 as price_per_month, max(o_date) as last_date, count(id_o) as check_or from orders5 o 
group by user_id
having last_date < '2017-02-01'
and 
price_per_month >=0
and 
check_or < 3
) n
)
)*0.72
;

-- 0.72 -  месячный коэффициент за 2016 год так как мы анализируем в основном средние суммы за год я решил что важно умножить на 0,72