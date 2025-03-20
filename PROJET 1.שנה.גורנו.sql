USE master --- הפרויקט שלי עונה של השאלה : מהו ההשפעה של עבודה מרחוק על בריאות הנפש של העובדים, בהתבסס על תפקידם
GO/* רציתי למחוק 
DATABASE 
הקיימת של 
REMOTEWORK*/
if exists (select * from sysdatabases where name ='RemoteWork')
		drop database RemoteWork
GO
/* מתחילה לייצר ה
DATABASE*/
CREATE DATABASE RemoteWork

GO

use RemoteWork
GO 
/*הייתי לא בטוחה בהתחלה אז פתחתי טרנזקציה*/
BEGIN TRAN TR1
GO

CREATE TABLE Employee_Details
(
Employee_ID INT IDENTITY(1,1) CONSTRAINT PK_employee PRIMARY KEY, -- מפתח ראשי עם מספר מזהה אוטומטי
Age INT CONSTRAINT CK_Employee_Age CHECK (Age >= 18), -- השיק מאפשר לא לקבל ערך מתחת ל18 אז יהיה רק עובדים מעל 18
Gender VARCHAR(10) NOT NULL CONSTRAINT CK_Employee_gender CHECK ( GENDER IN ('Male', 'Female', 'Non-binary', 'Prefer not to say')), --- העמודה מאפשרת רק 4 אופציות ולא יכולה לקבל נול
Years_of_Experience INT CONSTRAINT CK_Employee_YearofExp CHECK (Years_of_Experience >= 0) --- השיק מאפשר לקבל רק ערך גדול מ0 כלומר לא יהיה עובדים בלי לפחות שנה בניסיון
)
GO

COMMIT TRAN TR1

GO 
/*מתחילה לייצר טבלה של 
REGIONS
*/

CREATE TABLE Regions
(
RegionID INT IDENTITY(1,1) CONSTRAINT PK_Regions PRIMARY KEY,
Region_Name VARCHAR(100) CONSTRAINT NN_Regions_Name NOT NULL
)

GO

/*מוסיפה את העמודה 
REGIONID 
בתוך הטבלה
EMPLOYEE_DETAILS*/

begin tran tr2
go 

ALTER TABLE Employee_details
ADD RegionID INT CONSTRAINT FK_Employee_Regions FOREIGN KEY REFERENCES Regions(RegionID)

go 

commit tran tr2

go 
/* הטרנזקציה עבד אז סוגרת אותה */
/*מתחילה להוסיף ערכים של הטבלה 
REGIONS
לא צריך 
REGION_ID
כי הוא 
IDENTITY*/

INSERT INTO Regions (Region_Name)
VALUES ('Europe'),
('Asia'),
('North America'),
('South America'),
('Oceania'),
('Africa')

GO

ALTER TABLE Employee_Details
ALTER COLUMN Gender VARCHAR(20)

go 

INSERT INTO Employee_details VALUES
(32,'Non-binary',13,1),
(40,'Female',3,2),
(59,'Non-binary',22,3),
(27,'Male',20,1),
(49,'Male',32,3),
(59,'Non-binary',31,4),
(31,'Prefer not to say',24,2),
(42,'Non-binary',6,3),
(56,'Prefer not to say',9,1),
(30,'Female',28,3),
(33,'Non-binary',17,5),
(47,'Female',31,6),
(40,'Female',1,1),
(51,'Non-binary',5,3),
(36,'Prefer not to say',23,5),
(56,'Female',13,6),
(33,'Prefer not to say',3,6),
(45,'Non-binary',20,1),
(49,'Non-binary',30,5),
(59,'Male',13,4),
(26,'Female',33,4),
(26,'Non-binary',21,3),
(43,'Prefer not to say',21,6),
(53,'Non-binary',11,2),
(56,'Male',6,3),
(49,'Male',23,4),
(36,'Non-binary',30,3),
(53,'Female',31,5),
(47,'Prefer not to say',22,1),
(59,'Male',34,3),
(22,'Female',22,2),
(37,'Prefer not to say',4,3),
(45,'Prefer not to say',29,3),
(48,'Male',27,3),
(36,'Male',24,1),
(46,'Prefer not to say',28,1),
(48,'Male',10,2),
(31,'Female',18,2),
(24,'Non-binary',21,6),
(49,'Male',20,2),
(30,'Non-binary',22,1),
(53,'Male',14,3),
(54,'Prefer not to say',26,1),
(54,'Female',12,1),
(57,'Prefer not to say',13,4),
(32,'Male',24,3),
(33,'Male',33,4),
(30,'Female',4,5),
(22,'Female',7,6),
(35,'Male',11,1),
(26,'Non-binary',34,1),
(47,'Male',25,4),
(42,'Female',3,4),
(60,'Prefer not to say',34,2),
(26,'Female',5,2),
(30,'Non-binary',8,6),
(42,'Male',14,2),
(53,'Prefer not to say',7,4),
(26,'Prefer not to say',31,5),
(26,'Prefer not to say',17,5),
(25,'Non-binary',4,1),
(33,'Female',14,3),
(25,'Non-binary',20,2),
(22,'Female',5,4),
(60,'Prefer not to say',18,5),
(56,'Male',9,1),
(45,'Non-binary',6,5),
(60,'Female',32,5),
(32,'Female',23,4),
(25,'Female',6,3)

GO

BEGIN TRAN TR4 /* כשעשיתי את הפעולה העמודה של 
EMPLOYEE_ID 
לא התחילה ב1 כי מחקתי נתונים בהתחלה אז חיפשתי פונקציה שמאפשר לעשות איפוס על מה שמחקתי כמו 
DBCC 
לא הייתי בטוחה מזה אז פתחתי טרנזקציה 
*/

GO

DELETE FROM Employee_Details

GO

DBCC CHECKIDENT ('Employee_Details', RESEED, 0)

GO
/* פה הייתי רוצה לבדוק שהשורה הראשונה בטבלה מתחילה ב1 לפני להוסיף את כל השורות*/

INSERT INTO Employee_details VALUES
(32,'Non-binary',13,1)

GO

COMMIT TRAN TR4

GO
/*עבד כמו שצריך אז סגרתי טרנזקציה והוספתי כל הנתונים של טבלה 
EMPLOYEE_DETAILS*/

INSERT INTO Employee_details VALUES
(40,'Female',3,2),
(59,'Non-binary',22,3),
(27,'Male',20,1),
(49,'Male',32,3),
(59,'Non-binary',31,4),
(31,'Prefer not to say',24,2),
(42,'Non-binary',6,3),
(56,'Prefer not to say',9,1),
(30,'Female',28,3),
(33,'Non-binary',17,5),
(47,'Female',31,6),
(40,'Female',1,1),
(51,'Non-binary',5,3),
(36,'Prefer not to say',23,5),
(56,'Female',13,6),
(33,'Prefer not to say',3,6),
(45,'Non-binary',20,1),
(49,'Non-binary',30,5),
(59,'Male',13,4),
(26,'Female',33,4),
(26,'Non-binary',21,3),
(43,'Prefer not to say',21,6),
(53,'Non-binary',11,2),
(56,'Male',6,3),
(49,'Male',23,4),
(36,'Non-binary',30,3),
(53,'Female',31,5),
(47,'Prefer not to say',22,1),
(59,'Male',34,3),
(22,'Female',22,2),
(37,'Prefer not to say',4,3),
(45,'Prefer not to say',29,3),
(48,'Male',27,3),
(36,'Male',24,1),
(46,'Prefer not to say',28,1),
(48,'Male',10,2),
(31,'Female',18,2),
(24,'Non-binary',21,6),
(49,'Male',20,2),
(30,'Non-binary',22,1),
(53,'Male',14,3),
(54,'Prefer not to say',26,1),
(54,'Female',12,1),
(57,'Prefer not to say',13,4),
(32,'Male',24,3),
(33,'Male',33,4),
(30,'Female',4,5),
(22,'Female',7,6),
(35,'Male',11,1),
(26,'Non-binary',34,1),
(47,'Male',25,4),
(42,'Female',3,4),
(60,'Prefer not to say',34,2),
(26,'Female',5,2),
(30,'Non-binary',8,6),
(42,'Male',14,2),
(53,'Prefer not to say',7,4),
(26,'Prefer not to say',31,5),
(26,'Prefer not to say',17,5),
(25,'Non-binary',4,1),
(33,'Female',14,3),
(25,'Non-binary',20,2),
(22,'Female',5,4),
(60,'Prefer not to say',18,5),
(56,'Male',9,1),
(45,'Non-binary',6,5),
(60,'Female',32,5),
(32,'Female',23,4),
(25,'Female',6,3)

GO
/*מתחילה לייצר טבלה של
JOB_ROLES
כי הוא מכיל רק 
PK 
שקשרים לטבלה אחר יותר מורכב אז יותר קל לייצר אותו*/

CREATE TABLE Job_Roles 
(
Job_RoleID INT IDENTITY(1,1) CONSTRAINT PK_Job_Role PRIMARY KEY, -- מפתח ראשי עם מספר מזהה אוטומטי
Job_Role_Name VARCHAR(100) CONSTRAINT NN_Job_Role_Name NOT NULL --  התפקיד חייב להיות רשום לא יכול להיות (NULL) 
)

GO
/*אני מוסיפה את כל הנתונים של הטבלה 
JOB_ROLES*/

INSERT INTO Job_Roles VALUES
('HR'),
('Data Scientist'),
('Software Engineer'),
('Sales'),
('Marketing'),
('Designer'),
('Project Manager')

GO
/*אני מתחילה לייצר טבלה של 
INDUSTRIES
אני עושה 
IDENTITY
שמתחיל מ101 ככה יהיה שילוב בין המספרים בטבלה */

CREATE TABLE INDUSTRIES
(
IndustryID INT IDENTITY(101,1) CONSTRAINT PK_Industry PRIMARY KEY, -- מפתח ראשי עם מספר מזהה אוטומטישמתחיל מ101
Industry_Name VARCHAR(30) CONSTRAINT NN_Industry_Name NOT NULL -- התפקיד חייב להיות רשום לא יכול להיות (NULL) 
)

GO
/*רציתי להוסיף את הנתונים של טבלה 
INDUSTRIES
אבל לא הייתי בטוחה אז פתחתי טנזקציה */

BEGIN TRAN TR5

GO 


INSERT INTO INDUSTRIES VALUES
('Healthcare'),
('IT'),
('Education'),
('Finance'),
('Consulting'),
('Manufacturing'),
('Retail')

GO

COMMIT TRAN TR5

GO
/*עבד כמו שצריך אז סגרתי את הטרנזקציה*/
/* אני מתחילה עכשיו לייצר את הטבלה 
WORK_DETAILS
מורכב מכמה 
FK*/

/* האמת שהיה לי בעייה כי לפי מה שקבעתי בהתחלה חשבתי ש
EMPLOYEE_ID
ו
WORK_ID
יהיה אותו דבר אבל לא יהיה הגיוני בסוף אז בניתי שורות נוספות שלכמה מ
EMPLOYEE_ID
יהיה יותר משורה אחת ב
WORK_DETAILS
שזה אומר שלכמה עובדים יהיה
JOB_ROLE,INDUSTRIES
שונה*/

BEGIN TRAN TR6

GO 

CREATE TABLE Work_Details
(
WorkID INT IDENTITY(1,1) CONSTRAINT PK_Work_Details PRIMARY KEY, -- מפתח ראשי עם מספר מזהה אוטומטי
Employee_ID INT NOT NULL CONSTRAINT FK_Work_Employee FOREIGN KEY REFERENCES Employee_Details(Employee_ID), -- מפתח זר לטבלה ההוא
Job_RoleID INT NOT NULL CONSTRAINT FK_Work_Job_Role FOREIGN KEY REFERENCES Job_Roles(Job_RoleID), -- מפתח זר לטבלה ההוא
IndustryID INT NOT NULL CONSTRAINT FK_Work_Industry FOREIGN KEY REFERENCES Industries(IndustryID), -- מפתח זר לטבלה ההוא
Work_Location VARCHAR(30) CONSTRAINT NN_Work_loc NOT NULL CHECK( Work_Location IN ('Hybrid', 'Remote', 'Onsite')), --- עמודה חדשה שהיא יכולה לקבל רק 3 אופציות לא יכולה להיות נול
Satisfaction_with_Remote_Work VARCHAR(20) CONSTRAINT NN_Satisfaction_Work NOT NULL CHECK (Satisfaction_with_Remote_Work IN ('Satisfied', 'Unsatisfied', 'Neutral')),-- עמודה חדשה  שיכולה לקבל רק 3 אופציות על ידי הCHECK
Stress_Level VARCHAR(10) CONSTRAINT NN_Stress_Level NOT NULL CHECK (Stress_Level IN ('High', 'Medium', 'Low')), -- עמודה חדשה  שיכולה לקבל רק 3 אופציות על ידי הCHECK
Mental_Health_Condition VARCHAR(20) CONSTRAINT NN_Mental_Health CHECK (Mental_Health_Condition IN ('Depression', 'Anxiety', 'Burnout', 'NULL')) DEFAULT NULL -- כאן אם לא יהיה נתון הוספתי יכולת לעמודה לקבל NULL
)
GO 

COMMIT TRAN TR6

GO
/*אני רוצה לנסות להוסיף את כל הנתונים של הטבלה 
WORKDETAILS
אז אני עושה טרנזקציה*/
BEGIN TRAN TR7

GO

INSERT INTO Work_Details VALUES
(1,1,101,'Hybrid','Unsatisfied','Medium','Depression'),
(2,2,102,'Remote','Satisfied','Medium','Anxiety'),
(2,2,101,'Remote','Unsatisfied','High','Anxiety'),
(3,3,103,'Hybrid','Unsatisfied','Medium','Anxiety'),
(4,3,104,'Onsite','Unsatisfied','High','Depression'),
(5,4,105,'Onsite','Unsatisfied','High',''),
(6,4,102,'Hybrid','Unsatisfied','High',''),
(7,4,102,'Remote','Neutral','Low','Anxiety'),
(8,3,106,'Remote','Unsatisfied','High','Depression'),
(8,2,106,'Onsite','Satisfied','Medium','Depression'),
(9,2,101,'Hybrid','Unsatisfied','High',''),
(10,1,102,'Hybrid','Neutral','Low','Depression'),
(10,5,105,'Onsite','Neutral','Medium',''),
(11,3,104,'Remote','Satisfied','High',''),
(12,5,105,'Hybrid','Neutral','Medium',''),
(13,5,105,'Remote','Neutral','High','Depression'),
(14,6,106,'Hybrid','Satisfied','Low','Anxiety'),
(14,6,103,'Onsite','Satisfied','Low',''),
(15,7,107,'Remote','Neutral','High','Anxiety'),
(16,4,101,'Remote','Satisfied','Low','Anxiety'),
(17,1,103,'Onsite','Satisfied','Medium',''),
(18,2,105,'Onsite','Neutral','Low','Burnout'),
(18,2,106,'Remote','Neutral','Low','Anxiety'),
(19,3,102,'Remote','Satisfied','High','Anxiety'),
(20,3,105,'Remote','Neutral','Medium','Anxiety'),
(21,4,107,'Hybrid','Satisfied','Low','Burnout'),
(22,4,103,'Onsite','Unsatisfied','Medium','Depression'),
(23,4,104,'Onsite','Satisfied','Low','Depression'),
(24,5,105,'Onsite','Neutral','Low','Depression'),
(24,4,105,'Onsite','Neutral','Low',''),
(24,6,105,'Onsite','Satisfied','Low',''),
(25,4,104,'Remote','Neutral','Low','Burnout'),
(26,7,101,'Onsite','Neutral','High','Burnout'),
(27,7,107,'Onsite','Unsatisfied','High',''),
(28,7,107,'Onsite','Unsatisfied','Low','Depression'),
(29,4,102,'Onsite','Satisfied','High','Depression'),
(29,4,107,'Onsite','Unsatisfied','High','Depression'),
(30,3,101,'Remote','Satisfied','High','Depression'),
(30,5,101,'Remote','Unsatisfied','High','Depression'),
(31,2,102,'Onsite','Neutral','Low','Anxiety'),
(32,5,106,'Hybrid','Satisfied','Medium','Depression'),
(33,7,106,'Remote','Satisfied','Medium','Anxiety'),
(34,3,101,'Remote','Neutral','Medium','Anxiety'),
(35,6,102,'Hybrid','Unsatisfied','Medium','Depression'),
(36,4,101,'Hybrid','Neutral','Low',''),
(37,4,104,'Onsite','Satisfied','Low','Depression'),
(38,6,105,'Onsite','Unsatisfied','Low',''),
(38,6,107,'Onsite','Unsatisfied','Low',''),
(38,6,101,'Remote','Satisfied','Low',''),
(39,4,102,'Onsite','Neutral','Low','Anxiety'),
(40,5,105,'Hybrid','Unsatisfied','High',''),
(41,2,102,'Remote','Neutral','High','Burnout'),
(42,7,102,'Onsite','Unsatisfied','Low',''),
(43,7,104,'Remote','Unsatisfied','High',''),
(43,4,104,'Onsite','Satisfied','High',''),
(44,6,106,'Remote','Unsatisfied','Medium','Depression'),
(45,1,107,'Remote','Neutral','High','Anxiety'),
(45,1,103,'Onsite','Neutral','Medium','Anxiety'),
(46,5,107,'Remote','Neutral','Medium','Burnout'),
(47,2,103,'Remote','Unsatisfied','Medium','Burnout'),
(48,4,105,'Remote','Unsatisfied','High',''),
(49,1,101,'Onsite','Neutral','Low',''),
(50,7,107,'Onsite','Satisfied','Medium','Burnout'),
(51,1,106,'Onsite','Satisfied','High','Anxiety'),
(51,4,106,'Onsite','Satisfied','High','Anxiety'),
(52,4,105,'Remote','Satisfied','Low',''),
(53,3,107,'Onsite','Satisfied','Medium',''),
(53,7,103,'Onsite','Neutral','Medium',''),
(54,7,101,'Onsite','Neutral','Medium','Depression'),
(55,3,103,'Hybrid','Satisfied','Medium','Burnout'),
(56,7,103,'Hybrid','Neutral','Low','Anxiety'),
(57,3,102,'Remote','Neutral','Low','Depression'),
(57,3,106,'Remote','Satisfied','Low',''),
(58,1,102,'Onsite','Satisfied','Low',''),
(59,6,106,'Remote','Unsatisfied','Low',''),
(60,2,102,'Remote','Satisfied','Medium',''),
(60,3,102,'Remote','Satisfied','Medium',''),
(61,4,105,'Hybrid','Unsatisfied','Medium','Depression'),
(62,4,102,'Remote','Unsatisfied','Medium','Depression'),
(63,7,104,'Hybrid','Satisfied','Medium','Depression'),
(64,3,101,'Onsite','Satisfied','Medium','Depression'),
(65,2,101,'Hybrid','Unsatisfied','Medium','Burnout'),
(65,5,101,'Onsite','Satisfied','Medium','Anxiety'),
(66,1,104,'Remote','Satisfied','Medium','Anxiety'),
(67,3,102,'Hybrid','Satisfied','Medium','Burnout'),
(67,5,101,'Hybrid','Satisfied','Medium',''),
(68,5,103,'Remote','Unsatisfied','High',''),
(69,6,106,'Onsite','Neutral','High','Anxiety'),
(70,5,104,'Remote','Neutral','Low',''),
(70,5,101,'Onsite','Neutral','High','')

GO

ROLLBACK TRAN TR7

GO

/* יש לי משהוא שלא עבד בעמודה של 
Mental_Health_Condition
רציתי כיהיה ריק אז אפשר לקבל 
NULL
אבל עשיתי טעות הוספתי 
'NULL' 
כנתון בטבלה, אז אני צריכה לבטל על ה
CONSTRAINT NN_Mental_Health
ואז להוסיף אותה מחדש*/

ALTER TABLE Work_Details
DROP CONSTRAINT NN_Mental_Health

GO

ALTER TABLE Work_Details
ADD CONSTRAINT NN_Mental_Health 
CHECK (Mental_Health_Condition IN ('Depression', 'Anxiety', 'Burnout') OR Mental_Health_Condition IS NULL)

GO

BEGIN TRAN TR8

GO 

INSERT INTO Work_Details VALUES
(1,1,101,'Hybrid','Unsatisfied','Medium','Depression'),
(2,2,102,'Remote','Satisfied','Medium','Anxiety'),
(2,2,101,'Remote','Unsatisfied','High','Anxiety'),
(3,3,103,'Hybrid','Unsatisfied','Medium','Anxiety'),
(4,3,104,'Onsite','Unsatisfied','High','Depression'),
(5,4,105,'Onsite','Unsatisfied','High',''),
(6,4,102,'Hybrid','Unsatisfied','High',''),
(7,4,102,'Remote','Neutral','Low','Anxiety'),
(8,3,106,'Remote','Unsatisfied','High','Depression'),
(8,2,106,'Onsite','Satisfied','Medium','Depression'),
(9,2,101,'Hybrid','Unsatisfied','High',''),
(10,1,102,'Hybrid','Neutral','Low','Depression'),
(10,5,105,'Onsite','Neutral','Medium',''),
(11,3,104,'Remote','Satisfied','High',''),
(12,5,105,'Hybrid','Neutral','Medium',''),
(13,5,105,'Remote','Neutral','High','Depression'),
(14,6,106,'Hybrid','Satisfied','Low','Anxiety'),
(14,6,103,'Onsite','Satisfied','Low',''),
(15,7,107,'Remote','Neutral','High','Anxiety'),
(16,4,101,'Remote','Satisfied','Low','Anxiety'),
(17,1,103,'Onsite','Satisfied','Medium',''),
(18,2,105,'Onsite','Neutral','Low','Burnout'),
(18,2,106,'Remote','Neutral','Low','Anxiety'),
(19,3,102,'Remote','Satisfied','High','Anxiety'),
(20,3,105,'Remote','Neutral','Medium','Anxiety'),
(21,4,107,'Hybrid','Satisfied','Low','Burnout'),
(22,4,103,'Onsite','Unsatisfied','Medium','Depression'),
(23,4,104,'Onsite','Satisfied','Low','Depression'),
(24,5,105,'Onsite','Neutral','Low','Depression'),
(24,4,105,'Onsite','Neutral','Low',''),
(24,6,105,'Onsite','Satisfied','Low',''),
(25,4,104,'Remote','Neutral','Low','Burnout'),
(26,7,101,'Onsite','Neutral','High','Burnout'),
(27,7,107,'Onsite','Unsatisfied','High',''),
(28,7,107,'Onsite','Unsatisfied','Low','Depression'),
(29,4,102,'Onsite','Satisfied','High','Depression'),
(29,4,107,'Onsite','Unsatisfied','High','Depression'),
(30,3,101,'Remote','Satisfied','High','Depression'),
(30,5,101,'Remote','Unsatisfied','High','Depression'),
(31,2,102,'Onsite','Neutral','Low','Anxiety'),
(32,5,106,'Hybrid','Satisfied','Medium','Depression'),
(33,7,106,'Remote','Satisfied','Medium','Anxiety'),
(34,3,101,'Remote','Neutral','Medium','Anxiety'),
(35,6,102,'Hybrid','Unsatisfied','Medium','Depression'),
(36,4,101,'Hybrid','Neutral','Low',''),
(37,4,104,'Onsite','Satisfied','Low','Depression'),
(38,6,105,'Onsite','Unsatisfied','Low',''),
(38,6,107,'Onsite','Unsatisfied','Low',''),
(38,6,101,'Remote','Satisfied','Low',''),
(39,4,102,'Onsite','Neutral','Low','Anxiety'),
(40,5,105,'Hybrid','Unsatisfied','High',''),
(41,2,102,'Remote','Neutral','High','Burnout'),
(42,7,102,'Onsite','Unsatisfied','Low',''),
(43,7,104,'Remote','Unsatisfied','High',''),
(43,4,104,'Onsite','Satisfied','High',''),
(44,6,106,'Remote','Unsatisfied','Medium','Depression'),
(45,1,107,'Remote','Neutral','High','Anxiety'),
(45,1,103,'Onsite','Neutral','Medium','Anxiety'),
(46,5,107,'Remote','Neutral','Medium','Burnout'),
(47,2,103,'Remote','Unsatisfied','Medium','Burnout'),
(48,4,105,'Remote','Unsatisfied','High',''),
(49,1,101,'Onsite','Neutral','Low',''),
(50,7,107,'Onsite','Satisfied','Medium','Burnout'),
(51,1,106,'Onsite','Satisfied','High','Anxiety'),
(51,4,106,'Onsite','Satisfied','High','Anxiety'),
(52,4,105,'Remote','Satisfied','Low',''),
(53,3,107,'Onsite','Satisfied','Medium',''),
(53,7,103,'Onsite','Neutral','Medium',''),
(54,7,101,'Onsite','Neutral','Medium','Depression'),
(55,3,103,'Hybrid','Satisfied','Medium','Burnout'),
(56,7,103,'Hybrid','Neutral','Low','Anxiety'),
(57,3,102,'Remote','Neutral','Low','Depression'),
(57,3,106,'Remote','Satisfied','Low',''),
(58,1,102,'Onsite','Satisfied','Low',''),
(59,6,106,'Remote','Unsatisfied','Low',''),
(60,2,102,'Remote','Satisfied','Medium',''),
(60,3,102,'Remote','Satisfied','Medium',''),
(61,4,105,'Hybrid','Unsatisfied','Medium','Depression'),
(62,4,102,'Remote','Unsatisfied','Medium','Depression'),
(63,7,104,'Hybrid','Satisfied','Medium','Depression'),
(64,3,101,'Onsite','Satisfied','Medium','Depression'),
(65,2,101,'Hybrid','Unsatisfied','Medium','Burnout'),
(65,5,101,'Onsite','Satisfied','Medium','Anxiety'),
(66,1,104,'Remote','Satisfied','Medium','Anxiety'),
(67,3,102,'Hybrid','Satisfied','Medium','Burnout'),
(67,5,101,'Hybrid','Satisfied','Medium',''),
(68,5,103,'Remote','Unsatisfied','High',''),
(69,6,106,'Onsite','Neutral','High','Anxiety'),
(70,5,104,'Remote','Neutral','Low',''),
(70,5,101,'Onsite','Neutral','High','')

GO

ROLLBACK TRAN TR8

GO 

/*יש לי אותו בעייה, בטבלה עם הנתונים באקסל יש ריק כשאין נתון ב
MENTAL_HEALTH
אז שיניתי כל נתון ריק ל
NULL*/

BEGIN TRAN TR9

GO 


INSERT INTO Work_Details VALUES
(1,1,101,'Hybrid','Unsatisfied','Medium','Depression'),
(2,2,102,'Remote','Satisfied','Medium','Anxiety'),
(2,2,101,'Remote','Unsatisfied','High','Anxiety'),
(3,3,103,'Hybrid','Unsatisfied','Medium','Anxiety'),
(4,3,104,'Onsite','Unsatisfied','High','Depression'),
(5,4,105,'Onsite','Unsatisfied','High',NULL),
(6,4,102,'Hybrid','Unsatisfied','High',NULL),
(7,4,102,'Remote','Neutral','Low','Anxiety'),
(8,3,106,'Remote','Unsatisfied','High','Depression'),
(8,2,106,'Onsite','Satisfied','Medium','Depression'),
(9,2,101,'Hybrid','Unsatisfied','High',NULL),
(10,1,102,'Hybrid','Neutral','Low','Depression'),
(10,5,105,'Onsite','Neutral','Medium',NULL),
(11,3,104,'Remote','Satisfied','High',NULL),
(12,5,105,'Hybrid','Neutral','Medium',NULL),
(13,5,105,'Remote','Neutral','High','Depression'),
(14,6,106,'Hybrid','Satisfied','Low','Anxiety'),
(14,6,103,'Onsite','Satisfied','Low',NULL),
(15,7,107,'Remote','Neutral','High','Anxiety'),
(16,4,101,'Remote','Satisfied','Low','Anxiety'),
(17,1,103,'Onsite','Satisfied','Medium',NULL),
(18,2,105,'Onsite','Neutral','Low','Burnout'),
(18,2,106,'Remote','Neutral','Low','Anxiety'),
(19,3,102,'Remote','Satisfied','High','Anxiety'),
(20,3,105,'Remote','Neutral','Medium','Anxiety'),
(21,4,107,'Hybrid','Satisfied','Low','Burnout'),
(22,4,103,'Onsite','Unsatisfied','Medium','Depression'),
(23,4,104,'Onsite','Satisfied','Low','Depression'),
(24,5,105,'Onsite','Neutral','Low','Depression'),
(24,4,105,'Onsite','Neutral','Low',NULL),
(24,6,105,'Onsite','Satisfied','Low',NULL),
(25,4,104,'Remote','Neutral','Low','Burnout'),
(26,7,101,'Onsite','Neutral','High','Burnout'),
(27,7,107,'Onsite','Unsatisfied','High',NULL),
(28,7,107,'Onsite','Unsatisfied','Low','Depression'),
(29,4,102,'Onsite','Satisfied','High','Depression'),
(29,4,107,'Onsite','Unsatisfied','High','Depression'),
(30,3,101,'Remote','Satisfied','High','Depression'),
(30,5,101,'Remote','Unsatisfied','High','Depression'),
(31,2,102,'Onsite','Neutral','Low','Anxiety'),
(32,5,106,'Hybrid','Satisfied','Medium','Depression'),
(33,7,106,'Remote','Satisfied','Medium','Anxiety'),
(34,3,101,'Remote','Neutral','Medium','Anxiety'),
(35,6,102,'Hybrid','Unsatisfied','Medium','Depression'),
(36,4,101,'Hybrid','Neutral','Low',NULL),
(37,4,104,'Onsite','Satisfied','Low','Depression'),
(38,6,105,'Onsite','Unsatisfied','Low',NULL),
(38,6,107,'Onsite','Unsatisfied','Low',NULL),
(38,6,101,'Remote','Satisfied','Low',NULL),
(39,4,102,'Onsite','Neutral','Low','Anxiety'),
(40,5,105,'Hybrid','Unsatisfied','High',NULL),
(41,2,102,'Remote','Neutral','High','Burnout'),
(42,7,102,'Onsite','Unsatisfied','Low',NULL),
(43,7,104,'Remote','Unsatisfied','High',NULL),
(43,4,104,'Onsite','Satisfied','High',NULL),
(44,6,106,'Remote','Unsatisfied','Medium','Depression'),
(45,1,107,'Remote','Neutral','High','Anxiety'),
(45,1,103,'Onsite','Neutral','Medium','Anxiety'),
(46,5,107,'Remote','Neutral','Medium','Burnout'),
(47,2,103,'Remote','Unsatisfied','Medium','Burnout'),
(48,4,105,'Remote','Unsatisfied','High',NULL),
(49,1,101,'Onsite','Neutral','Low',NULL),
(50,7,107,'Onsite','Satisfied','Medium','Burnout'),
(51,1,106,'Onsite','Satisfied','High','Anxiety'),
(51,4,106,'Onsite','Satisfied','High','Anxiety'),
(52,4,105,'Remote','Satisfied','Low',NULL),
(53,3,107,'Onsite','Satisfied','Medium',NULL),
(53,7,103,'Onsite','Neutral','Medium',NULL),
(54,7,101,'Onsite','Neutral','Medium','Depression'),
(55,3,103,'Hybrid','Satisfied','Medium','Burnout'),
(56,7,103,'Hybrid','Neutral','Low','Anxiety'),
(57,3,102,'Remote','Neutral','Low','Depression'),
(57,3,106,'Remote','Satisfied','Low',NULL),
(58,1,102,'Onsite','Satisfied','Low', NULL),
(59,6,106,'Remote','Unsatisfied','Low', NULL ),
(60,2,102,'Remote','Satisfied','Medium', NULL),
(60,3,102,'Remote','Satisfied','Medium', NULL),
(61,4,105,'Hybrid','Unsatisfied','Medium','Depression'),
(62,4,102,'Remote','Unsatisfied','Medium','Depression'),
(63,7,104,'Hybrid','Satisfied','Medium','Depression'),
(64,3,101,'Onsite','Satisfied','Medium','Depression'),
(65,2,101,'Hybrid','Unsatisfied','Medium','Burnout'),
(65,5,101,'Onsite','Satisfied','Medium','Anxiety'),
(66,1,104,'Remote','Satisfied','Medium','Anxiety'),
(67,3,102,'Hybrid','Satisfied','Medium','Burnout'),
(67,5,101,'Hybrid','Satisfied','Medium', NULL ),
(68,5,103,'Remote','Unsatisfied','High', NULL ),
(69,6,106,'Onsite','Neutral','High','Anxiety'),
(70,5,104,'Remote','Neutral','Low', NULL),
(70,5,101,'Onsite','Neutral','High', NULL)

GO 

/* זה עובד אז אני סוגרת את הטרנזקציה */

COMMIT TRAN TR9

GO 

/* עכשיו אני עושה כמה בדיקות כדי לבדוק שהטבלאות שבניתי עובדים*/ 
-- בדיקות קלות
-- בדיקה של טבלה REGIONS
SELECT * FROM Regions

GO

-- בדיקה של טבלה Job_Roles
SELECT * FROM Job_Roles

GO

-- בדיקה של טבלה Industries
SELECT * FROM Industries

GO

-- בדיקה של טבלה Employee_Details
SELECT * FROM Employee_Details

GO

-- בדיקה של טבלה Work_Details
SELECT * FROM Work_Details

GO

/* בדיקה קשר בין הטבלאות */ 

SELECT 
    e.Employee_ID, 
    e.Age, 
    e.Gender, 
    r.Region_Name
FROM Employee_Details e
JOIN Regions r 
ON e.RegionID = r.RegionID

GO
/* מאפשר לקבל כל מקומות של העובדים */ 

SELECT 
    e.Employee_ID, 
    e.Age, 
    e.Gender, 
    w.WorkID, 
    j.Job_Role_Name, 
    i.Industry_Name, 
    w.Work_Location, 
    w.Satisfaction_with_Remote_Work, 
    w.Stress_Level
FROM Employee_Details e
JOIN Work_Details w 
ON e.Employee_ID = w.Employee_ID
JOIN Job_Roles j 
ON w.Job_RoleID = j.Job_RoleID
JOIN Industries i
ON w.IndustryID = i.IndustryID

GO

/* נותן את כל המידע שאפשר לקבל לעובדים לכל המשרה שהיה לו בחיים עם הפרטי אישיים ואך הוא מרגיש עם המקום עבודה שלו */ 

/* בדיקה סטטיסטיקה */

SELECT 
    e.Employee_ID, 
    e.Age, 
    w.Satisfaction_with_Remote_Work, 
    w.Stress_Level
FROM Employee_Details e
JOIN Work_Details w 
ON e.Employee_ID = w.Employee_ID

GO 

/* מאפשר לקבל מידע על העובדים עם המקום עבודה שלהם וליחוץ בעבודה */ 

SELECT 
    e.Employee_ID, 
    e.Age, 
    w.Stress_Level
FROM Employee_Details e
JOIN Work_Details w ON e.Employee_ID = w.Employee_ID
WHERE w.Stress_Level = 'high'

GO 

/* מאפשר לקבל העובדים עם לחץ גבוע בעבודה */ 

/* תודה */ 