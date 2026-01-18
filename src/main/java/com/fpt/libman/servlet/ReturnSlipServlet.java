package com.fpt.libman.servlet;

import com.fpt.libman.dao.BorrowedDocumentDAO;
import com.fpt.libman.dao.ReaderDAO;
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
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ReturnSlipServlet", urlPatterns = {"/completeReturn"})
public class ReturnSlipServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReturnSlipServlet.class.getName());
    private ReaderDAO readerDAO;
    private BorrowedDocumentDAO borrowedDocumentDAO;
    private ViolationDAO violationDAO;

    @Override
    public void init() {
        try {
            readerDAO = new ReaderDAO();
            borrowedDocumentDAO = new BorrowedDocumentDAO();
            violationDAO = new ViolationDAO();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khởi tạo DAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Librarian librarian = (session != null) ? (Librarian) session.getAttribute("librarian") : null;
        String readerIdStr = request.getParameter("readerId");
        String readerBarcode = request.getParameter("readerBarcode");

        if (librarian == null || readerIdStr == null || readerBarcode == null) {
            response.sendRedirect("view/reader/Login.jsp");
            return;
        }

        try {
            int readerId = Integer.parseInt(readerIdStr);

            @SuppressWarnings("unchecked")
            Map<Integer, List<ReturnViolation>> confirmedDocsMap =
                    (Map<Integer, List<ReturnViolation>>) session.getAttribute("confirmedDocsMap");

            if (confirmedDocsMap == null || confirmedDocsMap.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&error=NoItemsConfirmed");
                return;
            }

            // Tính tổng tiền phạt lấy từ js
            float totalFine = 0;
            for (List<ReturnViolation> violations : confirmedDocsMap.values()) {
                for (ReturnViolation rv : violations) {
                    totalFine += rv.getFee();
                }
            }

            // Đóng gói ReturnSlip
            ReturnSlip slip = new ReturnSlip();
            slip.setBarcode("RS-" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase());
            slip.setReturnDate(new Timestamp(System.currentTimeMillis()));
            slip.setFine(totalFine);
            slip.setLibrarianId(librarian.getId());
            slip.setReaderId(readerId);
            session.setAttribute("currentReturnSlip", slip);

            // Lấy lại thông tin Reader
            Reader reader = readerDAO.searchByBarcode(readerBarcode);
            session.setAttribute("currentReader", reader);

            List<BorrowedDocument> borrowingList = borrowedDocumentDAO.getListBorrowedDocument(readerId, false);
            session.setAttribute("sessionBorrowingList", borrowingList);


            if(session.getAttribute("sessionViolationMap") == null) {
                List<Violation> allViolations = violationDAO.getAllViolations();
                Map<Integer, Violation> violationMap = allViolations.stream()
                        .collect(Collectors.toMap(Violation::getId, Function.identity()));
                session.setAttribute("sessionViolationMap", violationMap);
            }

            // Chuyển hướng đến Confirm.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/librarian/Confirm.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi chuẩn bị phiếu trả", e);
            response.sendRedirect(request.getContextPath() + "/searchReader?barcode=" + readerBarcode + "&error=CompleteFailed");
        }
    }
}