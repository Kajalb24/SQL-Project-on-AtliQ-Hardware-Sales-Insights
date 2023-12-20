use moviesdb;

select actor_id , count(*) as movies_count
from movie_actor
group by actor_id
order by movies_count desc 	 ;

explain analyze
select actor_id , name,
	( select count(*) from movie_actor
	  where actor_id = actors.actor_id) as movies_count
from actors
order by movies_count desc;


select * from movies where release_year in 
				((select max(release_year) from movies),
                (select min(release_year) from movies));
                
                
select * from movies where imdb_rating > (select avg(imdb_rating) from movies);
                
                
 