package com.fpt.libman.dao;
import com.fpt.libman.model.Bill;

import java.sql.*;

public class BillDAO extends DAO{

    public BillDAO() {
        super();
    }

    public boolean addBill(Bill bill) throws SQLException {
        String sql = "INSERT INTO tblBill (barcode, createAt, paymentType, note, tblReturnSlipId) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, bill.getBarcode());
            ps.setTimestamp(2, bill.getCreatedAt());
            ps.setString(3, bill.getPaymentType());
            ps.setString(4, bill.getNote());
            ps.setInt(5, bill.getReturnSlip().getId());

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bill.setId(rs.getInt(1));
                    }
                }
                System.out.println("[OK] Added Bill, id=" + bill.getId());
                return true;
            }
            return false;
        }
    }
}
