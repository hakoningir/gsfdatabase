CREATE TABLE MovieExec(
	name varchar(25),
	address varchar(25),
	cert varchar(3) primary key, 
	netWorth int
);

CREATE TABLE Studio (
	name varchar(25) primary key, 
	address varchar(25), 
	presC varchar(3) 
		references MovieExec(cert)
);

CREATE TABLE Movie (
	title varchar(25), 
	year int, length int, 
	inColor boolean, 
	studioName varchar(25) 
		references Studio(name), 
	producerC varchar(3) 
		references MovieExec(cert), 
	primary key (title, year)
);

CREATE TABLE MovieStar (
	name varchar(25) primary key, 
	address varchar(25), 
	gender char(1), 
	birthdate varchar(10)
);

CREATE TABLE StarsIn (
	movieTitle varchar(25), 
	movieYear int, 
	starName varchar(25) 
		references MovieStar(name), 
	primary key (movieTitle, movieYear, starName), 
	foreign key (movieTitle, movieYear) 
		references Movie(title,year)
);
insert into MovieStar values
	('Tumi' ,'Kopavogur' ,'M' ,'Sept'),
	('Hakon', 'Saudakrokur' ,'M', 'April'),
	('Gunnar', 'Vestmannaeyjar' ,'M' ,'Oct'),
	('Maria', 'Reykjavik' ,'F' ,'June'),
	('Isabella', 'Reykjavik', 'F', 'Feb'),
	('Veturlidi' ,'Isafjordur','M' ,'Nov'),
	('Patrik' ,'Poland' ,'M' ,'Feb');
	
insert into Studio values
	('Metro golden Mayer' ,'Calefornia' ,'SIG'),
	('Disney Studios' ,'Rio' ,'STI'),
	('Dreamworks' ,'Raufarhofn','STD'),
	('Paramount' ,'Kopasker','FML'),
	('Warner Brothers', 'Ibizafjordur', 'PAL');
	
insert into MovieExec values
	('Siggi', 'Bolholt 10', 'SIG', 150),
	('Palli', 'Bolholt 11', 'PAL', 930),
	('Stína', 'Bolholt 12', 'STI', 30),
	('Lísa' , 'Bolholt 13', 'LIS', 100),
	('Rögnvaldur', 'Ísafjörður 83', 'ROG', 10000),
	('Sjonatan', 'Akranesvegur 29', 'STD', 50),
	('Frida', 'Glerartorg 10', 'FML', 310);

insert into Movie values
	('Avatar', 2007, 	300,0, 'Metro golden Mayer', 	'SIG'),
	('Green Mile', 2017, 	250,1, 'Metro golden Mayer', 	'PAL'),
	('Harry Potter 3', 2012,170,1, 'Disney Studios', 		'STI'),
	('Tron', 2013, 		130,1, 'Disney Studios', 		'STI'),
	('Tron', 1987, 		180,0, 'Metro golden Mayer', 'PAL'),
	('Titanic', 2015, 	250,1, 'Disney Studios', 		'STI'),
	('Star Wars', 1997, 	210,1, 'Disney Studios', 		'LIS'),
	('Star Trek', 1834, 	169,1, 'Metro golden Mayer', 	'PAL'),
	('Guns Akimbo',	2001, 	170,1, 'Disney Studios', 		'LIS'),
	('Road Work Ahead', 2010, 309,1, 'Metro golden Mayer', 	'ROG'),
	('I Sure Hope It Does',	2017, 102,1, 'Metro golden Mayer', 	'ROG'),
	('Mad Max', 2001, 	520,1, 'Metro golden Mayer', 	'SIG'),
	('Hacker', 2017, 	150,1, 'Metro golden Mayer', 	'SIG'),
	('Gone With The Wind', 1939, 238, 0, 'Warner Brothers', 'PAL');

insert into StarsIn values
	('Avatar', 2007, 'Hakon'),
	('Green Mile', 2017, 'Hakon'),
	('Tron', 1987, 'Hakon'),
	('Hacker', 2017, 'Hakon'),
	('Harry Potter 3', 2012, 'Tumi'),
	('Tron', 2013, 'Tumi'),
	('Titanic', 2015, 'Tumi'),
	('Hacker', 2017, 'Tumi'),
	('Star Wars', 1997, 'Hakon'),
	('Star Wars', 1997, 'Tumi'),
	('Star Wars', 1997, 'Gunnar'),
	('Star Wars', 1997, 'Maria'),
	('Star Wars', 1997, 'Isabella'),
	('Star Trek', 1834, 'Veturlidi'),
	('Star Trek', 1834, 'Patrik'),
	('Guns Akimbo', 2001, 'Maria'),
	('Guns Akimbo', 2001, 'Gunnar'),
	('Road Work Ahead', 2010, 'Veturlidi'),
	('I Sure Hope It Does', 2017, 'Veturlidi'),
	('Mad Max', 2001, 'Isabella'),
	('Mad Max', 2001, 'Tumi'),
	('Mad Max', 2001, 'Veturlidi');
