-- |||||||||||||||||||||||||||||||||
-- ||    __    sjomli.is    __    ||
-- ||  _/  |_ __ __  _____ |__|   ||
-- ||  \   __\  |  \/     \|  |   ||
-- ||   |  | |  |  /  Y Y  \  |   ||
-- ||   |__| |____/|__|_|__/__|   ||
-- ||                             ||
-- |||||||||||||||||||||||||||||||||

-- 1.a
.system echo 1.a
select title, year from movie order by length desc limit 1;

-- 1.b
.system echo 1.b
select name from MovieStar 
	left join StarsIn on name = starName 
	left join Movie on movieTitle = title and movieYear = year
	group by name having count(title) = 0;

-- 1.c
.system echo 1.c
select distinct name from MovieExec, Movie, StarsIn where
	cert = producerC and
	title = movieTitle and
	year = movieYear and
	starName = 'Veturlidi';

-- 2.a
.system echo 2.a
select M1.title from Movie as M1, Movie as M2 where
	M1.title = M2.title and
	M1.year <> M2.year;

-- 2.b
.system echo 2.b
select starName from StarsIn as S1 where not exists
	(select * from StarsIn as S2 where
		S1.starName <> S2.starName and
		S1.movieTitle = S2.movieTitle and
		S1.movieYear = S2.movieYear);

-- 2.c
.system echo 2.c
select name, sum(length) as "Total length" from MovieExec, Movie where 
	cert = producerC
	group by cert having count(*) >= 2;

-- 3.a
.system echo 3.a
select name, count(title), avg(length) from MovieStar
	left join StarsIn on name = starName
	left join Movie on title = movieTitle and year = movieYear
	group by name;

-- 3.b
.system echo 3.b
select name from MovieExec, Movie where
	cert = producerC
	group by name
	order by sum(length)
	desc limit 1;

-- 3.c
.system echo 3.c
select starName from StarsIn, Movie where 
	movieTitle = title and
	movieYear = year
	group by starName
	order by sum(length)
	desc limit 1;

-- 4.a
.system echo 4.b
select starName as "2017 'G' Stjörnur" from StarsIn, Movie where
	movieTitle = title and 
	movieYear = year and
	movieTitle like 'G%' and
	movieYear = 2017;

-- 4.b
.system echo 4.b
select name from MovieExec where not exists
	(select * from Movie where cert = producerC and not exists
		(select * from StarsIn where
			title = movieTitle and
			year = movieYear));
