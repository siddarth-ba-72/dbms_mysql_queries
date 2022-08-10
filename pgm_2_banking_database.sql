-- Create Banking database
create database Banking;
use Banking;

-- Create branch table
create table branch (
	branch_name varchar(20),
    branch_city varchar(20),
    assets real,
    primary key(branch_name)
);
desc branch;

-- Create Bank Account table
create table bankAccount (
	acc_no int,
    branch_name varchar(20),
    balance real,
    primary key(acc_no),
    foreign key(branch_name) references branch(branch_name)
);
desc bankAccount;

-- Create Bank Customer table
create table bankCustomer (
	customer_name varchar(20),
    customer_street varchar(20),
    customer_city varchar(20),
    primary key(customer_name)
);
desc bankCustomer;

-- Create Depositor table
create table depositor (
	customer_name varchar(20),
    acc_no int,
    primary key(customer_name, acc_no),
    foreign key(customer_name) references bankCustomer(customer_name),
    foreign key(acc_no) references bankAccount(acc_no)
);
desc depositor;

-- Create Loan table
create table loan (
	loan_number int,
    branch_name varchar(20),
    amount int,
    primary key(loan_number),
    foreign key(branch_name) references branch(branch_name)
);
desc loan;

insert into branch values('Bannerghatta rd', 'Bengaluru', 100000000);
insert into branch values('Malleshwaram', 'Bengaluru', 200000000);
insert into branch values('Majestic', 'Bengaluru', 150000000);
insert into branch values('Basavanagudi', 'Bengaluru', 102000000);
insert into branch values('Yeshwantpur', 'Bengaluru', 300000000);

insert into branch values('Andheri', 'Mumbai', 600000000);
insert into branch values('Dombivilli', 'Mumbai', 1200000000);
insert into branch values('Powai', 'Mumbai', 2700000000);

desc branch;
select * from branch;

insert into bankAccount values(10001, 'Bannerghatta rd', 100000);
insert into bankAccount values(10002, 'Malleshwaram', 150000);
insert into bankAccount values(10003, 'Majestic', 1500000);
insert into bankAccount values(10004, 'Basavanagudi', 10000);
insert into bankAccount values(10005, 'Yeshwantpur', 200000);
insert into bankAccount values(10006, 'Yeshwantpur', 200000);

insert into bankAccount values(10007, 'Andheri', 1500000);
insert into bankAccount values(10008, 'Dombivilli', 1800000);
insert into bankAccount values(10009, 'Powai', 2100000);

desc bankAccount;
select * from bankAccount;

insert into bankCustomer values('Mahesh', 'Church St', 'Bengaluru');
insert into bankCustomer values('Joseph', 'Dairy circle', 'Bengaluru');
insert into bankCustomer values('Prabhat', 'Shantinagar', 'Bengaluru');
insert into bankCustomer values('Stokes', 'Bannerghatta rd', 'Bengaluru');
insert into bankCustomer values('Thomas', 'Birmingham', 'Bengaluru');

insert into bankCustomer values('Scofield', 'Marine drive', 'Mumbai');
insert into bankCustomer values('Linc', 'Ballard estate', 'Mumbai');
insert into bankCustomer values('Alexander', 'Dadar', 'Mumbai');

desc bankCustomer;
select * from bankCustomer;

insert into depositor values('Mahesh', 10001);
insert into depositor values('Joseph', 10002);
insert into depositor values('Prabhat', 10003);
insert into depositor values('Stokes', 10004);
insert into depositor values('Thomas', 10005);

insert into depositor values('Scofield', 10007);
insert into depositor values('Linc', 10008);
insert into depositor values('Alexander', 10009);

desc depositor;
select * from depositor;

insert into loan values(0001, 'Bannerghatta rd', 500000);
insert into loan values(0002, 'Malleshwaram', 750000);
insert into loan values(0003, 'Majestic', 1000000);
insert into loan values(0004, 'Basavanagudi', 50000);
insert into loan values(0005, 'Yeshwantpur', 900000);

desc loan;
select * from loan;

-- Find all the customers who have at least two deposits at the same branch
select c.customer_name
from bankCustomer c
where exists (
	select d.customer_name, count(d.customer_name)
    from depositor d, bankAccount b
    where
    d.acc_no = b.acc_no and
    b.branch_name = "Basavanagudi"
    group by d.customer_name
    having count(d.customer_name) >= 1
);

-- Find all the customers who have an account at all the branches located in a specific city
select b.acc_no, d.customer_name, br.branch_name
from depositor d, bankAccount b, branch br
where d.acc_no = b.acc_no and b.branch_name = br.branch_name
and br.branch_city = "Mumbai";

-- delete all account tuples at every branch located in a specific city
delete from bankAccount
where branch_name in (
	select branch_name
    from branch
    where branch_city = "Mumbai"
);

-- List the entire loan relation in the descending order of the amount
select * from loan
order by amount desc;

-- Create a view which gives each branch the sum of the amount of all loans at the branch
create view branch_total_loan(Branch_name, Total_loan) as
select branch_name, sum(amount)
from loan group by branch_name;

select * from branch_total_loan;

-- The annual intereset payments are made and all branches are to be increased to 5%
update bankAccount set balance = balance * 1.05;