
CREATE DATABASE ASS2

go

USE ASS2

CREATE TABLE Personal
(
   ID			char(9)	primary key,
   Psw          varchar(20) not null,
   First_Name	varchar(50) not null,
   Last_Name	varchar(50) not null,
   Degree       varchar(20) default 'staff',
   P_Year       char(10),
   Phone_num    varchar(10),
   Address      varchar(50)
);

CREATE TABLE Personal_Specialization
(
   ID		  char(9) references Personal(ID) ON UPDATE CASCADE ON DELETE CASCADE,
   Specialty  varchar(50) default 'General',
   CONSTRAINT tab_pk PRIMARY KEY (ID,Specialty)
);

CREATE TABLE Patients
(
   Patient_ID	char(9) primary key,
   Patient_psw  varchar(20) not null,
   First_Name	varchar(20) not null,
   Last_Name    varchar(20) not null,
   Birthday     char(10),
   Address      varchar(50),
   Phone_num    varchar(10),
   Fathers_name varchar(20),
   Mothers_name varchar(20)
);

CREATE TABLE Treatment	
(
	Code          int  primary key,
    T_Name	      varchar(20) not null,
    T_Description varchar(100) not null
);
 
CREATE TABLE Shifts
(
    Employee_id char(9) references Personal(ID)ON UPDATE CASCADE ON DELETE CASCADE,
    Date char(10),
    Start_time char(10),
    Finish_time char(10),
	CONSTRAINT shifts_pk PRIMARY KEY (Employee_ID,Date,Start_time),
	CONSTRAINT ch_wk check (Start_time<Finish_time)
);

CREATE TABLE Labs
(
    Lab_ID	 int primary key,
	Lab_name varchar(30) not null,
    Lab_desc varchar(100)
);

CREATE TABLE Patients_Labs
(
    Lab_ID	 int references Labs(Lab_id)ON UPDATE CASCADE ON DELETE CASCADE,
	Lab_date char(10) default getdate(),
    Patient_id char(9) references Patients(Patient_id)ON UPDATE CASCADE ON DELETE CASCADE,
    Result varchar(50) default 'none',
    CONSTRAINT PL_pk PRIMARY KEY (Lab_ID,Lab_date,Patient_id),
);

CREATE TABLE Patients_Treatments
(
    Patient_ID	 char(9) references Patients(Patient_id)ON UPDATE CASCADE ON DELETE CASCADE,
	Treatment_code int references Treatment(Code)ON UPDATE CASCADE ON DELETE CASCADE,
    Personal_id char(9) references Personal(ID)ON UPDATE CASCADE ON DELETE CASCADE,
    Start_date char(10),
    Finish_date char(10),
    CONSTRAINT PT_pk PRIMARY KEY (Patient_ID,Treatment_code,Personal_id),
); 

CREATE TABLE Patients_Progress
(
    Patient_ID	 char(9),
	Treatment_code int,
    Personal_id char(9),
    Initial_description varchar(100) not null,
    Present_description varchar(100) not null,
    Date_Ending char(10),     
    CONSTRAINT PP_pk PRIMARY KEY (Patient_ID,Treatment_code,Personal_id),
    CONSTRAINT fk_pk FOREIGN KEY (Patient_ID,Treatment_code,Personal_id)
    references Patients_Treatments(Patient_ID,Treatment_code,Personal_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
); 

Delete from Personal
INSERT INTO Personal VALUES('111111111','DC','Dani','Cohen','Phd',1997,'03-11111','Tel-Aviv')
INSERT INTO Personal VALUES('222222222','RM','Ron','Malcha','MA',1995,'08-22222','Ashdod')
INSERT INTO Personal VALUES('333333333','DH','David','Hadari','Msc',2000,'09-33333','Rechovot')
INSERT INTO Personal VALUES('444444444','DB','Dana','Biton','Phd',1999,'03-44444','Tel-Aviv')

Delete from Personal_Specialization
INSERT INTO Personal_Specialization VALUES('111111111','Computer')
INSERT INTO Personal_Specialization VALUES('111111111','Systems Engineering')
INSERT INTO Personal_Specialization VALUES('222222222','Systems Engineering')
INSERT INTO Personal_Specialization VALUES('444444444','Artificial Intelligence')
INSERT INTO Personal_Specialization VALUES('444444444','DataBase')
INSERT INTO Personal_Specialization VALUES('111111111','Engineering')
INSERT INTO Personal_Specialization VALUES('333333333','Engineering')


Delete from Patients
INSERT INTO Patients VALUES('777777777','PP','Dan','Shabtay','03/10/2001','bla','1212','Rona','David')
INSERT INTO Patients VALUES('888888888','CC','Elad','Gigi','23/05/1991','blabla','1414','Tiki','Dani')
INSERT INTO Patients VALUES('787878787','SS','Ronen','Hadar','12/07/1997','blab','3232','Ruth','Moshe')
INSERT INTO Patients VALUES('999999999','EE','Dana','Shalom','15/11/1986','bbbb','5555','Orna','Asher')
INSERT INTO Patients VALUES('191919191','BB','Tal','Shalom','25/10/2000','bbbb','5959','Tami','Oren')
INSERT INTO Patients VALUES('232323232','EE','Gil','Levi','08/12/1985','bbabb','1525','Lea','Shlomi')

Delete from Treatment
INSERT INTO Treatment VALUES(111,'Name1','Bla Bla Bla Bla')
INSERT INTO Treatment VALUES(333,'Name2','Bla Bla')
INSERT INTO Treatment VALUES(444,'Name3','Bla Bla Bla')
INSERT INTO Treatment VALUES(555,'Name4','Bla')


Delete from Shifts
INSERT INTO Shifts VALUES('111111111','01/01/2010','13:00','20:00')
INSERT INTO Shifts VALUES('222222222','02/01/2010','13:00','20:00')
INSERT INTO Shifts VALUES('444444444','01/01/2010','14:00','21:00')
INSERT INTO Shifts VALUES('111111111','03/01/2010','09:00','16:00')
INSERT INTO Shifts VALUES('333333333','01/01/2010','13:00','21:00')
INSERT INTO Shifts VALUES('222222222','05/01/2010','13:00','20:00')

Delete from Labs
INSERT INTO Labs VALUES(99,'NameLab1','bla')
INSERT INTO Labs VALUES(88,'NameLab2','blabla')
INSERT INTO Labs VALUES(11,'NameLab3','blablabal')
INSERT INTO Labs VALUES(77,'NameLab4','bbbbbb')
INSERT INTO Labs VALUES(33,'NameLab5','aaaa')
INSERT INTO Labs VALUES(44,'NameLab6','blablabla')

Delete from Patients_Labs
INSERT INTO Patients_Labs VALUES(99,'01/01/2010','777777777','Good')
INSERT INTO Patients_Labs VALUES(11,'01/01/2010','777777777','VeryGood')
INSERT INTO Patients_Labs VALUES(99,'12/12/2009','777777777','Bad')
INSERT INTO Patients_Labs VALUES(44,'24/05/2009','999999999','Good')
INSERT INTO Patients_Labs VALUES(33,'01/01/2010','999999999','VeryGood')
INSERT INTO Patients_Labs VALUES(99,'01/01/2010','787878787','Very Very Good')
INSERT INTO Patients_Labs VALUES(77,'12/12/2009','999999999','Good')
INSERT INTO Patients_Labs VALUES(11,'02/02/2009','888888888','Bad')
INSERT INTO Patients_Labs VALUES(33,'22/03/2010','191919191','Bad')


Delete from Patients_Treatments
INSERT INTO Patients_Treatments VALUES('999999999',333,'333333333','07/05/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('888888888',555,'333333333','07/11/2009','12/07/2010')
INSERT INTO Patients_Treatments VALUES('999999999',111,'333333333','07/05/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('777777777',333,'111111111','17/05/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('777777777',111,'444444444','27/06/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('191919191',555,'444444444','01/01/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('191919191',111,'222222222','15/05/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('888888888',333,'222222222','01/01/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('999999999',555,'222222222','07/05/2010','15/07/2010')
INSERT INTO Patients_Treatments VALUES('777777777',444,'444444444','27/07/2009','15/07/2010')
INSERT INTO Patients_Treatments VALUES('777777777',555,'444444444','27/08/2009','15/07/2010')


Delete from Patients_Progress
INSERT INTO Patients_Progress
VALUES('999999999',333,'333333333','bla','bla bla','22/08/2010')
INSERT INTO Patients_Progress
VALUES('999999999',111,'333333333','blabla','bla','30/07/2010')
INSERT INTO Patients_Progress
VALUES('777777777',333,'111111111','bla','bla','15/10/2011')
INSERT INTO Patients_Progress
VALUES('777777777',111,'444444444','blablabla','bla','25/12/2010')
INSERT INTO Patients_Progress
VALUES('999999999',555,'222222222','bla','bla','15/12/2010')
INSERT INTO Patients_Progress 
VALUES('777777777',444,'444444444','bla bla','bla','13/11/2010')
INSERT INTO Patients_Progress
VALUES('777777777',555,'444444444','bla','bla','30/07/2010')