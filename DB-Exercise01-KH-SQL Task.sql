create table students(
	matriculation_number int primary key,
	name varchar(30)
	);
create table grades(
	matriculation_number int references students(matriculation_number),
	grade decimal(2,1),
	course varchar(30),
	primary key (matriculation_number, course)
	);

insert into students (matriculation_number, name) values
(1,'Max'),(2,'Stephanie');

insert into grades(matriculation_number, grade, course) values
(1,1.0,'DB'), (1,1.3,'SysE'), (2,1.0,'SysE'),(2,1.3,'DB');