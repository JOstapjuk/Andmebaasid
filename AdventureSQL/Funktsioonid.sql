--32.funktsioonid
--Tabelisiseväärtusega funktsioon e Inline Table Valued function (ILTVF) koodinäide:
create function fn_ILTVF_GetEmployees()

returns table
as
Return(select EmployeeKey,FirstName,BirthDate as DOB 
from DimEmployee)

--Mitme avaldisega tabeliväärtusega funktsioonid e multi-statement table valued function (MSTVF):
create function fn_MSTVF_GetEmployees()

returns @Table Table (Id int,FirstName nvarchar(20),DOB Date)
as
Begin
insert into @Table
select EmployeeKey,FirstName,BirthDate
from DimEmployee

return
end

--Kui nüüd soovid mõlemat funktsiooni esile kutsuda, siis kasutad koodi:

Select * from fn_ILTVF_GetEmployees()
Select * from fn_MSTVF_GetEmployees()

--33. funktsioonid
--Skaleeritav funktsioon ilma krüpteerimata:
create function fn_GetEmployeeNameById (@Id int)

returns nvarchar(20)
as
begin
Return (select FirstName from DimEmployee where EmployeeKey = @Id)
end

--Nüüd muudame funktsiooni ja krüpteerime selle ära:
alter function fn_GetEmployeeNameById (@Id int)

returns nvarchar(20)
as
begin
Return (select FirstName from DimEmployee where EmployeeKey = @Id)
end

--Nüüd muuda funktsiooni ja kasuta käsklust WITH SCHEMABINDING valikut.
alter function fn_GetEmployeeNameById (@Id int)
returns nvarchar(20)
with SchemaBinding
as
begin
    return (
        select FirstName 
        from dbo.DimEmployee 
        where EmployeeKey = @Id
    )
end


--34.Ajutised tabelid
--#PersonDetails on local temporary tabel koos Id ja Name veeruga.
--Sisesta andmed ajutisse tabelisse:
Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1,'Mike')
insert into #PersonDetails values(2,'John')
insert into #PersonDetails values(3,'Todd')

--Need luuakse TEMPDB alla. Päri sysobjects käsuga TEMPDB alt. 
SELECT name 
FROM tempdb.sys.objects
WHERE name LIKE '#PersonDetails%';

--Kui ajutine tabel on loodud SP sees, siis see kustutakse peale SP lõpuleviimist automaatselt ära. Allpool olevas SP-s luuakse ajutine tabel #PersonsDetails ja edastab andmeid ja lõhub ajutise tabeli automaatselt peale käsu lõpule jõudmist.
create procedure spCreateLocalTempTable

as
begin
Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1,'Mike')
insert into #PersonDetails values(2,'John')
insert into #PersonDetails values(3,'Todd')

select * from #PersonDetails
end

--Selleks tuleb tuleb ajuitse tabeli ette panna kaks # märki. EmployeeDetails table on globaalne ajutine tabel.

Create Table ##PersonDetails(Id int, Name nvarchar(20))


