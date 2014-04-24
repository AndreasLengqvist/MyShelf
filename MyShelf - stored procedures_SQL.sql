
-- H�mtar och visar alla publiceringar.
ALTER PROCEDURE usp_Get_All_Pub
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
			BEGIN
				BEGIN TRY
					
						SELECT PubID, Publish.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publish INNER JOIN Type
							ON Publish.TypeID=Type.TypeID
						ORDER BY PubDate ASC;
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
END


-- H�mtar och visar en specifik publicering.
ALTER PROCEDURE usp_Get_Spec_Pub
@PubID int = 0
AS   
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
		IF EXISTS(SELECT PubID FROM Publish WHERE PubID=@PubID) OR @PubID = 0
			BEGIN
				BEGIN TRY
					IF EXISTS(SELECT @PubID FROM Publish WHERE PubID=@PubID)
						SELECT PubID, Publish.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publish INNER JOIN Type
							ON Publish.TypeID=Type.TypeID
						WHERE PubID=@PubID
						ORDER BY PubDate ASC;
					ELSE
						SELECT PubID, Publish.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publish INNER JOIN Type
							ON Publish.TypeID=Type.TypeID
						ORDER BY PubDate;
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
		ELSE
		BEGIN
			SET @SetMsg = 'PubID:t finns inte!'
			RAISERROR(@SetMsg, 16, 1)
		END
END




-- Publicera ett verk.
ALTER PROCEDURE usp_Publish
@PubID int output,
@TypeID int = 0,
@Creator varchar(25) = '',
@Email varchar(30) = '',
@Title varchar(40) = '',
@Textfield varchar(2000) = '',
@Filename varchar(50) = ''
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	BEGIN TRY
	
		INSERT INTO 
		Publish (TypeID, Creator, Email, Title, Textfield, Filename)
		
		VALUES 
			 (@TypeID, @Creator, @Email, @Title, @Textfield, @Filename);
		SELECT @PubID = SCOPE_IDENTITY();
		
	END TRY
	BEGIN CATCH
	
		SET @SetMsg = 'Fel intr�ffade vid inl�ggning av publicering!'
		RAISERROR(@SetMsg, 16, 1)
		
	END CATCH
END


EXEC usp_Publish 1, 'Andreas', 'al223bn@student.lnu.se', 'TopGame', 'Hej hej hej...' ,'janne.jpg'





-- Editera en publikation.
CREATE PROCEDURE usp_Edit_Pub
@PubID int = 0,
@TypeID int = 0,
@Creator varchar(25) = '',
@Email varchar(30) = '',
@Title varchar(40) = '',
@Textfield varchar(2000) = '',
@Filename varchar(50) = ''
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
	IF EXISTS(SELECT PubID FROM Publish WHERE PubID=@PubID)
		BEGIN
			BEGIN TRY
			
				UPDATE Publish 
				
				SET 
				TypeID = @TypeID,
				Creator = @Creator,
				Email = @Email,
				Title = @Title,
				Textfield = @Textfield,
				Filename = @Filename
				
				WHERE PubID=@PubID;
				
			END TRY
			BEGIN CATCH
				SET @SetMsg = 'Fel intr�ffade vid editering av vald publicering!'
				RAISERROR(@SetMsg, 16, 1)
			END CATCH
		END
	ELSE
		BEGIN
			SET @SetMsg = 'PubID:t finns inte!'
			RAISERROR(@SetMsg, 16, 1)
		END
END




-- Radera en publikation.
CREATE PROCEDURE usp_Delete_Pub
@PubID int = 0
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
	IF EXISTS(SELECT PubID FROM Publish WHERE PubID=@PubID)
		BEGIN
			BEGIN TRY
				DELETE Publish 
				WHERE PubID=@PubID;
			END TRY
			BEGIN CATCH
				SET @SetMsg = 'Fel intr�ffade vid borttagning av vald publicering!'
				RAISERROR(@SetMsg, 16, 1)
			END CATCH
		END
	ELSE
		BEGIN
			SET @SetMsg = 'PubID:t finns inte!'
			RAISERROR(@SetMsg, 16, 1)
		END
END