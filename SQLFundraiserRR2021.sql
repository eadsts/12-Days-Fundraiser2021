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
values ('amy@yahoo.com','amy11','Amy','Adams','123 Main Street','1','Hamilton','OH','45013','513-555-1212','amyadams@yahoo.com')

select *
	from Customers

create table Sales (
	Id int not null primary key identity (1,1),
	CustomerId int not null foreign key references Customers(Id),
	Quantity int not null DEFAULT 1,
	Total decimal(11,2) not null,
	StudentId int foreign key references Students(Id)
	);

insert Sales (CustomerId, Quantity, Total, StudentId)
values (1, 2, 20.00, 1)

select * 
from Sales

create table Tickets (
	Id int not null primary key identity(1,1),
	CustomerId int not null foreign key references Customers(Id),
	SalesId int not null foreign key references Sales(Id),
	TicketNumber int not null 
	);

insert Tickets (CustomerId, SalesId, TicketNumber)
values (1, 1, 1)

select *
	from Tickets



/* We are crediting a student's show choir fees if they sell $200 worth of tickets.
The student will receive a $100 credit if they sell $200.
We will ask the customer to select a student name from a drop down menu so that student gets credit for the tickets.*/
create table Students (
	Id int not null primary key identity(1,1),
	GroupName varchar(30) not null,
	StudentFirstName varchar(30) not null,
	StudentLastName varchar(30) not null,
	SalesId int not null foreign key references Sales(Id)
	);

insert Students (GroupName, StudentFirstName, StudentLastName, CustomerId, SalesId)
values ('Legacy', 'AJ', 'Eads', 1, 1)

select * 
	from Students


select c.CustomerFirstName, c.CustomerLastName, c.PhoneNumber, c.Email, t.TicketNumber, s.Quantity, s.Total, st.GroupName, st.FirstName, st.LastName
	from Customers c
	join Tickets t
		on t.CustomerId = c.Id
	join Sales s
		on s.CustomerId = s.Id
	join Students st
		on st.SalesId = s.Id
	order by st.GroupName











