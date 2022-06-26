USE [NETFLIX]
GO;


CREATE OR ALTER PROCEDURE GetAllData
AS
BEGIN TRANSACTION ADD_MOVIE
    begin try
        SELECT t.id,
               primaryTitle,
               originalTitle,
               isAdult,
               startYear,
               endYear,
               runtime,
               N.primaryName,
               R.averageRating,
               R.numVotes
        FROM Title t
                 INNER JOIN [IMDB_SERVER].[IMDB].[DBO].Rating R ON R.titleId = t.idIMDB
                 INNER JOIN Director D on t.id = D.titleId
                 INNER JOIN Name N on D.nameId = N.id
            ;
        COMMIT TRANSACTION
    end try
        begin catch
            EXECUTE usp_GetErrorInfo;
            ROLLBACK TRANSACTION
        end catch


GO;


EXEC GetAllData;