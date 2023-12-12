--Create a database called Nike
CREATE DATABASE Nike
GO

--Use Nike
USE Nike
GO

-- Create Category Table
Create table Category
(
  CategoryId int primary key,
  CatName nvarchar(50)
)
GO

-- Create Order Table
Create table [Order]
(
  OrderId int primary key identity,
  OrderName nvarchar(50),
  OrderDate date,
  PaymentType nvarchar(50),
  Status nvarchar(50),
  CustomerName nvarchar(100),
  CustomerPhone nvarchar(15),
  CustomerEmail nvarchar(100),
  CustomerAddress nvarchar(250)
)
GO

-- Create User Table
Create table [User]
(
 UserId int primary key identity(1,1),
 UserName varchar(50),
 UserEmail nvarchar(100),
 UserPassword varchar(255)
)
GO

--Create Product Table
Create table Product
(
  ProId int Primary Key Identity(1,1),
  ProName nvarchar(50),
  ProImage nvarchar(100),
  ProPrice decimal(15, 3),
  TypeOf nvarchar(10),
  CategoryId int, 
  Foreign key(CategoryId) references Category(CategoryId)
)
GO

-- Create OrderDetail Table
Create table OrderDetail
(
  OrderId int,
  ProductId int,
  Price float,
  Quantity int
  Primary key(OrderId, ProductId),
  Foreign key(OrderId) references [Order](OrderId),
  Foreign key(ProductId) references Product(ProId)
)
GO

CREATE TABLE Blog (
    BlogId INT PRIMARY KEY identity(1,1),
    Title nVARCHAR(255),
	BlogAvata nvarchar(255),
    Content nTEXT,
    AuthorId INT,
    CreatedAt DATETIME,
    FOREIGN KEY (AuthorId) REFERENCES [User](UserId)
)
Go

-- Insert some test data into Category Table
Insert into Category (CategoryId, CatName)
			values	(0, 'Swiper'),
					(1, 'Hoodies'),
					(2, 'Shorts'),
					(3, 'Jackets'),
					(4, 'Tracksuits'),
					(5, 'Shoes'),
					(6, 'Socks'),
					(7, 'T-shirts'),
					(8, 'Trousers')
GO

--Create Product_Category View 
Create view Product_Category as
Select ProId, ProName, ProImage, ProPrice, TypeOf, Category.CategoryId, CatName
From Product inner join Category on Product.CategoryId=Category.CategoryId
GO

-- Insert Some Test data into Product Table
Insert into Product (ProName, ProImage, ProPrice, TypeOf, CategoryId)
						--Swiper
			values	('Air Force 1', '/images/swiper/air-force1.jpg', 1450.000, 'Unisex',0),
					('Air Joden 1', '/images/swiper/air-jordan1.jpg', 1970.000, 'Unisex',0),
					('Air Max','/images/swiper/air-max.jpg', 2450.000, 'Unisex',0),
					('Metcon','/images/swiper/metcon.jpg', 2100.000, 'Unisex',0),
					('Nike Blazer', '/images/swiper/nike-blazer.jpg', 1970.00, 'Unisex', 0),
					('Pegasus Running', '/images/swiper/pegasus-running.jpg', 1240.000, 'Unisex',0),
						--Hoodies	
					('Cozy Nike', '/images/hoodies/hoodie1.jpg', 1890.000, 'Men', 1),
					('Warm Nike', '/images/hoodies/hoodie2.jpg', 1990.000, 'Women', 1),
					('Soft Nike', '/images/hoodies/hoodie3.jpg', 1790.000, 'Women', 1),
					('Comfy Nike', '/images/hoodies/hoodie4.jpg', 2090.000, 'Men', 1),
					('Casual Nike', '/images/hoodies/hoodie5.jpg', 1990.000, 'Men', 1),
					('Stylish Nike', '/images/hoodies/hoodie6.jpg', 2190.000, 'Unisex', 1),
					('Fashionable Nike', '/images/hoodies/hoodie7.jpg', 2090.000, 'Men', 1),
					('Trendy Nike', '/images/hoodies/hoodie8.jpg', 1990.000, 'Women', 1),
					('Chic Nike', '/images/hoodies/hoodie9.jpg', 2090.000, 'Unisex', 1),
					('Modern Nike', '/images/hoodies/hoodie10.jpg', 1890.000, 'Men', 1),
					('Cool Nike', '/images/hoodies/hoodie11.jpg', 1890.000, 'Men', 1),
					('Casual Nike', '/images/hoodies/hoodie12.jpg', 1890.000, 'Men', 1),
						--Shorts
					('Casual Nike', '/images/shorts/short1.jpg', 890.000, 'Men', 2),
					('Sporty Nike', '/images/shorts/short2.jpg', 950.000, 'Men', 2),
					('Comfy Nike', '/images/shorts/short3.jpg', 890.000, 'Men', 2),
					('Stylish Nike', '/images/shorts/short4.jpg', 990.000, 'Men', 2),
					('Chic Nike', '/images/shorts/short5.jpg', 950.000, 'Men', 2),
					('Trendy Nike', '/images/shorts/short6.jpg', 990.000, 'Men', 2),
					('Modern Nike', '/images/shorts/short7.jpg', 950.000, 'Men', 2),
					('Fashionable Nike', '/images/shorts/short8.jpg', 990.000, 'Men', 2),
					('Elegant Nike', '/images/shorts/short9.jpg', 950.000, 'Unisex', 2),
					('Urban Nike', '/images/shorts/short10.jpg', 890.000, 'Women', 2),
					('Cool Nike', '/images/shorts/short11.jpg', 990.000, 'Men', 2),
					('Casual Nike', '/images/shorts/short12.jpg', 890.000, 'Women', 2),
						--Jackets
					('Stylish Nike', '/images/jackets/jacket1.jpg', 2450.000, 'Men', 3),
					('Elegant Nike', '/images/jackets/jacket2.jpg', 2550.000, 'Men', 3),
					('Sporty Nike', '/images/jackets/jacket3.jpg', 2650.000, 'Kids', 3),
					('Classic Nike', '/images/jackets/jacket4.jpg', 2350.000, 'Men', 3),
					('Casual Nike', '/images/jackets/jacket5.jpg', 2450.000, 'Women', 3),
					('Chic Nike', '/images/jackets/jacket6.jpg', 2550.000, 'Women', 3),
					('Modern Nike', '/images/jackets/jacket7.jpg', 2650.000, 'Men', 3),
					('Trendy Nike', '/images/jackets/jacket8.jpg', 2350.000, 'Unisex', 3),
					('Fashionable Nike', '/images/jackets/jacket9.jpg', 2450.000, 'Men', 3),
					('Urban Nike', '/images/jackets/jacket10.jpg', 2550.000, 'Men', 3),
					('Cool Nike', '/images/jackets/jacket11.jpg', 2650.000, 'Kids', 3),
					('Casual Nike', '/images/jackets/jacket12.jpg', 2200.000, 'Men', 3),
						-- Tracksuits
					('Sporty Nike', '/images/tracksuits/tracksuit1.jpg', 2790.000, 'Unisex', 4),
					('Casual Nike', '/images/tracksuits/tracksuit2.jpg', 2690.000, 'Kids', 4),
					('Chic Nike', '/images/tracksuits/tracksuit3.jpg', 2990.000, 'Kids', 4),
					('Stylish Nike', '/images/tracksuits/tracksuit4.jpg', 2890.000, 'Unisex', 4),
						--Shoes
					('Casual Nike', '/images/shoes/shoe1.jpg', 1890.000, 'Unisex', 5),
					('Sporty Nike', '/images/shoes/shoe2.jpg', 1990.000, 'Unisex', 5),
					('Comfy Nike', '/images/shoes/shoe3.jpg', 1790.000, 'Unisex', 5),
					('Stylish Nike', '/images/shoes/shoe4.jpg', 2090.000, 'Unisex', 5),
					('Chic Nike', '/images/shoes/shoe5.jpg', 1990.000, 'Unisex', 5),
					('Trendy Nike', '/images/shoes/shoe6.jpg', 2190.000, 'Unisex', 5),
					('Modern Nike', '/images/shoes/shoe7.jpg', 2090.000, 'Unisex', 5),
					('Fashionable Nike', '/images/shoes/shoe8.jpg', 2190.000, 'Unisex', 5),
					('Elegant Nike', '/images/shoes/shoe9.jpg', 1990.000, 'Unisex', 5),
					('Urban Nike', '/images/shoes/shoe10.jpg', 1890.000, 'Unisex', 5),
					('Cool Nike	', '/images/shoes/shoe11.jpg', 2090.000, 'Unisex', 5),
						--Socks
					('Casual Nike', '/images/socks/sock1.jpg', 150.000, 'Unisex', 6),
					('Sporty Nike', '/images/socks/sock2.jpg', 120.000, 'Unisex', 6),
					('Chic Nike', '/images/socks/sock3.jpg', 180.000, 'Unisex', 6),
					('Stylish Nike', '/images/socks/sock4.jpg', 160.000, 'Unisex', 6),
					('Trendy Nike', '/images/socks/sock5.jpg', 130.000, 'Unisex', 6),
					('Elegant Nike', '/images/socks/sock6.jpg', 170.000, 'Unisex', 6),
					('Casual Nike', '/images/socks/sock7.jpg', 140.000, 'Unisex', 6),
					('Sporty Nike', '/images/socks/sock8.jpg', 160.000, 'Unisex', 6),
					('Chic Nike', '/images/socks/sock9.jpg', 190.000, 'Unisex', 6),
						--T-Shirts
					('Casual Nike', '/images/t-shirts/t-shirt1.jpg', 350.000, 'Men', 7),
					('Sporty Nike', '/images/t-shirts/t-shirt2.jpg', 390.000, 'Men', 7),
					('Comfy Nike', '/images/t-shirts/t-shirt3.jpg', 320.000, 'Unisex', 7),
					('Stylish Nike', '/images/t-shirts/t-shirt4.jpg', 420.000, 'Women', 7),
					('Chic Nike', '/images/t-shirts/t-shirt5.jpg', 390.000, 'Men', 7),
					('Trendy Nike', '/images/t-shirts/t-shirt6.jpg', 450.000, 'Men', 7),
					('Modern Nike', '/images/t-shirts/t-shirt7.jpg', 420.000, 'Unisex', 7),
					('Fashionable Nike', '/images/t-shirts/t-shirt8.jpg', 450.000, 'Men', 7),
					('Elegant Nike', '/images/t-shirts/t-shirt9.jpg', 390.000, 'Men', 7),
					('Urban Nike', '/images/t-shirts/t-shirt10.jpg', 350.000, 'Men', 7),
						--Trousers
					('Casual Nike', '/images/trousers/trouser1.jpg', 550.000, 'Women', 8),
					('Sporty Nike', '/images/trousers/trouser2.jpg', 590.000, 'Men', 8),
					('Comfy Nike', '/images/trousers/trouser3.jpg', 520.000, 'Men', 8),
					('Stylish Nike', '/images/trousers/trouser4.jpg', 620.000, 'Men', 8),
					('Chic Nike', '/images/trousers/trouser5.jpg', 590.000, 'Women', 8),
					('Trendy Nike', '/images/trousers/trouser6.jpg', 650.000, 'Men', 8),
					('Modern Nike', '/images/trousers/trouser7.jpg', 620.000, 'Men', 8),
					('Fashionable Nike', '/images/trousers/trouser8.jpg', 650.000, 'Men', 8),
					('Elegant Nike', '/images/trousers/trouser9.jpg', 590.000, 'Unisex', 8),
					('Urban Nike', '/images/trousers/trouser10.jpg', 550.000, 'Unisex', 8),
					('Cool Nike', '/images/trousers/trouser10.jpg', 550.000, 'Men', 8),
					('Casual Nike', '/images/trousers/trouser10.jpg', 550.000, 'Men', 8)
GO
