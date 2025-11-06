-- Exercise 4

---- Task 1: Simple selects
select * from Lecturers;
select * from Lecturers where Office like 'D%'; -- Select Lecturers with office in D Wing

select * from Students;
select * from Student_in_Event;

-- Select students who have not yet received a grade in the summer semester 2018
select distinct Student from Student_in_Event where Semester = 'ss18' and Grade is NULL;

-- Insert student birthdays
alter table Students
add Birthday date;

select * from Students;

update Students
set Birthday = '1980-12-25'
where matriculation_number = '1234';
update Students
set Birthday = '2002-11-02'
where matriculation_number = '3333';
update Students
set Birthday = '2004-04-14'
where matriculation_number = '3334';
update Students
set Birthday = '2022-09-09'
where matriculation_number = '3335';
update Students
set Birthday = '2001-03-17'
where matriculation_number = '3336';
update Students
set Birthday = '1987-07-25'
where matriculation_number = '5678';
update Students
set Birthday = '1989-12-31'
where matriculation_number = '8467';

select * from Students;

-- Query students older than 20 and younger than 40
select
	Name as n ,
	datediff (year , Birthday ,CURRENT_TIMESTAMP) as 'Age'
from
	Students
where
	datediff (year , Birthday ,CURRENT_TIMESTAMP) between 20 and 40;


---- Task 2: Join and cross product
-- Create a student room plan for the summer semester 2018 that shows who is in which event in which room
select * from Events;
select * from Student_in_Event; -- only event in ss18 is Volleyball!

select S.name, S.matriculation_number, Event, E.Lecturer, E.Room
--select *
from Students as S 
inner join Student_in_Event as SinE on S.matriculation_number = SinE.Student
inner join Events as E on SinE.Event = E.name and E.Semester = SinE.Semester
where E.Semester = 'ss18';

-- Part B skipped!

-- Select a Text Column
select
	concat(
		S.Name, 
		' participated in the lecture ',
		SinE.Event,
		' during the ',
		case 
			when SinE.Semester='ss17' then 'summer semester 2017' 
			when SinE.Semester='ws17' then 'winter semester 2017' 
			when SinE.Semester='ss18' then 'summer semester 2018' 
		end,
		' and ',
		case 
			when SinE.Grade is null then 'obtained no grade so far.' 
			when SinE.Grade<=4 then concat ( 'obtained the grade ' , SinE.Grade , ' Congratulations!') 
			when SinE.Grade>4 then ' did not pass.' 
		end) as 'Text'
--select *
from
	Students as S 
	inner join Student_in_Event as SinE on S.matriculation_number = SinE. Student
where
	SinE.Semester in ( 'ws17' , 'ss17' , 'ss18' );

---- Task 3: Quantifiers and set operations
-- Create a table which shows the best grade a lecturer has ever given for a specific event across all semesters
select distinct 
	L.Name, 
	E.Name, 
	concat ( 'Best Grade : ' , isnull(cast(SinE.Grade as varchar),'none')) 
from 
	Lecturers as L 
	inner join Events as E on E.Lecturer=L.Name 
	inner join Student_in_Event as SinE on SinE.Event = E.Name and SinE.Semester=E.Semester 
where  
	SinE.Grade <= all ( 
							select Grade 
							from Student_in_Event as SinE2 
								inner join Events as E2 on SinE2.Event=E2.Name and SinE2. Semester=E2.Semester 
								inner join Lecturers as L2 on E2.Lecturer=L2.Name 
							where Grade is not null and E2.Name=E.Name and L2.Name=L.Name
							);










