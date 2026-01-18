package com.fpt.libman.dao;

import com.fpt.libman.model.Violation;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ViolationDAO extends DAO {

    public ViolationDAO() throws SQLException {
        super();
    }

    public List<Violation> getAllViolations() throws SQLException {
        List<Violation> list = new ArrayList<>();
        String sql = "SELECT id, name, note FROM tblViolation";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Violation v = new Violation();
                v.setId(rs.getInt("id"));
                v.setName(rs.getString("name"));
                v.setNote(rs.getString("note"));
                list.add(v);
            }
        }
        return list;
    }

    public boolean addViolation(Violation violation) throws SQLException {
        String sql = "INSERT INTO tblViolation (name, note) VALUES (?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, violation.getName());
            ps.setString(2, violation.getNote());

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        violation.setId(rs.getInt(1));
                    }
                }
                return true;
            } else {
                return false;
            }
        }
    }
}