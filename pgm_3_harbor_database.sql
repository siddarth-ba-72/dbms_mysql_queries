-- Create the Harbour Database
create database harbor;
use harbor;

-- Create Sailor table 
create table sailor (
	sid int,
    sname varchar(30),
    rating int,
    age real,
    primary key(sid)
);

desc sailor;

-- Create Boat table
create table boat (
	bid int,
    bname varchar(30),
    color varchar(20),
    primary key(bid)
);

desc boat;

-- Create Reserves table
create table reserves (
	sid int,
    bid int,
    day date,
    primary key(sid, bid),
    foreign key(sid) references sailor(sid),
    foreign key(bid) references boat(bid)
);

desc reserves;

insert into sailor values(001, 'James', 5, 41);
insert into sailor values(002, 'Anderson', 4.3, 40);
insert into sailor values(003, 'Thomas', 4.8, 35);
insert into sailor values(004, 'Arthur', 2.3, 51);
insert into sailor values(005, 'John', 1.6, 36);

insert into sailor values(006, 'Bagwell', 0.6, 36);

select * from sailor;

insert into boat values(001, 'Titanic', 'navy blue');
insert into boat values(002, 'Liberty', 'green');
insert into boat values(003, 'Wanderlust', 'black');
insert into boat values(004, 'Sapphire', 'dark blue');
insert into boat values(005, 'Amazonite', 'yellow');

insert into boat values(006, 'titanic returns', 'white');
insert into boat values(007, 'amazon river', 'gray');
insert into boat values(008, 'fox river', 'brown');

select * from boat;

insert into reserves values(001, 001, '1998-09-08');
insert into reserves values(002, 002, '1991-11-01');
insert into reserves values(003, 003, '2000-05-22');
insert into reserves values(004, 004, '1996-08-09');
insert into reserves values(005, 005, '2001-04-03');

select * from reserves;

alter table sailor rename column sailor_name to sname;
desc sailor;

-- Select names and ages of all sailors
select sailor_name, age
from sailor;

-- Find all sailors with a rating above 4
select * from sailor
where rating > 4;

-- Find the sid of sailors who have reserved a red boat
select s.sid
from sailor s, reserves r
where s.sid = r.sid and r.bid is not null;

-- Find the color of the boat reserved by "Thomas"
select b.color
from boat b, sailor s, reserves r
where b.bid = r.bid and s.sid = r.sid and s.sname = "Thomas";

-- Delete all boats which have never been reserved
delete from boat
where boat.bid = reserves.bid and reserves.sid is null;

-- Find the names of sailors who have reserved boat number 002
select s.sname
from sailor s, boat b, reserves r
where b.bid=r.bid and s.sid=r.sid and r.bid=002;

-- Find the names of sailors who have reserved a red boat
select s.sid
from sailor s, boat b, reserves r
where s.sid=r.sid and b.bid=r.bid and b.color='green';

-- Find the age of the sailor whose name starts with J and has atleast 5 characters
select age from sailor
where sname like 'J%' and length(sname) >= 5;

-- Find the name and age of oldest sailor
select sname "Name", age "Age" from sailor
where age = (
	select max(age) from sailor
);

alter table sailor rename column sname to sailor_name;
desc sailor;