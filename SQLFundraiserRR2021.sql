use master;
go

drop database if exists FundraiserRR2021;
go

create database FundraiserRR2021;
go

use FundraiserRR2021;
go

create table Customers (
Id int not null primary key identity (1,1),
UserName varchar(20) not null,
Password varchar(15) not null,
CustomerFirstName varchar(30) not null,
CustomerLastName varchar(50) not null,
StreetAddress varchar(50) not null,
Apt# varchar(10),
City varchar(25) not null,
State varchar(2) not null,
Zip int not null,
PhoneNumber varchar(12) not null,
Email varchar(75) not null
);

insert Customers (UserName, Password, CustomerFirstName, CustomerLastName, StreetAddress, Apt#, City, State, Zip, PhoneNumber, Email)
values ('adamsuser','adamspass','Amy','Adams','123 Main Street','1','Hamilton','OH','45013','513-555-1212','amyadams@yahoo.com')

select *
	from Customers

create table Tickets (
	Id int not null primary key identity(1,1),
	CustomerId int not null foreign key references Customers(Id),
	TicketBundle varchar(9) not null, /* 1 for 10, 3 for 20, 10 for 40*/
	TicketNumber int not null 
	);

insert Tickets (CustomerId, TicketBundle, TicketNumber)
values (1, '1 for 10', 1)

select *
	from Tickets

create table Sales (
	Id int not null primary key identity (1,1),
	TicketId int not null foreign key references Tickets(Id),
	CustomerId int not null foreign key references Customers(Id),
	TicketBundle varchar(9) not null foreign key references Tickets(TicketBundle),
	Price decimal(11,2) not null,
	Quantity int not null DEFAULT 1,
	Total decimal(11,2) not null,
	--StudentId varchar(30) foreign key references Students(Id)
	);

insert Sales (CustomerId, TicketId, TicketBundle, Price, Quantity, Total)
values (1, 1, '1 for 10', 10.00, 2, 20.00)

select * 
from Sales

/* We are crediting a student's show choir fees if they sell $200 worth of tickets.
The student will receive a $100 credit if they sell $200.
We will ask the customer to select a student name from a drop down menu so that student gets credit for the tickets.*/
create table Students (
	Id int not null primary key identity(1,1),
	GroupName varchar(30) not null,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	CustomerId int not null foreign key references Customers(Id),
	SalesId int not null foreign key references Sales(Id)
	
	);

insert Students (GroupName, FirstName, LastName, CustomerId, SalesId)
values ('Legacy', 'AJ', 'Eads', 1, 1)

select * 
	from Students


select c.CustomerFirstName, c.CustomerLastName, c.PhoneNumber, t.TicketBundle, t.TicketNumber, s.Price, s.Quantity, s.Total, st.GroupName, st.FirstName, st.LastName
	from Customers c
	join Tickets t
		on t.CustomerId = c.Id
	join Sales s
		on s.CustomerId = s.Id
	join Students st
		on st.SalesId = s.Id
	order by st.GroupName











