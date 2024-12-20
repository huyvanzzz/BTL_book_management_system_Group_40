DELIMITER $$

CREATE TRIGGER ReduceStockAfterPurchase
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Books
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE BookID = NEW.BookID;

    -- Kiểm tra nếu số lượng tồn kho âm
    IF (SELECT StockQuantity FROM Books WHERE BookID = NEW.BookID) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The order quantity exceeds available stock. Please check the stock.';
    END IF;
END;
$$

DELIMITER ;
