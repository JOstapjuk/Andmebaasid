--35.IndeksidTabelid

select * from DimEmployee where BaseRate > 15 and BaseRate < 25

--Nüüd loome indeksi, mis aitab päringut: Loome indeksi BaseRate veerule.
create index IX_DimEmployee_Salary
on DimEmployee (BASERATE ASC)

--Kui kustutad indeksi, siis täpsusta tabeli nimi.
drop index DimEmployee.IX_DimEmployee_Salary



--36.Klastreeritud_Ja_Mitte-klastreeritud_Indeksid

drop index DimEmployee.PK_DimEmployee_EmployeeKey

--Klastreeritud indeks dikteerib säilitatud andmete järjestuse tabelis ja seda saab klastreeritud puhul olla tabeli peale ainult üks.
create clustered index IX_DimEmployee_Gender_BaseRate
on DimEmployee(Gender Desc,BaseRate Asc)

select * from DimEmployee

--Järgnev kood loob SQL-s mitte-klastreeritud indeksi FirstName veeru järgi tDimEmployee tabelis:
create nonclustered index IX_DimEmployee_FirstName
on DimEmployee(FirstName)



--37.Unikaalne_Ja_Mitte-Unikaalne_Index
--Saame kontrollida seda käsklusega sp_helpindex , mis on süsteemi SP talletatud.
execute sp_helpindex DimEmployee

--Nüüd on Id veerg UNIQUE CLUSTERED INDEX tüüpi ja igasugune katse kopeerida võtmeväärtusi annab veateate:
create table tblEmployee(
Id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50));

execute sp_helpindex tblEmployee

insert into tblEmployee values(1,'Mike','Sandoz',4500,'Male','New York')
insert into tblEmployee values(1,'John','Menco',2500,'Male','London')

drop index tblEmployee.PK__tblEmplo__3214EC07F8C0BBE0

select * from tblEmployee

create unique nonclustered index UIX_tblEmployee_FirstName_LastName
on tblEmployee(FirstName,LastName)


alter table tblEmployee
add constraint UQ_tblEmployee_City
unique nonclustered (City)

execute sp_helpconstraint tblEmployee

create unique index IX_tblEmployee_City
on tblEmployee(City)
with ignore_dup_key



--38.Indeksi plussid ja miinused
--Loo mitte-klastreeritud indeks Salary veerule:
create NonClustered index IX_DimEmployee_BaseRate
on DimEmployee (BaseRate asc)

--Järgnev SELECT päring saab kasu BaseRate veeru indeksist 
select * from DimEmployee where BaseRate > 20 and BaseRate < 25

--Mitte ainult SELECT käsklus, vaid isegi DELETE ja UPDATE väljendid saavad indeksist kasu
delete from DimEmployee where BaseRate = 21.6346
update DimEmployee set BaseRate = 30.0000 where BaseRate = 23.0769

--See välistab päringu käivitamisel ridade sorteerimise, mis oluliselt  suurendab  protsessiaega.
select * from DimEmployee order by BaseRate 

--BaseRate veeru indeks saab aidata ka allpool olevat päringut. Seda tehakse indeksi tagurpidi skanneerimises.
select * from DimEmployee order by BaseRate Desc

--GROUP BY päringud saavad kasu indeksitest. 
select BaseRate, count(BaseRate) as Total
from DimEmployee
group by BaseRate

