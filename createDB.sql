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
    TotalPrice DECIMAL(10, 2)
);

-- Create Shipping Table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    OrderID INT,
    ShippingDate DATE,
    ShippingMethod VARCHAR(50),
    TrackingNumber VARCHAR(50),
    ShippingAddress VARCHAR(255),
    ShippingFee DECIMAL(10,2)
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