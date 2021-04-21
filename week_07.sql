/*1.	Create a new column called “status” in the rental table that uses a case statement to indicate if a film
wasreturned late,early, or on time. */
/*For this we have used the case syntax.Case goes through conditionsand returns value when the first condition is met.
If no conditions are true it returns the value in the else clause.
We have also used datepart() in our sql query to fetch the number of days. From the table, it can be deduced that a higher
percentage of movies are returned before the rental duration ends and also a significant percentage of films are 
returned late..*/
/*SELECT CASE
        WHEN rental_duration > date_part('day', return_date-rental_date)THEN 'Returned Early'
        WHEN rental_duration = date_part('day' , return_date-rental_date)THEN 'Returned on time'
		ELSE 'Returned Late'
		END AS return,
		COUNT(*) AS total_no_of_films
		FROM film	INNER JOIN inventory 
		ON film.film_id=inventory.film_id
		INNER JOIN rental
		ON inventory.inventory_id=rental.inventory_id
		GROUP BY 1
		ORDER BY 2 DESC;*/
  

/*2.	Show the total payment amountsfor people who live in Kansas City or Saint Louis.*/ 
/*FOllowing tables are used to get the result :
payment -->customer  --> address -->city
Aggregate function sum() is used on amount column of payments table for getting total amount 
and then different tables are joined using JOIN .tHE TABLES ARE JOINED on primary, foreign key concept 
and futher used where by clause for getting amounts for people living in Kansas or Saint louis.*/

/*SELECT sum(payment.amount),customer.first_name,city
FROM payment
JOIN customer 
ON payment.customer_id=customer.customer_id
JOIN address
ON customer.address_id=address.address_id
JOIN city
ON address.city_id=city.city_id
WHERE city='kansas' OR city='Saint Louis'
GROUP BY customer.first_name,city;*/

/*3.How many film categories are in each category? Why do you think there is a table for category and
a table for film category?*/
/*Tables used :
category --> film_category --> film 
category_id is the primary key in category table which acts as the foreign key for film_category table.And 
for the film table film_id is the primary key which is the foreign key for film_category.So, film_category
is helping in joining category >film-category >film.If film_category table does not exist then
it would be difficult to establish such relation.*/

/*SELECT c.name,count(f.film_id) as "total films"
FROM category c 
JOIN film_category fc 
ON c.category_id=fc.category_id
JOIN film f
ON fc.film_id=f.film_id
GROUP BY c.name
ORDER BY count(f.film_id) DESC;*/


/*4.	Show a roster for the staff that includes their email, address, city, and country (not ids)*/
/*Tables used :
staff --> address -->city --> country.Then following tables are joined to fetch the desired results*/

/*SELECT email,address,city,country
FROM staff s
JOIN address a 
ON s.address_id=a.address_id
JOIN city c
ON a.city_id=c.city_id
JOIN country cty
ON c.country_id=cty.country_id;*/


/*5.	Show the film_id, title, and length for the movies that were returned from May 15 to 31, 2005*/
/* tables used 
film -->inventory --> rental. tables are joined using Joins on pK and fK concept.Date function is used 
SELECT DATE(column_name) FROM table_name syntax is used to get date from timestamp column.*/

/*Select film.film_id ,title ,length,date(return_date)
from film
inner join inventory
on film.film_id=inventory.film_id
inner join rental
on inventory.inventory_id=rental.inventory_id			 
where date(return_date)  between '2005-05-15' AND '2005-05-31';*/


/*6.Write a subquery to show which movies are rented below the average price for all movies*/
/*FOr claculating avg rental rate for movies we will use :*/
SELECT avg(rental_rate) from film;

/*For selecting movies that are rented below the average price for all movies*/
/*select title
from film
WHERE rental_rate < (SELECT avg(rental_rate) FROM film);*/


/*7.Write a join statement to show which moves are rented below the average price for all movies.*/
/*Using Self join*/

/*select  title, rental_rate
from film  f
join 
(select avg(rental_rate) avg_rental_rate from film) as f2 on f.rental_rate<f2.avg_rental_rate
order by rental_rate asc;*/

/*USing JOINS*/

/*select round(AVG(p.amount),2) as avg_rental, f.title
from film as f
join inventory as i
on f.film_id = i. film_id
join rental as r
on i.inventory_id = r.inventory_id
join payment as p
on p.rental_id = r.rental_id
where rental_rate < 2.98
group by f.title;*/


/*8.Perform an explain plan on 6 and 7, and describe what you’re seeing and important ways 
they differ*/
/*Explain  plan for 6 */
/*Explain select title
from film
WHERE rental_rate < (SELECT avg(rental_rate) FROM film);*/

/*Explain plan for 7*/
/*EXPLAIN select  title, rental_rate
from film  f
join 
(select avg(rental_rate) avg_rental_rate from film) as f2 on f.rental_rate<f2.avg_rental_rate
order by rental_rate asc;*/


/*9.With a window function, write a query that shows the film, its duration, 
and what percentile the duration fits into. */
/*select f.title,f.length as duration,
	percent_rank() over(order by f.length)
from film as f
inner join film_category as fi using (film_id)
order by percent_rank desc;*/


/*10.	In under 100 words, explain the difference is between set-based and procedural programming. 
Be sure to specify which sql and python are.*/
 /*Procedural approach is actually the "programmatic approach" that we are used to working with in our 
daily programming life. In this approach, we tell the system "what to do" along with "how to do" it. 
We query the database to obtain a result set and we write the data operational and manipulation logic 
using loops, conditions, and processing statements to produce the final result. The runtime does whatever we want 
it to do, however we want it to do.*/

/*Set based approach is actually an approach which lets you specify "what to do", but does not let you specify 
"how to do". That is, you just specify your requirement for a processed result that has to be obtained from a 
"set of data" (be it a simple table/view, or joins of tables/views), 
filtered by optional condition(s)*/

/*SQL is set based language whereas python is both procedural as well set based.*/

