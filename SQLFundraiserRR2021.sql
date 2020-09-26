use master;
go

drop database if exists FundraiserRR2021;
go

create database FundraiserRR2021;
go

use FundraiserRR2021;
go

create table Customers (
id int not null primary key identity (1,1),
UserName varchar(20) not null,
Password varchar(15) not null,
FirstName varchar(30) not null,
LastName varchar(50) not null,
StreetAddress varchar(50) not null,
Apt# varchar(10),
City varchar(25) not null,
State varchar(2) not null,
Zip int not null,
PhoneNumber varchar(12) not null,
Email varchar(75) not null
);

insert Customers (UserName, Password, FirstName, LastName, StreetAddress, Apt#, City, State, Zip, PhoneNumber, Email)
values ('adamsuser','adamspass','Amy','Adams','123 Main Street','1','Hamilton','OH','45013','513-555-1212','amyadams@yahoo.com')

select *
	from Customers

create table Payment (
id int not null primary key identity(1,1),
CustomerId int not null foreign key references Customers(Id),
FirstName varchar(30) not null,
LastName varchar(50) not null,
StreetAddress varchar(50) not null,
Apt# varchar(10),
City varchar(25) not null,
State varchar(2) not null,
Zip int not null,
Email varchar(75) not null,
CreditCard# int not null,
ExpirationMonth int not null,
ExpirationYear int not null,
CVC int not null

);

insert Payment (CustomerId, FirstName, LastName, StreetAddress, Apt#, City, State, Zip, Email, CreditCard#, ExpirationMonth, ExpirationYear, CVC)
values (1, 'Amy','Adams','123 Main Street','1','Hamilton','OH', '45013','amyadams@yahoo.com', '12345678', '01', '25','246')

select *
	from Payment

create table Tickets (
	id int not null primary key identity(1,1),
	CustomerId int not null foreign key references Customers(Id),
	PaymentId int not null foreign key references Payment(Id),
	TicketNumber1for10 int not null,
	TicketNumber3for20 int not null,
	TicketNumber10for40 int not null
	);

insert Tickets (CustomerId, PaymentId, TicketNumber1for10, TicketNumber3for20, TicketNumber10for40)
values (1, 1, 1, 1, 1)

select *
	from Tickets

create table Students (
	id int not null primary key identity(1,1),
	StudentsId int not null foreign key references Customers(Id),
	TicketsId int not null foreign key references Tickets(Id),
	GroupName varchar(30) not null,
	StudentName varchar(30) not null,
	TotalTicketNumber1for10 int not null,
	TotalTicketNumber3for20 int not null,
	TotalTicketNumber10for40 int not null
	);

insert Students (StudentsId, TicketsId, GroupName, StudentName, TotalTicketNumber1for10, TotalTicketNumber3for20, TotalTicketNumber10for40)
values (1, 1, 'Legacy', 'AJ Eads', 2, 2, 2)

select * 
	from Students


select *
	from Customers c
	join Payment p
		on p.CustomerId = c.id
	join Tickets t
		on t.PaymentId = p.id
	join Students s
		on s.TicketsId = t.id

select c.FirstName, c.LastName, c.Email, c.PhoneNumber, t.TicketNumber1for10, t.TicketNumber3for20, t.TicketNumber10for40, sum(t.TicketNumber1for10*10, t.TicketNumber3for20*20, t.TicketNumber10for40*40) as 'Total Sales Per Customer'
	group by c.LastName

select s.StudentName,  sum(s.TotalTicketNumber1for10*10, s.TotalTicketNumber3for20*20,s.TotalTicketNumber10for40*40) as 'Total Sales Per Student'
	order by s.StudentName








