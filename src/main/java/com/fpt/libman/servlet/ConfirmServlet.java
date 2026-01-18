package com.fpt.libman.servlet;

import com.fpt.libman.dao.BillDAO;
import com.fpt.libman.dao.ReturnSlipDAO;
import com.fpt.libman.model.ReturnSlip;
import com.fpt.libman.model.ReturnViolation;
import com.fpt.libman.model.Bill;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ConfirmServlet", urlPatterns = "/confirmAndSave")
public class ConfirmServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmServlet.class.getName());
    private ReturnSlipDAO returnSlipDAO;
    private BillDAO billDAO;
    private static final String PAGE_CONFIRM = "view/librarian/Confirm.jsp";

    @Override
    public void init() {
            try {
                returnSlipDAO = new ReturnSlipDAO();
                billDAO = new BillDAO();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Lỗi SQL khi khởi tạo DAO", e);
                throw new RuntimeException("Không thể khởi tạo các lớp DAO.", e);
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        ReturnSlip slip = (session != null) ? (ReturnSlip) session.getAttribute("currentReturnSlip") : null;

        @SuppressWarnings("unchecked")
        Map<Integer, List<ReturnViolation>> confirmedDocsMap =
                (session != null) ? (Map<Integer, List<ReturnViolation>>) session.getAttribute("confirmedDocsMap") : null;

        if (slip == null || confirmedDocsMap == null) {
            response.sendRedirect("view/reader/Login.jsp");
            return;
        }

        try {
            boolean success = returnSlipDAO.addSlip(slip, confirmedDocsMap);

            if (success) {
                if (slip.getFine() > 0) {
                    Bill bill = new Bill();
                    bill.setBarcode("BILL" + slip.getBarcode());
                    bill.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                    bill.setPaymentType("CASH");
                    bill.setReturnSlip(slip);

                    boolean billSuccess = billDAO.addBill(bill);

                    if (billSuccess) {
                        request.setAttribute("successMessage", "Đã hoàn tất phiếu trả. **Đã tạo Hóa đơn** với phí: " + slip.getFine() + " VNĐ.");
                        request.setAttribute("newBill", bill);
                    } else {
                        request.setAttribute("errorMessage", "Lưu phiếu trả thành công nhưng **LỖI khi tạo Hóa đơn**.");
                    }
                } else {
                    request.setAttribute("successMessage", "Đã hoàn tất phiếu trả. Không có phí phạt.");
                }

                // Dọn dẹp session
                session.removeAttribute("currentReturnSlip");
                session.removeAttribute("currentReader");
                session.removeAttribute("confirmedDocsMap");
                session.removeAttribute("sessionBorrowingList");
                session.removeAttribute("sessionViolationMap");

            } else {
                request.setAttribute("errorMessage", "Lỗi nghiêm trọng: Lưu phiếu trả (Transaction) thất bại.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi CSDL khi thực hiện Transaction trả sách", e);
            request.setAttribute("errorMessage", "Lỗi CSDL nghiêm trọng: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(PAGE_CONFIRM);
        dispatcher.forward(request, response);
    }
}