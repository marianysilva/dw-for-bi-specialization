-- Order Entry Database
-- Executes in both Oracle and PostgreSQL
CREATE SCHEMA IF NOT EXISTS orderdb;

-- Drop tables if exists
DROP TABLE IF EXISTS orderdb.OrdLine CASCADE;

DROP TABLE IF EXISTS orderdb.OrderTbl CASCADE;

DROP TABLE IF EXISTS orderdb.Product CASCADE;

DROP TABLE IF EXISTS orderdb.Employee CASCADE;

DROP TABLE IF EXISTS orderdb.Customer CASCADE;

CREATE TABLE orderdb.Customer (
	CustNo CHAR(8),
	CustFirstName VARCHAR(20) CONSTRAINT CustFirstNameRequired NOT NULL,
	CustLastName VARCHAR(30) CONSTRAINT CustLastNameRequired NOT NULL,
	CustStreet VARCHAR(50),
	CustCity VARCHAR(30),
	CustState CHAR(2),
	CustZip CHAR(10),
	CustBal DECIMAL(12, 2) DEFAULT 0,
	CONSTRAINT PKCustomer PRIMARY KEY (CustNo)
);

CREATE TABLE orderdb.Employee (
	EmpNo CHAR(8),
	EmpFirstName VARCHAR(20) CONSTRAINT EmpFirstNameRequired NOT NULL,
	EmpLastName VARCHAR(30) CONSTRAINT EmpLastNameRequired NOT NULL,
	EmpPhone CHAR(15),
	EmpEMail VARCHAR(50) CONSTRAINT EmpEMailRequired NOT NULL,
	SupEmpNo CHAR(8),
	EmpCommRate DECIMAL(3, 3),
	CONSTRAINT PKEmployee PRIMARY KEY (EmpNo),
	CONSTRAINT UniqueEMail UNIQUE(EmpEMail),
	CONSTRAINT FKSupEmpNo FOREIGN KEY (SupEmpNo) REFERENCES orderdb.Employee
);

CREATE TABLE orderdb.Product (
	ProdNo CHAR(8),
	ProdName VARCHAR(50) CONSTRAINT ProdNameRequired NOT NULL,
	ProdMfg VARCHAR(20) CONSTRAINT ProdMfgRequired NOT NULL,
	ProdQOH INTEGER,
	ProdPrice DECIMAL(12, 2) DEFAULT 0,
	ProdNextShipDate DATE,
	CONSTRAINT PKProduct PRIMARY KEY (ProdNo)
);

CREATE TABLE orderdb.OrderTbl (
	OrdNo CHAR(8),
	OrdDate DATE CONSTRAINT OrdDateRequired NOT NULL,
	CustNo CHAR(8) CONSTRAINT CustNoRequired NOT NULL,
	EmpNo CHAR(8),
	OrdName VARCHAR(50),
	OrdStreet VARCHAR(50),
	OrdCity VARCHAR(30),
	OrdState CHAR(2),
	OrdZip CHAR(10),
	CONSTRAINT PKOrderTbl PRIMARY KEY (OrdNo),
	CONSTRAINT FKCustNo FOREIGN KEY (CustNo) REFERENCES orderdb.Customer,
	CONSTRAINT FKEmpNo FOREIGN KEY (EmpNo) REFERENCES orderdb.Employee
);

CREATE TABLE orderdb.OrdLine (
	OrdNo CHAR(8),
	ProdNo CHAR(8),
	Qty INTEGER DEFAULT 1,
	CONSTRAINT PKOrdLine PRIMARY KEY (OrdNo, ProdNo),
	CONSTRAINT FKOrdNo FOREIGN KEY (OrdNo) REFERENCES orderdb.OrderTbl ON DELETE CASCADE,
	CONSTRAINT FKProdNo FOREIGN KEY (ProdNo) REFERENCES orderdb.Product
);
