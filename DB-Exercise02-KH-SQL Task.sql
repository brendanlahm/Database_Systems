-- Exercise 2

-- Create tables
create table R(
	A int,
	Y int,
	Z int
);
create table S(
	Y int,
	Z int,
	B int
);

-- Insert data
insert into R (A,Y,Z) values
(1,1,2),
(2,1,1),
(3,1,1),
(9,3,4),
(7,2,2);

insert into S (Y,Z,B) values 
(1,2,6),
(1,2,7),
(1,1,8),
(7,8,9),
(2,1,5),
(3,9,4),
(2,4,2),
(9,4,1);


-- Queries
--a)
select Z, Y from S where Y=1
intersect
select Z, Y from S where Y=1;

-- R x S
Select * from R, S;





-- delete tables
drop table R, S;
