use BOOK_MANAGEMENTS;
-- PHẦN A SỬ DỤNG INNER JOIN.
-- Lấy danh sách tất cả sách trong đơn hàng, bao gồm tên sách và số lượng mua.
SELECT Books.Title, OrderItems.Quantity
FROM OrderItems
JOIN Books ON OrderItems.BookID = Books.BookID;

-- Lấy thông tin về khách hàng và đơn hàng mà họ đã đặt.
SELECT Customers.FirstName, Customers.LastName, Orders.OrderDate, Orders.OrderID
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- PHẦN B SỬ DỤNG OUTER JOIN.
-- Lấy danh sách tất cả các sách và thông tin giảm giá nếu có.
SELECT Books.Title, Discounts.DiscountName, Discounts.DiscountAmount
FROM Books
LEFT JOIN BookDiscounts ON Books.BookID = BookDiscounts.BookID
LEFT JOIN Discounts ON BookDiscounts.DiscountID = Discounts.DiscountID;

-- Lấy danh sách khách hàng và thông tin wishlist của họ, kể cả khi không có wishlist.
SELECT Customers.FirstName, Customers.LastName, Wishlists.WishlistID, Wishlists.CreationDate
FROM Customers
LEFT JOIN Wishlists ON Customers.CustomerID = Wishlists.CustomerID;

-- PHẦN C SỬ DỤNG SUBQUERY TRONG WHERE.
-- Lấy danh sách tên các khách hàng đã đặt đơn hàng trong năm 2024.
SELECT concat(LastName,' ',FirstName) as name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE YEAR(OrderDate) = 2024
);

-- Tìm các sách có giảm giá cao hơn mức giảm giá trung bình.
SELECT Books.Title, Discounts.DiscountAmount
FROM Books
JOIN BookDiscounts ON Books.BookID = BookDiscounts.BookID
JOIN Discounts ON BookDiscounts.DiscountID = Discounts.DiscountID
WHERE Discounts.DiscountAmount > (
    SELECT AVG(DiscountAmount) FROM Discounts
);

-- PHẦN D SỬ DỤNG SUBQUERY TRONG FROM.
-- Tìm tổng số lượng sách được bán ra theo từng danh mục sách.
SELECT Categories.CategoryName, SUM(Subquery.Quantity) AS TotalQuantity
FROM (
    SELECT Books.CategoryID, OrderItems.Quantity
    FROM OrderItems
    INNER JOIN Books ON OrderItems.BookID = Books.BookID
) AS Subquery
JOIN Categories ON Subquery.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName;

-- PHẦN E SỬ DỤNG GROUP BY VÀ CÁC HÀM TỔNG HỢP.
-- Tìm tổng doanh thu và số lượng sách bán được theo từng tháng.
SELECT MONTH(Orders.OrderDate) AS Month, SUM(OrderItems.TotalPrice) AS TotalRevenue, SUM(OrderItems.Quantity) AS TotalBooksSold
FROM Orders
JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
GROUP BY MONTH(Orders.OrderDate);

-- Tính số lượng đánh giá và điểm đánh giá trung bình cho mỗi cuốn sách.
SELECT Books.Title, COUNT(Reviews.ReviewID) AS TotalReviews, AVG(Reviews.Rating) AS AverageRating
FROM Books
LEFT JOIN Reviews ON Books.BookID = Reviews.BookID
GROUP BY Books.Title;




