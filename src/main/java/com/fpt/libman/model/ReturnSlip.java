package com.fpt.libman.model;

import java.sql.Timestamp;
import java.util.List;

public class ReturnSlip {
    private int id;
    private String barcode;
    private Timestamp returnDate;
    private String note;
    private float fine;

    public int getLibrarianId() {
        return librarianId;
    }

    public void setLibrarianId(int librarianId) {
        this.librarianId = librarianId;
    }

    public int getReaderId() {
        return readerId;
    }

    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }

    private int librarianId;
    private int readerId;

    private Librarian librarian;
    private Reader reader;
    private List<ReturnedDocument> listReturnedDocument;

    public ReturnSlip() {};

    public ReturnSlip(String barcode, float fine, int id, Librarian librarian, List<ReturnedDocument> listReturnedDocument, String note, Reader reader, Timestamp returnDate) {
        this.barcode = barcode;
        this.fine = fine;
        this.id = id;
        this.librarian = librarian;
        this.listReturnedDocument = listReturnedDocument;
        this.note = note;
        this.reader = reader;
        this.returnDate = returnDate;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public float getFine() {
        return fine;
    }

    public void setFine(float fine) {
        this.fine = fine;
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

    public List<ReturnedDocument> getListReturnedDocument() {
        return listReturnedDocument;
    }

    public void setListReturnedDocument(List<ReturnedDocument> listReturnedDocument) {
        this.listReturnedDocument = listReturnedDocument;
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

    public Timestamp getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Timestamp returnDate) {
        this.returnDate = returnDate;
    }
}
