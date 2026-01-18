package com.fpt.libman.model;

import java.sql.Timestamp;
import java.util.List;

public class BorrowedDocument {
    private int id;
    private Timestamp borrowedDate;
    private Timestamp dueDate;
    private boolean isReturned;

    private int documentId;

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    private Document document;
    private List<BorrowViolation> listBorrowViolation;

    public BorrowedDocument() {};

    public BorrowedDocument(Document document, Timestamp dueDate, int id, boolean isReturned, List<BorrowViolation> listBorrowViolation) {
        this.document = document;
        this.dueDate = dueDate;
        this.id = id;
        this.isReturned = isReturned;
        this.listBorrowViolation = listBorrowViolation;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public Timestamp getDueDate() {
        return dueDate;
    }

    public void setDueDate(Timestamp dueDate) {
        this.dueDate = dueDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isReturned() {
        return isReturned;
    }

    public void setReturned(boolean returned) {
        isReturned = returned;
    }

    public List<BorrowViolation> getListBorrowViolation() {
        return listBorrowViolation;
    }

    public void setListBorrowViolation(List<BorrowViolation> listBorrowViolation) {
        this.listBorrowViolation = listBorrowViolation;
    }
}
