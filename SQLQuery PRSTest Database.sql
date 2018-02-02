use master
go
drop database if exists PRSTestDatabase
go
create database PRSTestDatabase
go
use PRSTestDatabase
go
drop table if exists PurchaseRequestLineItem
drop table if exists PurchaseRequest
drop table if exists Product
drop table if exists Vendor
drop table if exists [User]
go

create table [User] (
	Id int not null primary key identity (1,1),
	Username nvarchar(30) not null unique,
	Password nvarchar(30) not null,
	Firstname nvarchar(30) not null,
	LastName nvarchar(30) not null,
	Phone nvarchar(30) null,
	Email nvarchar(80) null,
	IsReviewer bit not null default 0, 
	IsAdmin bit not null default 0,
	Active bit not null default 1
)
go

insert into [User] (Username, Password, Firstname, LastName, Phone, Email, IsReviewer, IsAdmin, Active)
	 values ('christina.fox', 'My01Purchase', 'Christina', 'Fox', '5135551212', 'cfox.883@gmail.com', 1, 1, 1)
insert into [User] (Username, Password, Firstname, LastName, Phone, Email, IsReviewer, IsAdmin, Active)
	values ('GregDoud', 'My01Purchase', 'Greg', 'Doud', '5135554444', 'g.doud@gmail.com', 0,0,1)
insert into [User] (Username, Password, Firstname, LastName, Phone, Email, IsReviewer, IsAdmin, Active)
	  values ('MichaelRobinson', 'My01Purchase', 'Michael', 'Robinson', '5553336666', 'm.robinson@gmail.com', 0,0,1)

go

create table [Vendor](
	Id int not null primary key identity (1,1),
	Code nvarchar(30) not null unique, 
	Name nvarchar(30) not null, 
	Address nvarchar(30) not null,
	City nvarchar(30) not null,
	State nvarchar(2) not null, 
	Zip nvarchar(10) not null,
	Phone nvarchar(12) null,
	Email nvarchar(80) null,
	IsReccomended bit not null default 0,
	Active bit not null default 1
)
go

insert into Vendor (Code, Name, Address, City, State, Zip, Phone, Email, IsReccomended, Active)
	values (12345, 'Amazon', '111 Day One', 'Seattle', 'WA','98101', '123-123-1234', 'amazonproducts@amazon.com',1,1)
insert into Vendor (Code, Name, Address, City, State, Zip, Phone, Email, IsReccomended, Active)
	values (56789, 'Target', '222 Bullseye Street', 'Mineapolis','MN', '55075', '5559997777', 'targetproducts@target.com', 1,1)
go


create table [Product](
	Id int not null primary key identity (1,1),
	Name nvarchar(130) not null,
	VendorPartNumber nvarchar(50) not null,
	Price decimal (14,2) not null,
	Unit nvarchar(10) not null,
	PhotoPath nvarchar(255) null,
	VendorId int not null foreign key references Vendor,
	Active bit not null default 1
)
go

insert into Product (Name, VendorPartNumber, Price, Unit, PhotoPath, VendorId, Active)
	values('Desk', 'E60101', '150.00', '1', '12345678', '1', 0)
insert into Product (Name, VendorPartNumber, Price, Unit, PhotoPath, VendorId, Active)
	values('Chair', 'Q4523', '50.00', '3', '987654', '2', 1)
go


create table [PurchaseRequest] (
	Id int not null primary key identity (1,1),
	Description nvarchar(80) not null,
	Justification nvarchar(255) null,
	DateNeeded date not null default (getdate ()+7),
	DeliveryMode nvarchar(25) null, 
	Status nvarchar(10) not null default 'NEW',
	Total decimal (14,2) not null default 0.0,
	UserId int not null foreign key references [User]
)
go

insert into PurchaseRequest (Description, Justification, DateNeeded, DeliveryMode, Status, Total, UserId)
	values('Office Desk', 'New offices in company, all managers need desks', '3/1/2018', 'Fedex', 'Active', '165.00', '1')
insert into PurchaseRequest (Description, Justification, DateNeeded, DeliveryMode, Status, Total, UserId)
	values('Office Chair', 'New offices in company, all managers need chairs', '2/28/2018', 'UPS', 'Active', '200.00', '1')
go

create table [PurchaseRequestLineItems](
	Id int not null primary key identity (1,1),
	PurchaseRequestId int not null foreign key references [User],
	ProductId int not null foreign key references [Product],
	Quantity int not null default 1 
)
go

insert into [PurchaseRequestLineItems](PurchaseRequestId, ProductId, Quantity)
	values('1', '1', '1')
insert into [PurchaseRequestLineItems](PurchaseRequestId, ProductId, Quantity)
	values('2','2','3')

select * from [user]
select * from vendor
select * from product
select * from purchaserequest
select * from purchaserequestlineitems


