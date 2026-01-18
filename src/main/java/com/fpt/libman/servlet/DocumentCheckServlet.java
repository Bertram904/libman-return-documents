package com.fpt.libman.servlet;

import com.fpt.libman.dao.BorrowedDocumentDAO;
import com.fpt.libman.dao.BorrowViolationDAO;
import com.fpt.libman.dao.ViolationDAO;
import com.fpt.libman.model.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.function.Function;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet(name = "DocumentCheckServlet", urlPatterns = {"/checkDocument", "/confirmReturnDocument"})
public class DocumentCheckServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DocumentCheckServlet.class.getName());

    private static final String SESSION_CART_NAME = "confirmedDocsMap";
    private static final String SESSION_VIOLATION_MAP = "sessionViolationMap";
    private static final String PAGE_DOCUMENT_INFO = "view/librarian/DocumentInfor.jsp";

    private BorrowedDocumentDAO borrowedDocumentDAO;
    private ViolationDAO violationDAO;
    private BorrowViolationDAO borrowViolationDAO;

    @Override
    public void init() {
        try {
            borrowedDocumentDAO = new BorrowedDocumentDAO();
            violationDAO = new ViolationDAO();
            borrowViolationDAO = new BorrowViolationDAO();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi nghiêm trọng: Không thể khởi tạo các DAO", e);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String borrowedIdStr = request.getParameter("borrowedId");
        String readerBarcode = request.getParameter("readerBarcode");
        HttpSession session = request.getSession();

        try {
            int borrowedId = Integer.parseInt(borrowedIdStr);
            BorrowedDocument doc = borrowedDocumentDAO.getById(borrowedId);
            if (doc == null) {
                response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&error=DocumentNotFound");
                return;
            }
            // Lấy vi phạm cũ
            List<BorrowViolation> oldViolations = borrowViolationDAO.getViolation(borrowedId);
            // Lấy TẤT CẢ loại vi phạm (cho dropdown)
            List<Violation> violationTypes = violationDAO.getAllViolations();

            // Nạp Map(ID -> Tên Lỗi) vào Session (Để trang Confirm.jsp dùng tra cứu)
            Map<Integer, Violation> violationMap = violationTypes.stream()
                    .collect(Collectors.toMap(Violation::getId, Function.identity()));
            session.setAttribute(SESSION_VIOLATION_MAP, violationMap);

            request.setAttribute("borrowedDoc", doc);
            request.setAttribute("oldViolations", oldViolations);
            request.setAttribute("violationTypes", violationTypes); // Nạp cho dropdown
            request.setAttribute("readerBarcode", readerBarcode);

            RequestDispatcher dispatcher = request.getRequestDispatcher(PAGE_DOCUMENT_INFO);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy thông tin chi tiết tài liệu", e);
            response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&error=DatabaseError");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String borrowedIdStr = request.getParameter("borrowedId");
        String readerBarcode = request.getParameter("readerBarcode");

        // Lấy 2 mảng song song (ID Lỗi và Phí) từ form
        String[] newViolationIds = request.getParameterValues("violations");
        String[] newViolationFees = request.getParameterValues("fees"); // phí

        try {
            int borrowedId = Integer.parseInt(borrowedIdStr);

            @SuppressWarnings("unchecked")
            Map<Integer, List<ReturnViolation>> confirmedDocsMap =
                    (Map<Integer, List<ReturnViolation>>) session.getAttribute(SESSION_CART_NAME);
            if (confirmedDocsMap == null) {
                confirmedDocsMap = new HashMap<>();
            }

            List<ReturnViolation> newViolationsForThisDoc = new ArrayList<>();

            if (newViolationIds != null && newViolationFees != null && newViolationIds.length == newViolationFees.length) {

                for (int i = 0; i < newViolationIds.length; i++) {
                    int violationId = Integer.parseInt(newViolationIds[i]);
                    float fee = Float.parseFloat(newViolationFees[i]); // lấy phí

                    ReturnViolation rv = new ReturnViolation();
                    rv.setReturnDocumentId(borrowedId);
                    rv.setViolationId(violationId);
                    rv.setFee(fee);
                    rv.setPaid(false);

                    newViolationsForThisDoc.add(rv);
                }
            } else if (newViolationIds != null) {
                LOGGER.warning("Mảng violations và fees không khớp. Bỏ qua các vi phạm.");
            }

            confirmedDocsMap.put(borrowedId, newViolationsForThisDoc);
            session.setAttribute(SESSION_CART_NAME, confirmedDocsMap);

            LOGGER.info("Đã thêm sách ID " + borrowedId + " vào giỏ hàng (session) với " + newViolationsForThisDoc.size() + " vi phạm mới.");

            response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&itemConfirmed=true");

        } catch (NumberFormatException e) {
            LOGGER.warning("Lỗi: ID hoặc Phí không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&error=InvalidIDOrFee");
        }
    }
}