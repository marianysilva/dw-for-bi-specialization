-- Faculty Database
-- Executes in both Oracle and PostgreSQL
CREATE SCHEMA IF NOT EXISTS facultydb;

-- Drop tables if exists
DROP TABLE IF EXISTS facultydb.Enrollment CASCADE;

DROP TABLE IF EXISTS facultydb.Offering CASCADE;

DROP TABLE IF EXISTS facultydb.Student CASCADE;

DROP TABLE IF EXISTS facultydb.Course CASCADE;

DROP TABLE IF EXISTS facultydb.Faculty CASCADE;

CREATE TABLE facultydb.Student (
    StdNo CHAR(11) CONSTRAINT StdNoRequired NOT NULL,
    StdFirstName VARCHAR(50) CONSTRAINT StdFirstNameRequired NOT NULL,
    StdLastName VARCHAR(50) CONSTRAINT StdLastNameRequired NOT NULL,
    StdCity VARCHAR(50) CONSTRAINT StdCityRequired NOT NULL,
    StdState CHAR(2) CONSTRAINT StdStateRequired NOT NULL,
    StdZip CHAR(10) CONSTRAINT StdZipRequired NOT NULL,
    StdMajor CHAR(6),
    StdClass CHAR(6),
    StdGPA DECIMAL(3, 2) DEFAULT 0,
    CONSTRAINT PKStudent PRIMARY KEY (StdNo),
    CONSTRAINT ValidGPA CHECK (
        StdGPA BETWEEN 0
        AND 4
    ),
    CONSTRAINT ValidStdClass CHECK (StdClass IN ('FR', 'SO', 'JR', 'SR')),
    CONSTRAINT MajorDeclared CHECK (
        StdClass IN ('FR', 'SO')
        OR StdMajor IS NOT NULL
    )
);

CREATE TABLE facultydb.Faculty (
    FacNo CHAR(11),
    FacFirstName VARCHAR(30) CONSTRAINT FacFirstNameRequired NOT NULL,
    FacLastName VARCHAR(30) CONSTRAINT FacLastNameRequired NOT NULL,
    FacCity VARCHAR(30) CONSTRAINT FacCityRequired NOT NULL,
    FacState CHAR(2) CONSTRAINT FacStateRequired NOT NULL,
    FacZipCode CHAR(10) CONSTRAINT FacZipRequired NOT NULL,
    FacRank CHAR(4),
    FacHireDate DATE,
    FacSalary DECIMAL(10, 2),
    FacSupervisor CHAR(11),
    FacDept CHAR(6),
    CONSTRAINT FacultyPK PRIMARY KEY (FacNo),
    CONSTRAINT SupervisorFK FOREIGN KEY (FacSupervisor) REFERENCES facultydb.Faculty
);

CREATE TABLE facultydb.Course (
    CourseNo CHAR(6),
    CrsDesc VARCHAR(50) CONSTRAINT CrsDescRequired NOT NULL,
    CrsUnits INTEGER,
    CONSTRAINT CoursePK PRIMARY KEY (CourseNo),
    CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)
);

CREATE TABLE facultydb.Offering (
    OfferNo INTEGER,
    CourseNo CHAR(6) CONSTRAINT OffCourseNoRequired NOT NULL,
    OffTerm CHAR(6) CONSTRAINT OffTermRequired NOT NULL,
    OffYear INTEGER DEFAULT 2022 CONSTRAINT OffYearRequired NOT NULL,
    OffLocation VARCHAR(30),
    OffTime VARCHAR(10),
    FacNo CHAR(11),
    OffDays CHAR(6) DEFAULT 'MW',
    CONSTRAINT OfferingPK PRIMARY KEY (OfferNo),
    CONSTRAINT CourseFK FOREIGN KEY (CourseNo) REFERENCES facultydb.Course,
    CONSTRAINT FacultyFK FOREIGN KEY (FacNo) REFERENCES facultydb.Faculty
);

CREATE TABLE facultydb.Enrollment (
    OfferNo INTEGER,
    StdNo CHAR(11),
    EnrGrade DECIMAL(3, 2) DEFAULT 0,
    CONSTRAINT EnrollmentPK PRIMARY KEY (OfferNo, StdNo),
    CONSTRAINT OfferingFK FOREIGN KEY (OfferNo) REFERENCES facultydb.Offering ON DELETE CASCADE,
    CONSTRAINT StudentFK FOREIGN KEY (StdNo) REFERENCES facultydb.Student ON DELETE CASCADE
);
