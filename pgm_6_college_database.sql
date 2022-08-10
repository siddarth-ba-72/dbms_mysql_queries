create database College;
use College;

create table student(
	usn varchar(20),
    sname varchar(30),
    address varchar(30),
    phone real,
    gender char,
    primary key(usn)
);
desc student;

create table semsec(
	ssid varchar(20) primary key,
    sem int,
    sec char
);
desc semsec;

create table class(
	usn varchar(20),
    ssid varchar(20),
    primary key(usn, ssid),
    foreign key(usn) references student(usn),
    foreign key(ssid) references semsec(ssid)
);
desc class;

create table subject(
	subcode varchar(10) primary key,
    title varchar(30),
    sem int,
    credits int
);
desc subject;

create table iaMarks(
	usn varchar(20),
    subcode varchar(10),
    ssid varchar(20),
    test_1 int,
    test_2 int,
    test_3 int,
    final_ia int,
    primary key(usn, subcode, ssid),
    foreign key(usn) references student(usn),
    foreign key(subcode) references subject(subcode),
    foreign key(ssid) references semsec(ssid)
);
desc iaMarks;

insert into student values("1BM20AI025", "Scofield", "Bannerghatta", "9353286874", 'M');
insert into student values("1BM20AI043", "Sara", "Basavanagudi", "6548432323", 'F');
insert into student values("1BM20AI039", "Linc", "Malleshwaram", "7412398530", 'M');
insert into student values("1BM20AI050", "Alex", "Majestic", "3698745005", 'M');
insert into student values("1BM20AI048", "Sucre", "RR nagar", "9517536482", 'F');
insert into student values("1BM20AI016", "Mahesh", "Jaynagar", "9369874123", 'M');
select * from student;

insert into semsec values("ML01",  3, 'A');
insert into semsec values("ML02",  4, 'C');
insert into semsec values("ML03",  3, 'B');
insert into semsec values("ML04",  1, 'A');
insert into semsec values("ML05",  2, 'D');
insert into semsec values("ML06",  5, 'C');
select * from semsec;

insert into class values("1BM20AI025", "ML01");
insert into class values("1BM20AI043", "ML02");
insert into class values("1BM20AI039", "ML03");
insert into class values("1BM20AI050", "ML04");
insert into class values("1BM20AI048", "ML05");
insert into class values("1BM20AI016", "ML06");
select * from class;

insert into subject values("03MLOPS", "OPS", 3, 4);
insert into subject values("04MDBM", "DBMS", 4, 4);
insert into subject values("03MLCNS", "CNS", 3, 3);
insert into subject values("01MLM1", "M1", 1, 5);
insert into subject values("02MLCCP", "CCP", 2, 2);
insert into subject values("05MLDS", "DS", 5, 4);
select * from subject;

insert into iaMarks values("1BM20AI025", "03MLOPS", "ML01", 35, 36, 25, 95);
insert into iaMarks values("1BM20AI043", "04MDBM", "ML02", 25, 31, 28, 76);
insert into iaMarks values("1BM20AI039", "03MLCNS", "ML03", 15, 37, 26, 81);
insert into iaMarks values("1BM20AI050", "01MLM1", "ML04", 33, 26, 40, 68);
insert into iaMarks values("1BM20AI048", "02MLCCP", "ML05", 37, 39, 40, 91);
insert into iaMarks values("1BM20AI016", "05MLDS", "ML06", 37, 29, 34, 85);
select * from iaMarks;

-- List all the student details studying in fourth semester ‘C’section.
select * from student s, semsec ss, class c
where s.usn = c.usn and ss.ssid = c.ssid and ss.sec = 'C';

-- Compute the total number of male and female students in each semester
-- and in each section.
select ss.sem, ss.sec, s.gender, count(s.gender) as Count
from semsec ss, student s, class c
where s.usn = c.usn and ss.ssid = c.ssid
group by ss.sem, ss.sec, s.gender
order by ss.sem;

-- Create a view of Test1 marks of student USN ‘1BM20AI048’ in all subjects.
create view stud_test_1_marks as
select test_1, subcode
from iaMarks
where usn = "1BM20AI048";

select * from stud_test_1_marks;

-- Calculate the FinalIA (average of best two test marks) and
-- update the corresponding table for all students.
