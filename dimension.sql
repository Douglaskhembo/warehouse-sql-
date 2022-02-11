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


CREATE TABLE DimSales(
    SalesOrderID int IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    Status tinyint NOT NULL DEFAULT (1),
    CustomerID int NOT NULL,
    SalesPersonID int NULL,
    CreditCardApprovalCode varchar(15) NULL,    
    CurrencyRateID int NULL,
    SubTotal money NOT NULL DEFAULT (0.00)
 );


CREATE TABLE FactPerformanceRatios(
  SalesPersonID int primary key identity,
  TotalPerformanceRatios money NOT NULL DEFAULT (0.00),
  TotalMonthlySales money NOT NULL DEFAULT (0.00),
  TotalMonthlyTaxEffecitivnes money NOT NULL DEFAULT (0.00)
);

  
/*
The 4-Step Dimensional Design
	1. Business Process: Product Sales Profit Location
    	We have to interview key decision makers to know, what factors define the success in the business.
		We also have to converse with persons from different departments to know what is needed to satisfy their als.
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


Insert into DimCustomer(CustomerAltID, CustomerName, Gender) 
  values 
  ('CUS-001', 'Simon Gills', 'M'), 
  ('CUS-002', 'Fischer Bunny', 'M'),
  ('CUS-003', 'Zed Kent', 'F'),
  ('CUS-004', 'Raphson Roll', 'M'),
  ('CUS-005', 'Zoe Clementine', 'F');

Create table DimProduct (
  ProductKey int primary key identity,
  ProductAltKey varchar(10) not null, 
  ProductName varchar(100),
  ProductActualCost money, 
  ProductSalesCost money 
);


INSERT INTO DimProduct(ProductAltKey, ProductName, ProductActualCost, ProductSalesCost)
  values 
  ('PROD-001', 'Sugar 1kg', 5.50, 6.50), 
  ('PROD-002', 'Rice 1kg', 22.50, 24), 
  ('PROD-003', 'Simsim Oil 1 ltr', 42, 43.5), 
  ('PROD-004', 'Nirma Soap', 18, 20),
  ('PROD-005', 'Mr Claen 1 ltr', 135, 139); 

Create table DimStores ( 
  StoreID int primary key identity,
  StoreAltID varchar(10) not null, 
  StoreName varchar(100),
  StoreLocation varchar(100),
  City varchar(100), 
  State varchar(100),
  Country varchar(100) 
);

Insert into DimStores(StoreAltID, StoreName, StoreLocation, City, State, Country )
  values 
  ('LOC-A1','Wallmart','RingRoad','Gangtown', 'NorhFront', 'Greatnation'),
  ('LOC-A2', 'Wallmart', 'ElmStreet', 'Gangtown', 'NorhFront', 'Greatnation'),
  ('LOC-A3', 'Wallmart', 'Freeland', 'Gangtown', 'NorhFront', 'Greatnation'); 

Create table DimSalesPerson ( 
  SalesPersonID int primary key identity,
  SalesPersonAltID varchar(10) not null,
  SalesPersonName varchar(100),
  StoreID int, City varchar(100), 
  State varchar(100), 
  Country varchar(100) 
);

  
Insert into DimSalesPerson(SalesPersonAltID, SalesPersonName, StoreID, City, State, Country )
  values ('SP-DMSPR1','Raj',1,'Gangtown','NorhFront','Greatnation'),
  ('SP-DMSPR2','Astolfo',1,'Gangtown','NorhFront','Greatnation'),
  ('SP-DMNGR1','Bill',2,'Gangtown','NorhFront','Greatnation'),
  ('SP-DMNGR2','Said',2,'Gangtown','NorhFront','Greatnation'),
  ('SP-DMSVR1','Jasmin',3,'Gangtown','NorhFront','Greatnation'), 
  ('SP-DMSVR2','Ashton',3,'Gangtown','NorhFront','Greatnation');

 
CREATE TABLE FactSales(  
  ActualCost money NOT NULL DEFAULT (0.00),
  TotalSales money NOT NULL DEFAULT (0.00),
  Quantity Tinyint NOT NULL DEFAULT (0),
  RecordCount tinyint NOT NULL DEFAULT (0)
 );

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


CREATE TABLE DimSales(
    SalesOrderID int IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    TerritoryID int NULL,
    CreditCardID int NULL,
    CurrencyRateID int NULL,
    TaxAmt money NOT NULL DEFAULT (0.00),
);

  
CREATE TABLE FactTax(
    TotalTaxAmt money NOT NULL DEFAULT (0.00),
);

