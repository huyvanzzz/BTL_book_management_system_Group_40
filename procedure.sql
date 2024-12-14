-- tính tổng doanh thu trong một tháng theo năm.
DELIMITER $$

CREATE PROCEDURE CalculateMonthlyRevenue(IN p_Year INT, IN p_Month INT)
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2);

    -- Tính tổng doanh thu của tháng từ Payments
    SELECT IFNULL(SUM(P.PaymentAmount),0)
    INTO totalRevenue
    FROM Payments P
    JOIN Orders O ON P.OrderID = O.OrderID
    WHERE YEAR(P.PaymentDate) = p_Year
    AND MONTH(P.PaymentDate) = p_Month;

    -- Hiển thị doanh thu
    SELECT totalRevenue AS MonthlyRevenue;
    IF totalRevenue = 0 THEN
        SELECT 'Không có doanh thu trong tháng này.' AS Message;
    ELSE
        SELECT CONCAT('Doanh thu tháng ', p_Month, ' năm ', p_Year, ' là: ', totalRevenue) AS Message;
    END IF;
END$$

DELIMITER ;

-- Drop Procedure nếu cần(Xoá -- ở đầu đi để thực hiện lệnh).
-- DROP PROCEDURE IF EXISTS CalculateMonthlyRevenue;

-- Gọi hàm để tính tổng doanh thu tháng 9 năm 2024.
CALL CalculateMonthlyRevenue(2024, 9);
