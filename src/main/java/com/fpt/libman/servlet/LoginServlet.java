package com.fpt.libman.servlet;

import com.fpt.libman.dao.EmployeeDAO;
import com.fpt.libman.model.Employee;
import com.fpt.libman.model.Librarian;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login","/logout"})
public class LoginServlet extends HttpServlet {

    private EmployeeDAO employeeDAO;

    @Override
    public void init() {
        try {
            employeeDAO = new EmployeeDAO();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể khởi tạo EmployeeDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
         if ("/logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/view/reader/Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/login".equals(action)) {
            try {
                handleLogin(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi CSDL khi đăng nhập.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/Login.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        Employee employee = employeeDAO.checkLogin(user, pass);

        if (employee != null) {
            // Đăng nhập Thủ thư thành công
            HttpSession session = request.getSession();

            //Kiểm tra nhân viên có phải thủ thư không
            if (employee instanceof Librarian) {
                session.setAttribute("librarian", (Librarian)employee);
                System.out.println("Librarian " + employee.getFullName() + " login successfully");
                response.sendRedirect(request.getContextPath() + "/view/librarian/LibrarianHome.jsp");
            } else {
                session.setAttribute("employee", employee);
                System.out.println("Employee " + employee.getFullName() + " login failed beec");
                response.sendRedirect(request.getContextPath() + "/view/reader/Login.jsp");
            }
        } else {
            System.out.println("Đăng nhập thất bại cho: " + user);
            request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/Login.jsp");
            dispatcher.forward(request, response);
        }
    }
}