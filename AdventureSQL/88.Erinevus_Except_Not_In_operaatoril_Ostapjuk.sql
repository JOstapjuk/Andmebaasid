
--Tabeli loomine
create table tableA (
id int primary key,
Name nvarchar(50),
Gender nvarchar(10));

--Tabeli täitmine andmetega
insert into tableA values (1,'Mark','Male')
insert into tableA values (2,'Mary','Female')
insert into tableA values (3,'Steve','Male')

--Tabeli loomine
create table tableB (
id int primary key,
Name nvarchar(50),
Gender nvarchar(10));

--Tabeli täitmine andmetega
insert into tableB values (2,'Mary','Female')
insert into tableB values (3,'Steve','Male')

----väljastab andmeid, mis on unikaalsed ainult tabeli A jaoks(1,Mark,Male), st korduvaid andmeid ja unikaalseid andmeid tabelist B ei ole väljastab
select id,Name,Gender from tableA
except
select id,Name,Gender from tableB

--võtab andmed välja vastavalt ID-le ehk kui ID tabelis A ei ole tabelis B siis võetakse see välja
select id,Name,Gender from tableA
where id not in (select id from tableB)

insert into tableA values (1,'Mark','Male')

--ei ole midagi muutunud eelmisest päringusest
select id,Name,Gender from tableA
except
select id,Name,Gender from tableB

--Toob välja kaks andmestikku ehk kaks Marki, sest ID on neil ühesugune
--EXCEPT operaator  ootab sama arvu veerge mõlemas päringus ja NOT IN ei oota seda. NOT IN võrdleb üksikut veergu välisest päringust koos üksiku veeruga alampäringust.
select id,Name,Gender from tableA
where id not in (select id from tableB)

--Error - All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
--EXCEPT operaatoril peab olema võrdne arv väljendeid
select id,Name,Gender from tableA
except
select id,Name from tableB

--Error - Only one expression can be specified in the select list when the subquery is not introduced with EXISTS.
-- NOR IN võib olla ainult üks väljend
select id,Name,Gender from tableA
where id not in (select id, Name from tableB)