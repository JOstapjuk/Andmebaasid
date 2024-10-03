--Tabeli loomine
create table tableA (
id int primary key,
Name nvarchar(50),
Gender nvarchar(10));

--Tabeli täitmine andmetega
insert into tableA values (1,'Mark','Male')
insert into tableA values (2,'Mary','Female')
insert into tableA values (3,'Steve','Male')
insert into tableA values (4,'John','Male')
insert into tableA values (5,'Sara','Female')

--Tabeli loomine
create table tableB (
id int primary key,
Name nvarchar(50),
Gender nvarchar(10));

--Tabeli täitmine andmetega
insert into tableB values (4,'John','Male')
insert into tableB values (5,'Sara','Female')
insert into tableB values (6,'Pam','Female')
insert into tableB values (7,'Rebeca','Female')
insert into tableB values (8,'Jordan','Male')


--väljastab andmeid, mis on unikaalsed ainult tabeli A jaoks, st korduvaid andmeid ja unikaalseid andmeid tabelist B ei ole
select id,Name,Gender
from tableA
except
select id,Name,Gender
from tableB


select * from DimEmployee


--võtab välja kõik andmed BaseRate'i kohta 16-20 (välja arvatud 20)
select EmployeeKey,FirstName,Gender,BaseRate
from DimEmployee
where BaseRate>=16
except
select EmployeeKey,FirstName,Gender,BaseRate
from DimEmployee
where BaseRate>=20