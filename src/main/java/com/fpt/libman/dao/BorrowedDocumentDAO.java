package com.fpt.libman.dao;

import com.fpt.libman.model.BorrowedDocument;
import com.fpt.libman.model.Document;
import com.fpt.libman.model.Catalog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BorrowedDocumentDAO extends DAO {

    public BorrowedDocumentDAO() {
        super();
    }

    public List<BorrowedDocument> getListBorrowedDocument(int readerId, boolean isReturned) throws SQLException {
        List<BorrowedDocument> list = new ArrayList<>();
        String sql = "SELECT bd.*, d.barcode AS doc_barcode, c.name AS title " +
                "FROM tblBorrowedDocument bd " +
                "JOIN tblDocument d ON bd.tblDocumentId = d.id " +
                "JOIN tblCatalog c ON d.tblCatalogId = c.id " +
                "JOIN tblBorrowSlip bs ON bd.tblBorrowSlipId = bs.id " +
                "WHERE bs.tblReaderId = ? AND bd.isReturned = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, readerId);
            ps.setBoolean(2, isReturned);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BorrowedDocument bd = new BorrowedDocument();
                    bd.setId(rs.getInt("id"));
                    bd.setDueDate(rs.getTimestamp("dueDate"));
                    bd.setReturned(rs.getBoolean("isReturned"));
                    bd.setDocumentId(rs.getInt("tblDocumentId"));

                    Document doc = new Document();
                    doc.setBarcode(rs.getString("doc_barcode"));
                    Catalog cat = new Catalog();
                    cat.setName(rs.getString("title"));
                    doc.setCatalog(cat);

                    bd.setDocument(doc);
                    list.add(bd);
                }
            }
        }
        return list;
    }

    public BorrowedDocument getById(int borrowedDocumentId) throws SQLException {
        BorrowedDocument bd = null;
        String sql = "SELECT bd.*, d.barcode AS doc_barcode, c.name AS title, c.author, c.publisher, c.publishYear " +
                "FROM tblBorrowedDocument bd " +
                "JOIN tblDocument d ON bd.tblDocumentId = d.id " +
                "JOIN tblCatalog c ON d.tblCatalogId = c.id " +
                "WHERE bd.id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowedDocumentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bd = new BorrowedDocument();
                    bd.setId(rs.getInt("id"));
                    bd.setDueDate(rs.getTimestamp("dueDate"));
                    Document doc = new Document();
                    doc.setBarcode(rs.getString("doc_barcode"));
                    Catalog cat = new Catalog();
                    cat.setName(rs.getString("title"));
                    doc.setCatalog(cat);
                    bd.setDocument(doc);
                }
            }
        }
        return bd;
    }
}