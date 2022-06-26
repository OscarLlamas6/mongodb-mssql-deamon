USE [IMDB]
GO;

INSERT INTO TitleType(name) values ('+13'),('+16'),('+18');

INSERT INTO Title(primaryTitle,originalTitle, isAdult,startYear,endYear,runtime, titleTypeId)
 values('Ozark', 'Ozark',0,2017,2022,60,2),
        ('Orgullo y prejuicio', 'Pride and prejudice',0,2005,2005,127,1),
        ('Jane Eyre', 'Jane Eyre',0,2011,2011,120,1),
        ('La otra reina', 'La otra reina',1,2008,2008,115,2),
        ('Anna Karenina', 'Anna Karenina',1,2012,2012,130,2),
        ('Sailor moon', 'Sailor moon',0,1998,1999,21,1),
        ('Candy Candy', 'Candy Candy',0,1976,1780,21,2),
        ('Yo soy Betty la fea', 'Yo soy Betty la fea',0,2001,2003,60,2),
        ('The blacklist', 'Lista negra',0,2013,2022,45,2),
        ('Ninfomanía', 'Ninf()omanía',1,2013,2013,117,3),
        ('365 días', '365 days',1,2020,2020,115,3),
        ('50 sombras de Grey', '50 sombras de Grey',1,2015,2015,125,3),
        ('Peaky Blinders', 'Peaky Blinders',0,2013,2022,55,2),
        ('Blindspot', 'Punto ciego',0,2015,2020,45,2),
        ('Dark', 'Dark',0,2017,2020,52,2),
        ('DeadNote', 'Lista negra',0,2013,2022,45,2),
        ('Stranger Things', 'Stranger Things',0,2016,2022,60,2),
        ('Anne with an E', 'Anna de las tejas verdes',0,2016,2019,52,1),
        ('Breaking Bad', 'Braking Bad',0,2008,2013,58,2),
        ('Bridgerton', 'Bridgerton',0,2021,2022,58,2),
        ('Shadow hunters', 'Shadow hunters',0,2015,2019,45,2),
        ('Gambito de dama', 'Gambito de dama',0,2020,2020,60,2),
        ('House of cards', 'House of cards',0,2013,2018,56,2),
        ('Sensatez y sentimientos', 'Sensatez y sentimientos',0,1995,1995,136,2),
        ('Desde mi cielo', 'Desde mi cielo',0,2009,2009,136,1);


INSERT INTO Genre(name) values('Romance'),('Clásicas'),('Acción'),('Fantasía'),
                               ('Suspenso'),('Ánime'),('Dramas'),('Fe y espiritualidad'),
                               ('Independiente'),('Policiales'),('Terror'),('Comedias'),
                               ('Deportes'),('De Hollywood'), ('Infantil'),('Documentales'),
                               ('Érotico'),('Ciencia ficción');


INSERT INTO TitleGenre(titleId,genreId) values(1,3),(1,5),(1,10),
                                               (2,2),(2,1),(2,7),
                                               (3,2),(3,1),(3,7),(3,5),
                                               (4,2),(4,7),(4,5),
                                               (5,2),(5,7),(5,5),(5,1),
                                               (6,4),(6,6),(6,12),
                                               (7,6),(7,7),(7,1),
                                               (8,1),(8,7),(8,12),
                                               (9,3),(9,5),(9,10),
                                               (10,17),(10,7),
                                               (11,17),(11,7),
                                               (12,17),(12,7),(12,1),
                                               (13,10),(13,3),
                                               (14,3),(14,5),(14,10),
                                                (15,5),(15,18),
                                               (16,3),(16,5),(16,10),
                                               (17,18),(17,3),(17,3),
                                               (18,2),(18,7),(18,1),
                                               (19,3),(19,10),
                                               (20,1),(20,2),(20,7),
                                               (21,1),(21,3),(21,4),
                                               (22,2),(22,7),
                                               (23,14),(23,10),(23,7),(23,3),
                                               (24,2),(24,1),(24,7),
                                               (25,2),(25,7),(25,9),(25,10),(25,8);



INSERT INTO Region(name) values('Montreal'),('Toronto'),('Santiago'),('Iowa'),('Carolina del Sur'),
                                ('Los Ángeles'),('Oregón'),('Varsovia'),('Finlandia'),
                                ('Londres'),('Bélgica'),('Países bajos'),('Zúrich'),
                                ('Taiwán'),('Hong Kong'),('Tokio'),('Singapur'),
                                ('Sídney');


insert into Language(name) values('Español'),('Inglés'),('Alemán'),('Mandarín'),('Ruso'),
                                  ('Francés'),('Hebreo'),('Italiano'),('Portugués'),('Japonés'),
                                  ('Coreano');


INSERT INTO AlternativeType(name) values ('Alternativo 1'),('Alternativo 2'),
                                         ('Alternativo 3'),('Alternativo 4'),
                                         ('Alternativo 5'),('Alternativo 6'),
                                         ('Alternativo 7'),('Alternativo 8'),
                                         ('Alternativo 9'),('Alternativo 10'),
                                         ('Alternativo 11'),('Alternativo 12'),
                                         ('Alternativo 13'),('Alternativo 14'),
                                         ('Alternativo 15'),('Alternativo 16'),
                                         ('Alternativo 17'),('Alternativo 18'),
                                         ('Alternativo 19'),('Alternativo 20');

INSERT INTO AlternativeAttribute(name) values ('Atributo 1'),('Atributo 2'),
                                         ('Atributo 3'),('Atributo 4'),
                                         ('Atributo 5'),('Atributo 6'),
                                         ('Atributo 7'),('Atributo 8'),
                                         ('Atributo 9'),('Atributo 10'),
                                         ('Atributo 11'),('Atributo 12'),
                                         ('Atributo 13'),('Atributo 14'),
                                         ('Atributo 15'),('Atributo 16'),
                                         ('Atributo 17'),('Atributo 18'),
                                         ('Atributo 19'),('Atributo 20');


INSERT INTO AlternativeTitle(titleId,regionId,languageId,alternativeTypeId,
                             alternativeAttributeId,title,ordering,isOriginal)
                             values(1,4,2,1,1,
                                    'Las flipantes patoaventuras de Martin y Wendoly los lavadores de dinero',
                                    'ordering 1',
                                    0),
                                    (2,1,2,2,2,
                                        'El amor del señor egocéntrico y la señorita prejuiciosa',
                                        'ordering 2',0),
                                    (3,2,2,3,3,
                                        'La señorita adelantada a su época y don mentiroso',
                                       'ordering 3',1),
                                    (4,3,3,4,4,'El rey desgraciado y su triste esposa','ordering 4', 1),
                                    (5,11,3,5,5,'La duquesa sad y el duque adultero','ordering 3',0),
                                    (6,16,10,6,6,'La niña llorona y sus patoaventuras','ordering 6',1),
                                    (7,16,10,7,7,'La trágica historia de Dulce Candy', 'ordering 7',0),
                                    (8,3,1,8,8,'La secretaria fea roba pretendientes que se hizo millonaria','ordering 8',1),
                                    (9,5,2,9,9,'La poli sexy y el maje que tiene 20mil contactos para resolver todo','ordering 9',1),
                                    (10,6,6,10,10,'La tipa calenturienta que se folla a todo lo que se mueve','ordering 10',0),
                                    (11,12,5,11,11,'La chava con síndrome estocolmo','ordering 11',1),
                                    (12,10,2,12,12,'La woman tímida que cae a los pies del macho pecho peludo de grey','ordering 11',1),
                                    (13,6,2,13,13,'El vato pilas que siempre se sale con la suya','ordering 12', 1),
                                    (14,4,8,14,14,'La chava con tatuajes cool','ordering 13',1),
                                    (15,11,3,15,15, 'El man que hace todo un vergueo por viajar en el tiempo','ordering 15',1),
                                    (16,16,10,16,16,'El bato que encuentra un libro y se vuelve loco', 'ordering 16',1),
                                    (17,18,8,17,17,'Los flipantes sucesos extraños ocasionados por una niña que fue rata de laboratorio y consiguio poderes','ordering 1',0),
                                    (18,2,2,18,18,'La pelirroja pecosa que no para de hablar pero es adorable','ordering 2',0),
                                    (19,8,9,19,19,'El maestro moribundo que se vuelve capo junto a un drogadicto','ordering 3',1),
                                    (20,10,2,20,20,
                                     'Las tipas estiradas que solo piensan en conseguir marido y los perros que solo piensan en pisto',
                                     'ordering 4',0),
                                    (21,5,2,1,1,'La woman que se vuelve cazadora de sombras y después le salen alas','ordering 5',0),
                                    (22,13,5,2,2,'La ojos de gato que le gusta el ajedrez y embriagarse','ordering 6',1),
                                    (23,17,7,3,3,'Los majes corruptos y el país de las drogas','ordering 7',1),
                                    (24,10,2,4,4,'Las womancitas que tienen deseos de libertad','ordering 8', 1),
                                    (25,10,2,5,5,'La niña que se fue al cielo','ordering 9',0)
                                    ;

INSERT INTO Category(name) values('Categoria 1'),('Categoria 2'),
                                  ('Categoria 3'),('Categoria 4'),
                                  ('Categoria 5'),('Categoria 6'),
                                  ('Categoria 7'),('Categoria 8'),
                                  ('Categoria 9'),('Categoria 10');


INSERT INTO Name(primaryName,birthYear,deathYear)values('Director 1',1972,2018),('Director 2',1959,2010),
                                                       ('Director 3',1965,2020),('Director 4',1961,2012),
                                                       ('Director 5',1970,2019),('Director 6',1956,2011),
                                                       ('Director 7',1967,2017),('Director 8',1959,2009),
                                                       ('Director 9',1968,2018),('Director 10',1954,2017);

INSERT INTO Name(primaryName,birthYear,deathYear)values('Escritor 1',1972,2018),('Escritor 2',1959,2010),
                                                       ('Escritor 3',1965,2020),('Escritor 4',1961,2012),
                                                       ('Escritor 5',1970,2019),('Escritor 6',1956,2011),
                                                       ('Escritor 7',1967,2017),('Escritor 8',1959,2009),
                                                       ('Escritor 9',1968,2018),('Escritor 10',1954,2017);

INSERT INTO Name (primaryName, birthYear) values('Director 11',1980),('Director 12',1968),
                                                 ('Director 13',1971),('Director 14',19568),
                                                 ('Director 15',1983),('Director 16',1967);


INSERT INTO Profession(name) values ('Profesión 1'),('Profesión 2'),('Profesión 3'),
                                    ('Profesión 4'),('Profesión 5'), ('Profesión 6')


INSERT INTO NameProfession(nameId,professionId) values (1,5),(2,1),(3,1),(4,2),(5,6),
                                                       (6,4),(7,2),(8,1),(9,3),(10,2),
                                                       (11,5),(12,5),(13,3),(14,4),(15,6),
                                                       (16,5);
INSERT INTO NameProfession(nameId,professionId) values (17,5),(18,1),(19,1),(20,2),(21,6),
                                                       (22,4),(23,2),(24,1),(25,3),(26,2);

INSERT INTO Principal(nameId,titleId,categoryId,jobId,"order",character)
values(2,1,5,1000,25,'A'),(2,2,1,1001,30,'E'),(1,3,2,1002,40,'F'),
       (1,4,5,1003,19,'A'),(3,5,2,1004,101,'B'),(5,6,6,1005,45,'A'),
       (3,7,3,1006,37,'B'),(6,8,8,1007,39,'A'),(7,9,1,1008,21,'E'),
       (8,10,2,1009,103,'A'),(2,11,7,1010,44,'C'),(9,12,6,1011,74,'A'),
       (2,13,7,1012,65,'D'),(12,14,2,1013,130,'A'),(13,15,5,1014,81,'E'),
       (10,16,5,1015,54,'F'),(11,17,3,1016,1,'D'),(14,18,10,1017,16,'G'),
       (2,19,10,1018,53,'C'),(15,20,8,1019,81,'A'),(2,21,9,1020,41,'F'),
       (15,22,3,1021,7,'E'),(16,23,7,1022,15,'A'),(14,24,8,1023,33,'C'),
        (16,25,6,1024,2,'F');


INSERT INTO Director(nameId,titleId) values(2,1),(2,2),(1,3),(1,4),
                                                (3,5),(5,6),(3,7),(6,8),
                                                (7,9),(8,10),(2,11),(9,12),
(2,13),(12,14),(13,15),(10,16),(11,17),(14,18),(2,19),(15,20),
                                            (2,21),(15,22),(16,23),(14,24),(16,25);

INSERT INTO Writer(nameId,titleId) values(17,1),(18,2),(20,3),(21,4),
                                                (19,5),(18,6),(17,7),(22,8),
                                                (17,9),(18,10),(20,11),(23,12),
(24,13),(25,14),(21,15),(24,16),(23,17),(22,18),(18,19),(17,20),
                                            (24,21),(21,22),(25,23),(23,24),(20,25);

INSERT INTO KnowForTitle(nameId,titleId) values(11,1),(4,2),(20,3),(21,4),
                                                (19,5),(18,6),(17,7),(22,8),
                                                (8,9),(18,10),(2,11),(5,12),
(10,13),(9,14),(21,15),(24,16),(23,17),(9,18),(13,19),(17,20),
                                            (5,21),(1,22),(6,23),(13,24),(7,25);

INSERT INTO Title(primaryTitle,originalTitle, isAdult,startYear,endYear,runtime, titleTypeId)
 values
        ('Azucarada', 'Azucarada',0,2017,2017,127,2),
        ('Blue Cat', 'Blue Cat',0,2017,2017,120,2),
        ('El principio del fin', 'El principio del fin',0,2019,2019,120,2),
        ('Episodio 45 Ozark', 'Episodio 45',0,2019,2019,120,2),
        ('Episodio 46 Ozark', 'Episodio 46',0,2019,2019,120,2),
        ('Episodio 47 Ozark', 'Episodio 47',0,2019,2019,120,2),
        ('Episodio 48 Ozark', 'Episodio 48',0,2019,2019,120,2),
        ('Episodio 49 Ozark', 'Episodio 49',0,2019,2019,120,2),
        ('Episodio 50 Ozark', 'Episodio 50',0,2019,2019,120,2),
        ('Episodio 51 Ozark', 'Episodio 51',0,2019,2019,120,2),
        ('Usagi - Sailor moon', 'Usagi',0,1998,1999,21,1),
        ('Ami', 'Ami',0,1998,1999,21,1),
        ('Rei', 'Rei',0,1998,1999,21,1),
        ('Mascarada', 'Mascarada',0,1998,1999,21,1),
        ('Makoto', 'Makoto',0,1998,1999,21,1),
        ('Tuxedo Mask', 'Tuxedo Mask',0,1998,1999,21,1),
        ('Mamoru Chiba', 'Mamoru Chiba',0,1998,1999,21,1),
        ('Minako', 'Minako',0,1998,1999,21,1),
        ('Serenity', 'Serenity',0,1998,1999,21,1),
        ('Minako', 'Moon',0,1998,1999,21,1),
        ('Capitulo 1', 'Capitulo 1',0,2001,2003,60,2),
        ('Capitulo 2', 'Capitulo 2',0,2001,2003,60,2),
        ('Capitulo 3', 'Capitulo 3',0,2001,2003,60,2),
        ('Capitulo 4', 'Capitulo 4',0,2001,2003,60,2),
        ('Capitulo 5', 'Capitulo 5',0,2001,2003,60,2);

INSERT INTO Episode(titleId,parentId,season,episode) values
                    (26,1,1,1),(27,1,1,2),(28,1,4,1),(29,1,2,1),(30,1,2,2),(31,1,2,3),
                    (32,1,2,4),(33,1,2,5),(34,1,2,6),(35,1,2,7),(36,6,1,1),(37,6,1,2),
                    (38,6,1,3),(39,6,1,4),(40,6,1,5),(41,6,1,6),(42,6,1,7),(43,6,1,8),
                    (44,6,1,9),(45,6,1,10),(46,7,1,1),(47,7,1,2),(48,7,1,3),(49,7,1,4),
                    (50,7,1,5);


INSERT INTO Rating(titleId,averageRating,numVotes) values (1,7.5,140000),
                (2,8.7,180000),(3,9.45,200000),(4,8.17,35000),(5,9.58,41000),(6,9.11,1000000),
                (7,9.46,140000),(8,8.67,540000),(9,7.26,2598000),(10,7.85,4711001),
                (11,6.01,450001), (12,6.98,4152001),(13,8.95,781025),(14,8.12,854120),
                (15,9.12,14510001),(16,8.45,784101),(17,9.15,4512030),(18,9.64,12452001),
                (19,9.96,102100041),(20,7.7,4215422),(21,7.8,52100),(22,9.44,14521400),
                (23,8.5,4121001),(24,8.45,32152512),(25,8.21,441241223);

