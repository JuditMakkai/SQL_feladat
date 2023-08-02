
CREATE  PROCEDURE [dbo].[SP_REFUELING_DATA_GEN] (@PlateNr varchar(50), @Date_from date, @Date_to date, @Intensity int)
AS
DECLARE @VehicleID int
DECLARE @PersonID int
DECLARE @I int = 0
DECLARE @J int 
DECLARE @K int = 7
DECLARE @RAND int = 0
DECLARE @Date_gen date
DECLARE @Amount_gen DECIMAL(18,2)
DECLARE @StartDate date = @Date_from

BEGIN
	SET @VehicleID = (SELECT TOP 1 ID from Vehicle WHERE PlateNr = @PlateNr)
	IF @VehicleID is not null
	BEGIN

		 IF @Intensity = 1 SET @K = 7
		 IF @Intensity = 2 SET @K = 30
		 IF @Intensity = 3 SET @K = 91

		 SET @J = ceiling(DATEDIFF(day,@Date_from, @Date_to) / @K)
		 SET @VehicleID = (SELECT TOP 1 ID from Vehicle WHERE PlateNr = @PlateNr)
		 SET @PersonID = (SELECT OwnerPersonID from Vehicle WHERE ID = @VehicleID)

		 WHILE  (  @I<= @J )
			  BEGIN
			   
				SET @Date_gen = (SELECT DATEADD(DAY, floor(rand()*7 - 3),@StartDate))
				IF @Date_gen < @Date_from SET @Date_gen = @Date_from
				IF @Date_gen > @Date_to SET @Date_gen = @Date_to

				SET @Amount_gen = (SELECT CONVERT( DECIMAL(18, 2), 10 + (30-10)*RAND(CHECKSUM(NEWID()))))
				INSERT INTO Refueling (VehicleID, PersonID, RefuelingDate, Amount) values (@VehicleID,@PersonID,@Date_gen,@Amount_gen)
			 
				 SET @I = @I + 1;
				 SET @StartDate = (SELECT DATEADD(DAY, @k,@StartDate))
                     
			  END;
	END

END

GO


