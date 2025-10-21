-- Exercise 2

-- Create table for Students
create table Students(
	name varchar(30),
	matriculation_number int(4)
);

ALTER TABLE Students
ADD CONSTRAINT CHK_Matriculation_4Digits
CHECK (matriculation_number BETWEEN 0 AND 9999);

delete from Students where matriculation_number=1234;
delete from Students where matriculation_number=5678;

-- Insert data
insert into Students (name, matriculation_number) values
('Tom',1234),
('Jimmy',5678);

SELECT * FROM Students;

-- Create table for Lecturers
create table Lecturers(
	name varchar(30),
	Office varchar(30),
	Tel varchar(30)
)

EXEC sp_rename "Lecturers.name", "Name", "column";

insert into Lecturers (name, Office, Tel) values
('Draco', 'Dungeon', '666'),
('Flippy','Tower', '999');

select * from Lecturers;

