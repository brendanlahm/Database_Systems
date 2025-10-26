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
	name varchar(30) primary key,
	Office varchar(30) NOT NULL,
	Tel varchar(30)
);

EXEC sp_rename "Lecturers.name", "Name", "column";

-- Add entries to the table
insert into Lecturers (name, Office, Tel) values
('Draco', 'Dungeon', '666'),
('Flippy','Tower', '999'),
('Jason', 'Nursery', NULL);

UPDATE Lecturers
set name = 'Draconius'
where Office = 'Dungeon';

--drop table Lecturers;

select * from Lecturers; -- Query the table


-- Events Table
drop table Events;

create Table Events(
	name varchar(30),
	Semester char(4),
	Room varchar(8),
	Lecturer varchar(30) foreign key references Lecturers(name) on update cascade,
	primary key (name, Semester)
);

insert into Events (name, Semester, Room, Lecturer) values
('First Day', 1234, 36, 'Draco')

select * from Events; -- Query the table

