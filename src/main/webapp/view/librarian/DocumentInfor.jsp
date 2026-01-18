<%-- File: DocumentInfor.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Kiểm tra Tài liệu - LibMan</title>
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
        .card-header {
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%) !important;
            border-bottom: 3px solid var(--primary-dark);
            padding: 2rem !important;
            color: white;
        }
        .card-header h2 { font-weight: 700; letter-spacing: 0.5px; display: flex; align-items: center; gap: 12px; }
        .card-header i { font-size: 1.8rem; }
        h4 { font-weight: 700; margin-top: 2rem; margin-bottom: 1.5rem; padding-bottom: 0.75rem; border-bottom: 3px solid var(--primary-light); display: inline-block; }
        h4 i { margin-right: 8px; }
        .list-group-item { border: 1px solid #e0e0e0; padding: 1rem 1.25rem; transition: all 0.2s ease; background-color: #fff; }
        .list-group-item:hover { background-color: #f8f9fa; border-left: 4px solid var(--primary-light); padding-left: 1.5rem; }
        .list-group-item strong { color: var(--primary-color); font-weight: 700; }
        .table thead { background: linear-gradient(90deg, #f0f0f0 0%, #e8e8e8 100%); border-bottom: 2px solid var(--primary-light); }
        .table thead th { font-weight: 700; color: var(--primary-color); padding: 1rem; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 0.5px; }
        .table tbody tr { transition: all 0.2s ease; border-bottom: 1px solid #e0e0e0; }
        .table tbody tr:hover { background-color: #f8f9fa; box-shadow: inset 3px 0 0 var(--primary-light); }
        .table tbody td { padding: 1rem; vertical-align: middle; }
        .table-responsive { border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); }
        .form-label { font-weight: 600; color: var(--primary-color); margin-bottom: 0.75rem; font-size: 0.95rem; }
        .fee-input-item {
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-left: 4px solid var(--danger-color);
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 0.5rem;
        }
        .fee-input-item label { font-size: 0.9rem; font-weight: 500; color: #333; }
        .form-select, .form-control { border: 2px solid #e0e0e0; border-radius: 8px; padding: 0.75rem 1rem; transition: all 0.3s ease; font-size: 0.95rem; }
        .form-select:focus, .form-control:focus { border-color: var(--primary-light); box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.15); outline: none; }
        .form-select option { padding: 0.5rem; }
        .form-text { font-size: 0.85rem; color: #6c757d; margin-top: 0.5rem; font-style: italic; }
        .btn { font-weight: 600; border-radius: 8px; padding: 0.75rem 1.75rem; transition: all 0.3s ease; text-transform: uppercase; letter-spacing: 0.5px; font-size: 0.9rem; }
        .btn-sm { padding: 0.5rem 1rem; font-size: 0.8rem; letter-spacing: 0.25px; }
        .btn-primary { background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%); border: none; box-shadow: 0 4px 12px rgba(0, 90, 156, 0.3); color: white; }
        .btn-primary:hover { background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-color) 100%); box-shadow: 0 6px 16px rgba(0, 90, 156, 0.4); transform: translateY(-2px); color: white; }
        .btn-secondary { background-color: #6c757d; border: none; box-shadow: 0 4px 12px rgba(108, 117, 125, 0.2); color: white; }
        .btn-secondary:hover { background-color: #5a6268; box-shadow: 0 6px 16px rgba(108, 117, 125, 0.3); transform: translateY(-2px); color: white; }
        .btn-danger { background: linear-gradient(90deg, #dc3545 0%, #e74c3c 100%); border: none; box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3); color: white; }
        .btn-danger:hover { background: linear-gradient(90deg, #c82333 0%, #dc3545 100%); box-shadow: 0 6px 16px rgba(220, 53, 69, 0.4); transform: translateY(-2px); color: white; }
        .btn i { margin-right: 8px; }
        .alert { border: none; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        .alert-danger { background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); color: #721c24; }
        .alert-danger .alert-heading { font-weight: 700; color: #721c24; }
        .alert-danger hr { border-color: #f1b0b7; }
        hr { border: none; height: 2px; background: linear-gradient(90deg, transparent, var(--primary-light), transparent); margin: 2rem 0; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="LibrarianHome.jsp">
            <i class="bi bi-book-half"></i> LibMan
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item">
                    <span class="navbar-text text-white me-3">
                        Chào, <strong>${sessionScope.librarian.fullName}</strong>!
                    </span>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-header">
                    <h2>
                        <i class="bi bi-clipboard-check-fill"></i> Kiểm tra Thông tin Tài liệu
                    </h2>
                </div>

                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty borrowedDoc}">
                        <h4><i class="bi bi-book-fill"></i> Chi tiết Tài liệu</h4>
                        <ul class="list-group mb-4">
                            <li class="list-group-item">
                                <strong><i class="bi bi-hash"></i> ID Mượn:</strong>
                                <span class="badge bg-primary">${borrowedDoc.id}</span>
                            </li>
                            <li class="list-group-item">
                                <strong><i class="bi bi-barcode"></i> Barcode Sách:</strong>
                                <span class="badge bg-info">${borrowedDoc.document.barcode}</span>
                            </li>
                            <li class="list-group-item">
                                <strong><i class="bi bi-book"></i> Tên sách:</strong>
                                    ${borrowedDoc.document.catalog.name}
                            </li>
                            <li class="list-group-item">
                                <strong><i class="bi bi-person-fill"></i> Tác giả:</strong>
                                    ${borrowedDoc.document.catalog.author}
                            </li>
                            <li class="list-group-item">
                                <strong><i class="bi bi-calendar-event"></i> Hạn trả (Due Date):</strong>
                                <span class="badge bg-warning text-dark">${borrowedDoc.dueDate}</span>
                            </li>
                        </ul>

                        <h4><i class="bi bi-exclamation-circle-fill"></i> Vi phạm đã ghi nhận (Lúc mượn)</h4>
                        <div class="table-responsive mb-4">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-exclamation-triangle"></i> Tên Vi phạm</th>
                                    <th><i class="bi bi-chat-left-text"></i> Ghi chú</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="ov" items="${oldViolations}">
                                    <tr>
                                        <td>
                                            <span class="badge bg-danger">${ov.violation.name}</span>
                                        </td>
                                        <td>${ov.description}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty oldViolations}">
                                    <tr>
                                        <td colspan="2" class="text-center text-muted py-4">
                                            <i class="bi bi-check-circle"></i> Không có vi phạm nào được ghi nhận lúc mượn.
                                        </td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>

                        <hr>

                        <form action="${pageContext.request.contextPath}/confirmReturnDocument" method="post" id="returnForm">

                            <input type="hidden" name="borrowedId" value="${borrowedDoc.id}">
                            <input type="hidden" name="readerBarcode" value="${readerBarcode}">

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4><i class="bi bi-exclamation-triangle-fill"></i> Vi phạm MỚI (Nếu có)</h4>
                                <a href="${pageContext.request.contextPath}/manageViolations"
                                   class="btn btn-secondary btn-sm" target="_blank">
                                    <i class="bi bi-gear-fill"></i> Quản lý Lỗi
                                </a>
                            </div>

                            <div class="mb-4">
                                <label for="violationsSelect" class="form-label">Chọn các vi phạm mới phát hiện:</label>
                                <select id="violationsSelect" class="form-select" multiple size="6">
                                        <%-- Select này KHÔNG có name, chỉ dùng để chọn --%>
                                    <c:forEach var="vt" items="${violationTypes}">
                                        <option value="${vt.id}">${vt.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">
                                    <i class="bi bi-info-circle"></i> Giữ Ctrl (hoặc Cmd) để chọn nhiều vi phạm.
                                </div>
                            </div>

                                <%-- KHU VỰC NHẬP PHÍ ĐỘNG --%>
                            <div id="fee-inputs-container" class="mb-4">
                                    <%-- JavaScript sẽ chèn các ô nhập phí vào đây --%>
                            </div>

                            <div class="text-center mt-5">
                                <button type="button" class="btn btn-secondary btn-lg me-3"
                                        onclick="location.href='${pageContext.request.contextPath}/searchReader?barcode=${readerBarcode}'">
                                    <i class="bi bi-arrow-left-circle"></i> Quay lại
                                </button>
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle-fill"></i> Xác nhận trả sách
                                </button>
                            </div>
                        </form>

                    </c:if>

                    <c:if test="${empty borrowedDoc}">
                        <div class="alert alert-danger text-center" role="alert">
                            <h4 class="alert-heading">
                                <i class="bi bi-exclamation-octagon-fill"></i> Lỗi!
                            </h4>
                            <p>Không tìm thấy thông tin cho tài liệu được yêu cầu.</p>
                            <hr>
                            <a href="${pageContext.request.contextPath}/view/librarian/ReaderInfor.jsp" class="btn btn-danger">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<script>
    document.getElementById('violationsSelect').addEventListener('change', function(e) {
        const feeContainer = document.getElementById('fee-inputs-container');
        feeContainer.innerHTML = '';

        const selectedOptions = e.target.selectedOptions;

        for (let i = 0; i < selectedOptions.length; i++) {
            const option = selectedOptions[i];
            const violationId = option.value;
            const violationName = option.text;

            const feeInputItem = document.createElement('div');
            feeInputItem.className = 'fee-input-item input-group input-group-sm';

            const label = document.createElement('span');
            label.className = 'input-group-text';
            label.innerHTML = `Phí cho: <strong>&nbsp;${violationName}</strong>`;

            // Input CHO PHÍ (name="fees")
            const feeInput = document.createElement('input');
            feeInput.type = 'number';
            feeInput.name = 'fees';
            feeInput.className = 'form-control';
            feeInput.value = '0';
            feeInput.min = '0';
            feeInput.required = true;

            // Input ẨN CHO ID (name="violations")
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'violations';
            idInput.value = violationId;

            feeInputItem.appendChild(label);
            feeInputItem.appendChild(feeInput);
            feeInputItem.appendChild(idInput); // Thêm input ẩn vào
            feeContainer.appendChild(feeInputItem);
        }
    });
</script>

</body>
</html>