DELIMITER $$

CREATE PROCEDURE ProcessPayments(IN p_OrderID INT, IN p_PaymentAmount DECIMAL(10,2))
BEGIN
    DECLARE totalAmount DECIMAL(10,2);
    DECLARE currentStatus ENUM('Pending', 'Completed');
    DECLARE exit handler for sqlexception
    BEGIN
        -- Xử lý lỗi: Rollback giao dịch khi có lỗi
        ROLLBACK;
        SELECT 'Có lỗi trong quá trình thanh toán. Thay đổi đã bị hoàn tác.' AS Message;
    END;

    -- Bắt đầu giao dịch
    START TRANSACTION;

    -- Kiểm tra trạng thái của thanh toán
    SELECT Status INTO currentStatus
    FROM Payments
    WHERE OrderID = p_OrderID;

    IF currentStatus = 'Completed' THEN
        SIGNAL SQLSTATE '45000';
    END IF;

    -- Kiểm tra số tiền thanh toán có hợp lệ không
    IF p_PaymentAmount <= 0 THEN
        -- Nếu số tiền thanh toán không hợp lệ, kích hoạt lỗi và thực hiện ROLLBACK
        SIGNAL SQLSTATE '45000';
    END IF;

    -- Lấy tổng số tiền của đơn hàng từ bảng Payments
    SELECT PaymentAmount INTO totalAmount
    FROM Payments
    WHERE OrderID = p_OrderID;

    -- Kiểm tra nếu số tiền thanh toán không khớp với tổng số tiền của đơn hàng
    IF ROUND(totalAmount, 2) != ROUND(p_PaymentAmount, 2) THEN
        -- Nếu số tiền thanh toán không khớp, rollback và hiển thị lỗi
        SIGNAL SQLSTATE '45000';
    END IF;

    -- Nếu không có lỗi, cập nhật trạng thái thanh toán thành 'Completed'
    UPDATE Payments
    SET status = 'Completed', PaymentAmount = p_PaymentAmount, PaymentDate = NOW()
    WHERE OrderID = p_OrderID;

    -- Nếu không có lỗi, commit giao dịch
    COMMIT;
    SELECT 'Thanh toán thành công.' AS Message;
END$$

DELIMITER ;

-- Drop Procedure nếu cần (Xoá -- ở đầu đi để thực hiện lệnh).
-- DROP PROCEDURE IF EXISTS ProcessPayments;

-- Gọi Procedure với tham số
CALL ProcessPayments(1, 44.98);
