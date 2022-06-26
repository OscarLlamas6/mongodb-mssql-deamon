IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'IMDB')
BEGIN
    CREATE DATABASE [IMDB]
END


USE [IMDB]
GO

-- Generado por Oracle SQL Developer Data Modeler 20.3.0.283.0710
--   en:        2022-06-21 19:36:27 CST
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE AlternativeAttribute
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE AlternativeAttribute ADD CONSTRAINT AlternativeAttribute_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE AlternativeTitle
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     title NVARCHAR (200) NOT NULL ,
     ordering NVARCHAR (50) NOT NULL ,
     isOriginal BIT NOT NULL ,
     regionId INTEGER NOT NULL ,
     languageId INTEGER NOT NULL ,
     alternativeTypeId INTEGER NOT NULL ,
     alternativeAttributeId INTEGER NOT NULL ,
     titleId INTEGER NOT NULL
    )
GO

ALTER TABLE AlternativeTitle ADD CONSTRAINT AlternativeTitle_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE AlternativeType
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE AlternativeType ADD CONSTRAINT AlternativeType_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Category
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Category ADD CONSTRAINT Category_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

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
     parentId INTEGER NOT NULL ,
     titleId INTEGER NOT NULL
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

CREATE TABLE KnowForTitle
    (
     titleId INTEGER NOT NULL ,
     nameId INTEGER NOT NULL
    )
GO

CREATE TABLE Language
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Language ADD CONSTRAINT Language_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Name
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     primaryName NVARCHAR (50) NOT NULL ,
     birthYear INTEGER NOT NULL ,
     deathYear INTEGER
    )
GO

ALTER TABLE Name ADD CONSTRAINT Name_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE NameProfession
    (
     nameId INTEGER NOT NULL ,
     professionId INTEGER NOT NULL
    )
GO

CREATE TABLE Principal
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     "order" INTEGER NOT NULL ,
     character CHAR (1) NOT NULL ,
     jobId INTEGER NOT NULL ,
     categoryId INTEGER NOT NULL ,
     titleId INTEGER NOT NULL ,
     nameId INTEGER NOT NULL
    )
GO

ALTER TABLE Principal ADD CONSTRAINT Principal_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Profession
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Profession ADD CONSTRAINT Profession_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Rating
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     averageRating decimal NOT NULL ,
     numVotes INTEGER NOT NULL ,
     titleId INTEGER NOT NULL
    )
GO

ALTER TABLE Rating ADD CONSTRAINT Rating_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Region
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE Region ADD CONSTRAINT Region_PK PRIMARY KEY CLUSTERED (id)
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
     titleTypeId INTEGER NOT NULL
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

CREATE TABLE TitleType
    (
     id INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
     name NVARCHAR (50) NOT NULL
    )
GO

ALTER TABLE TitleType ADD CONSTRAINT TitleType_PK PRIMARY KEY CLUSTERED (id)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Writer
    (
     titleId INTEGER NOT NULL ,
     nameId INTEGER NOT NULL
    )
GO

ALTER TABLE AlternativeTitle
    ADD CONSTRAINT AlternativeTitle_AlternativeAttribute_FK FOREIGN KEY
    (
     alternativeAttributeId
    )
    REFERENCES AlternativeAttribute
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE AlternativeTitle
    ADD CONSTRAINT AlternativeTitle_AlternativeType_FK FOREIGN KEY
    (
     alternativeTypeId
    )
    REFERENCES AlternativeType
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE AlternativeTitle
    ADD CONSTRAINT AlternativeTitle_Language_FK FOREIGN KEY
    (
     languageId
    )
    REFERENCES Language
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE AlternativeTitle
    ADD CONSTRAINT AlternativeTitle_Region_FK FOREIGN KEY
    (
     regionId
    )
    REFERENCES Region
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE AlternativeTitle
    ADD CONSTRAINT AlternativeTitle_Title_FK FOREIGN KEY
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
     parentId
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
     titleId
    )
    REFERENCES Title
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE KnowForTitle
    ADD CONSTRAINT KnowForTitle_Name_FK FOREIGN KEY
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

ALTER TABLE KnowForTitle
    ADD CONSTRAINT KnowForTitle_Title_FK FOREIGN KEY
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

ALTER TABLE NameProfession
    ADD CONSTRAINT NameProfession_Name_FK FOREIGN KEY
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

ALTER TABLE NameProfession
    ADD CONSTRAINT NameProfession_Profession_FK FOREIGN KEY
    (
     professionId
    )
    REFERENCES Profession
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Principal
    ADD CONSTRAINT Principal_Category_FK FOREIGN KEY
    (
     categoryId
    )
    REFERENCES Category
    (
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Principal
    ADD CONSTRAINT Principal_Name_FK FOREIGN KEY
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

ALTER TABLE Principal
    ADD CONSTRAINT Principal_Title_FK FOREIGN KEY
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

ALTER TABLE Rating
    ADD CONSTRAINT Rating_Title_FK FOREIGN KEY
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

ALTER TABLE Title
    ADD CONSTRAINT Title_TitleType_FK FOREIGN KEY
    (
     titleTypeId
    )
    REFERENCES TitleType
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

ALTER TABLE Writer
    ADD CONSTRAINT Writer_Name_FK FOREIGN KEY
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

ALTER TABLE Writer
    ADD CONSTRAINT Writer_Title_FK FOREIGN KEY
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
-- CREATE TABLE                            19
-- CREATE INDEX                             0
-- ALTER TABLE                             36
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


SELECT * FROM INFORMATION_SCHEMA.TABLES;