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
-- finni[ fyrir sérhverja kvikmyndastjörnu, sem leikið hefur a.m.k. tveimur kvikmyndum, heildarlengd allra kvikmynda þeirra
-- find, for each movie star that has starred in at least two movies, the total sum lenght of their movies
.system echo '2.c'
select starName, sum(length) from StarsIn left outer join Movie on movieTitle = title and movieYear = year group by starName having count(*) >= 2;
select starName, sum(length) from StarsIn, Movie where title = movieTitle and year = movieYear group by starName having count(*) >= 2;
