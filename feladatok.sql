-- 3.1
select LastName, FirstName, Type, Brand, PlateNr
from Person
inner join Vehicle on Vehicle.OwnerPersonID = Person.ID
--3.2
select LastName, FirstName, Type, Brand, PlateNr
from Person
inner join HasLicence on HasLicence.PersonID = Person.ID
left join Vehicle on Vehicle.ID = HasLicence.VehicleID

--3.3
select Type, Brand, PlateNr, LastName,FirstName
from Vehicle
cross join Person
where  not exists (select ID from HasLicence where PersonID = Person.ID and VehicleID = Vehicle.ID)

--3.4
select RefuelingDate, Amount, Type, Brand, PlateNr, LastName, FirstName
from Refueling
left join Vehicle on Vehicle.ID = Refueling.VehicleID
left join Person on Person.ID = Refueling.PersonID
where Vehicle.OwnerPersonID <> Refueling.PersonID

--3.5
select RefuelingDate, Amount, Type, Brand, PlateNr, LastName, FirstName
from Refueling
left join Vehicle on Vehicle.ID = Refueling.VehicleID
left join Person on Person.ID = Refueling.PersonID
where  Refueling.PersonID not in (select PersonID from HasLicence where HasLicence.VehicleID = Refueling.VehicleID)

--3.6
select Type, Brand, PlateNr,  datepart(year,RefuelingDate) as Év ,sum(Amount) as Összeg
from Refueling
left join Vehicle on Vehicle.ID = Refueling.VehicleID
group by Type, Brand, PlateNr, datepart(year,RefuelingDate)

--3.7
select TOP 1 Type, Brand, PlateNr,  datepart(year,RefuelingDate) as Év ,sum(Amount) as Összeg
from Refueling
left join Vehicle on Vehicle.ID = Refueling.VehicleID
where datepart(year,RefuelingDate) = 2017
group by Type, Brand, PlateNr, datepart(year,RefuelingDate)
order by 5 desc

--3.8
select LastName, FirstName, Type, Brand, PlateNr
from Refueling
left join Vehicle on Vehicle.ID = Refueling.VehicleID
left join Person on Person.ID = Refueling.PersonID
where  Refueling.PersonID <> Vehicle.OwnerPersonID