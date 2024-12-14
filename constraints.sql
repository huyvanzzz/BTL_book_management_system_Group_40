use BOOK_MANAGEMENTS;
-- Add foreign key constraint to Books table for AuthorID
ALTER TABLE Books
ADD CONSTRAINT fk_books_authors FOREIGN KEY (AuthorID)
REFERENCES Authors(AuthorID)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- Add foreign key constraint to Books table for PublisherID
ALTER TABLE Books
ADD CONSTRAINT fk_books_publishers FOREIGN KEY (PublisherID)
REFERENCES Publishers(PublisherID)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- Add foreign key constraint to OrderItems table for OrderID
ALTER TABLE OrderItems
ADD CONSTRAINT fk_order_items_orders FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Add foreign key constraint to OrderItems table for BookID
ALTER TABLE OrderItems
ADD CONSTRAINT fk_order_items_books FOREIGN KEY (BookID)
REFERENCES Books(BookID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Add foreign key constraint to Shipping table for OrderID
ALTER TABLE Shipping
ADD CONSTRAINT fk_shipping_orders FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID)
ON DELETE CASCADE
ON UPDATE CASCADE;
