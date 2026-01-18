# 📚 LibMan - University Library Management System

> **LibMan** is an integrated library management system designed to handle university documents (books, journals, curriculum materials, etc.) and automate the processes of member registration and document returns.

![Java](https://img.shields.io/badge/Language-Java-orange)
![Tech](https://img.shields.io/badge/Architecture-J2EE_3--Tier-blue)
![Database](https://img.shields.io/badge/Database-MySQL_8.0-lightgrey)

---

## 📌 Project Overview

This project was developed as a major assignment for the **System Analysis and Design** course. The system provides a web-based platform for managers, librarians, and readers to interact with library resources efficiently.

It specifically focuses on streamlining two core workflows:
1.  **Online Reader Registration:** Allowing students to sign up remotely.
2.  **Document Return Processing:** Automating the validation, violation recording, and fine calculation for librarians.

---

## 🚀 Key Features

### 1. 📖 For Readers
* **Online Registration:** Allows students to register for a library card by providing personal details (name, date of birth, contact info) directly via the web portal.
* **Document Search:** Search functionality to browse available documents within the library catalog.
* **Borrowing & Returning:** Facilitates the interaction with librarians to borrow and return documents seamlessly.

### 2. 👩‍💼 For Librarians
* **Inventory Management:** Tools to update, add, or delete document information, reader details, and supplier data.
* **Document Return Processing (Core Module):**
    * **Search:** Quickly find reader cards by ID or barcode.
    * **Violation Handling:** Identify borrowed documents and record new violations (e.g., torn pages, lost books, late returns).
    * **Auto-Calculation:** Automatically calculate fines based on predefined library regulations.
    * **Invoicing:** Confirm returns and print detailed Return Slips for readers.
* **Import Documents:** Manage the import process of new resources from various suppliers.

### 3. 👨‍⚖️ For Managers
* **Statistical Reports:** View detailed analytics on most-borrowed documents, top readers, and supplier performance.
* **Staff Management:** Oversee and manage librarian accounts and information within the system.

---

## 🛠 System Architecture & Technologies

The system is built using a **3-Tier Architecture** based on J2EE standards, ensuring separation of concerns between the presentation, logic, and data layers.

| Component | Technology |
| :--- | :--- |
| **Programming Language** | Java (JDK 17+) |
| **Frontend** | JSP, JavaScript, CSS, Bootstrap 5.3.3 |
| **Backend** | Java Servlets (Controller), DAO Pattern |
| **Server** | Apache Tomcat 10.1.48 |
| **Database** | MySQL Server 8.0.33 |

---

## 📐 System Design & Database

### Entity Class Diagram
*Visual representation of the system's classes and their relationships.*

<div align="center">
  <img width="1001" height="525" alt="image" src="https://github.com/user-attachments/assets/244308c9-3b35-4303-9b9f-b0f2f3457ac1" />
</div>

### Database Schema
*Normalized database design handling Members, Documents, Transactions, and Violations.*

<div align="center">
  <img width="1012" height="712" alt="image" src="https://github.com/user-attachments/assets/80f56a1e-de39-47a9-84ee-a1ebe365243c" />
</div>

---

## 📂 Project Structure

```text
/LibMan
├── src/main/java/com/fpt/libman/
│   ├── dao/      # Data Access Object Layer (ReaderDAO, ReturnSlipDAO, etc.)
│   ├── model/    # Entity Layer (Member, Document, Violation, etc.)
│   └── servlet/  # Business Logic & Controllers (LoginServlet, ConfirmServlet, etc.)
└── src/main/webapp/
    └── view/     # User Interface Layer (JSP)
        ├── librarian/ # Views for Librarians (DocumentInfor.jsp, Confirm.jsp, etc.)
        └── reader/    # Views for Readers (Login.jsp, ReaderCard.jsp)
