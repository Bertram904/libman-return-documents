package com.fpt.libman.model;

import java.sql.Timestamp;
import java.util.List;

public class BorrowSlip {
    private int id;
    private String barcode;
    private Timestamp borrowDate;
    private String note;

    private Reader reader;
    private Librarian librarian;
    private List<BorrowedDocument> borrowedDocuments;

    public BorrowSlip() {};

    public BorrowSlip(String barcode, Timestamp borrowDate, List<BorrowedDocument> borrowedDocuments, int id, Librarian librarian, String note, Reader reader) {
        this.barcode = barcode;
        this.borrowDate = borrowDate;
        this.borrowedDocuments = borrowedDocuments;
        this.id = id;
        this.librarian = librarian;
        this.note = note;
        this.reader = reader;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public Timestamp getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Timestamp borrowDate) {
        this.borrowDate = borrowDate;
    }

    public List<BorrowedDocument> getBorrowedDocuments() {
        return borrowedDocuments;
    }

    public void setBorrowedDocuments(List<BorrowedDocument> borrowedDocuments) {
        this.borrowedDocuments = borrowedDocuments;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Librarian getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian librarian) {
        this.librarian = librarian;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }
}
