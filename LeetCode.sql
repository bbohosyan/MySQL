-- 595. Big Countries
select name, population, area from World
where area > 3000000 or population > 25000000;
-- 620. Not Boring Movies
select * from cinema
where id%2 = 1 and description <> "boring"
order by rating desc;