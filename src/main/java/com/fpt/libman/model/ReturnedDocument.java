package com.fpt.libman.model;

import java.sql.Timestamp;
import java.util.List;

public class ReturnedDocument extends BorrowedDocument {
    private Timestamp returnTime;

    private int returnSlipId;

    private List<ReturnViolation> listReturnViolations;
    public ReturnedDocument() {
        super();
    }

    public List<ReturnViolation> getListReturnViolations() {
        return listReturnViolations;
    }

    public void setListReturnViolations(List<ReturnViolation> listReturnViolations) {
        this.listReturnViolations = listReturnViolations;
    }

    public int getReturnSlipId() {
        return returnSlipId;
    }

    public void setReturnSlipId(int returnSlipId) {
        this.returnSlipId = returnSlipId;
    }

    public Timestamp getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(Timestamp returnTime) {
        this.returnTime = returnTime;
    }
}
