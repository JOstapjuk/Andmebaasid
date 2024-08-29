CREATE TABLE auto(
autoID int not null Primary key IDENTITY(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
SELECT * FROM auto
-------------------------------------------------
 
CREATE TABLE mark(
markID int not null Primary key IDENTITY(1,1),
autoMark varchar(30) UNIQUE
);
--------------------------------------------------
INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;
 --------------------------------------------------------
CREATE TABLE kaigukast(
kaigukastID int not null Primary key IDENTITY(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;
-----------------------------------------------------
ALTER TABLE auto
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);
-----------------------------------------------------
insert into auto(regNumber,markID,varv,v_aasta,kaigukastID,km)
Values('BBC065',3,'Valge',2008,2,2500.00)
insert into auto(regNumber,markID,varv,v_aasta,kaigukastID,km)
Values('DFR489',1,'Kollane',1994,2,6000.00)
insert into auto(regNumber,markID,varv,v_aasta,kaigukastID,km)
Values('PLO889',2,'Pruun',2020,1,9500.00)
insert into auto(regNumber,markID,varv,v_aasta,kaigukastID,km)
Values('PRE523',3,'Must',2023,1,3600.00)
insert into auto(regNumber,markID,varv,v_aasta,kaigukastID,km)
Values('JPO365',1,'Valge',2001,2,4500.00)
select * from auto
----------- Loodud tabel amet
Create table amet(
ametID int not null Primary key IDENTITY(1,1),
ametNimi varchar(50));
----------- täitis amet tabeli
Insert into amet(ametNimi)
values ('Transpordiamet Tallinn')
Insert into amet(ametNimi)
values ('Transpordiamet Pärnu')
Insert into amet(ametNimi)
values ('Transpordiamet Tartu')
Insert into amet(ametNimi)
values ('Transpordiamet Narva')
----------------------------------------------------
Create table tootaja(
tootajaID int not null Primary key IDENTITY(1,1),
tootajaNimi varchar(50),
ametID int);
----------------------------------------------
ALTER TABLE tootaja
ADD FOREIGN KEY (ametID) REFERENCES amet(ametID);
-----------------------------------------------
Insert into tootaja(tootajaNimi,ametID)
values('Jake Vaal',2)
Insert into tootaja(tootajaNimi,ametID)
values('Joost Klein',1)
Insert into tootaja(tootajaNimi,ametID)
values('Anastasia Dubrova',4)
Insert into tootaja(tootajaNimi,ametID)
values('Kirill Vasiljev',3)
Insert into tootaja(tootajaNimi,ametID)
values('Vasilisa Molodova',1)
------------------------------------------------
Create table klient(
klientID int not null Primary key IDENTITY(1,1),
kliendiNimi varchar(50),
telefon varchar(20),
aadress varchar (50),
soiduKogemus varchar(20));
--------------------------------------
insert into klient(kliendiNimi,telefon,aadress,soiduKogemus)
values('Anton Vasilyev','+372586841','Heli 6-89','10 aastat')
insert into klient(kliendiNimi,telefon,aadress,soiduKogemus)
values('Vasilisa Moor','+372896112','Valge 4-12','5 aastat')
insert into klient(kliendiNimi,telefon,aadress,soiduKogemus)
values('Raul Pärn','+372115778','Kalevipoja 15-2','20 aastat')
insert into klient(kliendiNimi,telefon,aadress,soiduKogemus)
values('Anastasia Voolo','+372147369','Laagna 30-14','2 aastat')
insert into klient(kliendiNimi,telefon,aadress,soiduKogemus)
values('Emily Roots','+372147896','Paekaare 14-78','4 aastat')
-----------------------------------
Create table rendleping(
lepingID int not null Primary key IDENTITY(1,1),
rendiAlgus date,
rendiLopp date,
klientID int,
regNumber char(6),
rendiKestvus int,
hindKokku decimal(5,2),
tootajaID int);
select * from rendleping
------------------------------------
ALTER TABLE rendleping
ADD FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID);
ALTER TABLE rendleping
ADD FOREIGN KEY (klientID) REFERENCES klient(klientID);
ALTER TABLE rendleping
ADD FOREIGN KEY (regNumber) REFERENCES auto(regNumber);
-----------------------------------
insert into rendleping(rendiAlgus,rendiLopp,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values('2024-08-01','2024-08-08',4,'BBC065',130,160.00,2)
insert into rendleping(rendiAlgus,rendiLopp,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values('2024-08-21','2024-08-31',3,'DFR489',30,60.00,4)
insert into rendleping(rendiAlgus,rendiLopp,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values('2024-08-11','2024-08-31',1,'PLO889',500,360.00,3)
insert into rendleping(rendiAlgus,rendiLopp,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values('2024-09-01','2024-09-08',5,'PRE523',140,230.00,5)
insert into rendleping(rendiAlgus,rendiLopp,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values('2024-08-12','2024-08-16',3,'JPO365',140,90.00,2)
-----------------------------------
select auto.autoID,kaigukast.kaigukast from auto
inner join kaigukast on auto.kaigukastID = kaigukast.kaigukastID;
-----------------------------------
select auto.autoID, tootaja.tootajaNimi, auto.regNumber from auto
inner join rendleping on auto.regNumber = rendleping.regNumber
inner join tootaja on rendleping.tootajaID = tootaja.tootajaID;
---------------------------------
select count(*) as autodeArv, SUM(hindKokku) as summaarneMaksumus from rendleping
-----------------------------------
select klient.kliendiNimi, tootaja.tootajaNimi as Tootaja from klient
inner join rendleping on klient.klientID = rendleping.klientID
inner join tootaja on rendleping.tootajaID = tootaja.tootajaID;
----------------------------------
delete from rendleping where lepingID = 10
----------------------------------
select * from rendleping
----------------------------------
use autorentOstapjuk;
go
create procedure LisaAndmetRendileping
	@uusRendAlgus date,
	@uusKlientID int,
	@uusRegNumber char(6),
	@uusRendiKestvus int,
	@uusHindKokku decimal (5,2),
	@uusTootajaID int
as
begin
insert into rendleping(rendiAlgus,klientID,regNumber,rendiKestvus,hindKokku,tootajaID)
values(@uusRendAlgus,@uusKlientID,@uusRegNumber,@uusRendiKestvus,@uusHindKokku,@uusTootajaID)
select * from rendleping
end;
--------------------
exec LisaAndmetRendileping '2024-06-12', 2, 'FAE456', 140, 450.00, 2