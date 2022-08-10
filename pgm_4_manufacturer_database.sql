create database manufacturer;
use manufacturer;

create table supplier (
	sid int,
    sname varchar(30),
    address varchar(30),
    primary key(sid)
);

desc supplier;

create table part (
	pid int,
    pname varchar(30),
    color varchar(20),
    primary key(pid)
);

desc part;

create table catalog (
	sid int,
    pid int,
    cost real,
    primary key(sid, pid),
    foreign key(sid) references supplier(sid),
    foreign key(pid) references part(pid)
);

desc catalog;

insert into supplier values(001, 'sup1', 'Banglore');
insert into supplier values(002, 'sup2', 'Mumbai');
insert into supplier values(003, 'sup3', 'Hyderabad');
insert into supplier values(004, 'sup4', 'Nashik');
insert into supplier values(005, 'sup5', 'Mysore');

select * from supplier;

insert into part values(001, 'part1', 'blue');
insert into part values(002, 'part2', 'green');
insert into part values(003, 'part3', 'red');
insert into part values(004, 'part4', 'black');
insert into part values(005, 'part5', 'yellow');

select * from part;

insert into catalog values(001, 001, 250000);
insert into catalog values(002, 002, 150000);
insert into catalog values(003, 003, 750000);
insert into catalog values(004, 004, 650000);
insert into catalog values(005, 005, 20000);

select * from catalog;

select sid "ID", sname "Name" from supplier;

select p.pname
from part p, catalog c
where p.pid=c.pid and c.cost = (
	select max(cost) from catalog
);

select s.sname, p.pname, MAX(c.cost)
from supplier s, part p, catalog c
where s.sid = c.sid and p.pid = c.pid;

select p.pname "Part Name"
from supplier s, part p, catalog c
where s.sid=c.sid and p.pid=c.pid and s.sid is not null;

select sid "ID", sname "Name", address "Address"
from supplier
where address="Banglore";

select s.sid "ID"
from supplier s, part p, catalog c
where s.sid = c.sid and p.pid = c.pid and p.color="red";

select s.sid
from supplier s
where s.sid in
(
	select s.sid
    from supplier s, part p, catalog c
    where s.sid = c.sid and p.pid = c.pid and p.color="red"
)
or
s.sid in
(
	select s.sid
    from supplier s, part p, catalog c
    where s.sid = c.sid and p.pid = c.pid and p.color="green"
);

select p.pname, MAX(c.cost)
from supplier s, part p, catalog c
where s.sid = c.sid and p.pid = c.pid and p.color like 'green%'
union
select p.pname, MAX(c.cost)
from supplier s, part p, catalog c
where s.sid = c.sid and p.pid = c.pid and p.color like 'red%';


