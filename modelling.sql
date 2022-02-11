/*
The 4-Step Dimensional Design
	1. Business Process: Sales Person Performance
    2. Granularity: Measure Effectives of Sales
    3. Choosing Dimension Tables: Order Dimension, Sales Person Dimension
    4. Identifying Numeric facts for Fact Table: TotalPerformanceRatios (SalesYTD / SalesLastYear), TotalMonthlySales, TotalMonthlyTaxEffecitivnes (TaxAmount / SalesSubTotal).
*/

Create table DimSales (
  SalesPersonID int primary key identity,
  SalesPersonAltID varchar(10) not null,
  SalesPersonName varchar(100),
  StoreID int, City varchar(100),
  State varchar(100),
  Country varchar(100) 
);
GO

Insert into DimSales (SalesPersonAltID, SalesPersonName, StoreID, City, State, Country )values ('SP-DMSPR1','Ashish',1,'Ahmedabad','Guj','India'), ('SP-DMSPR2','Ketan',1,'Ahmedabad','Guj','India'), ('SP-DMNGR1','Srinivas',2,'Ahmedabad','Guj','India'), ('SP-DMNGR2','Saad',2,'Ahmedabad','Guj','India'), ('SP-DMSVR1','Jasmin',3,'Ahmedabad','Guj','India'), ('SP-DMSVR2','Jacob',3,'Ahmedabad','Guj','India');

CREATE TABLE DimSales(
    SalesOrderID int IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    Status tinyint NOT NULL CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT (1),
    AccountNumber AccountNumber] NULL,
    CustomerID int NOT NULL,
    SalesPersonID int NULL,
    CreditCardApprovalCode varchar(15) NULL,    
    CurrencyRateID int NULL,
    SubTotal money NOT NULL DEFAULT (0.00),
 ;
GO

/*
The 4-Step Dimensional Design
	1. Business Process: Product Sales Profit Location
    	We have to interview key decision makers to know, what factors define the success in the business.
		We also have to converse with persons from different departments to know what is needed to satisfy their goals.
    2. Granularity: Factors define the success in the business
    3. Choosing Dimensions Tables: Product, Customer, Store, Date, Time, Sales person
    4. Identifying Numeric facts for Fact Table: Actual Cost, Total Sales, Quantity, record count
*/

Create table DimCustomer (
  CustomerID int primary key identity,
  CustomerAltID varchar(10) not null,
  CustomerName varchar(50),
  Gender varchar(20)
);
GO

Insert into DimCustomer(CustomerAltID, CustomerName, Gender) 
  values 
  ('IMI-001', 'Mustafa Simba', 'M'), 
  ('IMI-002', 'Mark Gates', 'M'),
  ('IMI-003', 'Alfred Wayne', 'F'),
  ('IMI-004', 'Richard Goblin', 'M'),
  ('IMI-005', 'Emma Potter', 'F');

Create table DimProduct (
  ProductKey int primary key identity,
  ProductAltKey varchar(10) not null, 
  ProductName varchar(100),
  ProductActualCost money, 
  ProductSalesCost money 
);
GO

INSERT INTO DimProduct(ProductAltKey, ProductName, ProductActualCost, ProductSalesCost)
  values 
  ('ITM-001', 'Sugar 1kg', 5.50, 6.50), 
  ('ITM-002', 'Rice 1kg', 22.50, 24), 
  ('ITM-003', 'Simsim Oil 1 ltr', 42, 43.5), 
  ('ITM-004', 'Nirma Soap', 18, 20),
  ('ITM-005', 'Mr Claen 1 ltr', 135, 139); 

Create table DimStores ( 
  StoreID int primary key identity,
  StoreAltID varchar(10) not null, 
  StoreName varchar(100),
  StoreLocation varchar(100),
  City varchar(100), 
  State varchar(100),
  Country varchar(100) 
);
GO

Insert into DimStores(StoreAltID, StoreName, StoreLocation, City, State, Country )
  values 
  ('LOC-A1','Free-Mart','RingRoad','Ahmedabad', 'VBox', 'Meta'),
  ('LOC-A2', 'Free-Mart', 'ElmStreet', 'Ahmedabad', 'VBox', 'Meta'),
  ('LOC-A3', 'Free-Mart', 'Freeland', 'Ahmedabad', 'VBox', 'Meta'); 

Create table DimSalesPerson ( 
  SalesPersonID int primary key identity,
  SalesPersonAltID varchar(10) not null,
  SalesPersonName varchar(100),
  StoreID int, City varchar(100), 
  State varchar(100), 
  Country varchar(100) 
);
GO
  
Insert into DimSalesPerson(SalesPersonAltID, SalesPersonName, StoreID, City, State, Country )
  values ('SP-DMSPR1','Raj',1,'Ahmedabad','VBox','Meta'),
  ('SP-DMSPR2','Astolfo',1,'Ahmedabad','VBox','Meta'),
  ('SP-DMNGR1','Bill',2,'Ahmedabad','VBox','Meta'),
  ('SP-DMNGR2','Said',2,'Ahmedabad','VBox','Meta'),
  ('SP-DMSVR1','Jasmin',3,'Ahmedabad','VBox','Meta'), 
  ('SP-DMSVR2','Ashton',3,'Ahmedabad','VBox','Meta');


/*
The 4-Step Dimensional Design
	1. Business Process: CreditCard Order
    2. Granularity: SalesPerson Performance
    3. Choosing Dimension Tables: Order Dimension, CreditCard Dimension
    4. Identifying Numeric facts for Fact Table: TotalTax
*/

CREATE TABLE DimCreditCard(
    CreditCardID INT PRIMARY KEY identity (1, 1) NOT NULL,
    CardType nvarchar(50) NOT NULL,
    CardNumber nvarchar(25) NOT NULL,
    ExpMonth tinyint NOT NULL,
    ExpYear smallint NOT NULL, 
    ModifiedDate datetime NOT NULL DEFAULT (GETDATE()) 
);
GO

CREATE TABLE DimSales(
    SalesOrderID int IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    TerritoryID int NULL,
    CreditCardID int NULL,
    CurrencyRateID int NULL,
    TaxAmt money NOT NULL DEFAULT (0.00),
);
GO
