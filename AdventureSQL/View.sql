--39.View_SQL_Serveris
--
select EmployeeKey,FirstName,BaseRate,Gender,DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

--Nüüd loome view, kus kasutame JOIN-i:
create view vWEmployeesByDepartment
as
select EmployeeKey,FirstName,BaseRate,Gender,DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

select * from vWEmployeesByDepartment

--View, mis tagastab ainult Quality Assurance osakonna töötajad:
create view vWQualityAssurance_Employees
as
select EmployeeKey,FirstName,BaseRate,Gender,DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
where DimDepartmentGroup.DepartmentGroupName = 'Quality Assurance'

select * from vWQualityAssurance_Employees

--View, kus ei ole BaseRate veergu:
create view vWEmployeesNonConfidentialData
as
select EmployeeKey,FirstName,Gender,DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

select * from vWEmployeesNonConfidentialData

--View, mis tagastab summeeritud andmed töötajate koondarvest.
create view vWEmployeesCountByDepartment
as
select DepartmentName, count(EmployeeKey) as TotaleEmployees
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
group by DepartmentName

select * from DimEmployee

--40.View_Uuendused
--tagastab peaaegu kõik veerud, aga va Salary veerg.
create view vWEmployeeDataExceptSalary
as
select EmployeeKey,FirstName,Gender,DepartmentName
from DimEmployee

select * from vWEmployeeDataExceptSalary

--Järgnev päring uuendab Name veerus olevat nime Kevin peale.
update vWEmployeeDataExceptSalary
set FirstName = 'Mikey' where EmployeeKey = 2

--Samas on võimalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.
delete from vWEmployeeDataExceptSalary where EmployeeKey = 2

insert into vWEmployeeDataExceptSalary values(2,'Mikey','M','Marketing')

--Loome view, mis ühendab kaks eelpool käsitletud tabelit ja annab sellise tulemuse:
create view vwEmployeeDetailsByDepartment
as
select EmployeeKey,FirstName,BaseRate,Gender,DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

select * from vwEmployeeDetailsByDepartment

--Nüüd uuendame Peng osakonda Qualiti Assurance pealt Research and Development peale.
update vwEmployeeDetailsByDepartment
set DepartmentName = 'Research and Development' where FirstName = 'Peng'