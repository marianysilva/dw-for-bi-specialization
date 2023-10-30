-------------------------------------------------------------------------------
-- Drop tables if exists
-- DROP TABLE Facility;
-- DROP TABLE Location;

CREATE TABLE Facility (
  FacNo 	    CHAR(11)        CONSTRAINT FacNoRequired NOT NULL,
  FacName     VARCHAR(50)     CONSTRAINT FacNameRequired NOT NULL,
	
  CONSTRAINT FacilityPK       PRIMARY KEY (FacNo),
  CONSTRAINT UniqueFacName    UNIQUE (FacName)
);

-------------------------------------------------------------------------------

CREATE TABLE Location (
  LocNo 	    CHAR(11)        CONSTRAINT LocNoRequired NOT NULL,
  FacNo 	    CHAR(11)        CONSTRAINT FacNoRequired NOT NULL,
  LocName     VARCHAR(50)     CONSTRAINT LocNameRequired NOT NULL,
	
  CONSTRAINT LocationPK       PRIMARY KEY (LocNo),
  CONSTRAINT FacilityFK       FOREIGN KEY (FacNo) REFERENCES Facility
);

-------------------------------------------------------------------------------