/* Names:
	Gil Zeevi ID 203909320
	Joel Liurner ID 346243579
*/

use world;
select * from country;
select * from countrylanguage;
select * from city;
/* q1 */

/* Retrieve all continents: */
Select distinct continent from country;

/* how many of them: */
select  COUNT(distinct continent) from country;

/* q2 */
/* Retrieve the countries that are from South America? */
select name from country where continent = 'south America';
/* How many countries are there? ? */
select count(name) from country where continent = 'south America';

/* q3 */
/* Retrieve the names of 10 countries with the highest life expectancy */
select name from country
order by LifeExpectancy DESC
Limit 10;

/* q4 */
/*In how many countries only one language is used by its entire population?*/

/*Assumption: 100.0 percentage from countrylanguage table means there is only 1 spoken language */

select count(CountryCode)
from countrylanguage
where Percentage > 99.9;

/* q5 */
/* Retrieve the languages that are dominant in any country (i.e. there is a country where its entire population speak only this language) */
/*Assumption: dominant language is where  percentage from countrylanguage table is 100% */
select distinct Language
from countrylanguage
where Percentage > 99.9;

/* How many such languages are there? */
select count(distinct Language)
from countrylanguage
where Percentage > 99.9;

/* q6 */
/*Retrieve a sorted list of countries that got independent during decade of the 1980s*/
select Name
from country
where IndepYear> 1979 and IndepYear < 1990
ORDER BY Name ASC;

/* How many such countries are there?*/
select count(Name)
from country
where IndepYear> 1979 and IndepYear < 1990;

/* q7 */
/*What are the names of the 5 cities with the lowest population? */
/*Assumption: we have countries with 0 population but we assume that you meant to inspect cities from city table */
select name,population
from city
order by Population asc
Limit 5;

/* q8 */
/*List the countries located in America (either north or south) which are not republic.*/
/*Assumption: federal republic means also republic to us hence we will refer it as also republic */

select name ,region,GovernmentForm 
from country
where (GovernmentForm !='republic') and (GovernmentForm !='Federal Republic') and (region = 'North america' or region = 'south america');

/* q9 */

/*Examine the country table, how many countries are not independent? */

/* assumption: if independence year is null hence the country is not independent*/
select count(name)
from country
where  IndepYear is null;

/*How many countries have a strange IndepYear value?*/
/*answer: we have 47 countries with null as IndepYear hence we say they are not indepndent*/

/* note: we have 3 countries with negative IndepYear which those are believed to be established Before Count (BC)*/

/* What query did you use? Explain your answer.*/
/* answer: we queried the null instances excplicitly to find the non independent countries

/* q10 */
/* Which countries with population over 100,000,000 are Constitutional Monarchy? */
select name,population,GovernmentForm
from country
where  population > 100000000 and GovernmentForm = 'Constitutional Monarchy';

/* q11 */

use sakila;
/* q11/a */

SELECT count(*) 
FROM information_schema.tables
where table_schema = 'sakila';
/* q11/b*/

select first_name,last_name
from staff;
/* q11/b*/

select title 
from film
where length > 180;
