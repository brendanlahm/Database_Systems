drop table animal_eats;

create table animal_eats(
	animal varchar(30),
	eats varchar (30)
);


insert into animal_eats (animal, eats) values
	('Ape','Banana'),
	('Ape','Apple'),
	('Ape','Frog'),
	('Frog','Fly'),
	('Fly','Apple'),
	('Fly','Sugarwater'),
	('Jackal','Ape'),
	('Wolf','Jackal'),
	--('Fly','Wolf'),
	('Wolf','Apple');



-- Insert the following line to generate a circle
insert into tier_frisst (animal, eats) values
	('Fly','Wolf');



