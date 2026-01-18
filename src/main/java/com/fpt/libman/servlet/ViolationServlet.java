package com.fpt.libman.servlet;

import com.fpt.libman.dao.ViolationDAO;
import com.fpt.libman.model.Violation;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ViolationServlet", urlPatterns = {"/manageViolations", "/addViolation"})
public class ViolationServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ViolationServlet.class.getName());
    private ViolationDAO violationDAO;
    private static final String PAGE_VIOLATION = "view/librarian/AddViolation.jsp";

    @Override
    public void init() {
        try {
            violationDAO = new ViolationDAO();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khởi tạo DAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Violation> list = violationDAO.getAllViolations(); // Chỉ lấy ID, name, note
            request.setAttribute("violationList", list);

            RequestDispatcher dispatcher = request.getRequestDispatcher(PAGE_VIOLATION);
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi CSDL: Không thể tải danh sách vi phạm.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(PAGE_VIOLATION);
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("/addViolation".equals(request.getServletPath())) {

            String name = request.getParameter("name");
            String note = request.getParameter("note");

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên lỗi không được để trống.");
                doGet(request, response);
                return;
            }

            try {
                Violation newViolation = new Violation();
                newViolation.setName(name);
                newViolation.setNote(note);

                boolean success = violationDAO.addViolation(newViolation);

                if (success) {
                    request.setAttribute("successMessage", "Đã thêm loại vi phạm '" + name + "' thành công!");
                } else {
                    request.setAttribute("errorMessage", "Thêm lỗi thất bại.");
                }

                doGet(request, response);

            } catch (SQLException e) {
                request.setAttribute("errorMessage", "Lỗi CSDL: " + e.getMessage());
                doGet(request, response);
            }
        }
    }
}