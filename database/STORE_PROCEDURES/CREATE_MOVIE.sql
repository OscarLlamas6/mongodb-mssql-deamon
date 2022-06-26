USE [NETFLIX]
GO;

CREATE OR ALTER PROCEDURE insertData @primaryTitle nvarchar(50),
                                     @originalTitle nvarchar(50),
                                     @isAdult bit,
                                     @startYear nvarchar(50),
                                     @endYear nvarchar(50),
                                     @runtime nvarchar(50)
AS

    BEGIN TRANSACTION ADD_MOVIE
        begin try
            DECLARE @idIMDB int;
            DECLARE @idTitle int;

            -- SELECCIONAMOS EL ID DE LA PELÍCULA DE LA BASE DE DATOS DE IMDB PARA ENLAZARLA CON LA DE NETFLIX
            SET @idIMDB = (SELECT imdb.id
                           FROM [IMDB_SERVER].[IMDB].[dbo].Title as imdb
                           where imdb.primaryTitle = @primaryTitle
                             and imdb.originalTitle = @originalTitle
                             and imdb.isAdult = @isAdult
                             and imdb.startYear = @startYear
                             and imdb.endYear = @endYear
                             and imdb.runtime = @runtime);

            -- PARA PREVENIR RESULTADOS EXTRA QUE INTERFIERAN CON EL SELECT
            SET NOCOUNT ON;

            -- SI NO EXISTE LA PELÍCULA BUSCA EN LA BASE DE DATOS IMDB E INSERTA EN NETFLIX 
            IF NOT EXISTS(SELECT idIMDB
                      FROM Title
                      where idIMDB = @idIMDB)
                begin
                    -- INSERTAMOS EL TITULO QUE SE ENCONTRÓ EN LA BD DE IMDB
                    insert into [dbo].Title(primaryTitle, originalTitle, isAdult, startYear, endYear,                        runtime, idIMDB)
                    values (@primaryTitle, @originalTitle, @isAdult, @startYear, @endYear, @runtime, @idIMDB);

                    PRINT N'NUEVA PELI CREADA';

                    -- OBTENIENDO EL ID DEL ÚLTIMO TITULO INSERTADO.
                    SET @idTitle = SCOPE_IDENTITY();

                    -- INSERTAMOS EN EL DETALLE DE TitleGenre en base a lo que se encontró en la base de datos IMDB
                    INSERT INTO TitleGenre(genreId, titleId)
                    SELECT Genre.id, @idTitle
                    FROM Genre
                    where name IN
                          (SELECT G.name
                           FROM [IMDB_SERVER].[IMDB].[dbo].Genre G
                                    inner join [IMDB_SERVER].[IMDB].[dbo].TitleGenre TG on G.id = TG.genreId
                           where TG.titleId = @idIMDB);

                    PRINT N'NUEVO GENERO CREADO';

                    -- INSERTAMOS EN EL DETALLE DE DIRECTOR EN BASE A LO QUE SE ENCONTRÓ EN LA BASE DE DATOS DE IMDB
                    INSERT INTO Director(titleId, nameId)
                    SELECT @idTitle, nam.id
                    FROM Name nam
                    where nam.primaryName IN
                          (SELECT n.primaryName
                           FROM [IMDB_SERVER].[IMDB].[dbo].Name N
                                    inner join [IMDB_SERVER].[IMDB].[dbo].Director D on N.id = D.nameId
                           where D.titleId = @idIMDB);
                    PRINT N'NUEVO DIRECTOR CREADO';

                    -- INSERTAMOS EN LA TABLA EPISODIO SI SE ENCUENTRA EL PADRE EN LA TABLA TITLE DE NETFLIX
                    INSERT INTO Episode(season, episode, titleId, parentId)
                    SELECT epic.season, epic.episode, @idTitle, tt.id
                    FROM (SELECT epi.season, epi.episode, epi.parentId
                          FROM [IMDB_SERVER].[IMDB].[dbo].Episode epi
                          where epi.titleId = @idIMDB) epic,
                         Title tt
                    where tt.idIMDB = epic.parentId;
                end
            COMMIT TRANSACTION
        end try
        begin catch
            EXECUTE usp_GetErrorInfo;
            ROLLBACK TRANSACTION
        end catch


GO;

SELECT *
FROM Title;
select *
FROM TitleGenre;
select *
from Director;
select *
from Episode;
EXEC insertData 'Ozark', 'Ozark', 0, 2017, 2022, 60;
EXEC insertData 'Orgullo y prejuicio', 'Pride and prejudice', 0, 2005, 2005, 127;
EXEC insertData 'La otra reina', 'La otra reina',1,2008,2008,115;
EXEC insertData 'Jane Eyre', 'Jane Eyre',0,2011,2011,120;
EXEC insertData 'Anna Karenina', 'Anna Karenina',1,2012,2012,130;
EXEC insertData 'Candy Candy', 'Candy Candy',0,1976,1780,21;


CREATE PROCEDURE usp_GetErrorInfo
AS
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
GO