package com.fpt.libman.model;

public class Document {
    private int id;
    private String barcode;
    private String shelfLocation;

    private int catalogId;
    private Catalog catalog;

    public Document(){};
    public Document(int id, String barcode, String shelfLocation, int catalogId, Catalog catalog) {
        this.id = id;
        this.barcode = barcode;
        this.shelfLocation = shelfLocation;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public Catalog getCatalog() {
        return catalog;
    }

    public void setCatalog(Catalog catalog) {
        this.catalog = catalog;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getShelfLocation() {
        return shelfLocation;
    }

    public void setShelfLocation(String shelfLocation) {
        this.shelfLocation = shelfLocation;
    }
}
