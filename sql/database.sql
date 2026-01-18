
CREATE DATABASE IF NOT EXISTS libman;
USE libman;

CREATE TABLE tblMember (
                           id INT(10) PRIMARY KEY AUTO_INCREMENT,
                           username VARCHAR(50) UNIQUE NOT NULL,
                           password VARCHAR(255) NOT NULL,
                           fullName VARCHAR(75) NOT NULL,
                           dateOfBirth DATE NOT NULL,
                           address VARCHAR(255) NOT NULL,
                           phoneNumber VARCHAR(25) NOT NULL,
                           email VARCHAR(50) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tblCatalog (
                            id INT(10) PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(255) NOT NULL,
                            author VARCHAR(50) NOT NULL,
                            price FLOAT(10) NOT NULL,
                            amount INT(10) NOT NULL,
                            publisher VARCHAR(255) NOT NULL,
                            publishYear INT(10) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tblViolation (
                              id INT(10) PRIMARY KEY AUTO_INCREMENT,
                              name VARCHAR(50) NOT NULL,
                              note VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE tblEmployee (
                             tblMemberId INT(10) NOT NULL UNIQUE PRIMARY KEY,
                             code VARCHAR(25) UNIQUE NOT NULL,
                             note VARCHAR(255) NOT NULL,
                             FOREIGN KEY (tblMemberId) REFERENCES tblMember(id)
) ENGINE=InnoDB;

CREATE TABLE tblReader (
                           tblMemberId INT(10) NOT NULL UNIQUE primary key,
                           barcode VARCHAR(25) UNIQUE NOT NULL,
                           FOREIGN KEY (tblMemberId) REFERENCES tblMember(id)
) ENGINE=InnoDB;

CREATE TABLE tblDocument (
                             id INT(10) PRIMARY KEY AUTO_INCREMENT,
                             barcode VARCHAR(25) UNIQUE NOT NULL,
                             shelfLocation VARCHAR(50) NOT NULL,
                             tblCatalogId INT(10) NOT NULL,
                             FOREIGN KEY (tblCatalogId) REFERENCES tblCatalog(id)
) ENGINE=InnoDB;

CREATE TABLE tblLibrarian (
                              tblMemberId INT(10) NOT NULL UNIQUE primary key,
                              FOREIGN KEY (tblMemberId) REFERENCES tblEmployee(tblMemberId)
) ENGINE=InnoDB;

CREATE TABLE tblBorrowSlip (
                               id INT(10) PRIMARY KEY AUTO_INCREMENT,
                               barcode VARCHAR(25) UNIQUE NOT NULL,
                               borrowDate TIMESTAMP NOT NULL,
                               note VARCHAR(255),
                               tblReaderId INT(10) NOT NULL,
                               tblLibrarianId INT(10) NOT NULL,
                               FOREIGN KEY (tblReaderId) REFERENCES tblReader(tblMemberId),
                               FOREIGN KEY (tblLibrarianId) REFERENCES tblLibrarian(tblMemberId)
) ENGINE=InnoDB;

CREATE TABLE tblReturnSlip (
                               id INT(10) PRIMARY KEY AUTO_INCREMENT,
                               barcode VARCHAR(25) UNIQUE NOT NULL,
                               returnDate TIMESTAMP NOT NULL,
                               note VARCHAR(255),
                               fine FLOAT(10) NOT NULL,
                               tblLibrarianId INT(10) NOT NULL,
                               tblReaderId INT(10) NOT NULL,
                               FOREIGN KEY (tblLibrarianId) REFERENCES tblLibrarian(tblMemberId),
                               FOREIGN KEY (tblReaderId) REFERENCES tblReader(tblMemberId)
) ENGINE=InnoDB;

CREATE TABLE tblBorrowedDocument (
                                     id INT(10) PRIMARY KEY AUTO_INCREMENT,
                                     dueDate TIMESTAMP NOT NULL,
                                     isReturned BIT NOT NULL,
                                     tblDocumentId INT(10) NOT NULL,
                                     tblBorrowSlipId INT(10) NOT NULL,
                                     FOREIGN KEY (tblDocumentId) REFERENCES tblDocument(id),
                                     foreign key (tblBorrowSlipId) references tblBorrowSlip(id)
) ENGINE=InnoDB;

CREATE TABLE tblBill (
                         id INT(10) PRIMARY KEY AUTO_INCREMENT,
                         barcode VARCHAR(25) UNIQUE NOT NULL,
                         createAt TIMESTAMP NOT NULL,
                         paymentType VARCHAR(50) NOT NULL,
                         note VARCHAR(255),
                         tblReturnSlipId INT(10) NOT NULL UNIQUE,
                         FOREIGN KEY (tblReturnSlipId) REFERENCES tblReturnSlip(id)
) ENGINE=InnoDB;

CREATE TABLE tblReturnedDocument (
                                     tblBorrowedDocumentId INT(10) NOT NULL UNIQUE primary key,
                                     returnTime TIMESTAMP NOT NULL,
                                     tblReturnSlipId INT(10) NOT NULL,
                                     FOREIGN KEY (tblReturnSlipId) REFERENCES tblReturnSlip(id),
                                     FOREIGN KEY (tblBorrowedDocumentId) REFERENCES tblBorrowedDocument(id)
) ENGINE=InnoDB;

CREATE TABLE tblBorrowViolation (
                                    id INT(10) PRIMARY KEY AUTO_INCREMENT,
                                    description VARCHAR(255),
                                    tblBorrowedDocumentId INT(10) NOT NULL,
                                    tblViolationId INT(10) NOT NULL,
                                    FOREIGN KEY (tblBorrowedDocumentId) REFERENCES tblBorrowedDocument(id),
                                    FOREIGN KEY (tblViolationId) REFERENCES tblViolation(id)
) ENGINE=InnoDB;

CREATE TABLE tblReturnViolation (
                                    id INT(10) PRIMARY KEY AUTO_INCREMENT,
                                    fee FLOAT(10) NOT NULL,
                                    isPaid BIT NOT NULL,
                                    tblReturnedDocumentId INT(10) NOT NULL,
                                    tblViolationId INT(10) NOT NULL,
                                    FOREIGN KEY (tblReturnedDocumentId) REFERENCES tblReturnedDocument(tblBorrowedDocumentId),
                                    FOREIGN KEY (tblViolationId) REFERENCES tblViolation(id)
) ENGINE=InnoDB;