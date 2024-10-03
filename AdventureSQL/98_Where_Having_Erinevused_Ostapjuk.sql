
--Tabeli loomine
create table Sales (
product nvarchar(50),
SaleAmount int);

--Tabeli t‰itmine andmetega

insert into Sales values ('iPhone',500)
insert into Sales values ('Laptop',800)
insert into Sales values ('iPhone',1000)
insert into Sales values ('Speakers',400)
insert into Sales values ('Laptop',600)


--Selleks, et arvutada kogu m¸¸ki toote pealt, siis peame kirjutama GROUP BY p‰ringu:
select product, sum(SaleAmount) as TotalSales
from Sales
group by product


--Kui soovime ainult neid tooteid, kus m¸¸k kokku on suurem kui 1000Ä, siis kasutame filtreerimaks tooteid HAVING tingimust.
select product,sum(SaleAmount) as TotalSales
from Sales
group by product
Having sum(SaleAmount) > 1000


--Error - Incorrect syntax near the keyword 'where'.
--Pıhjuseks on WHERE-i mitte tˆˆtamine kokku arvutava funktsiooniga, mis sisaldab SUM, MIN, MAX, AVG jne
select product,sum(SaleAmount) as TotalSales
from Sales
group by product
where sum(SaleAmount) > 1000


--p‰rib kıik read Sales tabelis, mis n‰itavad summat ning eemaldavad kıik tooted peale iPhone-i ja Speakerite.
select product,sum(SaleAmount) as TotalSales
from Sales
where product in('iPhone','Speakers')
group by product


--samasugune p‰ring aga Havingéga 
select product,sum(SaleAmount) as TotalSales
from Sales
group by product
having product in('iPhone','Speakers')


