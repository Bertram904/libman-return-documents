package com.fpt.libman.dao;

import java.sql.*;

public class DAO {
    public static final String JDBC_URL = "jdbc:mysql://localhost:3306/libman";
    public static final String USER = "root";
    public static final String PASS = "Anh2210anh";

    protected static Connection conn;

    public static Connection getConnection() {
        Connection conn = null;
        try {
            //Dang ky Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            //Mo ket noi
            conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Khong ket noi duoc database");
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        if (getConnection()  != null) {
            System.out.println("Ket noi CSDL thanh cong");
        } else {
            System.out.println("Ket noi that bai voi CSDL");
        }
    }
}
