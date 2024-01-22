CREATE DATABASE Advising_Team_final

use Advising_Team_final;

GO
CREATE PROCEDURE CreateAllTables

AS

CREATE TABLE Advisor 
(advisor_id INT PRIMARY KEY NOT NULL IDENTITY,
name VARCHAR(40), 
email VARCHAR(40), 
office VARCHAR(40),
password VARCHAR(40));

CREATE TABLE Student(
student_id int PRIMARY KEY NOT NULL IDENTITY ,
f_name VARCHAR(40), 
l_name VARCHAR(40),
gpa DECIMAL, 
faculty VARCHAR(40), 
email VARCHAR(40), 
major VARCHAR(40),
password VARCHAR(40), 
financial_status bit ,
semester int, 
acquired_hours int, 
assigned_hours int,
advisor_id int,
CONSTRAINT SA FOREIGN KEY(advisor_id)REFERENCES Advisor (advisor_id) ,
check(assigned_hours<=34),
check(gpa between 0.7 and 5)
);

CREATE TABLE Student_Phone 
(student_id INT NOT NULL,
phone_number VARCHAR(40) NOT NULL,
PRIMARY KEY (student_id,phone_number),
CONSTRAINT SP FOREIGN KEY(student_id)REFERENCES Student (student_id) );

CREATE TABLE Course 
(course_id INT PRIMARY KEY NOT NULL IDENTITY, 
name VARCHAR(40), 
major VARCHAR(40),
is_offered bit,
credit_hours int,
semester int);


CREATE TABLE Instructor
(instructor_id INT PRIMARY KEY NOT NULL IDENTITY, 
name VARCHAR(40),
email VARCHAR(40), 
faculty VARCHAR(40),
office VARCHAR(40)) ;


CREATE TABLE Semester 
(semester_code VARCHAR(40) PRIMARY KEY NOT NULL , 
start_date DATE,
end_date DATE) ;





CREATE TABLE Slot
(slot_id INT PRIMARY KEY NOT NULL IDENTITY,
day VARCHAR(40), 
time VARCHAR(40),
location VARCHAR(40),
course_id INT,
instructor_id int,
CONSTRAINT SC FOREIGN KEY(course_id)REFERENCES Course (course_id) ,
CONSTRAINT SI FOREIGN KEY(instructor_id)REFERENCES Instructor (instructor_id) );


CREATE TABLE Graduation_Plan
(plan_id INT NOT NULL IDENTITY, 
semester_code VARCHAR(40) NOT NULL,
semester_credit_hours INT, 
expected_grad_date date,
advisor_id int,
student_id int,
PRIMARY KEY (plan_id,semester_code),
CONSTRAINT GPA FOREIGN KEY(advisor_id)REFERENCES Advisor (advisor_id) ,
CONSTRAINT GPS FOREIGN KEY(student_id)REFERENCES Student (student_id) );


CREATE TABLE Request
(
request_id int PRIMARY KEY NOT NULL IDENTITY,
type VARCHAR(40),
comment VARCHAR(40),
status VARCHAR(40) DEFAULT 'pending',
credit_hours INT,
student_id INT,
advisor_id INT,
course_id INT,
CONSTRAINT RA FOREIGN KEY(advisor_id)REFERENCES Advisor (advisor_id) ,
CONSTRAINT RS FOREIGN KEY(student_id)REFERENCES Student (student_id) ,
CONSTRAINT RC FOREIGN KEY(course_id) REFERENCES Course (course_id));


CREATE TABLE MakeUp_Exam 
(exam_id INT PRIMARY KEY NOT NULL IDENTITY,
date DATETIME,
type VARCHAR(40),
course_id INT,
CONSTRAINT MC FOREIGN KEY(course_id)REFERENCES Course (course_id) );


CREATE TABLE Payment
(payment_id INT PRIMARY KEY NOT NULL IDENTITY,
amount INT,
deadline DATETIME, 
n_installments INT, 
status VARCHAR(40) DEFAULT 'notPaid',
fund_percentage DECIMAL, 
start_date DATETIME,
student_id INT, 
semester_code VARCHAR(40), 
CONSTRAINT PS FOREIGN KEY(student_id)REFERENCES Student (student_id) ,
CONSTRAINT PSC FOREIGN KEY(semester_code)REFERENCES Semester (semester_code));


CREATE TABLE Installment 
(payment_id INT NOT NULL, 
deadline DATETIME  NOT NULL, 
amount INT,
status VARCHAR(40), 
start_date DATETIME,
PRIMARY KEY (payment_id,deadline),
CONSTRAINT IP FOREIGN KEY(payment_id)REFERENCES Payment (payment_id) );

CREATE TABLE PreqCourse_course
(prerequisite_course_id INT NOT NULL,
course_id INT NOT NULL,
PRIMARY KEY (prerequisite_course_id,course_id),
CONSTRAINT PC FOREIGN KEY(course_id)REFERENCES Course (course_id) ,
CONSTRAINT PPC FOREIGN KEY(prerequisite_course_id)REFERENCES Course (course_id) );

CREATE TABLE Instructor_Course (
course_id INT  NOT NULL, 
instructor_id INT  NOT NULL,
PRIMARY KEY (course_id,instructor_id),
CONSTRAINT IC FOREIGN KEY(course_id) REFERENCES Course (course_id) ,
CONSTRAINT II FOREIGN KEY(instructor_id) REFERENCES Instructor (instructor_id) );

CREATE TABLE Student_Instructor_Course_Take 
(student_id INT  NOT NULL, 
course_id INT NOT NULL, 
instructor_id INT  NOT NULL,
semester_code VARCHAR(40), 
exam_type VARCHAR(40) DEFAULT 'Normal', 
grade VARCHAR(40),
PRIMARY KEY (student_id,course_id,semester_code),
CONSTRAINT SIS FOREIGN KEY(student_id)REFERENCES Student (student_id) ,
CONSTRAINT SIC FOREIGN KEY(course_id) REFERENCES Course (course_id) ,
CONSTRAINT SII FOREIGN KEY(instructor_id) REFERENCES Instructor (instructor_id) ); 


CREATE TABLE Course_Semester 
(course_id INT  NOT NULL, 
semester_code VARCHAR(40) NOT NULL,
PRIMARY KEY (course_id,semester_code),
CONSTRAINT CSC FOREIGN KEY(course_id) REFERENCES Course (course_id) ,
CONSTRAINT CSS FOREIGN KEY(semester_code)REFERENCES Semester (semester_code) );


CREATE TABLE GradPlan_Course 
(plan_id INT  NOT NULL, 
semester_code VARCHAR(40)  NOT NULL,
course_id INT  NOT NULL,
PRIMARY KEY (plan_id,semester_code,course_id),
CONSTRAINT GPC FOREIGN KEY(plan_id,SEMESTER_CODE) REFERENCES Graduation_Plan (plan_id,semester_code) ,
) ;

CREATE TABLE Exam_Student 
(exam_id INT NOT NULL, 
student_id INT NOT NULL, 
course_id INT NOT NULL,
PRIMARY KEY (exam_id,student_id),
CONSTRAINT ESE FOREIGN KEY(exam_id)REFERENCES MakeUp_Exam (exam_id) ,
CONSTRAINT ESS FOREIGN KEY(student_id)REFERENCES Student (student_id) 
) ;
GO


CREATE PROCEDURE DropAllTables
AS
ALTER TABLE Student
DROP CONSTRAINT SA;
ALTER TABLE Slot
DROP CONSTRAINT SC,SI;
ALTER TABLE Graduation_Plan
DROP CONSTRAINT GPA,GPS;
ALTER TABLE Request
DROP CONSTRAINT RA,RS,RC;
ALTER TABLE MakeUp_Exam
DROP CONSTRAINT MC;
ALTER TABLE Payment
DROP CONSTRAINT PS,PSC;
ALTER TABLE Installment
DROP CONSTRAINT IP;
ALTER TABLE Student_Phone
DROP CONSTRAINT SP;
ALTER TABLE PreqCourse_course
DROP CONSTRAINT PC,PPC;
ALTER TABLE Instructor_Course
DROP CONSTRAINT IC,II;
ALTER TABLE Student_Instructor_Course_Take
DROP CONSTRAINT SIS,SIC,SII;
ALTER TABLE Course_Semester
DROP CONSTRAINT CSC,CSS;
ALTER TABLE GradPlan_Course
DROP CONSTRAINT GPC;
ALTER TABLE Exam_Student
DROP CONSTRAINT ESE,ESS;

DROP Table Student;
DROP Table Course;
DROP Table Instructor;
DROP Table Semester;
DROP Table Advisor;
DROP Table Slot;
DROP Table Graduation_Plan;
DROP Table Request;
DROP Table MakeUp_Exam;
DROP Table Payment;
DROP Table Installment;
DROP Table Student_Phone;
DROP Table PreqCourse_course;
DROP Table Instructor_Course;
DROP Table Student_Instructor_Course_Take;
DROP Table Course_Semester;
DROP Table GradPlan_Course;
DROP Table  Exam_Student;

GO


CREATE PROCEDURE clearAllTables
AS
ALTER TABLE Student
DROP CONSTRAINT SA;
ALTER TABLE Slot
DROP CONSTRAINT SC,SI;
ALTER TABLE Graduation_Plan
DROP CONSTRAINT GPA,GPS;
ALTER TABLE Request
DROP CONSTRAINT RA,RS,RC;
ALTER TABLE MakeUp_Exam
DROP CONSTRAINT MC;
ALTER TABLE Payment
DROP CONSTRAINT PS,PSC;
ALTER TABLE Installment
DROP CONSTRAINT IP;
ALTER TABLE Student_Phone
DROP CONSTRAINT SP;
ALTER TABLE PreqCourse_course
DROP CONSTRAINT PC,PPC;
ALTER TABLE Instructor_Course
DROP CONSTRAINT IC,II;
ALTER TABLE Student_Instructor_Course_Take
DROP CONSTRAINT SIS,SIC,SII;
ALTER TABLE Course_Semester
DROP CONSTRAINT CSC,CSS;
ALTER TABLE GradPlan_Course
DROP CONSTRAINT GPC;
ALTER TABLE Exam_Student
DROP CONSTRAINT ESE,ESS;


Truncate Table Student;
Truncate Table Course;
Truncate Table Instructor;
Truncate Table Semester;
Truncate Table Advisor;
Truncate Table Slot;
Truncate Table Graduation_Plan;
Truncate Table Request;
Truncate Table MakeUp_Exam;
Truncate Table Payment;
Truncate Table Installment;
Truncate Table Student_Phone;
Truncate Table PreqCourse_course;
Truncate Table Instructor_Course;
Truncate Table Student_Instructor_Course_Take;
Truncate Table Course_Semester;
Truncate Table GradPlan_Course;
Truncate Table  Exam_Student;




ALTER TABLE Student
ADD CONSTRAINT SA FOREIGN KEY(student_id)REFERENCES Student (student_id) 
ALTER TABLE Slot
ADD CONSTRAINT SC FOREIGN KEY(course_id)REFERENCES Course (course_id),
 CONSTRAINT SI FOREIGN KEY(instructor_id)REFERENCES Instructor (instructor_id)
ALTER TABLE Graduation_Plan
ADD CONSTRAINT GPA FOREIGN KEY(advisor_id)REFERENCES Advisor (advisor_id) ,
Constraint GPS FOREIGN KEY(student_id)REFERENCES Student (student_id);
ALTER TABLE Request
ADD CONSTRAINT RA FOREIGN KEY(advisor_id)REFERENCES Advisor (advisor_id),
CONSTRAINT RS FOREIGN KEY(student_id)REFERENCES Student (student_id),
CONSTRAINT RC FOREIGN KEY(course_id)REFERENCES Course (course_id);
ALTER TABLE MakeUp_Exam
ADD CONSTRAINT MC FOREIGN KEY(course_id)REFERENCES Course (course_id);
ALTER TABLE Payment
ADD CONSTRAINT PS FOREIGN KEY(student_id)REFERENCES Student (student_id),
CONSTRAINT PSC FOREIGN KEY(semester_code)REFERENCES Semester (semester_code);
ALTER TABLE Installment
ADD CONSTRAINT IP FOREIGN KEY(payment_id)REFERENCES Payment (payment_id);
ALTER TABLE Student_Phone
ADD CONSTRAINT SP FOREIGN KEY(student_id)REFERENCES Student (student_id);
ALTER TABLE PreqCourse_course
ADD CONSTRAINT PC FOREIGN KEY(course_id)REFERENCES Course (course_id) ,
 CONSTRAINT PPC FOREIGN KEY(prerequisite_course_id)REFERENCES Course (course_id);
ALTER TABLE Instructor_Course
ADD CONSTRAINT IC FOREIGN KEY(course_id)REFERENCES Course (course_id) ,
CONSTRAINT II FOREIGN KEY(instructor_id)REFERENCES Instructor (instructor_id);
ALTER TABLE Student_Instructor_Course_Take
ADD CONSTRAINT SIS FOREIGN KEY(student_id)REFERENCES Student (student_id) ,
CONSTRAINT SIC FOREIGN KEY(course_id) REFERENCES Course (course_id) ,
CONSTRAINT SII FOREIGN KEY(instructor_id) REFERENCES Instructor (instructor_id);
ALTER TABLE Course_Semester
ADD CONSTRAINT CSC FOREIGN KEY(course_id)REFERENCES Course (course_id),
CONSTRAINT CSS FOREIGN KEY(semester_code)REFERENCES Semester (semester_code);
ALTER TABLE GradPlan_Course
ADD CONSTRAINT GPC FOREIGN KEY(plan_id,SEMESTER_CODE) REFERENCES Graduation_Plan (plan_id,semester_code) ;
ALTER TABLE Exam_Student
ADD CONSTRAINT ESE FOREIGN KEY(exam_id)REFERENCES MakeUp_Exam (exam_id) ,
CONSTRAINT ESS FOREIGN KEY(student_id)REFERENCES Student (student_id) ;


GO




CREATE VIEW view_Students 

AS 

SELECT * FROM Student 

GO


/*2.2.B*/ 

CREATE VIEW view_Course_prerequisites
AS

SELECT C.* , pc.prerequisite_course_id , pc.course_id AS post_course_id FROM 
COURSE C LEFT OUTER JOIN PreqCourse_course pc  
ON c.course_id =  pc.course_id 

GO


/*2.2.C*/


CREATE VIEW Instructors_AssignedCourses 

AS

SELECT i.* FROM 

Instructor i LEFT OUTER JOIN Instructor_Course ic 
ON i.instructor_id = ic.instructor_id

GO

/*2.2.D*/

CREATE VIEW Student_Payment

AS 

SELECT p.*, s.f_name , s.l_name FROM 
Payment p LEFT OUTER JOIN Student s
ON p.student_id = s.student_id

GO

/*2.2.E*/

CREATE VIEW Courses_Slots_Instructor

AS

SELECT s.Course_ID as slotc, c.name AS cname, s.slot_id, s.day, s.time ,s.location, i.name AS iname
FROM course c LEFT OUTER JOIN slot s 
ON c.course_id = s.Course_id
INNER JOIN Instructor i 
ON s.instructor_id = i.instructor_id

GO


/*2.2.F*/


CREATE VIEW Courses_MakeupExams

AS 

SELECT c.name, c.semester, m.exam_id , m.date, m.type , m.course_id as mcourse
FROM Course c LEFT OUTER JOIN MakeUp_Exam m
ON c.course_id = m.Course_id

GO

/*2.2.G*/

CREATE VIEW Students_Courses_transcript

AS

SELECT s.student_id, s.f_name, s.l_name,  c.course_id, c.name AS cname, m.type, sict.grade, sict.semester_code, i.name AS iname

FROM  (((Student s LEFT OUTER JOIN Student_Instructor_Course_Take sict
ON s.student_id = sict.student_id ) 
LEFT OUTER JOIN Course c 
ON sict.course_id = c.course_id)
LEFT OUTER JOIN MakeUp_Exam m 
ON c.course_id = m.course_id )
LEFT OUTER JOIN Instructor i 
ON sict.instructor_id = i.instructor_id

GO 

/*2.2.H*/

CREATE VIEW Semster_offered_Courses

AS

SELECT c.course_id, c.name ,s.semester_code 
FROM Semester s INNER JOIN Course_Semester cs
ON s.semester_code = cs.semester_code
INNER JOIN Course c 
ON cs.course_id = c.course_id 

GO

/*2.2.I*/

CREATE VIEW Advisors_Graduation_Plan

AS 

SELECT g.*, a.advisor_id AS AID, a.name
FROM Graduation_plan g 
LEFT OUTER JOIN Advisor a 
ON g.advisor_id = a.advisor_id

GO



/* 2.3.A */

CREATE PROCEDURE Procedures_StudentRegistration

@f_name varchar (40),
@l_name varchar (40),
@password varchar (40), 
@faculty varchar (40),
@email varchar(40),
@major varchar (40), 
@Semester int,
@student_id int OUTPUT

AS

INSERT INTO Student (f_name,l_name,faculty,email,major,password,semester)
VALUES(@f_name,@l_name,@faculty,@email,@major,@password, @semester)
SELECT S.student_id
FROM Student S
WHERE S.f_name=@f_name AND S.l_name=@l_name AND S.faculty= @faculty AND S.email=@email AND S.major=@major AND S.password=@password AND S.semester=@semester;
GO

/* 2.3.B */

CREATE PROCEDURE Procedures_AdvisorRegistration 

@advisor_name VARCHAR (40),
@password VARCHAR (40),
@email VARCHAR (40),
@office VARCHAR (40),
@Advisor_id int OUTPUT 

AS 

INSERT INTO Advisor (name, email , office , password) 
VALUES (@advisor_name, @email, @office,@password  )
SELECT A.advisor_id
FROM Advisor A
WHERE A.name=@advisor_name AND A.email=@email AND A.office= @office AND A.password=@password;
GO


/* 2.3.C */

CREATE PROC Procedures_AdminListStudents

AS 

SELECT * FROM Student 

GO



/* 2.3.D */

CREATE PROC Procedures_AdminListAdvisors

AS 

SELECT * FROM Advisor 

GO


/* 2.3.E */

CREATE PROC AdminListStudentsWithAdvisors

AS

SELECT * 
FROM Student LEFT OUTER JOIN Advisor 
ON student.advisor_id = advisor.advisor_id

GO


/* 2.3.F */

CREATE PROCEDURE AdminAddingSemester
@start_date date, 
@end_date date,  
@semester_code VARCHAR (40)
AS
INSERT INTO semester VALUES (@semester_code, @start_date ,@end_date)
GO


/* 2.3.G */

CREATE PROCEDURE Procedures_AdminAddingCourse
@major varchar (40), 
@semester int,
@credit_hours int,
@course_name varchar (40),  
@offered bit
AS
INSERT INTO course (name, major, is_offered, credit_hours, semester )
VALUES (@course_name, @major, @offered, @credit_hours, @semester )
GO


/* 2.3.H */

CREATE PROCEDURE Procedures_AdminLinkInstructor
@instructorId int, 
@courseId int,
@slotID int
AS
UPDATE Slot
SET course_id = @courseId , instructor_id = @instructorId
WHERE slot_id=@slotID
GO


/* 2.3.I */

CREATE PROCEDURE Procedures_AdminLinkStudent
@InstructorId int, 
@studentID int, 
@courseID int, 
@semestercode varchar (40) 
AS

INSERT INTO Student_Instructor_Course_Take(student_id,course_id,instructor_id,semester_code)
VALUES(@studentID, @courseID,@InstructorId,@semestercode)
GO


/* 2.3.J */

CREATE PROCEDURE Procedures_AdminLinkStudentToAdvisor
@studentID int, 
@advisorID int 
AS
UPDATE Student
SET advisor_id = @advisorID
WHERE student_id = @studentID
GO


/* 2.3.K */

CREATE PROCEDURE Procedures_AdminAddExam
@Type varchar (40), 
@date datetime, 
@courseID int
AS
INSERT INTO MakeUp_Exam(date, type, course_id) 
VALUES(@date, @Type, @courseID)
GO


/* 2.3.L */

CREATE PROCEDURE Procedures_AdminIssueInstallment
@payment_ID int
AS
DECLARE  
@amount DECIMAL ,
@installments int  , 
@pay DECIMAL , 
@Pdate DATETIME, 
@ddate DATETIME


SELECT @amount= P.amount, 
@installments=P.n_installments , 
@Pdate = P.start_date

FROM Payment P 
WHERE P.payment_id=@payment_ID
Set @pay=@amount/@installments

WHILE @installments > 0
BEGIN
SET @ddate = DATEADD(month,1,@Pdate)
INSERT INTO Installment  (payment_ID, deadline,amount,start_date)
VALUES (@payment_ID,@ddate,@pay,@Pdate)
SET @Pdate = @ddate
SET @installments = @installments - 1
END
GO


/* 2.3.M */

CREATE PROCEDURE  Procedures_AdminDeleteCourse
@courseID int
AS

ALTER TABLE Slot
DROP CONSTRAINT SC
ALTER TABLE PreqCourse_course
DROP CONSTRAINT PC,PPC
ALTER TABLE Request
DROP CONSTRAINT RC
ALTER TABLE MakeUp_Exam
DROP CONSTRAINT MC
ALTER TABLE Instructor_Course
DROP CONSTRAINT IC
ALTER TABLE Student_Instructor_Course_Take
DROP CONSTRAINT SIC
ALTER TABLE Course_Semester
DROP CONSTRAINT CSC


delete from Slot where course_id = @courseID

delete from PreqCourse_course where course_id = @courseID

delete from PreqCourse_course where prerequisite_course_id = @courseID

Delete from Exam_Student WHERE exam_id= (Select E.exam_id from Exam_Student E INNER JOIN MakeUp_Exam s on E.exam_id=s.exam_id where E.course_id=@courseID)

delete froM MakeUp_Exam where course_id = @courseID

delete from Request where course_id = @courseID

delete from Course_Semester where course_id = @courseID

delete from Student_Instructor_Course_Take where course_id= @courseID

delete from Instructor_Course where course_id = @courseID 

delete from Course where course_id = @courseID

 
ALTER TABLE Slot
ADD CONSTRAINT SC FOREIGN KEY(course_id)REFERENCES Course (course_id);


ALTER TABLE Request
ADD CONSTRAINT RC FOREIGN KEY(course_id)REFERENCES Course (course_id);

ALTER TABLE MakeUp_Exam
ADD CONSTRAINT MC FOREIGN KEY(course_id)REFERENCES Course (course_id);


ALTER TABLE PreqCourse_course
ADD CONSTRAINT PC FOREIGN KEY(course_id)REFERENCES Course (course_id) ,
 CONSTRAINT PPC FOREIGN KEY(prerequisite_course_id)REFERENCES Course (course_id);
ALTER TABLE Instructor_Course
ADD CONSTRAINT IC FOREIGN KEY(course_id)REFERENCES Course (course_id) ;

ALTER TABLE Student_Instructor_Course_Take
ADD CONSTRAINT SIC FOREIGN KEY(course_id) REFERENCES Course (course_id) ;

ALTER TABLE Course_Semester
ADD CONSTRAINT CSC FOREIGN KEY(course_id)REFERENCES Course (course_id);
ALTER TABLE Exam_Student
ADD CONSTRAINT ESE FOREIGN KEY(exam_id)REFERENCES MakeUp_Exam (exam_id) ,
CONSTRAINT ESS FOREIGN KEY(student_id)REFERENCES Student (student_id) 


GO


/* 2.3.N */

CREATE PROC Procedure_AdminUpdateStudentStatus 
@StudentID int 

AS
DECLARE @status VARCHAR(40), @deadline date
SELECT @status = i.status ,  @deadline = i.deadline
FROM Payment p INNER JOIN Installment i ON p.payment_id = i.payment_id
WHERE @StudentID = p.student_id

if @status = 'notPaid' AND GETDATE() > @deadline
BEGIN 

UPDATE STUDENT 
SET financial_status = 0
WHERE student_id = @StudentID

END 

ELSE 

UPDATE STUDENT 
SET financial_status = 1
WHERE student_id = @StudentID




GO


/* 2.3.O */

CREATE VIEW all_Pending_Requests

AS 

SELECT r.*, s.f_name,s.l_name, a.name
FROM Request r INNER JOIN STUDENT s
ON r.student_id = s.student_id INNER JOIN Advisor a
ON s.advisor_id = a.advisor_id
WHERE r.status = 'Pending'

GO


/* 2.3.P */

CREATE PROCEDURE Procedures_AdminDeleteSlots

@current_semester varchar (40)

AS
ALTER TABLE Slot
DROP CONSTRAINT SC
DELETE FROM Slot WHERE course_id NOT IN (
   SELECT F.course_id
   FROM Course_Semester F INNER JOIN Course C ON F.course_id=C.course_id
   WHERE  F.semester_code=@current_semester /*AND Slot.course_id=F.course_id*/)
ALTER TABLE Slot
ADD CONSTRAINT SC FOREIGN KEY(course_id) REFERENCES Course (course_id)

Go

/* 2.3.Q */

CREATE FUNCTION [FN_AdvisorLogin] (@ID int, @password VARCHAR(40))

RETURNS BIT

AS 
BEGIN
DECLARE @x BIT
IF EXISTS( SELECT a.advisor_id FROM Advisor a WHERE a.advisor_id = @ID AND a.password = @password)
   SET @x = 1
ELSE 
   SET @x = 0
RETURN @x
END

GO




/* 2.3.R */

CREATE PROCEDURE Procedures_AdvisorCreateGP
@Semester_code varchar(40),
@expected_graduation_date date,
@sem_credit_hours int,
@advisor_id int,
@student_id int

AS

DECLARE @acq int
SELECT @acq = Student.acquired_hours 
FROM Student 
WHERE Student.student_id = @student_id
IF @acq > 157 
BEGIN
INSERT INTO Graduation_Plan(semester_code,semester_credit_hours, expected_grad_date,advisor_id,student_id)
VALUES(@Semester_code,@sem_credit_hours,@expected_graduation_date,@advisor_id,@student_id)
END
GO


/* 2.3.S*/

CREATE PROCEDURE Procedures_AdvisorAddCourseGP

@student_id int,
@Semester_code varchar(40),
@course_name varchar(40)

AS

DECLARE @plan INT
SELECT @plan = g.plan_id
FROM Graduation_Plan g
WHERE g.student_id = @student_id AND g.semester_code = @Semester_code

DECLARE @courseID int 
SELECT @courseID = c.course_Id
FROM course c 
WHERE c.name = @course_name

INSERT INTO GradPlan_Course 
VALUES (@plan, @Semester_code, @courseID)


GO





/* 2.3.T */
CREATE PROCEDURE Procedures_AdvisorUpdateGP
@expected_grad_date date,
@studentID int
AS
UPDATE Graduation_Plan
SET expected_grad_date = @expected_grad_date
WHERE student_id = @studentID
GO

 


/* 2.3.U */

CREATE PROCEDURE Procedures_AdvisorDeleteFromGP
@studentID int,
@semester_code varchar(40),
@courseID INT
AS

DECLARE @plan INT
SELECT @plan = g.plan_id
FROM Graduation_Plan g
WHERE g.student_id = @studentID AND g.semester_code = @semester_code

ALTER TABLE GradPlan_Course
DROP CONSTRAINT GPC 
DELETE FROM GradPlan_Course 
where plan_id=@plan AND semester_code=@semester_code
AND course_id=@courseID
ALTER TABLE GradPlan_Course
ADD CONSTRAINT GPC FOREIGN KEY(plan_id,SEMESTER_CODE) REFERENCES Graduation_Plan (plan_id,semester_code) 

GO


/* 2.3.V */



CREATE FUNCTION [FN_Advisors_Requests] 
(@advisorID int) --Define Function Inputs
RETURNS Table -- Define Function Output
AS
Return (Select * from Request r WHERE r.advisor_id = @advisorID)
GO




/* 2.3.W */

CREATE PROCEDURE Procedures_AdvisorApproveRejectCHRequest

@RequestID int,
@Current_semester_code varchar(40)


AS

DECLARE @type varchar(40)
SELECT @type=r.type 
FROM Request r 
WHERE r.request_id=@RequestID

IF @type LIKE '%credit_hours%'
Begin


declare @gpa decimal , @assignedHours INT, @creditHours INT
SELECT @gpa = s.GPA, @assignedHours = s.assigned_hours, @creditHours = r.credit_hours 
FROM Student s INNER JOIN Request r 
ON s.student_id = r.student_id
WHERE r.request_id = @RequestID




IF @gpa<= 3.7 AND ( @creditHours BETWEEN 1 AND 3) AND (@assignedHours+@creditHours)<=34
BEGIN

update REQUEST
set status = 'accepted'

DECLARE @sum INT 
SET @sum = 1000 * @creditHours
Update Installment 
SET amount= @sum+ amount
where Installment.deadline = (SELECT MIN(i.deadline)
FROM Installment i INNER JOIN Payment P ON i.payment_id = P.payment_id
where i.status='NotPaid' AND P.semester_code=@Current_semester_code)


end
ELSE
begin
update REQUEST 
set status='rejected'
where @RequestID = request_id

end
end


GO



/* 2.3.X */

Create Procedure Procedures_AdvisorViewAssignedStudents 

@AdvisorID int ,
@major varchar(40)

AS


SELECT S.student_id,S.f_name,S.l_name,S.major,C.name
FROM Student S INNER JOIN Student_Instructor_Course_Take F 
ON S.student_id=F.student_id
RIGHT OUTER JOIN Course C ON F.course_id=C.course_id
where S.major=@major AND S.advisor_id=@AdvisorID

GO
/* 2.3.Y */
Create Procedure Procedures_AdvisorApproveRejectCourseRequest
@RequestID int,
@current_semester_code varchar(40)

AS
DECLARE @type varchar(40)
SELECT @type=r.type 
FROM Request r 
WHERE r.request_id=@RequestID

IF @type LIKE '%course%'
Begin


DECLARE @courseID INT, @courseCreditHours INT , @assignedHours INT
SELECT @courseID = r.course_id , @courseCreditHours = c.credit_hours, @assignedHours = s.assigned_hours
FROM  Course c INNER JOIN  Request r
ON c.course_id = r.course_id inner join Student s ON r.student_id=s.student_id
WHERE r.request_id = @RequestID 


IF NOT EXISTS ( SELECT pc.course_id FROM PreqCourse_course pc WHERE pc.course_id = @courseID)
OR EXISTS (SELECT p.course_id FROM PreqCourse_course P INNER JOIN Student_Instructor_Course_Take ST ON P.prerequisite_course_id=ST.course_id
WHERE ( ST.grade IS NOT NULL OR ST.grade <> 'FA') and p.course_id = @courseID)
AND @courseCreditHours + @assignedHours<=34
BEGIN
update REQUEST
set status = 'accepted'
WHERE REQUEST_ID=@RequestID
UPDATE Student_Instructor_Course_Take
SET course_id= @courseID
where semester_code=@current_semester_code


END

else 

BEGIN
update REQUEST
set status = 'rejected'
where REQUEST_ID=@RequestID
END


END

Go




/* 2.3.Z */

Create Procedure Procedures_AdvisorViewPendingRequests 

@AdvisorID int

AS 

SELECT * 
FROM Request r
WHERE r.advisor_id = @AdvisorID AND r.status = 'Pending'

GO







/* 2.3.AA */




CREATE FUNCTION FN_StudentLogin (@Student_ID int, @password varchar (40))

RETURNS BIT

AS 
BEGIN
DECLARE @x BIT
IF EXISTS( SELECT s.student_id FROM Student s WHERE  s.student_id = @Student_ID  AND s.password = @password)
   SET @x = 1
ELSE 
   SET @x = 0
RETURN @x
END


GO






/* 2.3.BB */

Create Procedure Procedures_StudentaddMobile 
 @StudentID int,
 @mobile_number varchar (40) 

 AS
 INSERT INTO Student_Phone VALUES (@StudentID, @mobile_number )
 Go




/* 2.3.CC */




CREATE FUNCTION [FN_SemsterAvailableCourses]
(@semster_code varchar (40)) --Define Function Inputs
RETURNS Table -- Define Function Output
AS
Return (Select c.course_id from Course_Semester c WHERE c.semester_code = @semster_code)
GO



/* 2.3.DD */

Create Procedure Procedures_StudentSendingCourseRequest 
@StudentID int,
@courseID int,
@type varchar (40),
@comment varchar (40)

AS 
INSERT INTO Request (type,comment, student_id , course_id ) VALUES (@type,@comment, @StudentID , @courseID)
Go




/* 2.3.EE */

Create Procedure  Procedures_StudentSendingCHRequest
@StudentID int ,
@credithours int,
@type varchar (40),
@comment varchar (40)

AS
if @credithours Between 1 and 3
INSERT INTO Request (type,comment,credit_hours, student_id ) VALUES (@type,@comment, @credithours , @StudentID)
Go


/* 2.3.FF */


CREATE FUNCTION [FN_StudentViewGP]
(@student_ID INT) --Define Function Inputs
RETURNS Table -- Define Function Output
AS
Return (Select s.student_id, s.f_name, s.l_name, g.plan_id
,c.course_id, c.name, g.semester_code, g.expected_grad_date, g.semester_credit_hours, g.advisor_id
FROM Student s INNER JOIN Graduation_Plan g
ON s.student_id = g.student_id
INNER JOIN GradPlan_Course gp
ON g.plan_id = gp.plan_id
INNER JOIN Course c 
ON gp.course_id = c.course_id 
WHERE s.student_id = @student_ID
)
GO




/* 2.3.GG */



CREATE FUNCTION FN_StudentUpcoming_installment(@studentID int)

RETURNS date

AS 
BEGIN
declare @date date 
SELECT @date = MIN( i.deadline )
FROM Student s INNER JOIN Payment p ON s.student_id = p.student_id 
INNER JOIN Installment i ON p.payment_id = i.payment_id
WHERE s.student_id = @studentID AND i.status ='NotPaid' 

                     
RETURN 
 @DATE


END

GO


/* 2.3.HH */



CREATE FUNCTION [FN_StudentViewSlot]
(@CourseID int,@InstructorID int ) --Define Function Inputs
RETURNS Table -- Define Function Output
AS
Return (Select s.slot_id,s.location,s.time,s.day,c.name AS cname,i.name AS iname
FROM Instructor i INNER JOIN Slot s
ON i.instructor_id=s.instructor_id
INNER JOIN Course c
ON s.course_id=c.course_id
WHERE s.course_id = @CourseID AND s.instructor_id=@InstructorID
)
GO





/* 2.3.II */

CREATE PROCEDURE Procedures_StudentRegisterFirstMakeup

@StudentID int ,
@courseID int,
@studentCurrent_semester varchar (40)

AS

IF EXISTS (SELECT S.student_id,S.course_id 
FROM Student_Instructor_Course_Take S  
WHERE S. exam_type='Normal' AND (S.grade='null' OR S.grade='FF' OR S.grade='F') 
AND S.student_id = @StudentID AND S.semester_code=@studentCurrent_semester) and not exists (select m.*
from MakeUp_Exam m inner join Exam_student E on m.exam_id=E.exam_id
where E.student_id=@StudentID)
BEGIN
update Student_Instructor_Course_Take
set Student_Instructor_Course_Take.exam_type ='First_Makeup'
WHERE student_id = @StudentID AND course_id = @courseID

END

Go




/* 2.3.JJ */




CREATE FUNCTION FN_StudentCheckSMEligiability(@courseID int ,@studentID int)

RETURNS BIT

AS 
BEGIN
DECLARE @codd VARCHAR(40), @ceven VARCHAR(40) , @x bit, @sem VARCHAR(40)
SELECT @sem = s.semester_code
FROM Student_Instructor_Course_Take S
WHERE @courseID = s.course_id AND @studentID = s.student_id 



SELECT @codd = COUNT(*)
FROM Student_Instructor_Course_Take S
WHERE @studentID = s.student_id AND (s.grade = 'FA' OR s.grade = 'FF' OR s.grade = 'F') 
AND s.exam_type = 'First Makeup' AND (s.semester_code LIKE 'W%' OR s.semester_code LIKE '%R1') 


SELECT @ceven = COUNT(*)
FROM Student_Instructor_Course_Take S
WHERE @studentID = s.student_id AND (s.grade = 'FA' OR s.grade = 'FF' OR s.grade = 'F') 
AND s.exam_type = 'First Makeup' AND (s.semester_code LIKE 'S__' OR s.semester_code LIKE '%R2')

IF ((@sem LIKE 'W%' OR @sem LIKE '%R1') AND  @codd >2) OR ((@sem LIKE 'S__' OR @sem LIKE '%R2') AND @ceven >2)
  SET  @X=0
  ELSE
  SET @X=1


RETURN @X
END


GO




/* 2.3.KK */


CREATE PROC Procedures_StudentRegisterSecondMakeup
@StudentID int,
@courseID int ,
@Student_Current_Semester Varchar (40)

AS 
DECLARE @elig BIT
SET @elig= dbo.FN_StudentCheckSMEligiability(@courseID,@StudentID)


DECLARE @CODE Varchar (40)
SELECT @CODE=ST.semester_code FROM Student_Instructor_Course_Take ST
WHERE ST.course_id=@courseID

IF (@CODE  LIKE 'S_' OR @CODE LIKE '%R2') AND (@Student_Current_Semester LIKE 'S_' OR  @Student_Current_Semester LIKE '%R2') AND @elig=1 
BEGIN
update Student_Instructor_Course_Take
set Student_Instructor_Course_Take.exam_type ='Second Makeup' 
WHERE student_id = @StudentID AND course_id = @courseID

update Student_Instructor_Course_Take
set Student_Instructor_Course_Take.grade='Null'
WHERE student_id = @StudentID AND course_id = @courseID
END
IF (@CODE LIKE 'W%' OR @CODE LIKE '%R1') AND ( @Student_Current_Semester LIKE 'S__' OR @Student_Current_Semester LIKE '%R2') AND @elig=1 
BEGIN
update Student_Instructor_Course_Take
set Student_Instructor_Course_Take.exam_type ='Second Makeup'
WHERE student_id = @StudentID AND course_id = @courseID

update Student_Instructor_Course_Take
set Student_Instructor_Course_Take.grade='Null'
WHERE student_id = @StudentID AND course_id = @courseID
END

GO



/* 2.3.LL */

CREATE PROC Procedures_ViewRequiredCourses


@StudentID int, 
@Current_semester_code Varchar (40)

AS 


SELECT c.* 
FROM Student_Instructor_Course_Take S INNER JOIN Course c ON S.course_id=c.course_id
WHERE (S.exam_type = 'First Makeup' AND S.student_id=@StudentID AND (S.grade ='FF' or S.grade = 'F' or  S.grade = 'NULL')
AND dbo.FN_StudentCheckSMEligiability(c.course_id,@StudentID)= 0) OR 
(s.exam_type = 'Normal' AND s.grade = 'FA' AND s.semester_code <> @Current_semester_code ) 









Go
/* 2.3.MM */


CREATE PROCEDURE Procedures_ViewOptionalCourse 
@StudentID int, 
@Current_semester_code Varchar (40)

AS

 DECLARE @SEM_START_DATE date
SELECT @SEM_START_DATE = s.start_date
FROM Semester s
WHERE s.semester_code = @Current_semester_code


select Distinct c.* 
from Course c 
where c.course_id IN ( SELECT cs.course_id
                       FROM Semester s inner join Course_Semester cs ON s.semester_code = cs.semester_code
                        where s.start_date >= @SEM_START_DATE  and cs.course_id IN 
(SELECT  p.course_id 
FROM PreqCourse_course P INNER JOIN Student_Instructor_Course_Take ST ON P.prerequisite_course_id=ST.course_id INNER JOIN Student s ON st.student_id = s.student_id
WHERE ( ST.grade IS NOT NULL OR ST.grade <> 'FA')  and ST.student_id=@StudentID))





GO

/* 2.3.NN */


CREATE PROCEDURE Procedures_ViewMS
@StudentID int
AS

select  c.course_id
from Course c 
where  c.major in (select S.faculty
from student s where S.student_id=@StudentID )
EXCEPT
(select  st.course_id
from Student_instructor_course_take st
where st.student_id=@StudentID AND st.grade <> 'NULL' and st.grade <> 'F' and st.grade <> 'FF')


GO






/* 2.3.OO */

CREATE PROCEDURE Procedures_ChooseInstructor
@Student_id INT,
@Instructor_id INT,
@Course_id INT

AS


UPDATE Student_Instructor_Course_Take 

SET instructor_id=@Instructor_id
where student_id=@Student_id AND course_id=@Course_id

Go
