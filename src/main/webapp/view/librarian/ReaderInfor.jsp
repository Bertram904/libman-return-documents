<%--
  Created by IntelliJ IDEA.
  User: ngotu
  Date: 21/10/2025
  Time: 21:52
  Trang Thông tin Bạn đọc - ĐÃ SỬA LẠI LOGIC "GIỎ HÀNG"
  ENHANCED: Professional & Beautiful UI Design
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Trả Tài Liệu - LibMan</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary-color: #005A9C;
            --primary-light: #007bff;
            --primary-dark: #004078;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #3b82f6;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --card-shadow-hover: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        * {
            transition: all 0.3s ease;
        }

        body, html {
            height: 100%;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #1e293b;
        }

        /* ===== NAVBAR ===== */
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%) !important;
            box-shadow: var(--card-shadow);
            border-bottom: 3px solid var(--primary-light);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 0.5px;
        }

        .navbar-brand i {
            margin-right: 8px;
            font-size: 1.8rem;
        }

        .navbar-text {
            font-weight: 500;
            letter-spacing: 0.3px;
        }

        .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.2);
            border-color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* ===== CARDS ===== */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-4px);
        }

        .card-header {
            font-weight: 600;
            padding: 1.25rem;
            border-bottom: 2px solid rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-header h4 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .card-header i {
            font-size: 1.5rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* ===== SEARCH SECTION ===== */
        .search-card .input-group {
            gap: 8px;
        }

        .search-card .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-card .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .search-card .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            border: none;
            border-radius: 8px;
            font-weight: 600;
            padding: 12px 24px;
        }

        .search-card .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 90, 156, 0.3);
        }

        /* ===== ALERTS ===== */
        .alert {
            border: none;
            border-radius: 8px;
            border-left: 4px solid;
            padding: 1rem 1.25rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-danger {
            background-color: #fee2e2;
            border-left-color: var(--danger-color);
            color: #991b1b;
        }

        .alert-success {
            background-color: #dcfce7;
            border-left-color: var(--success-color);
            color: #166534;
        }

        .alert i {
            font-size: 1.25rem;
        }

        /* ===== READER INFO SECTION ===== */
        .reader-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .info-item {
            padding: 1rem;
            background: #f8fafc;
            border-radius: 8px;
            border-left: 4px solid var(--primary-light);
        }

        .info-item strong {
            color: var(--primary-color);
            font-weight: 700;
            display: block;
            margin-bottom: 4px;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-item p {
            margin: 0;
            font-size: 1rem;
            color: #334155;
            font-weight: 500;
        }

        /* ===== TABLES ===== */
        .table-responsive {
            border-radius: 8px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            font-size: 0.95rem;
        }

        .table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        .table thead th {
            border: none;
            padding: 1rem;
            vertical-align: middle;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-color: #e2e8f0;
        }

        .table tbody tr {
            border-bottom: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
            transform: scale(1.01);
        }

        .table-success {
            background-color: #dcfce7 !important;
        }

        .table-success:hover {
            background-color: #bbf7d0 !important;
        }

        .table-info {
            background-color: #dbeafe !important;
        }

        .table-info:hover {
            background-color: #bfdbfe !important;
        }

        /* ===== BUTTONS ===== */
        .btn {
            border-radius: 6px;
            font-weight: 600;
            padding: 8px 16px;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }

        .btn-lg {
            padding: 14px 28px;
            font-size: 1.1rem;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(16, 185, 129, 0.3);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #d97706 100%);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(245, 158, 11, 0.3);
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 90, 156, 0.3);
            color: white;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* ===== COMPLETE BUTTON SECTION ===== */
        .complete-section {
            text-align: center;
            padding: 2rem 0;
            background: linear-gradient(135deg, rgba(0, 90, 156, 0.05) 0%, rgba(0, 123, 255, 0.05) 100%);
            border-radius: 12px;
            margin-top: 2rem;
        }

        .complete-section .btn-lg {
            min-width: 300px;
            box-shadow: 0 8px 16px rgba(16, 185, 129, 0.2);
        }

        .complete-section .btn-lg:hover {
            box-shadow: 0 12px 24px rgba(16, 185, 129, 0.3);
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #94a3b8;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .reader-info-grid {
                grid-template-columns: 1fr;
            }

            .card-header h4 {
                font-size: 1.1rem;
            }

            .table {
                font-size: 0.85rem;
            }

            .table thead th,
            .table tbody td {
                padding: 0.75rem 0.5rem;
            }

            .complete-section .btn-lg {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>

<%-- Kiểm tra nếu Thủ thư chưa đăng nhập (Giữ nguyên logic) --%>
<c:if test="${empty sessionScope.librarian}">
    <c:redirect url="${pageContext.request.contextPath}/view/reader/Login.jsp"/>
</c:if>

<%-- ===== THANH ĐIỀU HƯỚNG (NAVBAR) ===== --%>
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="/view/librarian/LibrarianHome.jsp">
            <i class="bi bi-book-half"></i> LibMan
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item">
                    <span class="navbar-text text-white me-3">
                        Chào, <strong>${sessionScope.librarian.fullName}</strong>!
                    </span>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%-- ===== NỘI DUNG CHÍNH ===== --%>
<div class="container-fluid p-4">

    <%-- Lấy "giỏ hàng" từ session để kiểm tra --%>
    <c:set var="confirmedMap" value="${sessionScope.confirmedDocsMap}" />

    <%-- ===== KHU VỰC TÌM KIẾM ===== --%>
    <div class="card shadow-sm mb-4 search-card">
        <div class="card-body">
            <h4 class="card-title mb-3"><i class="bi bi-search"></i> Tìm kiếm Bạn đọc</h4>
            <form action="${pageContext.request.contextPath}/searchReader" method="get">
                <div class="input-group">
                    <input type="text" class="form-control form-control-lg"
                           placeholder="Nhập Barcode của bạn đọc..."
                           name="barcode" value="${param.barcode}" required>
                    <button class="btn btn-primary btn-lg" type="submit">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%-- Hiển thị thông báo (Lỗi hoặc Thành công) --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <span>${errorMessage}</span>
        </div>
    </c:if>

    <c:if test="${param.itemConfirmed == 'true'}">
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle-fill"></i>
            <span>Đã thêm tài liệu vào danh sách chờ trả.</span>
        </div>
    </c:if>

    <%-- ===== KHU VỰC THÔNG TIN (Chỉ hiển thị khi tìm thấy) ===== --%>
    <c:if test="${not empty reader}">

        <%-- 1. Thông tin chi tiết Bạn đọc --%>
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white">
                <i class="bi bi-person-circle"></i>
                <h4>Thông tin chi tiết Bạn đọc</h4>
            </div>
            <div class="card-body">
                <div class="reader-info-grid">
                    <div class="info-item">
                        <strong>ID</strong>
                        <p>${reader.id}</p>
                    </div>
                    <div class="info-item">
                        <strong>Barcode</strong>
                        <p>${reader.barcode}</p>
                    </div>
                    <div class="info-item">
                        <strong>Họ tên</strong>
                        <p>${reader.fullName}</p>
                    </div>
                    <div class="info-item">
                        <strong>Ngày sinh (DOB)</strong>
                        <p>${reader.dateOfBirth}</p>
                    </div>
                    <div class="info-item">
                        <strong>Email</strong>
                        <p>${reader.email}</p>
                    </div>
                    <div class="info-item">
                        <strong>Số điện thoại</strong>
                        <p>${reader.phoneNumber}</p>
                    </div>
                    <div class="info-item" style="grid-column: 1 / -1;">
                        <strong>Địa chỉ</strong>
                        <p>${reader.address}</p>
                    </div>
                </div>
            </div>
        </div>

        <%-- 2. Danh sách tài liệu đang mượn (CHƯA TRẢ) --%>
        <div class="card shadow-sm mb-4">
            <div class="card-header" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: white;">
                <i class="bi bi-hourglass-split"></i>
                <h4>Danh sách tài liệu ĐANG CHỜ KIỂM TRA</h4>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead>
                        <tr>
                            <th>ID Mượn</th>
                            <th>Barcode Sách</th>
                            <th>Tên sách</th>
                            <th>Hạn trả (Due Date)</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="hasUnconfirmedItems" value="${false}" />
                        <c:forEach var="item" items="${borrowingList}">
                            <%-- ***** LOGIC LỌC ĐƯỢC ÁP DỤNG TẠI ĐÂY ***** --%>
                            <c:choose>
                                <%-- TRƯỜNG HỢP 1: ĐÃ XÁC NHẬN trong SESSION (Hiển thị là đã xác nhận) --%>
                                <c:when test="${not empty confirmedMap[item.id]}">
                                    <tr class="table-success">
                                        <td><strong>${item.id}</strong></td>
                                        <td>${item.document.barcode}</td>
                                        <td>${item.document.catalog.name}</td>
                                        <td>${item.dueDate}</td>
                                        <td>
                                            <span class="btn btn-success btn-sm disabled">
                                                <i class="bi bi-check-lg"></i> Đã xác nhận
                                            </span>
                                        </td>
                                    </tr>
                                </c:when>

                                <%-- TRƯỜNG HỢP 2: CHƯA XÁC NHẬN (Cho phép kiểm tra) --%>
                                <c:otherwise>
                                    <tr>
                                        <td><strong>${item.id}</strong></td>
                                        <td>${item.document.barcode}</td>
                                        <td>${item.document.catalog.name}</td>
                                        <td>${item.dueDate}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/checkDocument?borrowedId=${item.id}&readerBarcode=${reader.barcode}"
                                               class="btn btn-warning btn-sm">
                                                <i class="bi bi-clipboard-check"></i> Kiểm tra Trả
                                            </a>
                                        </td>
                                    </tr>
                                    <c:set var="hasUnconfirmedItems" value="${true}" />
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${empty borrowingList}">
                            <tr>
                                <td colspan="5" class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <p>Không có tài liệu nào đang mượn.</p>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- 3. Danh sách tài liệu đã trả --%>
        <div class="card shadow-sm mb-4">
            <div class="card-header" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white;">
                <i class="bi bi-check-circle"></i>
                <h4>Danh sách tài liệu ĐÃ TRẢ (Đã lưu CSDL + Đã xác nhận)</h4>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead>
                        <tr>
                            <th>ID Mượn</th>
                            <th>Barcode Sách</th>
                            <th>Tên sách</th>
                            <th>Hạn trả</th>
                        </tr>
                        </thead>
                        <tbody>

                            <%-- 1. Lặp qua danh sách ĐÃ TRẢ TRONG CSDL (ReturnedList) --%>
                        <c:forEach var="item" items="${returnedList}">
                            <tr>
                                <td><strong>${item.id}</strong></td>
                                <td>${item.document.barcode}</td>
                                <td>${item.document.catalog.name}</td>
                                <td>${item.dueDate}</td>
                            </tr>
                        </c:forEach>

                            <%-- 2. Lặp qua danh sách ĐÃ XÁC NHẬN TRONG SESSION (ConfirmedMap) --%>
                        <c:forEach var="entry" items="${confirmedMap}">
                            <c:set var="borrowedId" value="${entry.key}" />

                            <%--
                                Để hiển thị thông tin sách,  ta cần tìm đối tượng BorrowedDocument
                                trong danh sách borrowingList (CSDL) ban đầu mà có ID khớp.
                            --%>
                            <c:forEach var="item" items="${borrowingList}">
                                <c:if test="${item.id == borrowedId}">
                                    <tr class="table-info">
                                        <td><strong>${item.id}</strong></td>
                                        <td>${item.document.barcode}</td>
                                        <td>${item.document.catalog.name}</td>
                                        <td>${item.dueDate}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>

                            <%-- Kiểm tra xem có bất kỳ mục nào được hiển thị không --%>
                        <c:if test="${empty returnedList and empty confirmedMap}">
                            <tr>
                                <td colspan="4" class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <p>Chưa có tài liệu nào được trả hoặc xác nhận.</p>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- Nút hoàn thành --%>
        <div class="complete-section">
            <form action="${pageContext.request.contextPath}/completeReturn" method="post">
                <input type="hidden" name="readerId" value="${reader.id}" />
                <input type="hidden" name="readerBarcode" value="${reader.barcode}" />
                <button type="submit" class="btn btn-success btn-sm shadow-sm">
                    <i class="bi bi-check-all"></i> Hoàn tất Phiếu trả
                </button>
            </form>
        </div>

    </c:if> <%-- Kết thúc c:if test="${not empty reader}" --%>

</div> <%-- Kết thúc container-fluid --%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
