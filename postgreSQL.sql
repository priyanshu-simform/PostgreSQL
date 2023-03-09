-- SELECT
SELECT  * FROM actor;
SELECT * FROM actor where first_name like 'A%';
SELECT * FROM city where city_id=100 and country_id >=100;

-- column aliAS
SELECT country_id AS Country_rank FROM city;

-- order by
SELECT * FROM city order by country_id;
SELECT * FROM actor order by first_name;

-- SELECT distinct -- distinct ON
SELECT distinct * FROM actor;
SELECT distinct ON (lASt_name) * FROM actor;



-- where
SELECT * FROM film where length >= 180;
-- limit
SELECT address_id,address FROM address limit 100;
-- offset
SELECT address_id, address FROM address limit 100 offset 50;
-- fetch
SELECT address_id, address FROM address fetch first 3 row ONly;
-- in
SELECT * FROM film where film_id in (1,2,3,4,7,9,10);
-- between
SELECT title, length FROM film where length between 180 and 200;




-- inner join
SELECT c.first_name, c.lASt_name, c.email, p.amount, p.payment_date FROM customer c inner join payment p using (customer_id);
-- right join
SELECT a.actor_id,a.first_name, film_id FROM actor a right join film_actor f ON a.actor_id = f.actor_id;
SELECT a.actor_id,a.first_name, film_id FROM actor a right join film_actor f ON a.actor_id = f.actor_id where a.actor_id is null;
SELECT * FROM film f right join inventory i using (film_id) where store_id is null;
-- SELECT store_id FROM inventory where null;
-- left join
-- SELECT f.film_id,f.title FROM film f left join inventory i using (film_id);
SELECT f.film_id,f.title FROM film f left join inventory i ON f.film_id=i.film_id where i.film_id is null;
-- self-join
SELECT e1.emp_id,e1.emp_name,e2.salary FROM employee e1 join employee e2 ON e1.emp_name=e2.emp_name where e1.salary>=10000;
-- cross join
SELECT * FROM reservatiON;
SELECT * FROM staff cross join reservatiON;

SELECT * FROM employee;
-- group by
SELECT dept_name,count(*) AS count FROM employee  group by dept_name;
-- having
SELECT dept_name, count(*) AS count FROM employee group by dept_name having count(*) >5;





-- uniON 
(SELECT * FROM rental where customer_id<=100) uniON (SELECT * FROM rental where rental_id<=100);

-- uniON all
(SELECT * FROM rental where customer_id<=100) uniON all (SELECT * FROM rental where rental_id<=100);

-- except
SELECT film_id,title,descriptiON,releASe_year FROM film where film_id in (SELECT f.film_id FROM film f except (SELECT a.actor_id FROM actor a)) ;
-- SELECT * FROM film_actor;
-- intersect
(SELECT film_id,title,descriptiON FROM film where length=100) intersect (SELECT film_id,title,descriptiON FROM film where rental_rate=2.99);




-- subquery
SELECT customer_id,first_name,lASt_name FROM customer where customer_id in
(SELECT customer_id FROM payment where amount=4.99) limit 100;
-- any
SELECT title FROM film where length >= any(SELECT max(length) FROM film);
-- all
SELECT ci.city,postal_code FROM city ci inner join address ad using(city_id) where city_id > all (SELECT avg(city_id) FROM city) limit 100;




--created temp TABLE
-- create TABLE temp(
-- 	id int not null,
-- 	fname varchar(10),
-- 	lname varchar(10),
-- 	primary key(id)
-- );

-- INSERT
-- INSERT INTO temp(id,fname,lname)
-- VALUES (2,'f2','l2');
-- INSERT INTO temp(id,fname,lname)
-- VALUES (3,'f3','l3');
-- INSERT INTO temp(id,fname,lname)
-- VALUES (4,'f4','l4');
-- INSERT INTO temp(id,fname,lname)
-- VALUES (5,'f5','l5');

-- create TABLE temp2(
-- 	new_id int not null,
-- 	dept varchar(10),
-- 	primary key(new_id),
-- 	foreign key(new_id)
-- 	references temp(id)
-- );
-- INSERT INTO temp2 (new_id,dept)
-- VALUES(1,'comp');
-- INSERT INTO temp2 (new_id,dept)
-- VALUES(2,'it');
-- INSERT INTO temp2 (new_id,dept)
-- VALUES(3,'ec');
-- INSERT INTO temp2 (new_id,dept)
-- VALUES(5,'comp');


SELECT * FROM temp;
-- update
update temp
set fname='f4update'
where id=4;
SELECT * FROM temp order by id;
update demo
set id 


SELECT * FROM temp;
-- delete 
-- delete FROM temp
-- where id=4;
SELECT * FROM temp;





-- upsert (how ot implement upsert  funtiONallity in postgres)

INSERT INTO temp(id,fname,lname)
VALUES (5,'five','lASt')
ON cONflict (id)
DO UPDATE 
set fname='five';
SELECT * FROM temp;



-- CommON TABLE expressiON
-- CTE
--subquery statement
--TABLE 
SELECT * FROM temp;
WITH cte AS (
	SELECT * FROM address 
	where city_id between 1 and 10
)
SELECT * FROM cte where address_id>400;
with cte2 AS 
(
	SELECT id,fname,lname, 
	(CASE
		when id<2 then temp.fname='less'
		when id = 2 then temp.fname='med'
		else fname='more'
	END) AS val 
	FROM temp
)
SELECT * FROM cte2;



-- recusive query using CTE
with recursive x AS 
(
	SELECT 1 num 
	uniON all
	SELECT num+1 FROM x where num<=10
)
SELECT * FROM x;

-- TransactiON
create TABLE demo AS SELECT 1 n,current_timestamp t;
SELECT * FROM demo;
INSERT INTO demo VALUES(2,current_timestamp);
INSERT INTO demo VALUES(3,current_timestamp);
INSERT INTO demo VALUES(4,current_timestamp);
insert INTO demo VALUES(5,current_timestamp);
-- postgres TransactiON
start transactiON;
insert INTO demo VALUES(9,current_timestamp);
SELECT * FROM demo;
savepoint my;
SELECT * FROM demo;
insert INTO demo VALUES(10,current_timestamp);
SELECT * FROM demo;
insert INTO demo VALUES(11,current_timestamp);
SELECT * FROM demo;
rollback to my;
insert INTO demo VALUES(10,current_timestamp);
SELECT * FROM demo;
end transactiON;
SELECT * FROM demo;

alter TABLE demo
add unique(n);
select * from temp2;

CREATE TABLE csvfile(roll_no int,fname varchar,lname varchar);
select * from csvfile;

COPY csvfile(roll_no,fname,lname)
FROM '/home/priyanshu/PostgreSQL_PGAdmin/one.csv'
DELIMITER ','
CSV HEADER;
--performed from psql terminal and try \COPY

COPY temp 
TO '/home/priyanshu/PostgreSQL_PGAdmin/simple.csv'
DELIMITER ','
CSV HEADER;
--perfomed from psql terminal and try \COPY

show autovacuum;


-- Managing tables 
-- postgresql data types 
-- create tables 
CREATE TABLE post1 
(
	id serial unique, 
	fname varchar(20) not null,
	lname varchar(20) not null UNIQUE,
	num numeric(10),
	insert_time TIMESTAMP not null,
	primary key(id)
);

insert into post1(fname,lname,num,insert_time) values ('one3','two3','300',CURRENT_TIMESTAMP);
insert into post1(fname,lname,num,insert_time) values ('one4','two4','400',CURRENT_TIMESTAMP);
select * from post1;

-- select into 
select customer_id,email,create_date into post2 from customer where customer_id<=10;
select * from post2;
-- create tables as 
select * from actor;
select * from film_actor;
drop table post3;
CREATE TABLE IF NOT EXISTS post3 AS  (select actor_id,film_id,first_name,last_name from actor join film_actor using(actor_id) limit 15);
select * from post3;

-- serial 
-- sequences 
CREATE SEQUENCE IF NOT EXISTS my_seq
AS INT
INCREMENT 2
MINVALUE 1
MAXVALUE 10
START 5
CYCLE;
SELECT nextval('my_seq')
insert into post1 values (nextval('my_seq'),'one1','two1','100',CURRENT_TIMESTAMP);
insert into post1 values (nextval('my_seq'),'one2','two2','100',CURRENT_TIMESTAMP);

select * from post1;
select nextval('my_seq');
DROP SEQUENCE my_seq;

-- identity column 
CREATE TABLE post5
(
	enroll INT GENERATED ALWAYS AS IDENTITY,
	name varchar(10),
	dept_id int not null
);
insert into post5 OVERRIDING SYSTEM VALUE values(10,'new1',1);
insert into post5 (name,dept_id) values('new2',2);
insert into post5 (name,dept_id) values('new3',3);
SELECT * FROM post5;

ALTER TABLE post5
ALTER COLUMN dept_id
ADD GENERATED BY DEFAULT AS IDENTITY;

insert into post5(name) values('name4');
insert into post5(name,dept_id) values('name4',5);
insert into post5(enroll,name,dept_id) OVERRIDING SYSTEM VALUE values(6,'name5',5);
select * from post5;


-- alter table 
ALTER TABLE post5 
ADD COLUMN new_col int UNIQUE;

select * from post5;

DELETE FROM post5 where enroll=6 RETURNING *;

UPDATE post5 SET new_col=enroll*123 WHERE dept_id=5;
SELECT *FROM post5;

-- rename column
ALTER TABLE post5
RENAME COLUMN new_col to updated;
select * from post5;
--rename table
ALTER TABLE post5 
RENAME TO new_post5;
SELECT * FROM new_post5;

-- drop table 
drop table new_post5;

-- add column 
ALTER TABLE post5
ADD COLUMN new_col int DEFAULT 1;
SELECT * FROM post5;
-- drop column 
ALTER TABLE post5
DROP COLUMN new_col;
SELECT * FROM post5;

-- change data type 
-- temporary table 
-- truncate tables 

-- Constraints in database  

-- primary key 
-- foreign key 
-- check constraint 
-- unique constraint 
-- not null constraint 
drop table post4;
create table post4(id int, name varchar(10), primary key(id));
insert into post4 values (1,'a'), (2,'b');
insert into post4 values (3,'a'), (5,'b');
insert into post4 values (4,'z'), (6,'h');
select * from post4 order by id;
CREATE TABLE post6 
(
	new_id INT PRIMARY KEY,
	dept_id INT NOT NULL,
	age INT CHECK (age >18),
	city_id INT,
	CONSTRAINT my_fk FOREIGN KEY(city_id) REFERENCES city(city_id)
);
insert into post6(new_id,dept,age,)

select distinct * from post4 order by id;
SELECT COUNT(*) FROM RENTAL;

--random numbers in trange
--random() * (High-Low+1) + low
SELECT random() * (100-1+1) +1 as Random_number;
EXPLAIN (SUMMARY TRUE) SELECT * FROM staff;

SELECT '1000'::INTEGER;
SELECT CAST('10.2' AS DOUBLE PRECISION) AS Num;
create table xyz1(id int);
insert into xyz1(id) values(1), (2);
ALTER TABLE xyz1 
ADD COLUMN name varchar(10) default 'x';

create table xyz2(id int);
insert into xyz2(id) values(2), (3);
alter table xyz2 ADD COLUMN name varchar(10);

UPDATE xyz2 SET name='y';

select * from xyz1 left outer join xyz2 using(id);
select * from xyz1 right outer join xyz2 using(id);
select * from xyz1 full outer join xyz2 using(id,name);

--grouping sets
SELECT * from film 
JOIN film_actor USING(film_id) limit 10;
select * from payment order by rental_id; 
SELECT customer_id,staff_id,sum(amount) 
FROM payment 
GROUP BY
GROUPING SETS(customer_id,staff_id) limit 10;

SELECT title,actor_id,rental_duration,rating, COUNT(*) 
FROM  (SELECT * FROM film join film_actor USING(film_id) LIMIT 20) AS tp
GROUP BY 
GROUPING SETS(title,actor_id,rental_duration,rating) HAVING rating is not null;

--ROLLUP
SELECT title,actor_id,rental_duration,rating, COUNT(*) 
FROM  (SELECT * FROM film join film_actor USING(film_id) LIMIT 20) AS tp
GROUP BY 
ROLLUP(title,actor_id,rating,rental_duration) ;

SELECT EXTRACT (year FROM f.last_update) yy,
		EXTRACT (month FROM f.last_update) mm, count(actor_id) 
FROM film f
	join film_actor fa USING(film_id)
GROUP BY 
	ROLLUP(
		EXTRACT (year FROM f.last_update),
		EXTRACT (month FROM f.last_update)
	);
	
--CUBE
SELECT title,rating,rental_duration,count(*) FROM FILM 
GROUP BY
CUBE(title,rating,rental_duration) limit 20;