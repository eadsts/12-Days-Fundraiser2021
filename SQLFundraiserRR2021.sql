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
-- the CreditCard# says a 16 digit integer is too long, so I put an 8 digit integer in for now
insert Payment (CustomerId, FirstName, LastName, StreetAddress, Apt#, City, State, Zip, Email, CreditCard#, ExpirationMonth, ExpirationYear, CVC)
values (1, 'Amy','Adams','123 Main Street','1','Hamilton','OH', '45013','amyadams@yahoo.com', '12345678', '01', '25','246')

select *
	from Payment


/* Item would be choosing tickets at 1 for $10, 3 for $20, or 10 for $40.
Each ticket needs to have a unique ItemNumber, but I don't know how to enter multiple ItemNumbers in one column??
Item (at $10 or $20 or $40) multiplied by quantity will produce a total for the customer*/
create table Tickets (
	id int not null primary key identity(1,1),
	CustomerId int not null foreign key references Customers(Id),
	PaymentId int not null foreign key references Payment(Id),
	Item varchar (9) not null,
	ItemNumber int not null unique,
	Quantity int not null,
	Total decimal not null
	);

insert Tickets (CustomerId, PaymentId, Item, ItemNumber, Quantity, Total)
values (1, 1, '3 for 20', 122, 40.00)

select *
	from Tickets


/* We are crediting a student's show choir fees if they sell $200 worth of tickets.
The student will receive a $100 credit if they sell $200.
We will ask the customer to select a student name from a drop down menu so that student gets credit for the tickets.*/
create table Students (
	id int not null primary key identity(1,1),
	StudentsId int not null foreign key references Customers(Id),
	TicketsId int not null foreign key references Tickets(Id),
	GroupName varchar(30) not null,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Item varchar (9) not null,
	ItemNumber int not null unique,
	Quantity int not null,
	Total decimal not null
	);

insert Students (StudentsId, TicketsId, GroupName, FirstName, LastName, Item, ItemNumber, Quantity, Total)
values (1, 1, 'Legacy', 'AJ', 'Eads', '3 for 20', 122, 2, 40.00)

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

/* rows 112-116 have an error that says they cannot be bound.
Did I not jon them correctly?*/
select c.FirstName, c.LastName, c.Email, c.PhoneNumber, t.Item, t.ItemNumber, t.Quantity, t.Total
	group by c.LastName

select s.FirstName, s.LastName, s.Item, s.ItemNumber, s.Quantity, s.Total
	order by s.LastName








