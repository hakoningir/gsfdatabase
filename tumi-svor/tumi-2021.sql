-- 1.a
-- finnið titil og ár kvikmyndarinnar sem hefur titil sem er fremst í stafrófröð allra titla
-- find the title and year of the movie whose title is the first in alphabetic order among all titles
.system echo '1.a'
select title, year from movie order by title limit 1;

-- 1.b
-- finnið nöfn þeirra kvikmyndaframleiðenda sem ekki hafa framleitt neina kvikmynd
-- find the names of those movie executives that have not produced any movie
.system echo '1.b'
select name from MovieExec left outer join Movie on cert = producerC group by cert, name having count(title) = 0;

-- 1.c
-- finnið nöfn þeirra kvikmyndavera sem ekki hafa framleitt kvikmynd sem Jack Nicholson (Veturlidi) lék í 
-- find the names of the movie studios that have not produced any movie starring Jack Nicholson (Veturlidi)
.system echo '1.c'
select name from Studio where not exists
	(select * from Movie, StarsIn where 
		name = studioName and
		title = movieTitle and 
		year = movieYear and 
		starName = 'Veturlidi');

-- 2.a 
-- finnið nöfn þeirra kvikmynda sem hafa samnefnda kvikmynd
-- find the titles of movies that have another movie with the same title
.system echo '2.a'
select m1.title from Movie as m1, Movie as m2 where m1.title = m2.title and m1.year <> m2.year group by m1.title;

-- 2.b
-- finnið nöfn þeirra kvikmyndastjarna sem hafa leikið með öllum öðrum kvenkyns kvikmyndastjörnum í einhverri kvikmynd
-- find the names of movie stars that have starred in a movie with every other female star
.system echo '2.b'
select name from MovieStar as m1 where 
	not exists 
	(select name from MovieStar as m2 where 
		m2.gender = 'F' and
		m1.name <> m2.name and
		not exists 
		(select * from StarsIn as s1, StarsIn as s2 where
			s1.movieTitle = s2.movieTitle and
			s1.movieYear = s2.movieYear and
			s1.starName = m1.name and
			s2.starName = m2.name));

-- 2.c
-- finnið fyrir sérhverja kvikmyndastjörnu, sem leikið hefur a.m.k. tveimur kvikmyndum, heildarlengd allra kvikmynda þeirra
-- find, for each movie star that has starred in at least two movies, the total sum lenght of their movies
.system echo '2.c'
select starName, sum(length) from StarsIn 
	left outer join Movie on 
		movieTitle = title and movieYear = year 
	group by starName having count(*) >= 2;

-- finnið fyrir alla kvikmyndaframleiðendur hve margar kvikmyndir framleiðandinn hefur framleitt og heildarlengd, ath. ekki studio
-- find for all movie producers how many movies the producer has produced and the total lenght of the movies, producers not the studios
.system echo '3.a'
select name, count(title), sum(length) from MovieExec, Movie where cert = producerC group by producerC;

-- finnið nafn og heimilisfang þess kvikmyndavers sem framleitt hefur mestu heildarlengd kvikmynda
-- find the name and address of the movie studio that has produceced the largest total length of movies
.system echo '3.b'
select name, address from Studio, Movie where name = studioName group by studioName order by sum(length) desc limit 1;

-- finnið nafn og heimilisfang þeirrar kvikmyndastjörnu sem leikið hefur í mestri heildarlengd kvikmynda
-- find the name and address of the movie star that has starred in the longest total length of movies
.system echo '3.c'
select name, address from MovieStar where 
	name in 
	(select starName from starsIn, movie where 
		movieTitle = title and
		movieYear = year 
		group by starName 
		order by sum(length) desc limit 1);	

-- finnið þær kvikmyndastjörnur sem léku í öllum kvikmyndum þar sem titillinn byrjar á stöfunum 'Star Trek'
-- find all moviestars that starred in movies starting with the letters 'Star Trek'
.system echo 4.a
select name from MovieStar where 
	not exists
	(select * from Movie where 
		title like 'Star Trek%' and
		not exists
		(select * from StarsIn where
			title = movieTitle and 
			year = movieYear and 
			name = starName));

-- finnið nafn þeirrar kvikmyndastjörnu sem leikið hefur í kvikmyndum með flestum framleiðendum
-- find the name of the movie star that has starred in movies with the largest number of different producers
.system echo 4.b
select starName from StarsIn, Movie where 
	movieTitle = title and
	movieYear = year
	group by StarName
	order by sum(distinct producerC) desc limit 1;
