#kormanyzasi formak
select distinct GovernmentForm 
from country;

#kontinensek
select distinct Continent
from country;

#melyik orszagok vannak antarktiszon
select Name
from country
where Continent = 'Antarctica';

#10 legkisebb nepessegu orszag
select c.Name, c.Population 
from country c 
order by c.Population asc
limit 10;

#hany orszag van europaban
select count(c.Name) 
from country c
where c.Continent = 'Europe';

#torpeallamok europaban
select c.Name
from country c
where c.Continent = 'Europe'
	and c.SurfaceArea < 1000;

#torpeallamok NEM europaban
select c.Name, c.SurfaceArea  , c.Continent 
from country c
where c.Continent != 'Europe'
	and c.SurfaceArea < 1000;

#a vilag torpeallamainak hany %-a van
#Europaban
select (select count(c.Name)
from country c
where c.Continent = 'Europe'
	and c.SurfaceArea < 1000)
/
(select count(c.Name)
from country c
where c.SurfaceArea < 1000)*100 szazalek;

#hany ember el a foldon
select sum(c.Population) `Ember el a foldon`
from country c;

#hany ember el a foldon kontinensenkent
select c.Continent, sum(c.Population) as Population
from country c 
group by c.Continent;

#orszagonkent hany varos van
select co.Name as Orszag, count(ci.Name) as VarosokSzama
from country co 
	inner join City ci on ci.CountryCode = co.Code
group by co.Name
order by varosokszama desc;

#atlagosan hany varos van egy orszagban
select avg(s1.varosokszama)
from (select co.Name as Orszag, count(ci.Name) as VarosokSzama
from country co 
	inner join City ci on ci.CountryCode = co.Code
group by co.Name
) as s1;

#hany magyar el a foldon
select language,
	sum(c.Population*cl.Percentage/100) as beszelokSzama
from countrylanguage cl
	inner join country c on c.Code = cl.CountryCode 
where language = 'hungarian';

#melyik nyelvet beszelik a legtobben a vilagon
select cl.language,
	sum(c.Population*cl.Percentage/100) as beszelokSzama
from countrylanguage cl
	inner join country c on c.Code = cl.CountryCode 
group by cl.language
order by beszelokszama desc;

#Europai varosok tobb mint 1000000 lakossal
select c.Continent , ci.Name , ci.Population 
from city ci
	inner join country c on c.Code = ci.CountryCode
where c.Continent = 'Europe' and ci.Population > 1000000
order by c.Population desc;

#Beszelt nyelvek kontinensenkent
select c.Continent, count(cl.Language) as beszelltNyelvek
from countryLanguage cl
	inner join country c on cl.countryCode = c.Code 
group by continent;

#Kontinensenkent a legelterjedtebb nyelv
#1. megoldas: temporary table
drop temporary table if exists nyelviadatok;

create temporary table nyelviadatok as
select 
    c.continent, 
    cl.language, 
    sum(c.population * cl.percentage / 100) as beszelok
from countrylanguage cl
	join country c on c.code = cl.countrycode
group by c.continent, cl.language;

select 
    n.continent, 
    n.language, 
    n.beszelok
from nyelviadatok n
join (
    select 
        continent, 
        max(beszelok) as max_beszelok
    from nyelviadatok
    group by continent
) m
  on n.continent = m.continent 
 and n.beszelok = m.max_beszelok
order by n.continent;

#2. megoldas: with
WITH nyelviadatok AS (
    SELECT 
        c.continent, 
        cl.language, 
        SUM(c.population * cl.percentage / 100) AS beszelok
    FROM countrylanguage cl
    JOIN country c ON c.code = cl.countrycode
    GROUP BY c.continent, cl.language
),
maxnyelvek AS (
    SELECT 
        continent, 
        MAX(beszelok) AS max_beszelok
    FROM nyelviadatok
    GROUP BY continent
)
SELECT 
    n.continent, 
    n.language, 
    n.beszelok
FROM nyelviadatok n
JOIN maxnyelvek m 
    ON n.continent = m.continent 
   AND n.beszelok = m.max_beszelok
ORDER BY n.continent;

#Orszagonkent a legnepesebb varosok
WITH legnepesebb AS (
    SELECT ct.CountryCode MAX(ct.Population) AS maxpop
    FROM city ct
    GROUP BY ct.CountryCode
)
SELECT c.Name AS Orszag, ct.Name AS Varos, ct.Population
FROM legnepesebb l
JOIN country c ON c.Code = l.CountryCode
JOIN city ct ON ct.CountryCode = l.CountryCode
              AND ct.Population = l.maxpop;

#Legnépesebb ország minden kontinensen
SELECT c1.Continent, c1.Name, c1.Population
FROM country c1
WHERE c1.Population = (
    SELECT MAX(c2.Population)
    FROM country c2
    WHERE c2.Continent = c1.Continent
)
ORDER BY c1.Continent;

#Mely országok fővárosa azonos a saját nevükkel azonos?
SELECT c.Name AS Orszag, ci.Name AS Fovaros
FROM country c
JOIN city ci ON ci.ID = c.Capital
WHERE c.Name = ci.Name;

#Átlagos országméret kontinensenként
SELECT Continent, AVG(SurfaceArea) AS AtlagTerulet
FROM country
GROUP BY Continent
ORDER BY AtlagTerulet DESC;

#Legmagasabb népsűrűségű országok
SELECT Name, Population / SurfaceArea AS Nepsuruseg
FROM country
WHERE SurfaceArea > 0
ORDER BY Nepsuruseg DESC
LIMIT 5;

#Legalacsonyabb népsűrűségű országok
SELECT Name, Population / SurfaceArea AS Nepsuruseg
FROM country
WHERE SurfaceArea > 0
ORDER BY Nepsuruseg ASC
LIMIT 5;

#A legnépesebb város a világon és az ország, ahol található
SELECT ci.Name AS Varos, c.Name AS Orszag, ci.Population
FROM city ci
JOIN country c ON ci.CountryCode = c.Code
ORDER BY ci.Population DESC
LIMIT 1;

#Országok, ahol több mint 5 nyelvet beszélnek
#1. modszer: with
with nyelvekszama AS(
select 
cl.CountryCode,count(cl.Language) SZAM
from countrylanguage cl
group by cl.CountryCode)
select C.NAME,N.SZAM
from country c
	inner join nyelvekszama n on n.countrycode=c.Code
where n.szam>=5
order by n.szam desc

#2. modszer: HAVING
select 
c.Name,count(cl.Language) SZAM
from countrylanguage cl
	inner join country c on cl.countrycode=c.Code
group by cl.CountryCode
having szam>=5
order by szam desc

#legtobb nyelvet beszelok orszagai
with nyelvekszama AS(
select 
cl.CountryCode,count(cl.Language) SZAM
from countrylanguage cl
group by cl.CountryCode)
select C.NAME,N.SZAM
from country c
	inner join nyelvekszama n on n.countrycode=c.Code
where n.szam=
(select max(SZAM)
from nyelvekszama)

#Mely orszagokban el legalabb annyi mint a vilag nepessegenek egy szazaleka
select c.Name ,c.Population 
from country c 
where c.Population >
(select sum(c.Population)*0.01
from country c )

