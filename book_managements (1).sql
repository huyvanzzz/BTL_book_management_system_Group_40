CREATE DATABASE  IF NOT EXISTS BOOK_MANAGEMENTS;
use BOOK_MANAGEMENTS;

-- Drop tables if they exist
DROP TABLE IF EXISTS WishlistItems;
DROP TABLE IF EXISTS Wishlists;
DROP TABLE IF EXISTS BookDiscounts;
DROP TABLE IF EXISTS Discounts;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Publishers;

-- Create Publishers Table
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(255),
    Website VARCHAR(100),
    Address VARCHAR(255)
);

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100),
    Description TEXT
);

-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255),
    Biography TEXT,
    Birthday DATE
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublisherID INT,
    PublicationYear INT,
    ISBN VARCHAR(13),
    Price DECIMAL(10, 2) DEFAULT 0.00 CHECK (Price >= 0),
    CategoryID INT,
   StockQuantity INT DEFAULT 0,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Shipping Table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    OrderID INT,
    ShippingDate DATE,
    ShippingMethod VARCHAR(50),
    TrackingNumber VARCHAR(50),
    ShippingAddress VARCHAR(255),
    ShippingFee DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    PaymentAmount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Reviews Table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create Discounts Table
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY,
    DiscountName VARCHAR(100),
    DiscountAmount DECIMAL(5, 2) CHECK (DiscountAmount >= 0),
    StartDate DATE,
    EndDate DATE
);

-- Create BookDiscounts Table
CREATE TABLE BookDiscounts (
    DiscountID INT,
    BookID INT,
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Wishlists Table
CREATE TABLE Wishlists (
    WishlistID INT PRIMARY KEY,
    CustomerID INT,
    CreationDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create WishlistItems Table
CREATE TABLE WishlistItems (
    WishlistItemID INT PRIMARY KEY,
    WishlistID INT,
    BookID INT,
    FOREIGN KEY (WishlistID) REFERENCES Wishlists(WishlistID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert into Publishers
INSERT INTO Publishers (PublisherID, PublisherName, Website, Address) 
VALUES 
(1, 'Publisher A', 'http://publishera.com', '123 Main St'),
(2, 'Publisher B', 'http://publisherb.com', '456 Elm St'),
(3, 'Publisher C', 'http://publisherc.com', '789 Oak St'),
(4, 'Publisher D', 'http://publisherd.com', '101 Pine St'),
(5, 'Publisher E', 'http://publishere.com', '202 Maple St'),
(6, 'Publisher F', 'http://publisherf.com', '303 Birch St'),
(7, 'Publisher G', 'http://publisherg.com', '404 Cedar St'),
(8, 'Publisher H', 'http://publisherh.com', '505 Walnut St'),
(9, 'Publisher I', 'http://publisheri.com', '606 Redwood St'),
(10, 'Publisher J', 'http://publisherj.com', '707 Fir St');

-- Insert into Categories
INSERT INTO Categories (CategoryID, CategoryName, Description) 
VALUES 
(1, 'Fiction', 'Books that contain fictional stories'),
(2, 'Non-Fiction', 'Books based on real events and facts'),
(3, 'Science', 'Books related to scientific topics'),
(4, 'Technology', 'Books about technology and its advancements'),
(5, 'Fantasy', 'Books set in imaginary worlds or magical settings'),
(6, 'Romance', 'Books that focus on romantic relationships'),
(7, 'History', 'Books that discuss historical events and periods'),
(8, 'Biography', 'Books detailing a person’s life story'),
(9, 'Self-Help', 'Books offering advice for personal improvement'),
(10, 'Mystery', 'Books that involve solving a crime or mystery');

-- Insert into Authors
INSERT INTO Authors (AuthorID, AuthorName, Biography, Birthday) 
VALUES 
(1, 'Author A', 'Biography of Author A', '1970-01-01'),
(2, 'Author B', 'Biography of Author B', '1980-02-15'),
(3, 'Author C', 'Biography of Author C', '1990-03-20'),
(4, 'Author D', 'Biography of Author D', '1965-04-25'),
(5, 'Author E', 'Biography of Author E', '1975-05-30'),
(6, 'Author F', 'Biography of Author F', '1985-06-10'),
(7, 'Author G', 'Biography of Author G', '1995-07-18'),
(8, 'Author H', 'Biography of Author H', '2000-08-05'),
(9, 'Author I', 'Biography of Author I', '1988-09-12'),
(10, 'Author J', 'Biography of Author J', '1992-10-22');


-- Insert into Books
INSERT INTO Books (BookID, Title, AuthorID, PublisherID, PublicationYear, ISBN, Price, CategoryID, StockQuantity) 
VALUES 
(1, 'Book A', 1, 1, 2020, '1234567890123', 19.99, 1, 100),
(2, 'Book B', 2, 2, 2021, '2345678901234', 29.99, 2, 50),
(3, 'Book C', 3, 3, 2019, '3456789012345', 39.99, 3, 75),
(4, 'Book D', 4, 4, 2018, '4567890123456', 24.99, 4, 80),
(5, 'Book E', 5, 5, 2022, '5678901234567', 14.99, 5, 120),
(6, 'Book F', 6, 6, 2023, '6789012345678', 34.99, 6, 60),
(7, 'Book G', 7, 7, 2017, '7890123456789', 44.99, 7, 90),
(8, 'Book H', 8, 8, 2016, '8901234567890', 54.99, 8, 40),
(9, 'Book I', 9, 9, 2020, '9012345678901', 64.99, 9, 110),
(10, 'Book J', 10, 10, 2021, '0123456789012', 74.99, 10, 130);

-- Insert into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address) 
VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Elm St'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', '789 Oak St'),
(4, 'Bob', 'Williams', 'bob.williams@example.com', '456-789-0123', '101 Pine St'),
(5, 'Charlie', 'Brown', 'charlie.brown@example.com', '567-890-1234', '202 Maple St'),
(6, 'David', 'Jones', 'david.jones@example.com', '678-901-2345', '303 Birch St'),
(7, 'Eve', 'Miller', 'eve.miller@example.com', '789-012-3456', '404 Cedar St'),
(8, 'Frank', 'Davis', 'frank.davis@example.com', '890-123-4567', '505 Walnut St'),
(9, 'Grace', 'Garcia', 'grace.garcia@example.com', '901-234-5678', '606 Redwood St'),
(10, 'Hannah', 'Martinez', 'hannah.martinez@example.com', '012-345-6789', '707 Fir St');

-- Insert into Orders
INSERT INTO Orders (OrderID, OrderDate, CustomerID) 
VALUES 
(1, '2024-01-01', 1),
(2, '2024-02-02', 2),
(3, '2024-03-03', 3),
(4, '2024-04-04', 4),
(5, '2024-05-05', 5),
(6, '2024-06-06', 6),
(7, '2024-07-07', 7),
(8, '2024-08-08', 8),
(9, '2024-09-09', 9),
(10, '2024-10-10', 10);

-- Insert into OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, BookID, Quantity, TotalPrice) 
VALUES 
(1, 1, 1, 2, 39.98),
(2, 2, 2, 1, 29.99),
(3, 3, 3, 3, 89.97),
(4, 4, 4, 1, 24.99),
(5, 5, 5, 4, 59.96),
(6, 6, 6, 2, 69.98),
(7, 7, 7, 1, 44.99),
(8, 8, 8, 2, 109.98),
(9, 9, 9, 3, 194.97),
(10, 10, 10, 5, 374.95);

-- Insert into Shipping
INSERT INTO Shipping (ShippingID, OrderID, ShippingDate, ShippingMethod, TrackingNumber, ShippingAddress, ShippingFee) 
VALUES 
(1, 1, '2024-01-02', 'Standard', 'TRK001', '123 Main St', 5.00),
(2, 2, '2024-02-03', 'Express', 'TRK002', '456 Elm St', 10.00),
(3, 3, '2024-03-04', 'Standard', 'TRK003', '789 Oak St', 5.00),
(4, 4, '2024-04-05', 'Express', 'TRK004', '101 Pine St', 10.00),
(5, 5, '2024-05-06', 'Standard', 'TRK005', '202 Maple St', 5.00),
(6, 6, '2024-06-07', 'Express', 'TRK006', '303 Birch St', 10.00),
(7, 7, '2024-07-08', 'Standard', 'TRK007', '404 Cedar St', 5.00),
(8, 8, '2024-08-09', 'Express', 'TRK008', '505 Walnut St', 10.00),
(9, 9, '2024-09-10', 'Standard', 'TRK009', '606 Redwood St', 5.00),
(10, 10, '2024-10-11', 'Express', 'TRK010', '707 Fir St', 10.00);

-- Insert into Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, PaymentAmount, PaymentMethod) 
VALUES 
(1, 1, '2024-01-01', 39.98, 'Credit Card'),
(2, 2, '2024-02-02', 29.99, 'PayPal'),
(3, 3, '2024-03-03', 89.97, 'Credit Card'),
(4, 4, '2024-04-04', 24.99, 'Debit Card'),
(5, 5, '2024-05-05', 59.96, 'Credit Card'),
(6, 6, '2024-06-06', 69.98, 'PayPal'),
(7, 7, '2024-07-07', 44.99, 'Credit Card'),
(8, 8, '2024-08-08', 109.98, 'Debit Card'),
(9, 9, '2024-09-09', 194.97, 'Credit Card'),
(10, 10, '2024-10-10', 374.95, 'PayPal');

-- Insert into Reviews
INSERT INTO Reviews (ReviewID, BookID, CustomerID, Rating, Comment, ReviewDate) 
VALUES 
(1, 1, 1, 5, 'Great book, very enjoyable!', '2024-01-10'),
(2, 2, 2, 4, 'Very interesting but a bit long.', '2024-02-11'),
(3, 3, 3, 5, 'A masterpiece of sci-fi!', '2024-03-12'),
(4, 4, 4, 3, 'Good read but predictable.', '2024-04-13'),
(5, 5, 5, 4, 'Nice story, would recommend.', '2024-05-14'),
(6, 6, 6, 5, 'Excellent plot and writing.', '2024-06-15'),
(7, 7, 7, 4, 'Solid book, but could have been better.', '2024-07-16'),
(8, 8, 8, 5, 'An exciting and thrilling adventure!', '2024-08-17'),
(9, 9, 9, 4, 'A bit too long but very good overall.', '2024-09-18'),
(10, 10, 10, 5, 'One of the best books I have ever read!', '2024-10-19');
-- Insert into Discounts
INSERT INTO Discounts (DiscountID, DiscountName, DiscountAmount, StartDate, EndDate)
VALUES 
(1, 'Winter Sale', 20.00, '2024-12-01', '2024-12-31'),
(2, 'Summer Offer', 15.00, '2024-06-01', '2024-06-30'),
(3, 'Black Friday', 50.00, '2024-11-28', '2024-11-29'),
(4, 'Holiday Special', 30.00, '2024-12-15', '2024-12-25'),
(5, 'Back to School', 10.00, '2024-08-01', '2024-08-15'),
(6, 'Flash Sale', 25.00, '2024-07-01', '2024-07-02'),
(7, 'Christmas Discount', 35.00, '2024-12-10', '2024-12-24'),
(8, 'New Year Sale', 40.00, '2024-01-01', '2024-01-10'),
(9, 'Easter Deal', 18.00, '2024-04-01', '2024-04-05'),
(10, 'Spring Discount', 12.00, '2024-03-01', '2024-03-31');

-- Insert into BookDiscounts
INSERT INTO BookDiscounts (DiscountID, BookID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
-- Insert into Wishlists
INSERT INTO Wishlists (WishlistID, CustomerID, CreationDate)
VALUES 
(1, 1, '2024-01-06'),
(2, 2, '2024-02-07'),
(3, 3, '2024-03-08'),
(4, 4, '2024-04-09'),
(5, 5, '2024-05-10'),
(6, 6, '2024-06-11'),
(7, 7, '2024-07-12'),
(8, 8, '2024-08-13'),
(9, 9, '2024-09-14'),
(10, 10, '2024-10-15');

-- Insert into WishlistItems
INSERT INTO WishlistItems (WishlistItemID, WishlistID, BookID)
VALUES 
(1, 1, 1),
(2, 1, 3),
(3, 2, 2),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(7, 4, 7),
(8, 4, 8),
(9, 5, 9),
(10, 5, 10);
