<%-- File: Confirm.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>

<html>
<head>
    <title>Xác nhận Phiếu trả - LibMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
        body, html {
            height: 100%;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #1e293b;
        }
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%) !important;
            box-shadow: var(--card-shadow);
            border-bottom: 3px solid var(--primary-light);
        }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; }
        .navbar-brand i { margin-right: 8px; font-size: 1.8rem; }
        .btn-outline-light:hover { background-color: rgba(255, 255, 255, 0.2); border-color: white; }
        .card { border: none; border-radius: 12px; box-shadow: var(--card-shadow); overflow: hidden; }
        .card-header {
            font-weight: 600;
            padding: 1.25rem;
            border-bottom: 2px solid rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .card-header h3 { margin: 0; font-size: 1.4rem; font-weight: 700; }
        .card-header i { font-size: 1.75rem; }
        .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; }
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
        }
        .info-item p { margin: 0; font-size: 1rem; color: #334155; }
        .table-responsive { border-radius: 8px; overflow: hidden; }
        .table { margin-bottom: 0; font-size: 0.95rem; }
        .table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            font-size: 0.85rem;
        }
        .table thead th { border: none; padding: 1rem; }
        .table tbody td { padding: 1rem; vertical-align: middle; border-color: #e2e8f0; }
        .table tfoot td, .table tfoot th {
            font-weight: 700;
            font-size: 1.1rem;
            padding: 1rem;
            background-color: #f8fafc;
        }
        .alert { border: none; border-radius: 8px; border-left: 4px solid; padding: 1.5rem; font-weight: 500; }
        .alert-danger { background-color: #fee2e2; border-left-color: var(--danger-color); color: #991b1b; }
        .alert-success { background-color: #dcfce7; border-left-color: var(--success-color); color: #166534; }
        .alert-info { background-color: #dbeafe; border-left-color: var(--info-color); color: #1e40af; }
        .btn {
            border-radius: 6px;
            font-weight: 600;
            padding: 12px 24px;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-lg { padding: 14px 28px; font-size: 1.1rem; }
        .btn-success { background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%); color: white; }
        .btn-success:hover { transform: translateY(-2px); }
        .btn-primary { background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%); color: white; }
        .btn-primary:hover { transform: translateY(-2px); }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #5a6268; transform: translateY(-2px); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/view/librarian/LibrarianHome.jsp">
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

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-11">
            <div class="card shadow-lg border-0">
                <div class="card-header" style="background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%); color: white;">
                    <i class="bi bi-receipt-cutoff"></i>
                    <h3>Xác nhận Phiếu Trả Tài Liệu</h3>
                </div>

                <div class="card-body p-4 p-md-5">

                    <%-- ===== TRẠNG THÁI 1: HIỂN THỊ KẾT QUẢ (SAU KHI LƯU CSDL) ===== --%>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger text-center" role="alert">
                            <h4 class="alert-heading"><i class="bi bi-x-circle-fill"></i> Lỗi!</h4>
                            <p class="mb-0">${errorMessage}</p>
                            <hr>
                            <button onclick="history.back()" class="btn btn-danger">
                                <i class="bi bi-arrow-left"></i> Thử lại
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success text-center" role="alert">
                            <h4 class="alert-heading"><i class="bi bi-check-circle-fill"></i> Thành công!</h4>
                            <p class="mb-0">${successMessage}</p>
                            <hr>
                            <a href="${pageContext.request.contextPath}/view/librarian/LibrarianHome.jsp" class="btn btn-success">
                                <i class="bi bi-house-door-fill"></i> Về trang chủ
                            </a>
                        </div>

                        <%-- HIỂN THỊ NÚT IN HÓA ĐƠN (NẾU CÓ BILL) --%>
                        <c:if test="${not empty requestScope.newBill}">
                            <div class="alert alert-info text-center mt-4" role="alert">
                                <h4 class="alert-heading"><i class="bi bi-printer-fill"></i> Hóa đơn đã được tạo.</h4>
                                <p>Hóa đơn số: ${requestScope.newBill.barcode}</p>
                                <hr>
                                <a href="${pageContext.request.contextPath}/printBill?billId=${requestScope.newBill.id}" target="_blank" class="btn btn-primary">
                                    In Hóa đơn
                                </a>
                            </div>
                        </c:if>
                    </c:if>

                    <%-- Dọn dẹp session (Chỉ dọn khi đã xử lý xong) --%>
                    <c:if test="${not empty successMessage or not empty errorMessage}">
                        <c:remove var="currentReturnSlip" scope="session"/>
                        <c:remove var="currentReader" scope="session"/>
                        <c:remove var="confirmedDocsMap" scope="session"/>
                        <c:remove var="sessionBorrowingList" scope="session"/>
                        <c:remove var="sessionViolationMap" scope="session"/>
                    </c:if>

                    <%-- ===== TRẠNG THÁI 2: CHỜ XÁC NHẬN (HIỂN THỊ FORM) ===== --%>
                    <c:if test="${not empty sessionScope.currentReturnSlip}">
                        <c:set var="slip" value="${sessionScope.currentReturnSlip}"/>
                        <c:set var="reader" value="${sessionScope.currentReader}"/>
                        <c:set var="confirmedMap" value="${sessionScope.confirmedDocsMap}" />

                        <div class="info-grid mb-4">
                            <div class="info-item">
                                <strong>Thủ thư tạo</strong>
                                <p>${sessionScope.librarian.fullName}</p>
                            </div>
                            <div class="info-item">
                                <strong>Ngày giờ trả</strong>
                                <p><fmt:formatDate value="${slip.returnDate}" pattern="HH:mm:ss 'ngày' dd/MM/yyyy" /></p>
                            </div>
                            <div class="info-item">
                                <strong>Bạn đọc</strong>
                                <p>${reader.fullName} (ID: ${reader.id})</p>
                            </div>
                            <div class="info-item">
                                <strong>Barcode Bạn đọc</strong>
                                <p>${reader.barcode}</p>
                            </div>
                        </div>

                        <h4 class="text-primary mb-3"><i class="bi bi-list-check"></i> Chi tiết tài liệu và vi phạm</h4>
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered table-hover align-middle">
                                <thead>
                                <tr>
                                    <th>ID Mượn</th>
                                    <th>Tên sách (Barcode)</th>
                                    <th>Vi phạm (Mới)</th>
                                    <th class="text-end">Phí (VNĐ)</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach var="entry" items="${confirmedMap}">
                                    <c:set var="borrowedId" value="${entry.key}" />
                                    <c:set var="violations" value="${entry.value}" />

                                    <%-- FIX: Tìm thông tin sách TỪ SESSION --%>
                                    <c:set var="docInfo" value="${null}"/>
                                    <c:forEach var="item" items="${sessionScope.sessionBorrowingList}">
                                        <c:if test="${item.id == borrowedId}">
                                            <c:set var="docInfo" value="${item.document}" />
                                        </c:if>
                                    </c:forEach>

                                    <tr>
                                        <td><strong>${borrowedId}</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty docInfo}">
                                                    <strong>${docInfo.catalog.name}</strong><br>
                                                    <small class="text-muted">Barcode: ${docInfo.barcode}</small>
                                                </c:when>
                                                <c:otherwise>
                                                    <em class="text-danger">Lỗi: Không tìm thấy thông tin sách</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty violations}">
                                                    <ul class="list-unstyled mb-0 small">
                                                        <c:forEach var="rv" items="${violations}">
                                                            <%-- FIX: Tra cứu tên lỗi TỪ MAP TRONG SESSION --%>
                                                            <c:set var="vInfo" value="${sessionScope.sessionViolationMap[rv.violationId]}" />
                                                            <li class="text-danger">
                                                                <i class="bi bi-exclamation-triangle-fill"></i>
                                                                <c:out value="${vInfo.name}" default="Lỗi ID: ${rv.violationId}"/>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-success small">
                                                        <i class="bi bi-check-circle-fill"></i> Không có vi phạm mới
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                            <%-- FIX: Hiển thị PHÍ ĐỘNG --%>
                                        <td class="text-end">
                                            <c:set var="itemFee" value="${0}"/>
                                            <c:forEach var="rv" items="${violations}">
                                                <c:set var="itemFee" value="${itemFee + rv.fee}"/>
                                            </c:forEach>
                                            <span class="fw-bold ${itemFee > 0 ? 'text-danger' : 'text-success'}">
                                                <fmt:formatNumber value="${itemFee}" type="currency" currencySymbol=""/>
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tfoot>
                                <tr class="table-light">
                                    <th colspan="3" class="text-end h5 text-danger mb-0">
                                        TỔNG CỘNG PHIẾU TRẢ
                                    </th>
                                    <th class="text-end h5 text-danger mb-0">
                                        <fmt:formatNumber value="${slip.fine}" type="currency" currencySymbol="VNĐ"/>
                                    </th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                        <%-- Nút bấm xác nhận --%>
                        <form action="${pageContext.request.contextPath}/confirmAndSave" method="post" class="text-center mt-5">
                            <button type="button" class="btn btn-secondary btn-lg me-md-3" onclick="history.back()">
                                <i class="bi bi-arrow-left-circle"></i> Hủy
                            </button>
                            <button type="submit" name="actionType" value="SAVE_AND_BILL" class="btn btn-primary btn-lg">
                                <i class="bi bi-check-circle-fill"></i> Xác nhận & Lưu Phiếu
                            </button>
                        </form>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>