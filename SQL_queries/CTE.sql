use moviesdb;

select * from					
(select name,
	   year(current_date()) - birth_year as age
from actors ) as actors_age
where age > 70 and age < 85;



with actors_age as (
					select name,
					year(current_date()) - birth_year as age
					from actors )
select * from actors_age where age > 70 and age < 85;



with actors_age (name, age) as (               #(name, age) columns named manually for table actors_age
					select name,
					year(current_date()) - birth_year
					from actors )
select * from actors_age where age > 70 and age < 85;



select * from movies where imdb_rating < (select avg(imdb_rating) from movies) ;
select *, (revenue - budget)*100/budget as pct from financials having pct > 500 ;



with X as (select *, (revenue - budget)*100/budget as pct from financials having pct > 500),
	 Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select * from x join y using (movie_id);


with X as (select *, (revenue - budget)*100/budget as pct from financials having pct > 500),
	 Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select * from x join y on x.movie_id = y.movie_id;

with X as (select *, (revenue - budget)*100/budget as pct from financials having pct > 500),
	 Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select x.movie_id , x.pct , y.title , y.imdb_rating 
from x join y on x.movie_id = y.movie_id;

with X as (select *, (revenue - budget)*100/budget as pct from financials),
	 Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select x.movie_id , x.pct , y.title , y.imdb_rating 
from x join y on x.movie_id = y.movie_id where pct > 500;


with X as (select *, (revenue - budget)*100/budget as pct from financials),
	 Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select x.movie_id , x.pct , y.title , y.imdb_rating 
from x join y using(movie_id) where pct > 500;


#exercise
select * from movies where release_year > 2000 and industry = 'Hollywood';

select *, (revenue - budget) as profit from financials;

select *, (revenue - budget) as profit from financials where (revenue - budget) > 500;


with 
	new_holly as (select * from movies where release_year > 2000 and industry = 'Hollywood'),
    rich_holly as (select *, (revenue - budget) as profit from financials where (revenue - budget) > 500)
select
	nh.movie_id, nh.title, nh.industry, nh.release_year, rh.revenue, rh.budget, rh.profit 
    from new_holly nh join rich_holly rh using (movie_id);
    
    
with 
	new_holly as (select * from movies where release_year > 2000 and industry = 'Hollywood'),
    rich_holly as (select *, (revenue - budget) as profit from financials)
select
	nh.movie_id, nh.title, nh.industry, nh.release_year, rh.revenue, rh.budget, rh.profit 
    from new_holly nh join rich_holly rh using (movie_id) where profit > 500;





	
