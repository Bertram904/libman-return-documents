package com.fpt.libman.model;

import java.sql.Timestamp;

public class Bill {
    private int id;
    private String barcode;
    private Timestamp createdAt;
    private String paymentType;
    private String note;
    private ReturnSlip returnSlip;

    public Bill() {};

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public ReturnSlip getReturnSlip() {
        return returnSlip;
    }

    public void setReturnSlip(ReturnSlip returnSlip) {
        this.returnSlip = returnSlip;
    }
}
