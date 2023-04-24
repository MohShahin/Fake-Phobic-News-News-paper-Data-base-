CREATE TABLE Publication 
( 
    ISSN		VARCHAR(20)           NOT NULL, 
    PRIMARY KEY(ISSN), 
    Num_Pages 	INTEGER 	    NOT NULL, 
    Copies 	INTEGER 	        NOT NULL, 
    Headline 	VARCHAR(50)     NOT NULL , 
    Issue 		INTEGER 	    NOT NULL, 
    Volume 		INTEGER 	    NOT NULL, 
    Lang		VARCHAR(10), 
    P_Date		DATE	   	   NOT NULL, 
    Publication_type 	VARCHAR(10)   NOT NULL, 
    Portal_Domain       VARCHAR(50), 
    FOREIGN KEY (Portal_Domain) REFERENCES News_Portal (Domain)
ON DELETE SET NULL
   );


CREATE TABLE Employee 
( 
FName 	VARCHAR (10) 	NOT NULL, 
LName 	VARCHAR (20) 	NOT NULL, 
E_ID		VARCHAR(10)	NOT NULL , 
PRIMARY KEY (E_ID), 
Email 		VARCHAR(20),
Sex 		CHAR(1)		CHECK(Sex IN ('F', 'M')), 
Salary 		INTEGER 		NOT NULL, 
Country 	VARCHAR(30) 	NOT NULL, 
City 		VARCHAR(20) 	NOT NULL, 
Street 		VARCHAR(20) 	NOT NULL, 
Zip_Code 	INTEGER, 
Dno 		INTEGER		 DEFAULT  0,
SUPER_ID 	VARCHAR(10)	 DEFAULT	 2021055623,  
FOREIGN KEY (Super_ID) REFERENCES Employee(E_ID)
ON DELETE SET NULL
 );

—-------BEFORE YOU DO THIS COMMAND, CREATE THE DEPARTMENT TABLE FIRST —---------------



alter table Employee add constraint ForeignKeyDno FOREIGN KEY(Dno) references Department(Dep_num) ON DELETE SET NULL




CREATE TABLE E_Phone
(
E_ID 		VARCHAR(10) 	NOT NULL,
Phone 		INTEGER 	NOT NULL,
PRIMARY KEY (E_ID,Phone),
FOREIGN KEY (E_ID) REFERENCES Employee(E_ID)
ON DELETE SET NULL 
);


CREATE TABLE Department
 (
    Dep_Name    VARCHAR(10)	 NOT NULL 	UNIQUE ,
	Dep_num	    INTEGER		 NOT NULL,
    PRIMARY KEY (Dep_num),
	Mgr_ssn 	     VARCHAR(10)	 DEFAULT  2021055623,
	Mgr_start_date   DATE, 
	FOREIGN KEY (Mgr_ssn) REFERENCES Employee(E_ID)
	ON DELETE SET NULL  	
);



CREATE TABLE Dep_Phone
 (
   	Dep_num		    INTEGER,
   	Phone 			INTEGER 	NOT NULL,
	PRIMARY KEY(Dep_num, Phone),
   	FOREIGN KEY (Dep_num) REFERENCES Department(Dep_num)
		ON DELETE SET NULL 
);
    
CREATE TABLE Dep_Email
 (
   	Dep_num	INTEGER,
   	Email 		VARCHAR(30) 	NOT NULL ,
	PRIMARY KEY(Dep_num,Email),
    	FOREIGN KEY (Dep_num) REFERENCES Department(Dep_num)
ON DELETE SET NULL 	
);

CREATE TABLE Article 
(
	Article_ID 	VARCHAR(20) 	NOT NULL,
	PRIMARY KEY (Article_ID),
	Title		VARCHAR(50)	    NOT NULL 	 UNIQUE,
	Body 		VARCHAR(1000)	NOT NULL 	 UNIQUE,
	Byline 		VARCHAR(70) 	NOT NULL,
	Photo 		BLOB,
    Article_Date 	DATE		NOT NULL,
	Location 	VARCHAR(40) 	NOT NULL,
	P_Issn 	VARCHAR(20),
	Dno 		INTEGER	 DEFAULT 0,
	FOREIGN KEY (P_Issn) REFERENCES Publication(ISSN)
		ON DELETE SET NULL 	,
	FOREIGN KEY (Dno) REFERENCES Department (Dep_num)
		ON DELETE SET NULL	
);

	
CREATE TABLE Keywords
 (
    Article_ID 		VARCHAR(20),
    Keyword 		VARCHAR(10) 	NOT NULL,
    PRIMARY KEY (Article_ID,Keyword),
    FOREIGN KEY (Article_ID) REFERENCES Article (Article_ID)
    	ON DELETE SET NULL 		
);



CREATE TABLE Client
(
Client_ID 	VARCHAR (20) 	 NOT NULL,
PRIMARY KEY (Client_ID),
FName	VARCHAR (20)	 NOT NULL,
LName 	VARCHAR (20)	 NOT NULL, 
Zip_code 	INTEGER, 
Country 	VARCHAR (30)	 NOT NULL, 
City 		VARCHAR (20)	 NOT NULL, 
Street 		VARCHAR (20)	 NOT NULL
);


CREATE TABLE Client_Email
(
Client_ID	VARCHAR (20)	NOT NULL,
Email		VARCHAR (30)	NOT NULL,
PRIMARY KEY(Client_ID,Email),
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID)
ON DELETE SET NULL 	
);




CREATE TABLE Client_Phone
(
Client_ID	VARCHAR (20)	NOT NULL,
Phone		INTEGER		NOT NULL,
PRIMARY KEY (Client_ID,Phone),
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID)
ON DELETE SET NULL 	
);


CREATE TABLE Advertisement 
(
Ad_ID		VARCHAR (20)	NOT NULL,
PRIMARY KEY (Ad_ID),
Page		INTEGER		    NOT NULL,
Ad_Size	    Decimal (10,2)	NOT NULL, 
Template	VARCHAR (20)	NOT NULL, 
Price		Decimal(10,2)	NOT NULL,
Client_ID	VARCHAR (20)	NOT NULL,
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID)
ON  DELETE SET NULL 	
);


CREATE TABLE UserK
 (
User_ID	INTEGER		NOT NULL,
PRIMARY KEY (User_ID),
UserName 	VARCHAR (25) 	NOT NULL 	UNIQUE,
Full_Name	VARCHAR (50)	NOT NULL,
Email		VARCHAR (20)	NOT NULL,
Address	    VARCHAR (50)	NOT NULL,
Date_joined	DATE 			NOT NULL,
Domain	    VARCHAR(50)	    NOT NULL,
Sub_start 	DATE 			NOT NULL,
Sub_num 	INTEGER		NOT NULL,
FOREIGN KEY (Domain) REFERENCES News_Portal(Domain)
	ON DELETE SET NULL, 	
FOREIGN KEY (Sub_num) REFERENCES Subscription_Plan(Sub_num)
ON DELETE SET NULL 
);




CREATE TABLE News_Portal
(
Domain	VARCHAR (50)	NOT NULL,
PRIMARY KEY(Domain),
Region 	VARCHAR (10)	NOT NULL
);



CREATE TABLE Subscription_Plan
(
Sub_num	INTEGER		NOT NULL,
PRIMARY KEY (Sub_num),
Sub_Type 	VARCHAR(10)	CHECK(Sub_Type  IN ('Premium', 'Regular','Economy')),
Period		INTEGER		NOT NULL,
Status		VARCHAR (20)	CHECK(Status IN ('Active', 'Pending','Expired')),
Price		INTEGER		NOT NULL
);

CREATE TABLE Items
(
Bar_code	VARCHAR (15)	NOT NULL,
PRIMARY KEY (Bar_code),
Name		VARCHAR (50)	NOT NULL, 
Category	VARCHAR (15)	NOT NULL
);


CREATE TABLE Supplier
(
Supply_No  	VARCHAR(10)     NOT NULL,
PRIMARY KEY(Supply_No),
Full_Name   VARCHAR(40)     NOT NULL,
Country 	VARCHAR(30) 	NOT NULL, 
City 		VARCHAR(20) 	NOT NULL,
Street 		VARCHAR(20) 	NOT NULL,
Zip_Code 	INTEGER
 );





CREATE TABLE Works_On
(
E_ID             	VARCHAR(10)  	DEFAULT  2021055623,
Article_ID     	VARCHAR(20),
PRIMARY KEY(E_ID, Article_ID),
W_Hours         INTEGER     		NOT NULL,
FOREIGN KEY (E_ID) REFERENCES Employee(E_ID)
ON DELETE SET NULL,
FOREIGN KEY (Article_ID) REFERENCES Article(Article_ID)
ON DELETE SET NULL 	
);






CREATE TABLE Coordinates_with
(
Supply_No  	VARCHAR(10),
Co_ID         	VARCHAR(20),
PRIMARY KEY(Supply_No,Co_ID),
Start_Date  	DATE	NOT NULL,
FOREIGN KEY (Co_ID) REFERENCES Employee(E_ID)
ON DELETE SET NULL ,
FOREIGN KEY (Supply_No) REFERENCES Supplier(Supply_No)
ON DELETE SET NULL
);




CREATE TABLE Displays
(
P_ISSN	VARCHAR(20),	
Ad_ID		VARCHAR (20), 
Duration 	INTEGER	NOT NULL, 
PRIMARY KEY(P_ISSN,Ad_ID),
FOREIGN KEY (P_ISSN) REFERENCES Publication(ISSN)
	ON DELETE SET NULL,
FOREIGN KEY (Ad_ID) REFERENCES Advertisement(Ad_ID)
ON DELETE SET NULL

);




CREATE TABLE Supplies
(
Supply_No 	VARCHAR(10),
Bar_Code 	VARCHAR (15),
P_ISSN     	VARCHAR(20),
PRIMARY KEY(Supply_No,Bar_Code,P_ISSN),
Quantity   	INTEGER    	NOT NULL,
Cost       	FLOAT      	NOT NULL,
S_DATE	DATE 		    NOT NULL,
FOREIGN KEY (Supply_No) REFERENCES Supplier(Supply_No)
	ON DELETE SET NULL 	,
FOREIGN KEY (P_ISSN) REFERENCES Publication(ISSN)
	ON DELETE SET NULL 	,
FOREIGN KEY (Bar_Code) REFERENCES Items(Bar_Code)
ON DELETE SET NULL 
);


CREATE TABLE Distributor
 (
ISSN 			    VARCHAR(20),
Distributor_ID  	VARCHAR(20)	    NOT NULL, 
Distributor_Name	VARCHAR(20) 	UNIQUE, 
ADDRESS 		    VARCHAR(40),
REGION 		        VARCHAR(15),	
PRIMARY KEY(ISSN,Distributor_ID),
Frequency 		    VARCHAR(20)	    NOT NULL,
Quantity_ID		    VARCHAR(20)	    NOT NULL,
FOREIGN KEY (ISSN) REFERENCES Publication(ISSN)
ON DELETE SET NULL 
);




CREATE TABLE Dependant
(
D_ID 			VARCHAR(10),
Depend_Name 	VARCHAR(30)	NOT NULL,
Sex 			CHAR(1)		CHECK(Sex IN ('F' , 'M')), 
Relationship 		VARCHAR(20) 	NOT NULL,
Bdate 			DATE,
PRIMARY KEY(D_ID,Depend_Name),
FOREIGN KEY (D_ID) REFERENCES Employee(E_ID)
ON DELETE SET NULL 
);