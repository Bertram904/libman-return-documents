package com.fpt.libman.model;

public class BorrowViolation {
    private int id;
    private String description;

    private int borrowedDocumentId;
    private int violationId;

    private Violation violation;
    public BorrowViolation() {};

    public BorrowViolation(int borrowedDocumentId, String description, int id, Violation violation, int violationId) {
        this.borrowedDocumentId = borrowedDocumentId;
        this.description = description;
        this.id = id;
        this.violation = violation;
        this.violationId = violationId;
    }

    public int getBorrowedDocumentId() {
        return borrowedDocumentId;
    }

    public void setBorrowedDocumentId(int borrowedDocumentId) {
        this.borrowedDocumentId = borrowedDocumentId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Violation getViolation() {
        return violation;
    }

    public void setViolation(Violation violation) {
        this.violation = violation;
    }

    public int getViolationId() {
        return violationId;
    }

    public void setViolationId(int violationId) {
        this.violationId = violationId;
    }
}
