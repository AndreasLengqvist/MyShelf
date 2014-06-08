
-- H�mtar och visar alla publiceringar.
CREATE PROCEDURE appSchema.usp_Get_All_Pub
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
			BEGIN
				BEGIN TRY
					
						SELECT PubID, Publication.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publication INNER JOIN Type
							ON Publication.TypeID=Type.TypeID
						ORDER BY PubDate ASC;
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
END


-- H�mtar och visar en specifik publicering.
CREATE PROCEDURE appSchema.usp_Get_Spec_Pub
@PubID int = 0
AS   
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
		IF EXISTS(SELECT PubID FROM Publication WHERE PubID=@PubID) OR @PubID = 0
			BEGIN
				BEGIN TRY
					IF EXISTS(SELECT @PubID FROM Publication WHERE PubID=@PubID)
						SELECT PubID, Publication.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publication INNER JOIN Type
							ON Publication.TypeID=Type.TypeID
						WHERE PubID=@PubID
						ORDER BY PubDate ASC;
					ELSE
						SELECT PubID, Publication.TypeID, Creator, Email, Title, Textfield, Filename, PubDate
						FROM Publication INNER JOIN Type
							ON Publication.TypeID=Type.TypeID
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
CREATE PROCEDURE appSchema.usp_Publish
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
		Publication (TypeID, Creator, Email, Title, Textfield, Filename)
		
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
CREATE PROCEDURE appSchema.usp_Edit_Pub
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
	
	IF EXISTS(SELECT PubID FROM Publication WHERE PubID=@PubID)
		BEGIN
			BEGIN TRY
			
				UPDATE Publication 
				
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
CREATE PROCEDURE appSchema.usp_Delete_Pub
@PubID int = 0
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
	IF EXISTS(SELECT PubID FROM Publication WHERE PubID=@PubID)
		BEGIN
			BEGIN TRY
				DELETE Publication 
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


-- H�mtar alla typer.
CREATE PROCEDURE appSchema.usp_Get_All_Type
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
			BEGIN
				BEGIN TRY
					
						SELECT TypeID, Type
						FROM Type
						ORDER BY Type;
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
END


-- Procedur f�r inloggning av administrat�r.
ALTER PROCEDURE appSchema.usp_AdminLogin
@Username varchar(50),
@Hash varchar(500)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
			BEGIN
				BEGIN TRY
					
						SELECT Username
						FROM Admin
						WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS AND Hash = @Hash COLLATE SQL_Latin1_General_CP1_CS_AS;
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
END


-- H�mtar  Salt
CREATE PROCEDURE appSchema.usp_GetSalt
@Username varchar(50) = ''
AS   
BEGIN
	SET NOCOUNT ON;
	DECLARE @Setmsg varchar(40) = ''
	
		IF EXISTS(SELECT Username FROM Admin WHERE Username=@Username)
			BEGIN
				BEGIN TRY
					IF EXISTS(SELECT @Username FROM Admin WHERE Username=@Username)
						SELECT Salt
						FROM Admin
						WHERE Username=@Username
				END TRY
				BEGIN CATCH
					SET @SetMsg = 'Fel vid k�rning av proceduren!'
					RAISERROR(@SetMsg, 16, 1)
				END CATCH
			END
		ELSE
		BEGIN
			SET @SetMsg = 'The Username does not exists!'
			RAISERROR(@SetMsg, 16, 1)
		END
END