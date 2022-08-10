-- Creating Insurance Database 

create database Insurance;
use Insurance;

-- Person Table
create table person (
	driver_id varchar(10),
    name varchar(20),
    address varchar(30),
    primary key(driver_id)
);

desc person;

-- Car Table
create table car (
	reg_num varchar(15),
    model varchar(20),
    year int,
    primary key(reg_num)
);

desc car;

-- Accident table
create table accident (
	report_num int,
    accident_date date,
    location varchar(30),
    primary key(report_num)
);

desc accident;

-- Owns table
create table owns (
	driver_id varchar(10),
    reg_num varchar(15),
    foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num)
);

desc owns;

-- Participated table
create table participated (
	driver_id varchar(10),
    reg_num varchar(15),
    report_num int,
    damage_amount int,
    foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num),
    foreign key(driver_id) references person(driver_id),
	foreign key(report_num) references accident(report_num)
);

desc participated;

-- Inserting Person values
insert into person values('A01', 'Richard', 'Srinagar');
insert into person values('A02', 'Pradeep', 'Rajajinagar');
insert into person values('A03', 'James', 'London');
insert into person values('A04', 'Stuart', 'JPnagar');
insert into person values('A05', 'Amar', 'Majestic');
select * from person;

-- Inserting Car values
insert into car values('KA052250', 'Indica', 1990);
insert into car values('KA031181', 'Lancer', 1957);
insert into car values('KA254401', 'I10', 2000);
insert into car values('MH153747', 'I20', 1999);
insert into car values('KA011234', 'Nano', 2002);
select * from car;

-- Inserting Accident values
insert into accident values(111, '2011-01-02', 'Mysore road');
insert into accident values(112, '2003-01-01', 'Indiranagar');
insert into accident values(113, '2012-08-11', 'Majestic');
insert into accident values(114, '2014-04-08', 'JPnagar');
insert into accident values(115, '2016-09-05', 'Jaynagar');
select * from accident;

-- Inserting Owns values
insert into owns values('A01', 'KA052250');
insert into owns values('A02', 'KA031181');
insert into owns values('A03', 'KA254401');
insert into owns values('A04', 'MH153747');
insert into owns values('A05', 'KA011234');
select * from owns;

-- Inserting Participated values
insert into participated values('A01', 'KA052250', 111, 10000);
insert into participated values('A02', 'KA031181', 112, 15000);
insert into participated values('A03', 'KA254401', 113, 17500);
insert into participated values('A04', 'MH153747', 114, 13500);
insert into participated values('A05', 'KA011234', 115, 25000);
select * from participated;

/*
Update the damage amount to 25000 for the car with a specific reg-num(example KA052250;)
for which the accident report number was 111.
*/
update participated set damage_amount=25000 where reg_num='KA052250' and report_num=111;
select * from participated;

/*
Add a new accident to the database.
*/
insert into accident values(116, '2001-12-11', 'Dolmur');
select * from accident;

/*
Find the total number of people who owned cars that involved in accidents in 1998.
*/
select year(accident_date) from accident;
select count(distinct driver_id) CNT from participated a, accident b where
a.report_num = b.report_num and year(b.accident_date)='2011';

/*
Find the total number of accidents in which cars belong to a specific model
*/
select count(report_num) CNT from car c, participated p where c.reg_num = p.reg_num
and model='I10';
