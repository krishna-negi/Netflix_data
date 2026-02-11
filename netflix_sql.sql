-- Count total records in the table.
select count(*) from netflix_table;
-- Count Movies vs TV Shows.
-- select sum(case  when type='Movie' then 1 else 0 end ) as Movies,
-- sum(case  when type='TV Show' then 1 else 0 end ) as tvseries
-- from netflix_table; 
select count(*) filter (where type='Movie') as movie ,
count(*) filter(where type='TV Show') as tv_shows 
from netflix_table;

-- Find distinct countries.
select distinct(trim(c)) as country from netflix_table cross join lateral 
unnest(string_to_array(country,',')) as c
where trim(c)<>''
order by country;

-- Find titles released after 2020.
select title from netflix_table where extract(year from date_added)>'2020';

-- Find all TV Shows with more than 3 seasons. 
select listed_in,duration_num from netflix_table where  type='TV Show' and duration_num>=3;

-- Top 10 countries by number of titles.  
select trim(c) as country,count(*) as number_of_Titles from 
netflix_table cross join lateral 
unnest(string_to_array(country,',')) as c
group by trim(c)  
order by number_of_Titles desc
limit 10;

-- Extract year from date_added.
select distinct extract(year from date_added)  as year from netflix_Table order by year ;

-- Find titles added in the last 5 years.
select title from netflix_Table where 
date_Added>=current_date-interval'5 years' ;


-- Split listed_in into individual genres.
select trim(genre ) as genre from netflix_table
cross join lateral unnest(string_to_Array(listed_in,',')) as genre;


-- Find titles with multiple genres.
select title,listed_in  from
netflix_table where array_length(string_to_Array(listed_in,','),1)>1;

-- Number of titles released each year.
select year,count(*) as Number_of_titles from netflix_table 
group by year order by year;



-- Average movie duration.
select round(avg(duration_num),2)  as avg_duration
from netflix_Table where type='Movie';

-- Count of titles per rating. 
select rating,count(*) as total_titles from netflix_table 
group by rating order by total_titles desc ;

-- Rank countries by content count (use RANK()).

select country,content_count,rank() over(order by content_count desc) as rank
from
(select trim(c) as country,count(*) as content_count from netflix_table cross join lateral
unnest(string_to_array(country,',')) as c
group by c )t;


select * from netflix_table;

-- Running total of titles added by year.
with yearly as ( 
select year,count(*) as titles_Added 
from netflix_table group by year)
select year,titles_Added,
sum(titles_Added) over(order by year )from yearly
order by year;

-- Percentage of Movies vs TV Shows.
select round(count(*) filter(where type='Movie')*100.0/count(*),2) as movies
,round(count(*) filter(where type='TV Show')*100.0/count(*),2) as tv_shows  from netflix_table

-- Find directors with more than 5 titles.
select trim(d) as director,
count(*) as total_titles  from netflix_table 
cross join lateral unnest(string_to_Array(director,',')) as d
where director is not null and director <>'unknown'
group by trim(d) having count(*)>5 order by total_titles  desc
;

-- Country-wise Movie vs TV Show comparison.
select trim(c) as country,count(*) filter (where type='Movie') as movies 
,count(*) filter (where type='TV Show') as tv_show from netflix_table cross join lateral 
unnest(string_to_array(country,',')) as c
group by trim(c) order by movies desc ,tv_show desc;

-- Year-over-year growth in content.
select year,count(*) as total_titles ,
count(*)-LAG(count(*)) over (order by year) as yoy_growth 
from netflix_table group by year order by year;
-- Top 5 genres.
select genres ,count(*) as no_of_genres from netflix_table 
cross join lateral unnest(string_To_array(listed_in,',')) as genres
group by genres order by no_of_genres desc limit 5;