-- Execute in both Oracle and PostgreSQL
-- Execute CREATE TABLE statements first
INSERT INTO
  intercollegiatedb.Customer(
    CusNo,
    CusName,
    Address,
    Internal,
    Contact,
    Phone,
    City,
    State,
    Zip
  )
VALUES
  (
    'C100',
    'Football',
    'Box 352200',
    'Y',
    'Mary Manager',
    '6857100',
    'Boulder',
    'CO',
    '80309'
  ),
  (
    'C101',
    'Men s Basketball',
    'Box 352400',
    'Y',
    'Sally Supervisor',
    '5431700',
    'Boulder',
    'CO',
    '80309'
  ),
  (
    'C103',
    'Baseball',
    'Box 352020',
    'Y',
    'Bill Baseball',
    '5431234',
    'Boulder',
    'CO',
    '80309'
  ),
  (
    'C104',
    'Women s Softball',
    'Box 351200',
    'Y',
    'Sue Softball',
    '5434321',
    'Boulder',
    'CO',
    '80309'
  ),
  (
    'C105',
    'High School Football',
    '123 AnyStreet',
    'N',
    'Coach Bob',
    '4441234',
    'Louisville',
    'CO',
    '80027'
  );

INSERT INTO
  intercollegiatedb.Employee(EmpNo, EmpName, Department, Email, Phone, MgrNo)
VALUES
  (
    'E100',
    'Chuck Couch',
    'Administration',
    'chuck@colorado.edu',
    '3-1111',
    'E104'
  ),
  (
    'E101',
    'Mary Martell',
    'Football',
    'mary@colorado.edu',
    '5-1111',
    'E104'
  ),
  (
    'E102',
    'Sally Jones',
    'Planning',
    'sally@colorado.edu',
    '3-2222',
    'E104'
  ),
  (
    'E103',
    'Sue Wong',
    'Basketball',
    'sue@colorado.edu',
    '3-3333',
    'E104'
  ),
  (
    'E104',
    'Alan Smity',
    'Administration',
    'alan@colorado.edu',
    '3-4433',
    'E105'
  ),
  (
    'E105',
    'Jose Cuevas',
    'Administration',
    'jose@colorado.edu',
    '3-3344',
    NULL
  );

INSERT INTO
  intercollegiatedb.Facility(FacNo, FacName)
VALUES
  ('F100', 'Football stadium'),
  ('F101', 'Basketball arena'),
  ('F102', 'Baseball field'),
  ('F103', 'Recreation room');

INSERT INTO
  intercollegiatedb.Location(LocNo, FacNo, LocName)
VALUES
  ('L100', 'F100', 'Locker room'),
  ('L101', 'F100', 'Plaza'),
  ('L102', 'F100', 'Vehicle gate'),
  ('L103', 'F101', 'Locker room'),
  ('L104', 'F100', 'Ticket Booth'),
  ('L105', 'F101', 'Gate'),
  ('L106', 'F100', 'Pedestrian gat');

INSERT INTO
  intercollegiatedb.ResourceTbl(ResNo, ResName, Rate)
VALUES
  ('R100', 'attendant', 10.00),
  ('R101', 'police', 15.00),
  ('R102', 'usher', 10.00),
  ('R103', 'nurse', 20.00),
  ('R104', 'janitor', 15.00),
  ('R105', 'food service', 10.00);

INSERT INTO
  intercollegiatedb.EventRequest(
    EventNo,
    DateHeld,
    DateReq,
    FacNo,
    CusNo,
    DateAuth,
    Status,
    EstCost,
    EstAudience,
    BudNo
  )
VALUES
  (
    'E100',
    '2022-10-25',
    '2022-06-06',
    'F100',
    'C100',
    '2022-06-08',
    'Approved',
    5000.00,
    80000,
    'B1000'
  ),
  (
    'E101',
    '2022-10-26',
    '2022-07-28',
    'F100',
    'C100',
    NULL,
    'Pending',
    5000.00,
    80000,
    'B1000'
  ),
  (
    'E102',
    '2022-09-14',
    '2022-07-28',
    'F100',
    'C100',
    '2022-07-31',
    'Approved',
    5000.00,
    80000,
    'B1000'
  ),
  (
    'E103',
    '2022-09-21',
    '2022-07-28',
    'F100',
    'C100',
    '2022-08-01',
    'Approved',
    5000.00,
    80000,
    'B1000'
  ),
  (
    'E104',
    '2022-12-03',
    '2022-07-28',
    'F101',
    'C101',
    '2022-07-31',
    'Approved',
    2000.00,
    12000,
    'B1000'
  ),
  (
    'E105',
    '2022-12-05',
    '2022-07-28',
    'F101',
    'C101',
    '2022-08-01',
    'Approved',
    2000.00,
    10000,
    'B1000'
  ),
  (
    'E106',
    '2022-12-12',
    '2022-07-28',
    'F101',
    'C101',
    '2022-07-31',
    'Approved',
    2000.00,
    10000,
    'B1000'
  ),
  (
    'E107',
    '2022-11-23',
    '2022-07-28',
    'F100',
    'C105',
    '2022-07-31',
    'Denied',
    10000.00,
    5000,
    NULL
  );

INSERT INTO
  intercollegiatedb.EventPlan(
    PlanNo,
    EventNo,
    WorkDate,
    Notes,
    Activity,
    EmpNo
  )
VALUES
  (
    'P100',
    'E100',
    '2022-10-25',
    'Standard operation',
    'Operation',
    'E102'
  ),
  (
    'P101',
    'E104',
    '2022-12-03',
    'Watch for gate crashers',
    'Operation',
    'E100'
  ),
  (
    'P102',
    'E105',
    '2022-12-05',
    'Standard operation',
    'Operation',
    'E102'
  ),
  (
    'P103',
    'E106',
    '2022-12-12',
    'Watch for seat switching',
    'Operation',
    NULL
  ),
  (
    'P104',
    'E101',
    '2022-10-26',
    'Standard cleanup',
    'Cleanup',
    'E101'
  ),
  (
    'P105',
    'E100',
    '2022-10-25',
    'Light cleanup',
    'Cleanup',
    'E101'
  ),
  (
    'P199',
    'E102',
    '2022-12-10',
    'Standard operation',
    'Operation',
    'E101'
  ),
  (
    'P299',
    'E101',
    '2022-10-26',
    NULL,
    'Operation',
    'E101'
  ),
  (
    'P349',
    'E106',
    '2022-12-12',
    NULL,
    'Cleanup',
    'E101'
  ),
  (
    'P85',
    'E100',
    '2022-10-25',
    'Standard operation',
    'Setup',
    'E102'
  ),
  (
    'P95',
    'E101',
    '2022-10-26',
    'Extra security',
    'Setup',
    'E102'
  );

INSERT INTO
  intercollegiatedb.EventPlanLine(
    PlanNo,
    LineNo,
    TimeStart,
    TimeEnd,
    ResourceCnt,
    LocNo,
    ResNo
  )
VALUES
  (
    'P100',
    1,
    '2022-10-25 08:00',
    '2022-10-25 17:00',
    2,
    'L100',
    'R100'
  ),
  (
    'P100',
    2,
    '2022-10-25 12:00',
    '2022-10-25 17:00',
    2,
    'L101',
    'R101'
  ),
  (
    'P100',
    3,
    ' 2022-10-25 07:00',
    '2022-10-25 16:30',
    1,
    'L102',
    'R102'
  ),
  (
    'P100',
    4,
    '2022-10-25 18:00',
    '2022-10-25 22:00',
    2,
    'L100',
    'R102'
  ),
  (
    'P101',
    1,
    '2022-12-03 18:00',
    '2022-12-03 20:00',
    2,
    'L103',
    'R100'
  ),
  (
    'P101',
    2,
    '2022-12-03 18:30',
    '2022-12-03 19:00',
    4,
    'L105',
    'R100'
  ),
  (
    'P101',
    3,
    '2022-12-03 19:00',
    '2022-12-03 20:00',
    2,
    'L103',
    'R103'
  ),
  (
    'P102',
    1,
    '2022-12-05 18:00',
    '2022-12-05 19:00',
    2,
    'L103',
    'R100'
  ),
  (
    'P102',
    2,
    '2022-12-05 18:00',
    '2022-12-05 21:00',
    4,
    'L105',
    'R100'
  ),
  (
    'P102',
    3,
    '2022-12-05 19:00',
    '2022-12-05 22:00',
    2,
    'L103',
    'R103'
  ),
  (
    'P103',
    1,
    '2022-12-12 18:00',
    '2022-12-12 21:00',
    2,
    'L103',
    'R100'
  ),
  (
    'P103',
    2,
    '2022-12-12 18:00',
    '2022-12-12 21:00',
    4,
    'L105',
    'R100'
  ),
  (
    'P103',
    3,
    '2022-12-12 19:00',
    '2022-12-12 22:00',
    2,
    'L103',
    'R103'
  ),
  (
    'P104',
    1,
    '2022-10-26 18:00',
    '2022-10-26 22:00',
    4,
    'L101',
    'R104'
  ),
  (
    'P104',
    2,
    '2022-10-26 18:00',
    '2022-10-26 22:00',
    4,
    'L100',
    'R104'
  ),
  (
    'P105',
    1,
    '2022-10-25 18:00',
    '2022-10-25 22:00',
    4,
    'L101',
    'R104'
  ),
  (
    'P105',
    2,
    '2022-10-25 18:00',
    '2022-10-25 22:00',
    4,
    'L100',
    'R104'
  ),
  (
    'P199',
    1,
    '2022-12-10 08:00',
    '2022-12-10 12:00',
    1,
    'L100',
    'R100'
  ),
  (
    'P349',
    1,
    '2022-12-12 12:00',
    '2022-12-12 15:30',
    1,
    'L103',
    'R100'
  ),
  (
    'P85',
    1,
    '2022-10-25 09:00',
    '2022-10-25 17:00',
    5,
    'L100',
    'R100'
  ),
  (
    'P85',
    2,
    '2022-10-25 08:00',
    '2022-10-25 17:00',
    2,
    'L102',
    'R101'
  ),
  (
    'P85',
    3,
    '2022-10-25 10:00',
    '2022-10-25 15:00',
    3,
    'L104',
    'R100'
  ),
  (
    'P95',
    1,
    '2022-10-26 08:00',
    '2022-10-26 17:00',
    4,
    'L100',
    'R100'
  ),
  (
    'P95',
    2,
    '2022-10-26 09:00',
    '2022-10-26 17:00',
    4,
    'L102',
    'R101'
  ),
  (
    'P95',
    3,
    '2022-10-26 10:00',
    '2022-10-26 15:00',
    4,
    'L106',
    'R100'
  ),
  (
    'P95',
    4,
    '2022-10-26 13:00',
    '2022-10-26 17:00',
    2,
    'L100',
    'R103'
  ),
  (
    'P95',
    5,
    '2022-10-26 13:00',
    '2022-10-26 17:00',
    2,
    'L101',
    'R104'
  );
