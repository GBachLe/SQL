-- Q1 Get the Top 3 film that have the most customers book
SELECT  screening.film_id, film.name, count(screening_id) as booking  
FROM screening Right JOIN film ON screening.film_id = film.id
				Right JOIN booking ON screening.id = booking.screening_id
 GROUP BY screening.film_id
 HAVING booking IN (SELECT count(screening_id) as booking  
					FROM screening 
                    RIGHT JOIN film ON screening.film_id = film.id
					RIGHT JOIN booking ON screening.id = booking.screening_id
					GROUP BY screening.film_id
                    )
                    ORDER BY booking DESC                    
                    LIMIT 3;

-- Q2 Get all film that longer than average length
select film.name, film.length_min
from film
Where film.length_min > (select avg(film.length_min) from film);

-- Q3 Get the room which have the highest and lowest screenings IN 1 SQL query
select room.name, count(*) as screening_times
from room join screening on room.id = screening.room_id
group by room.name
having screening_times = (	select count(*) as screening_times
							from room join screening on room.id = screening.room_id group by room.name order by screening_times DESC
                            limit 1)
						OR
							screening_times = (select count(*) as screening_times
							from room join screening on room.id = screening.room_id group by room.name order by screening_times ASC
                            limit 1)
order by screening_times ;

-- Q4 Get number of booking customers of each room of film ‘Tom&Jerry’
select room_id, count(*)
from screening join booking on screening.id = booking.screening_id
				join film on screening.film_id = film.id
where film.name = 'Tom&Jerry'
group by room_id;


-- Q5 What seat is being book the most ?
select seat_id, count(id) as bookings
from reserved_seat
group by seat_id
order by bookings desc
limit 1;

-- Q6 What film has the most screen in 2022
select film_id, count(*) as total_screening
from screening
where year(screening.start_time) = 2022
group by film_id
order by total_screening desc;

-- Q7 Which day has most screen?
select day(start_time) as Dday, count(*) as appearance
from screening
group by day(start_time)
having appearance = ( select count(*) as appearance
						from screening
						group by day(start_time)
						order by appearance desc
                        limit 1);
                        
                        
-- Q8 Show film on 2022-May
select distinct film.name from film
join screening on film.id = screening.film_id
where screening.start_time like '%2022-05%';







