-------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS intercollegiatedb;

-- Drop tables if exists
DROP TABLE IF EXISTS intercollegiatedb.ResourceTbl CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.Facility CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.Location CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.Customer CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.Employee CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.EventRequest CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.EventPlan CASCADE;

DROP TABLE IF EXISTS intercollegiatedb.EventPlanLine CASCADE;

CREATE TABLE intercollegiatedb.ResourceTbl (
  ResNo CHAR(8) CONSTRAINT ResNoRequired NOT NULL,
  ResName VARCHAR(30) CONSTRAINT ResNameRequired NOT NULL,
  Rate DECIMAL(10, 2) CONSTRAINT ResRateRequired NOT NULL DEFAULT 1 CHECK (Rate > 0),
  CONSTRAINT ResilityPK PRIMARY KEY (ResNo),
  CONSTRAINT ResourceTblUniqueResName UNIQUE (ResName)
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.Facility (
  FacNo CHAR(8) CONSTRAINT FacNoRequired NOT NULL,
  FacName VARCHAR(30) CONSTRAINT FacNameRequired NOT NULL,
  CONSTRAINT FacilityPK PRIMARY KEY (FacNo),
  CONSTRAINT FacilityUniqueFacName UNIQUE (FacName)
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.Location (
  LocNo CHAR(8) CONSTRAINT LocNoRequired NOT NULL,
  FacNo CHAR(8) CONSTRAINT LocFacNoRequired NOT NULL,
  LocName VARCHAR(30) CONSTRAINT LocNameRequired NOT NULL,
  CONSTRAINT LocationPK PRIMARY KEY (LocNo),
  CONSTRAINT LocationFacilityFK FOREIGN KEY (FacNo) REFERENCES intercollegiatedb.Facility
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.Customer (
  CusNo CHAR(8) CONSTRAINT CusNoRequired NOT NULL,
  CusName VARCHAR(50) CONSTRAINT CusNameRequired NOT NULL,
  Address VARCHAR(50) CONSTRAINT CusAddressRequired NOT NULL,
  Internal VARCHAR(1) CONSTRAINT CusInternalRequired NOT NULL DEFAULT 'Y',
  Contact VARCHAR(35) CONSTRAINT CusContactRequired NOT NULL,
  Phone VARCHAR(11) CONSTRAINT CusPhoneRequired NOT NULL,
  City VARCHAR(30) CONSTRAINT CusCityRequired NOT NULL,
  State VARCHAR(2) CONSTRAINT CusStateRequired NOT NULL,
  Zip VARCHAR(10) CONSTRAINT CusZipRequired NOT NULL,
  CONSTRAINT CustomerPK PRIMARY KEY (CusNo)
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.Employee (
  EmpNo CHAR(8) CONSTRAINT EmpNoRequired NOT NULL,
  EmpName VARCHAR(50) CONSTRAINT EmpNameRequired NOT NULL,
  Department VARCHAR(25) CONSTRAINT EmpDepartmentRequired NOT NULL,
  Email VARCHAR(30) CONSTRAINT EmpEmailRequired NOT NULL,
  Phone VARCHAR(11) CONSTRAINT EmpPhoneRequired NOT NULL,
  MgrNo CHAR(8),
  CONSTRAINT EmployeePK PRIMARY KEY (EmpNo),
  CONSTRAINT EmployeeUniqueEmail UNIQUE (Email),
  CONSTRAINT EmployeeManagerFK FOREIGN KEY (MgrNo) REFERENCES intercollegiatedb.Employee
);

-------------------------------------------------------------------------------
CREATE TYPE EventRequestStatus AS ENUM ('Pending', 'Approved', 'Denied');

CREATE TABLE intercollegiatedb.EventRequest (
  EventNo CHAR(8) CONSTRAINT EventReqNoRequired NOT NULL,
  DateHeld DATE CONSTRAINT EventReqDateHeldRequired NOT NULL,
  DateReq DATE CONSTRAINT EventReqDateReqRequired NOT NULL DEFAULT CURRENT_DATE,
  CusNo CHAR(8) CONSTRAINT EventReqCusNoRequired NOT NULL,
  FacNo CHAR(8) CONSTRAINT EventReqFacNoRequired NOT NULL,
  DateAuth DATE,
  Status EventRequestStatus CONSTRAINT EventReqStatusRequired NOT NULL DEFAULT 'Pending',
  EstCost DECIMAL(10, 2) CONSTRAINT EventReqEstCostRequired NOT NULL,
  EstAudience INTEGER CONSTRAINT EventReqEstAudienceRequired NOT NULL CHECK (EstAudience > 0),
  BudNo CHAR(8),
  CONSTRAINT EventReqPK PRIMARY KEY (EventNo),
  CONSTRAINT EventReqCustomerFK FOREIGN KEY (CusNo) REFERENCES intercollegiatedb.Customer,
  CONSTRAINT EventReqFacilityFK FOREIGN KEY (FacNo) REFERENCES intercollegiatedb.Facility
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.EventPlan (
  PlanNo CHAR(8) CONSTRAINT PlanNoRequired NOT NULL,
  EventNo CHAR(8) CONSTRAINT PlanEventNoRequired NOT NULL,
  WorkDate DATE CONSTRAINT PlanWorkDateRequired NOT NULL,
  Notes VARCHAR(50),
  Activity VARCHAR(50) CONSTRAINT PlanActivityRequired NOT NULL,
  EmpNo CHAR(8),
  CONSTRAINT EventPlanPK PRIMARY KEY (PlanNo),
  CONSTRAINT EventPlanEventRequestFK FOREIGN KEY (EventNo) REFERENCES intercollegiatedb.EventRequest ON DELETE CASCADE,
  CONSTRAINT EventPlanEmployeeFK FOREIGN KEY (EmpNo) REFERENCES intercollegiatedb.Employee
);

-------------------------------------------------------------------------------
CREATE TABLE intercollegiatedb.EventPlanLine (
  PlanNo CHAR(8) CONSTRAINT PlanLinePlanNoRequired NOT NULL,
  LineNo CHAR(8) CONSTRAINT PlanLineLineNoRequired NOT NULL,
  TimeStart TIMESTAMP CONSTRAINT PlanTimeStartRequired NOT NULL,
  TimeEnd TIMESTAMP CONSTRAINT PlanTimeEndRequired NOT NULL,
  ResourceCnt INTEGER CONSTRAINT PlanResourceCntRequired NOT NULL,
  LocNo CHAR(8) CONSTRAINT PlanLineLocNoRequired NOT NULL,
  ResNo CHAR(8) CONSTRAINT PlanLineResNoRequired NOT NULL,
  CONSTRAINT EventPlanLinePK PRIMARY KEY (LineNo, PlanNo),
  CONSTRAINT EventPlanLinePlanFK FOREIGN KEY (PlanNo) REFERENCES intercollegiatedb.EventPlan ON DELETE CASCADE,
  CONSTRAINT EventPlanLocationFK FOREIGN KEY (LocNo) REFERENCES intercollegiatedb.Location,
  CONSTRAINT EventPlanResourceTblFK FOREIGN KEY (ResNo) REFERENCES intercollegiatedb.ResourceTbl,
  CONSTRAINT TimeStartEndRelationship CHECK (TimeStart < TimeEnd)
);

-------------------------------------------------------------------------------
