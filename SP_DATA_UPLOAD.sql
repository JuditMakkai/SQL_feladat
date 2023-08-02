
CREATE  PROCEDURE [dbo].[SP_DATA_UPLOAD] 
AS
DECLARE @VehicleID int
DECLARE @PersonID int
DECLARE @I int = 1
DECLARE @J int = 1
DECLARE @RAND int = 0
DECLARE @PlateNr_gen VARCHAR(6)
DECLARE @Date_gen date
DECLARE @Amount_gen DECIMAL(18,2)
DECLARE @StartDate date = '2017.01.01'
DECLARE @EndDate date = '2018.12.31'

DECLARE @BrandsTable TABLE (number int, brand VARCHAR(50), type VARCHAR(50))

INSERT INTO @BrandsTable   SELECT 1, 'Alfa Romeo','Brera'      UNION ALL SELECT 2, 'Mercedes', 'EQC'
	UNION ALL SELECT 3, 'Ford','S Max'			  UNION ALL SELECT 4, 'Audi', 'A8'
	UNION ALL SELECT 5, 'Ford','C Max'			  UNION ALL SELECT 6, 'Honda', 'CRV'
	UNION ALL SELECT 7, 'Ferrari','Testarossa'    UNION ALL SELECT 8, 'Lancia', 'Ypsilon'
	UNION ALL SELECT 9, 'Chevrolet', 'Captiva'	  UNION ALL SELECT 10, 'Lancia', 'Delta'

BEGIN
	

    WHILE  (  @I<= 20 )
         BEGIN

		 INSERT INTO Person (LastName, FirstName) values('Lastname' + convert(nvarchar(2),@I),'Firstname' + convert(nvarchar(2),@I)) 

		SET @PersonID  = (SELECT IDENT_CURRENT ('Person') )

			 SET @RAND = (SELECT floor(rand()*9 + 1))
			 SET @PlateNr_gen = (select char((rand()*2 + 65))+char((rand()*25 + 65))) + convert(nvarchar(4),(SELECT floor(rand()*8999 + 1000)))
             INSERT INTO Vehicle (Type,Brand, PlateNr,OwnerPersonID) 
					values ((SELECT type from @BrandsTable where number = @RAND),(SELECT brand from @BrandsTable where number = @RAND),
						 @PlateNr_gen,@PersonID)        
						 
			SET @VehicleID  = (SELECT IDENT_CURRENT ('Vehicle') )

			INSERT INTO HasLicence (PersonID, VehicleID) values (@PersonID, @VehicleID)

			SET @RAND = (SELECT floor(rand()*3 + 1))
			SET @J = 1
			WHILE  (  @J<= @RAND )
				BEGIN
					SET @Date_gen = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate))
					SET @Amount_gen = (SELECT CONVERT( DECIMAL(18, 2), 10 + (30-10)*RAND(CHECKSUM(NEWID()))))
					INSERT INTO Refueling (VehicleID, PersonID, RefuelingDate, Amount) values (@VehicleID,@PersonID,@Date_gen,@Amount_gen)

					SET @J = @J + 1
				END;

			 IF @I % 2 = 1
			 BEGIN
				INSERT INTO Person (LastName, FirstName) values('Lastname' + convert(nvarchar(2),@I + 20),'Firstname' + convert(nvarchar(2),@I+20)) 
				SET @PersonID  = (SELECT IDENT_CURRENT ('Person') )
				INSERT INTO HasLicence (PersonID, VehicleID) values (@PersonID, @VehicleID)

				 IF @I % 4 = 1
					BEGIN
						SET @Date_gen = (SELECT DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate))
						SET @Amount_gen = (SELECT CONVERT( DECIMAL(18, 2), 10 + (30-10)*RAND(CHECKSUM(NEWID()))))
						INSERT INTO Refueling (VehicleID, PersonID, RefuelingDate, Amount) values (@VehicleID,@PersonID,@Date_gen,@Amount_gen)
					END;
			 END;

         SET @I = @I + 1;
                     
         END;




END

GO


