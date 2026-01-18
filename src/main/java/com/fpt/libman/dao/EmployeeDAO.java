package com.fpt.libman.dao;

import com.fpt.libman.model.Employee;
import com.fpt.libman.model.Librarian;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeDAO extends DAO {

    public EmployeeDAO() throws SQLException {
        super();
    }

    public Employee checkLogin(String username, String password) throws SQLException {
        Employee employee = null;
        String sql = "SELECT " +
                "    m.id, " +
                "    m.username, " +
                "    m.fullName, " +
                "    m.dateOfBirth, " +
                "    m.address, " +
                "    m.phoneNumber, " +
                "    m.email, " +
                "    e.code, " +
                "    l.tblMemberId AS librarianId " +
                "FROM tblmember m " +
                "JOIN tblemployee e ON m.id = e.tblMemberId " +
                "LEFT JOIN tbllibrarian l ON e.tblMemberId = l.tblMemberId " +
                "WHERE m.username = ? AND m.password = ?";

        System.out.println("Authenticating employee: " + username);

        conn = getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    if (rs.getObject("librarianId") != null) {
                        employee = new Librarian();
                        System.out.println("[OK] Found Librarian: " + rs.getString("fullName"));
                    } else {
                        employee = new Employee();
                        System.out.println("[OK] Found Employee (Not Librarian): " + rs.getString("fullName"));
                    }

                    employee.setId(rs.getInt("id"));
                    employee.setUsername(rs.getString("username"));
                    employee.setFullName(rs.getString("fullName"));
                    employee.setCode(rs.getString("code"));


                } else {
                    System.out.println("Login failed for: " + username);
                }
            }
        }
        return employee;
    }
}