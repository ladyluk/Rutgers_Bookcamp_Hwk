select first_name, last_name from actor;
select UPPER (concat (first_name,' ', last_name)) as 'Actor Name' from actor;
select actor_id, first_name, last_name from actor
	where first_name = 'JOE';
select actor_id, first_name, last_name from actor
	where last_name like '%GEN%';
select last_name, first_name from actor
	where last_name like '%LI%';
select country_id, country from country
	where country in ('afghanistan', 'Bangladesh', 'China');
Alter table actor 
    add middle_name varchar(20)
    after first_name;
Alter table actor
	modify middle_name blob;
Alter table actor 
	drop column middle_name;
select count(actor_id), last_name from actor
	group by last_name;
select count(actor_id), last_name from actor
	group by last_name
    having count(actor_id)>= '2';
update actor
	set first_name = 'Harpo'
	where actor_id = 172;
update actor
	set first_name = 'Groucho'
	where actor_id = 172;
create table address (
	address_id smallint(5) auto_increment not null,
    address varchar(50),
    address2 varchar(50),
    district varchar(20),
    city_id SMALLINT(5) not null,
    postal_code varchar(10),
    phone VARCHAR(20),
    location geometry,
    last_update TIMESTAMP,
    primary key (address_id)
    );
select s.first_name, s.last_name, a.address
from staff s 
left join
address a
on  s.address_id = a.address_id;

select s.first_name, s.last_name, sum(p.amount)
from staff s 
left join
payment p
on  s.staff_id = p.staff_id
where month(payment_date) = 08 and year (payment_date) = 2005
group by s.staff_id;

select f.title, count(fa.actor_id) as 'Number of Actors'
from  film f
left join 
film_actor fa
on f.film_id = fa.film_id
group by f.title;

select f.title,count(i.inventory_id) 
from film f
left join inventory i
on f.film_id = i.film_id
where f.title = 'HUNCHBACK IMPOSSIBLE';

select c.first_name, c.last_name, sum(p.amount)
from customer c
left join
payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name;

select f.title from 
film f
left join 
language l
on f.language_id = l.language_id
where l.language_id = 1 and f.title like "K%" or f.title like "Q%";

select a.first_name, a.last_name
from actor a
left join
film_actor fa
on a.actor_id = fa.actor_id
where fa.film_id =	
		(select film_id from film 
		where title = 'Alone Trip'
        )
group by a.actor_id;

select cust.first_name, cust.last_name, cust.email  
from customer cust
join 
address ad
on ad.address_id = cust.address_id
join
city
on ad.city_id =  city.city_id
join 
country
on city.country_id = country.country_id
where country = 'Canada';

select f.title
from film f
join 
film_category fc
on fc.film_id = f.film_id
join category c
on c.category_id = fc.category_id
where c.name = 'family';

select f.title, r.rental_date
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
order by r.rental_date desc;

select i.store_id, sum(p.amount)
from payment p
join
rental r
on r.rental_id=p.rental_id
join inventory i
on i.inventory_id = r.inventory_id
group by i.store_id;


select s.store_id, c.city, co.country
from store s
join address a
on s.address_id = a.address_id
join city c
on a.city_id = c.city_id
join country co
on c.country_id = co.country_id;

select category.name, sum(payment.amount)
from category 
join film_category fc
on category.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment
on r.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc
limit 5;

Create view Top_Five_Genres as
select category.name, sum(payment.amount)
from category 
join film_category fc
on category.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment
on r.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc
limit 5;

Select * from Top_Five_Genres;

Drop view Top_Five_Genres;