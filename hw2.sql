CREATE TABLE taverns (
  tavernID INT IDENTITY(1,1),
  tavernName VARCHAR(50),
  locationID INT,
  ownerID INT,
  PRIMARY KEY (tavernID)
);

ALTER TABLE taverns ADD FOREIGN KEY (locationID) REFERENCES locations(locationID);
ALTER TABLE taverns ADD FOREIGN KEY (ownerID) REFERENCES owners(ownerID);

CREATE TABLE owners (
  ownerID INT IDENTITY(1,1),
  ownerName VARCHAR(50),
  roleID INT
);

ALTER TABLE owners ADD FOREIGN KEY (roleID) REFERENCES roles(roleID);

CREATE TABLE roles (
  roleID INT IDENTITY(1,1),
  roleName VARCHAR(50),
  roleDescription VARCHAR(200),
  PRIMARY KEY (roleID)
);

CREATE TABLE locations (
  locationID INT IDENTITY(1,1),
  locationName VARCHAR(50),
  PRIMARY KEY (locationID)
);

CREATE TABLE supplies (
  supplyID INT IDENTITY(1,1),
  itemName VARCHAR(50),
  unit VARCHAR(3),
  dateUpdated DATE,
  currentAmount INT,
  tavernID INT,
  PRIMARY KEY (supplyID)
);

ALTER TABLE supplies ADD FOREIGN KEY (tavernID) REFERENCES taverns(tavernID);

CREATE TABLE services (
  serviceID INT IDENTITY(1,1),
  serviceName VARCHAR(50),
  statusID INT,
  tavernID INT,
  PRIMARY KEY (serviceID)
);

ALTER TABLE services ADD FOREIGN KEY (statusID) REFERENCES statuses(statusID);
ALTER TABLE services ADD FOREIGN KEY (tavernID) REFERENCES taverns(tavernID);

CREATE TABLE statuses (
  statusID INT IDENTITY(1,1),
  statusName VARCHAR(50),
  PRIMARY KEY (statusID)
);

CREATE TABLE sales (
 salesID INT IDENTITY(1,1),
 guestID INT,
 serviceID INT,
 supplyID INT,
 servPrice DECIMAL(6,2),
 supPrice DECIMAL(6,2),
 datePurchased DATE,
 amountServ INT,
 amountSup INT,
 tavernID INT,
 PRIMARY KEY (salesID) 
);

ALTER TABLE sales ADD FOREIGN KEY (guestID) REFERENCES guests(guestID);
ALTER TABLE sales ADD FOREIGN KEY (serviceID) REFERENCES services(serviceID);
ALTER TABLE sales ADD FOREIGN KEY (tavernID) REFERENCES taverns(tavernID);
ALTER TABLE sales ADD FOREIGN KEY (supplyID) REFERENCES supplies(supplyID);

CREATE TABLE guests (
  guestID INT IDENTITY(1,1),
  names VARCHAR(25),
  notes VARCHAR(250),
  cakeday DATE,
  statusID INT,
  PRIMARY KEY (guestID),
  FOREIGN KEY (statusID) REFERENCES guestStatus(statusID)  
);

ALTER TABLE guests ADD FOREIGN KEY (guestID) REFERENCES guests(guestID);

CREATE TABLE classLevel (
  levelNumber INT,
  classID INT,
  guestID INT,
  PRIMARY KEY (classID, guestID)
);

ALTER TABLE classLevel ADD FOREIGN KEY (classID) REFERENCES class(classID);
ALTER TABLE classLevel ADD FOREIGN KEY (guestID) REFERENCES guests(guestID);

CREATE TABLE class (
  classID INT IDENTITY(1,1),
  className VARCHAR(200),

)

CREATE TABLE guestStatus (
  statusID INT IDENTITY(1,1),
  statuses VARCHAR(250),
  PRIMARY KEY(statusID)
);

-- seeding data 

INSERT INTO taverns (tavernName, locationID, ownerID)
VALUES 
      ('redwig',1,1),
      ('charlies',2,2),
      ('bobs',2,3),
      ('hammerfell',2,4),
      ('ringos', 4,3);

INSERT INTO owners (ownerName, roleID)
VALUES 
      ('Ned',1),
      ('Don',3),
      ('Forkas',4),
      ('Murial',4),
      ('Geralt',3);

INSERT INTO roles (roleName, roleDescription)
VALUES
      ('warrior', 'skilled in combat uses melee weapons'),
      ('dragon', 'mythical beast'),
      ('archer', 'skilled with a bow'),
      ('thief', 'experienced with tricker and thieving'),
      ('samurai', 'warrior in search of the number 1 headband');

INSERT INTO locations (locationName)
VALUES 
      ('Briarwood'),
      ('Compton'),
      ('Skyrim'),
      ('Reach'),
      ('Naboo');

INSERT INTO supplies (itemName, unit, dateUpdated, currentAmount, tavernID)
VALUES 
      ('beer', 'oz', DATE, 25, 3),
      ('mutton', 'lbs', DATE, 15, 2),
      ('beef', 'lbs', DATE, 10, 5),
      ('wine', 'oz', DATE, 7, 1),
      ('sweetcakses', 'lbs', DATE, 13, 3);

INSERT INTO services (serviceName, statusID, tavernID)
VALUES
      ('pool', 3, 2),
      ('training', 5, 3),
      ('wizadry', 1, 1),
      ('smithing', 2, 4),
      ('archery', 1, 5);

INSERT INTO statuses (statusName)
VALUES
      ('active'),
      ('active'),
      ('inactive'),
      ('active'),
      ('inactive');

INSERT INTO sales (guestID, serviceID, supplyID, servPrice, supPrice, datePurchased, amountServ, amountSup, tavernID)
VALUES
      (2,3,3,10.23,12.65,DATE,2,3,4),
      (2,3,NULL,6.37,NULL,DATE,4,NULL,4),
      (5,NULL,3,NULL,19.74,DATE,NULL,7,3),
      (4,2,4,34.76,25.89,DATE,13,24,1),
      (5,2,4,13.11,7.35,DATE,2,9,2);

-- (2,3,NULL,NULL,NULL,DATE,4,NULL,4) would not work becasuse you can't have a price or amount for a service if you do not include the service ID

INSERT INTO guests (names, notes, cakeday, statusID)
VALUES
      ('Don', 'hes a cool cat', DATE, 4),
      ('Jay', 'Shes an aries', DATE, 2),
      ('Gary','Sheriffs department', DATE, 2),
      ('Branden', 'he is a real one', DATE, 1),
      ('Lewis', 'the man who is nothing without clark', DATE, 1);

INSERT INTO classLevel (levelNumber, classID, guestID)
VALUES
      (24,3,4),
      (21,5,2),
      (34,5,2),
      (99,5,2),
      (76,2,1);

INSERT INTO class (className)
VALUES
      ('warrior'),
      ('thief'),
      ('dark mage'),
      ('ligh mage'),
      ('beast');

INSERT INTO guestStatus
VALUES
      ('poisoned'),
      ('full health'),
      ('heavily damaged'),
      ('asleep'),
      ('paralyzed');