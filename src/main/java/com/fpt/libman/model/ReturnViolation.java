package com.fpt.libman.model;

public class ReturnViolation {
    private int id;
    private float fee;
    private boolean isPaid;

    public int getViolationId() {
        return violationId;
    }

    public void setViolationId(int violationId) {
        this.violationId = violationId;
    }

    private Violation violation;
    private int violationId;
    private int returnDocumentId;

    public int getReturnDocumentId() {
        return returnDocumentId;
    }

    public void setReturnDocumentId(int returnDocumentId) {
        this.returnDocumentId = returnDocumentId;
    }

    public Violation getViolation() {
        return violation;
    }

    public void setViolation(Violation violation) {
        this.violation = violation;
    }

    public ReturnViolation() {};

    public  ReturnViolation(int id, float fee, boolean isPaid) {
        this.id = id;
        this.fee = fee;
        this.isPaid = isPaid;
    }

    public float getFee() {
        return fee;
    }

    public void setFee(float fee) {
        this.fee = fee;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }
}
