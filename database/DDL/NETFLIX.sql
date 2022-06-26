IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'NETFLIX')
BEGIN
    CREATE DATABASE [NETFLIX]
END

use NETFLIX
GO;

CREATE TABLE Director
    (
     titleId INTEGER NOT NULL ,
     nameId INTEGER NOT NULL
    )
GO

CREATE TABLE Episode
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     season INTEGER NOT NULL ,
     episode INTEGER NOT NULL ,
     titleId INTEGER NOT NULL ,
     parentId INTEGER NOT NULL
    )
GO

ALTER TABLE Episode ADD CONSTRAINT Episode_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Genre
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Genre ADD CONSTRAINT Genre_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Name
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     primaryName NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Name ADD CONSTRAINT Name_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Title
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     primaryTitle NVARCHAR (50) NOT NULL ,
     originalTitle NVARCHAR (50) NOT NULL ,
     isAdult BIT NOT NULL ,
     startYear NVARCHAR (50) NOT NULL ,
     endYear NVARCHAR (50) NOT NULL ,
     runtime NVARCHAR (50) NOT NULL ,
     idIMDB INTEGER NULL
    )
GO

ALTER TABLE Title ADD CONSTRAINT Title_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE TitleGenre
    (
     genreId INTEGER NOT NULL ,
     titleId INTEGER NOT NULL
    )
GO

ALTER TABLE Director
    ADD CONSTRAINT Director_Name_FK FOREIGN KEY
    (
     nameId
    )
    REFERENCES Name
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Director
    ADD CONSTRAINT Director_Title_FK FOREIGN KEY
    (
     titleId
    )
    REFERENCES Title
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Episode
    ADD CONSTRAINT Episode_Title_FK FOREIGN KEY
    (
     titleId
    )
    REFERENCES Title
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Episode
    ADD CONSTRAINT Episode_Title_FKv2 FOREIGN KEY
    (
     parentId
    )
    REFERENCES Title
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE TitleGenre
    ADD CONSTRAINT TitleGenre_Genre_FK FOREIGN KEY
    (
     genreId
    )
    REFERENCES Genre
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE TitleGenre
    ADD CONSTRAINT TitleGenre_Title_FK FOREIGN KEY
    (
     titleId
    )
    REFERENCES Title
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler:
--
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             10
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
--
-- DROP DATABASE                            0
--
-- ERRORS                                   0
-- WARNINGS                                 0

EXEC sp_addlinkedserver
      @server= 'IMDB_SERVER', -- this value
      @srvproduct='',
      @provider='SQLNCLI',
      @datasrc='',--the data source -> IP of the Linked Server
      @catalog ='' ,  -- Default Database - chose one Database in Linked Server
      @provstr='Integrated Security=SSPI'   --

EXEC sp_addlinkedsrvlogin 'IMDB_SERVER','false',NULL,'',''
---- user, password for login LinkedServerName