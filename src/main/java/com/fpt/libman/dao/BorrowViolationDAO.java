package com.fpt.libman.dao;

import com.fpt.libman.model.BorrowViolation;
import com.fpt.libman.model.Violation;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BorrowViolationDAO extends DAO {

    public BorrowViolationDAO() throws SQLException {
        super();
    }

    public List<BorrowViolation> getViolation(int borrowedDocumentId) throws SQLException {
        List<BorrowViolation> list = new ArrayList<>();
        String sql = "SELECT bv.*, v.name, v.note FROM tblBorrowViolation bv " +
                "JOIN tblViolation v ON bv.tblViolationId = v.id " +
                "WHERE bv.tblBorrowedDocumentId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowedDocumentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BorrowViolation bv = new BorrowViolation();
                    bv.setId(rs.getInt("id"));
                    bv.setDescription(rs.getString("description"));

                    Violation v = new Violation();
                    v.setId(rs.getInt("tblViolationId"));
                    v.setName(rs.getString("name"));
                    v.setNote(rs.getString("note"));

                    bv.setViolation(v);
                    list.add(bv);
                }
            }
        }
        System.out.println("Found " + list.size() + " old violations for borrowedDocId: " + borrowedDocumentId);
        return list;
    }
}