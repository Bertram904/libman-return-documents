package com.fpt.libman.servlet;

import com.fpt.libman.dao.BorrowedDocumentDAO;
import com.fpt.libman.dao.ReaderDAO;
import com.fpt.libman.model.BorrowedDocument;
import com.fpt.libman.model.Reader;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@WebServlet(name = "ReaderServlet", urlPatterns = {"/register","/register-redirect","/searchReader"})
public class ReaderServlet extends HttpServlet {

    private ReaderDAO readerDAO;
    private BorrowedDocumentDAO borrowedDocumentDAO;

    @Override
    public void init() {
        readerDAO = new ReaderDAO();
        borrowedDocumentDAO = new BorrowedDocumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getServletPath();

            if ("/register-redirect".equals(action)) {
                // Điều hướng đến trang đăng ký
                System.out.println("Điều hướng đến trang đăng ký...");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/ReaderCard.jsp");
                dispatcher.forward(request, response);
            }
        String barcode = request.getParameter("barcode");
        if (barcode == null || barcode.isEmpty()) {
            response.sendRedirect("view/librarian/ReaderInfor.jsp");
            return;
        }

        try {
            Reader reader = readerDAO.searchByBarcode(barcode);

            if (reader != null) {
                List<BorrowedDocument> borrowingList = borrowedDocumentDAO.getListBorrowedDocument(reader.getId(), false);
                List<BorrowedDocument> returnedList = borrowedDocumentDAO.getListBorrowedDocument(reader.getId(), true);

                request.setAttribute("reader", reader);
                request.setAttribute("borrowingList", borrowingList);
                request.setAttribute("returnedList", returnedList);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy bạn đọc với barcode: " + barcode);
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("view/librarian/ReaderInfor.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi CSDL khi tìm kiếm bạn đọc.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/librarian/ReaderInfor.jsp");
            dispatcher.forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (!pass.equals(confirmPass)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/ReaderCard.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 2. Lấy thông tin từ form
        try {
            Reader reader = new Reader();
            reader.setUsername(request.getParameter("username"));
            reader.setPassword(pass);
            reader.setFullName(request.getParameter("fullName"));
            reader.setAddress(request.getParameter("address"));
            reader.setPhoneNumber(request.getParameter("tel"));
            reader.setEmail(request.getParameter("email"));

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dob = sdf.parse(request.getParameter("dateOfBith"));
            reader.setDateOfBirth(dob);

            reader.setBarcode("BR" + System.currentTimeMillis() % 100000);

            boolean success = readerDAO.create(reader);
            if (success) {
                System.out.println("Đăng ký thành công cho: " + reader.getUsername());
                request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/Login.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Đăng ký thất bại. Tên đăng nhập hoặc Email có thể đã tồn tại.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/ReaderCard.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ParseException e) {
            System.out.println("Lỗi định dạng ngày sinh.");
            request.setAttribute("errorMessage", "Lỗi định dạng ngày sinh (yyyy-MM-dd).");
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/ReaderCard.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi đăng ký.");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/reader/ReaderCard.jsp");
            dispatcher.forward(request, response);
        }
    }
}