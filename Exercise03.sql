-- Exercise 3

--drop table Students;

-- Create table for Students
create table Students(
	name varchar(30),
	matriculation_number int primary key
);

ALTER TABLE Students
ADD CONSTRAINT CHK_Matriculation_4Digits
CHECK (matriculation_number BETWEEN 0 AND 9999);

--delete from Students where matriculation_number=1234;

-- Insert data
insert into Students (name, matriculation_number) values
('Neville', 1234),
('Seamus', 5678),
('Luna', 8467);

insert into Students (name, matriculation_number) values
('Eva', 3333),
('Luise', 3334),
('Daniel', 3335),
('Dominik', 3336);

SELECT * FROM Students;


-- Create table for Lecturers

--drop table Lecturers;

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

insert into Lecturers (name, Office, Tel) values
('Prof. Klaus', 'C201', '123');

insert into Lecturers (name, Office, Tel) values
('Prof. Maria', 'D120', NULL);

UPDATE Lecturers
set name = 'Draconius'
where Office = 'Dungeon';

delete from Lecturers where name = 'Draconius';

select * from Lecturers; -- Query the table


-- Events Table

--drop table Events;

create Table Events(
	name varchar(30),
	Semester char(4),
	Room varchar(8),
	Lecturer varchar(30) foreign key references Lecturers(name) on delete set NULL on update cascade,
	primary key (name, Semester)
);

--delete from Events where name = 'Dance';

insert into Events (name, Semester, Room, Lecturer) values
('Dance', 'ws17', 'D111', 'Prof. Klaus'),
('Hang Gliding', 'ss17', 'Beach', 'Prof. Maria'),
('Volleyball', 'ss17', 'Beach', 'Prof. Maria'),
('Sack Race', 'ws18', NULL, 'Prof. Klaus'),
('Dance', 'ss18', 'D111', 'Prof. Klaus'),
('Hang Gliding', 'ss18', 'Beach', 'Prof. Maria'),
('Volleyball', 'ss18', 'Beach', 'Prof. Maria')

select * from Events; -- Query the table


-- Student_in_Event Table

--drop Table Student_in_Event;

create Table Student_in_Event(
	ID int identity(10,2) primary key,
	Student int foreign key references Students(matriculation_number) on delete set NULL on update cascade,
	Event varchar(30),
	Semester char(4),
	Grade dec(2,1) check (Grade>=1.0 and Grade<=5.0),
	foreign key (Event, Semester) references Events(name,Semester) on update cascade on delete cascade,
);

-- Eva, Luise & Daniel
insert into Student_in_Event (Student, Event, Semester, Grade) values
(3333, 'Volleyball', 'ss18', 1.3),
(3334, 'Volleyball', 'ss18', 4.0),
(3335, 'Volleyball', 'ss18', 4.3)

insert into Student_in_Event (Student, Event, Semester, Grade) values
-- Dominik & Eva
(3333, 'Hang Gliding', 'ss17', 2.7),
(3336, 'Hang Gliding', 'ss17', 4.0),
-- Luise & Daniel
(3334, 'Dance', 'ws17', 1.0),
(3335, 'Dance', 'ws17', 4.3),
(3334, 'Volleyball', 'ss17', 1.7),
(3335, 'Volleyball', 'ss17', 3.7)

select * from Student_in_Event; -- Query the table

-- Remove failing Volleyball grade
update Student_in_Event
set Grade = NULL
where Event = 'Volleyball' and Grade > 4.0;

--delete from Student_in_Event where Event='Volleyball' and Grade>4.0; -- Remove failing Volleyball students
select * from Student_in_Event; -- Query the table

-- Change Room # for Prof. Maria
update Lecturers
set Office = 'D22'
where name = 'Prof. Maria';

select * from Lecturers; -- Query the table

delete from Students where name = 'Eva'; -- Deregister Eva from all events

select * from Students; -- Query the table
select * from Student_in_Event; -- Query the table


