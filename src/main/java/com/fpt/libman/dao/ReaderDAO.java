package com.fpt.libman.dao;
import com.fpt.libman.model.Reader;

import java.sql.*;

public class ReaderDAO extends DAO {
    public ReaderDAO() {
        super();
    }
    public boolean create(Reader reader) throws SQLException {
        String sqlMember = "INSERT INTO tblMember(username, password, fullName, dateOfBirth, address, phoneNumber, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlReader = "INSERT INTO tblReader(tblMemberId, barcode) VALUES (?, ?)";
        Connection conn = getConnection();
        PreparedStatement psMember = null;
        PreparedStatement psReader = null;
        ResultSet rs = null;
        try {
            //su dung conn tu lop cha
            conn.setAutoCommit(false);
            System.out.println("Creating Reader " + reader.getUsername());

            //add tblMember
            psMember = conn.prepareStatement(sqlMember, Statement.RETURN_GENERATED_KEYS);
            psMember.setString(1, reader.getUsername());
            psMember.setString(2, reader.getPassword());
            psMember.setString(3, reader.getFullName());
            psMember.setDate(4, new java.sql.Date(reader.getDateOfBirth().getTime()));
            psMember.setString(5, reader.getAddress());
            psMember.setString(6, reader.getPhoneNumber());
            psMember.setString(7, reader.getEmail());

            int memberRows = psMember.executeUpdate();
            System.out.println("row updated (tblMember): " + memberRows);

            //Lay id cua member vua tao
            int memberId = 0;
            if (memberRows > 0) {
                rs = psMember.getGeneratedKeys();
                if (rs.next()) {
                    memberId = rs.getInt(1);
                    reader.setId(memberId);
                } else {
                    throw new SQLException("Creating member failed, no rows affected.");
                }

                //Insert vao tblReader
                int readerRows = 0;
                if (memberId > 0) {
                    String barcode = "R" + String.format("%03d", memberId);
                    reader.setBarcode(barcode);
                    System.out.println("Generated barcode: " + reader.getBarcode());
                    psReader = conn.prepareStatement(sqlReader);
                    psReader.setInt(1, memberId);
                    psReader.setString(2, reader.getBarcode());
                    readerRows = psReader.executeUpdate();
                    System.out.println("row updated (tblReader): " + readerRows);
                }

                if (readerRows > 0) {
                    conn.commit(); // Ket thuc transaction
                    System.out.println("Commit successful, Created new reader: " + reader.getUsername() + ", id=" + reader.getId());
                    return true;
                } else {
                    throw  new SQLException("Creating reader failed, no rows affected.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Failed to create reader " + reader.getUsername());
            if (conn != null) {
                System.out.println("Transaction is being rolled back");
                conn.rollback(); // rollback neu co loi
            }
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (psReader != null) psReader.close();
            if (psMember != null) psMember.close();
        }
        return false;
    }
    public Reader searchByBarcode(String barcode) throws SQLException {
        Reader reader = null;
        String sql = "SELECT m.*, r.barcode FROM tblReader r JOIN tblMember m ON r.tblMemberId = m.id WHERE r.barcode = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, barcode);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reader = new Reader();
                    reader.setId(rs.getInt("id"));
                    reader.setUsername(rs.getString("username"));
                    reader.setFullName(rs.getString("fullName"));
                    reader.setDateOfBirth(rs.getDate("dateOfBirth"));
                    reader.setAddress(rs.getString("address"));
                    reader.setPhoneNumber(rs.getString("phoneNumber"));
                    reader.setEmail(rs.getString("email"));
                    reader.setBarcode(rs.getString("barcode"));
                    System.out.println("Found reader: " + reader.getUsername());
                } else {
                    System.out.println("Not found reader with barcode: " + barcode);
                }
            }
        }
        return reader;
    }
}
