<%-- File: AddViolation.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Quản lý Loại Vi Phạm - LibMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary-color: #005A9C;
            --primary-light: #007bff;
            --primary-dark: #004078;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 15px rgba(0, 90, 156, 0.1);
            --card-shadow-hover: 0 8px 25px rgba(0, 90, 156, 0.15);
        }
        body, html {
            height: 100%;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #333;
        }
        .navbar {
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%) !important;
            box-shadow: var(--card-shadow);
            border-bottom: 3px solid var(--primary-dark);
        }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; letter-spacing: 0.5px; }
        .navbar-brand i { margin-right: 8px; font-size: 1.8rem; }
        .card { border: none; border-radius: 12px; overflow: hidden; box-shadow: var(--card-shadow); transition: all 0.3s ease; }
        .card:hover { box-shadow: var(--card-shadow-hover); transform: translateY(-2px); }
        .card-header { background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%) !important; border-bottom: 3px solid var(--primary-dark); padding: 1.5rem 2rem !important; color: white; }
        .card-header h2 { font-weight: 700; letter-spacing: 0.5px; display: flex; align-items: center; gap: 12px; font-size: 1.5rem;}
        .card-header i { font-size: 1.8rem; }
        h4 { font-weight: 700; margin-top: 1.5rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 3px solid var(--primary-light); display: inline-block; }
        h4 i { margin-right: 8px; }
        .table thead { background: linear-gradient(90deg, #f0f0f0 0%, #e8e8e8 100%); border-bottom: 2px solid var(--primary-light); }
        .table thead th { font-weight: 700; color: var(--primary-color); padding: 1rem; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 0.5px; }
        .table tbody tr { transition: all 0.2s ease; border-bottom: 1px solid #e0e0e0; }
        .table tbody tr:hover { background-color: #f8f9fa; box-shadow: inset 3px 0 0 var(--primary-light); }
        .table tbody td { padding: 1rem; vertical-align: middle; }
        .table-responsive { border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); }
        .form-label { font-weight: 600; color: var(--primary-color); margin-bottom: 0.5rem; font-size: 0.95rem; }
        .form-control { border: 2px solid #e0e0e0; border-radius: 8px; padding: 0.75rem 1rem; font-size: 0.95rem; }
        .form-control:focus { border-color: var(--primary-light); box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.15); }
        .btn { font-weight: 600; border-radius: 8px; padding: 0.75rem 1.75rem; text-transform: uppercase; }
        .btn-primary { background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%); border: none; box-shadow: 0 4px 12px rgba(0, 90, 156, 0.3); color: white; }
        .btn-primary:hover { background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-color) 100%); transform: translateY(-2px); }
        .btn-secondary { background-color: #6c757d; border: none; color: white; }
        .btn-secondary:hover { background-color: #5a6268; }
        .alert { border: none; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        .alert-success { background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); color: #155724; }
        .alert-danger { background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); color: #721c24; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/view/librarian/LibrarianHome.jsp">
            <i class="bi bi-book-half"></i> LibMan
        </a>
    </div>
</nav>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-header">
                    <h2>
                        <i class="bi bi-gear-fill"></i> Quản lý Loại Vi Phạm
                    </h2>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle-fill"></i> ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <h4><i class="bi bi-plus-circle-fill"></i> Thêm Loại Vi Phạm Mới</h4>
                    <form action="${pageContext.request.contextPath}/addViolation" method="post" class="mb-5">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Tên Lỗi (Ví dụ: Mất tài liệu)</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="note" class="form-label">Ghi chú (Tùy chọn)</label>
                                <input type="text" class="form-control" id="note" name="note">
                            </div>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Lưu Lỗi Mới
                            </button>
                        </div>
                    </form>

                    <hr>

                    <h4><i class="bi bi-list-columns"></i> Danh Sách Các Loại Vi Phạm</h4>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th style="width: 10%;">ID</th>
                                <th style="width: 35%;">Tên Lỗi</th>
                                <th style="width: 55%;">Ghi chú</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="v" items="${violationList}">
                                <tr>
                                    <td>${v.id}</td>
                                    <td><strong>${v.name}</strong></td>
                                    <td><c:out value="${v.note}" default="Không có ghi chú"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty violationList}">
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-3">
                                        <i class="bi bi-info-circle"></i> Hiện chưa có loại vi phạm nào được định nghĩa.
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center mt-5">
                        <a href="#" onclick="window.close()" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Đóng cửa sổ
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>