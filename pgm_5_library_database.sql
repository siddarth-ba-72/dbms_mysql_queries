create database Library;
use Library;

-- Book Table
create table book(
	book_id int,
    book_name varchar(40),
    publisher_name varchar(40),
    pub_year int,
    primary key(book_id)
);
desc book;

-- Book authors table
create table book_authors(
	book_id int,
    author_name varchar(30),
    primary key(book_id),
    foreign key(book_id) references book(book_id) on delete cascade
);
desc book_authors;

create table publisher(
	name varchar(40),
    address varchar(40),
    phone real
);
desc publisher;

alter table publisher
add primary key(name);

create table book_copies(
	book_id int,
    branch_id int,
    no_of_copies int,
    primary key(book_id, branch_id),
    foreign key(book_id) references book(book_id) on delete cascade
);
desc book_copies;

create table book_lending(
	book_id int,
    branch_id int,
    card_no int,
    date_out date,
    due_date date,
    foreign key(book_id) references book(book_id) on delete cascade
);
desc book_lending;

create table branch(
	branch_id int primary key,
    branch_name varchar(40),
    address varchar(40)
);
desc branch;

alter table book_copies
add foreign key(branch_id) references branch(branch_id) on delete cascade;

alter table book_lending
add foreign key(branch_id) references branch(branch_id) on delete cascade;

alter table book
add unique(publisher_name);

alter table publisher
add unique(name);

alter table book
add foreign key(publisher_name) references publisher(name) on delete cascade;

insert into book values(1, "Dbms", "Goyal brothers", 1198);
insert into book values(2, "Machine learning", "Oreilly", 2016);
insert into book values(3, "Artificial Intelligence", "Prentice Hall", 1970);
insert into book values(4, "Operating systems", "Willey", 1926);
insert into book values(5, "Computer networks", "Pearson", 1962);
select * from book;

insert into book_authors values(1, "Elmasri");
insert into book_authors values(2, "Aurelion Geron");
insert into book_authors values(3, "Russel");
insert into book_authors values(4, "Sebastian");
insert into book_authors values(5, "Larry Peterson");
select * from book_authors;

insert into publisher values("Goyal brothers", "Banglore", 987456321);
insert into publisher values("Oreilly", "Australia", 987455321);
insert into publisher values("Prentice Hall", "USA", 987256321);
insert into publisher values("Willey", "Birmingham", 987456327);
insert into publisher values("Pearson", "Auckland", 987406321);
select * from publisher;

insert into branch values(1, "Bannerghatta", "Bangalore");
insert into branch values(2, "RR nagar", "Bangalore");
insert into branch values(3, "Basavanagudi", "Bangalore");
insert into branch values(4, "Andheri", "Mumbai");
insert into branch values(5, "Dombivilli", "Mumbai");
select * from branch;

insert into book_copies values(1, 1, 36);
insert into book_copies values(2, 2, 72);
insert into book_copies values(3, 3, 100);
insert into book_copies values(4, 4, 200);
insert into book_copies values(5, 5, 144);
select * from book_copies;

insert into book_lending values(1, 1, 101, "2022-08-09", "2022-08-16");
insert into book_lending values(2, 2, 102, "2022-06-15", "2022-06-22");
insert into book_lending values(3, 3, 103, "2022-07-29", "2022-08-05");
insert into book_lending values(4, 4, 104, "2022-11-09", "2022-11-16");
insert into book_lending values(5, 5, 105, "2022-12-19", "2022-12-26");
select * from book_lending;

-- Retrieve details of all books in the library – id, title, name of publisher, authors, number
-- of copies in each branch,etc.
select b.book_id, b.book_name, b.publisher_name, a.author_name, c.no_of_copies, l.branch_id
from book b, book_authors a, branch l, book_copies c
where b.book_id = a.book_id and b.book_id = c.book_id and l.branch_id = c.branch_id;

-- Get the particulars of borrowers who have borrowed more than 3 books, but from Jan
-- 2017 to Jun2017
insert into book_lending values(4, 1, 106, "2017-01-19", "2017-01-26");
insert into book_lending values(3, 2, 106, "2017-02-09", "2017-02-16");
insert into book_lending values(1, 5, 106, "2017-02-28", "2017-03-07");
insert into book_lending values(1, 5, 106, "2017-04-25", "2017-05-01");

select card_no from book_lending
where date_out between "2017-01-01" and "2017-06-01"
group by card_no having count(*) > 3;

-- Delete a book in BOOK table. Update the contents of other tables to reflect this data
-- manipulationoperation.
delete from book where book_id = 3;

select * from book;
select * from book_copies;

-- Partition the BOOK table based on year of publication. Demonstrate its working with a
-- simplequery.
select pub_year from book;

create view v_publication
as select pub_year from book;

select * from v_publication;

-- Create a view of all books and its number of copies that are currently available in the
-- Library.
create view Num_Of_Books as
select b.book_name, c.no_of_copies
from book b, book_copies c
where b.book_id = c.book_id;

select * from Num_Of_Books;

