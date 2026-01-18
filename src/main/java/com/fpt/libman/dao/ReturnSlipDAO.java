package com.fpt.libman.dao;

import com.fpt.libman.model.ReturnSlip;
import com.fpt.libman.model.ReturnViolation;
import com.fpt.libman.model.Bill; // Import Bill
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReturnSlipDAO extends DAO {

    private static final Logger LOGGER = Logger.getLogger(ReturnSlipDAO.class.getName());

    public ReturnSlipDAO() throws SQLException {
        super();
    }

    public boolean addSlip(ReturnSlip slip, Map<Integer, List<ReturnViolation>> confirmedDocsMap) throws SQLException {

        conn.setAutoCommit(false); // Bắt đầu transs
        LOGGER.info("Bắt đầu Transaction trả sách...");

        try {
            String sqlSlip = "INSERT INTO tblReturnSlip (barcode, returnDate, note, fine, tblLibrarianId, tblReaderId) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement psSlip = conn.prepareStatement(sqlSlip, Statement.RETURN_GENERATED_KEYS)) {
                psSlip.setString(1, slip.getBarcode());
                psSlip.setTimestamp(2, slip.getReturnDate());
                psSlip.setString(3, slip.getNote());
                psSlip.setFloat(4, slip.getFine());
                psSlip.setInt(5, slip.getLibrarianId());
                psSlip.setInt(6, slip.getReaderId());

                int rowsUpdated = psSlip.executeUpdate();
                if (rowsUpdated == 0) {
                    throw new SQLException("Tạo ReturnSlip thất bại.");
                }

                try (ResultSet rs = psSlip.getGeneratedKeys()) {
                    if (rs.next()) {
                        slip.setId(rs.getInt(1)); // Cập nh id mới cho slip
                    }
                }
            }

            int newSlipId = slip.getId();
            LOGGER.info("Tạo ReturnSlip ID: " + newSlipId + " thành công.");

            // Bước 2: lưu ReturnedDocument và cập nhật BorrowedDocument
            String sqlReturnedDoc = "INSERT INTO tblReturnedDocument (tblBorrowedDocumentId, returnTime, tblReturnSlipId) VALUES (?, ?, ?)";
            String sqlUpdateBorrowed = "UPDATE tblBorrowedDocument SET isReturned = 1 WHERE id = ?";

            try (PreparedStatement psReturned = conn.prepareStatement(sqlReturnedDoc);
                 PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateBorrowed)) {

                for (Integer borrowedDocId : confirmedDocsMap.keySet()) {
                    psReturned.setInt(1, borrowedDocId);
                    psReturned.setTimestamp(2, slip.getReturnDate());
                    psReturned.setInt(3, newSlipId);
                    psReturned.addBatch();

                    psUpdate.setInt(1, borrowedDocId);
                    psUpdate.addBatch();
                }
                psReturned.executeBatch();
                psUpdate.executeBatch();
            }

            // Bước 3: lưu ReturnViolation
            String sqlViolation = "INSERT INTO tblReturnViolation (fee, isPaid, tblReturnedDocumentId, tblViolationId) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psViolation = conn.prepareStatement(sqlViolation)) {
                boolean hasViolations = false;
                for (Map.Entry<Integer, List<ReturnViolation>> entry : confirmedDocsMap.entrySet()) {
                    int borrowedDocId = entry.getKey();

                    for (ReturnViolation rv : entry.getValue()) {
                        psViolation.setFloat(1, rv.getFee());
                        psViolation.setBoolean(2, rv.isPaid());
                        psViolation.setInt(3, borrowedDocId);
                        psViolation.setInt(4, rv.getViolationId());
                        psViolation.addBatch();
                        hasViolations = true;
                    }
                }
                if (hasViolations) {
                    psViolation.executeBatch();
                }
            }

            conn.commit(); //done
            LOGGER.info("Transaction trả sách HOÀN TẤT (Commit).");
            return true;

        } catch (SQLException e) {
            conn.rollback();
            LOGGER.log(Level.SEVERE, "Transaction trả sách thất bại. Đã Rollback.", e);
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }
    }
}