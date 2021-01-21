use db;
/*
create table clients(
id_client BIGINT UNSIGNED auto_increment primary key NOT null,
limit_sum int
);
create table transactions(
id_transaction BIGINT UNSIGNED auto_increment primary key NOT null,
id_client bigint unsigned,
transaction_date DATE,
transaction_time TIME,
transaction_sum BIGINT,
foreign key (id_client) references clients(id_client)
);
*/
-- Написать текст SQL-запроса, выводящего количество транзакций, сумму транзакций, среднюю сумму транзакции и дату и время первой транзакции для каждого клиента
select id_client, 
Count(id_transaction) as n_transaction, 
sum(transaction_sum) as sum_transactions, 
avg(abs(transaction_sum)) as avg_transactions, 
(select min(transaction_date) from transactions t2 where t2.id_client = t.id_client) as min_date,
(select min(transaction_time) from transactions t2 where t2.id_client = t.id_client and t2.transaction_date = min_date ) as min_date 
from transactions t group by id_client;
-- я использовал  abs потомучто я не зная что именно хотите узнать средний разменр транзакции или среднюю сумму транзакции. ведь неизвестно что вы подразумевали в задании.
select id_client from clients c where (select sum(transaction_sum) as sums from transactions where id_client = c.id_client having sums < sum(transaction_sum)*0.7) group by id_client; 