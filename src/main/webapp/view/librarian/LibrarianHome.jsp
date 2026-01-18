<%--
  Created by IntelliJ IDEA.
  User: ngotu
  Date: 11/11/2025 (Refactored)
  Trang chủ Thủ thư (Dashboard) - Giao diện "siêu đẹp"
  Thiết kế đồng bộ với ReaderInfor.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Trang chủ Thủ thư - LibMan</title>

    <%-- 1. IMPORT BOOTSTRAP CSS (Giống ReaderInfor.jsp) --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <%-- 2. IMPORT BOOTSTRAP ICONS (Giống ReaderInfor.jsp) --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <%-- 3. SAO CHÉP TOÀN BỘ CSS TÙY CHỈNH TỪ ReaderInfor.jsp --%>
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
            /* Nền gradient đồng bộ */
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #1e293b;
        }

        /* ===== NAVBAR (Giữ nguyên) ===== */
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

        .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.2);
            border-color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* ===== [CSS MỚI] CHO DASHBOARD ===== */
        .dashboard-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            /* Lấy 100% chiều cao còn lại (trừ đi chiều cao navbar, ước lượng) */
            min-height: calc(100vh - 80px);
            padding: 2rem;
            text-align: center;
        }

        .dashboard-title {
            font-weight: 300; /* Font mỏng, hiện đại */
            font-size: 2.8rem;
            color: var(--primary-dark);
            margin-bottom: 2.5rem;
        }

        /* Nút "Trả Tài Liệu" được thiết kế lại thành 1 "Card" lớn */
        .action-card {
            display: block;
            text-decoration: none;
            /* Sử dụng màu gradient chủ đạo */
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            border-radius: 16px; /* Bo góc nhiều hơn */
            padding: 3.5rem 5rem;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            min-width: 380px;
        }

        .action-card:hover {
            color: white;
            box-shadow: var(--card-shadow-hover); /* Hiệu ứng hover nổi bật */
            transform: translateY(-10px);
        }

        .action-card .icon {
            font-size: 4.5rem; /* Icon cực lớn */
            display: block;
            margin-bottom: 1.5rem;
        }

        .action-card .title {
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

    </style>
</head>
<body>

<%-- Kiểm tra nếu Thủ thư chưa đăng nhập (Giữ nguyên logic) --%>
<c:if test="${empty sessionScope.librarian}">
    <c:redirect url="${pageContext.request.contextPath}/view/reader/Login.jsp"/>
</c:if>

<%-- ===== THANH ĐIỀU HƯỚNG (NAVBAR) - SAO CHÉP TỪ ReaderInfor.jsp ===== --%>
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

<%-- ===== NỘI DUNG CHÍNH (ĐÃ THIẾT KẾ LẠI) ===== --%>
<div class="dashboard-container">

    <h1 class="dashboard-title">Bảng điều khiển Thủ thư</h1>

    <%-- Nút chức năng duy nhất --%>
    <a href="${pageContext.request.contextPath}/view/librarian/ReaderInfor.jsp" class="action-card">
        <span class="icon">
            <%-- Icon tượng trưng cho việc Trả/Mượn (Return/Exchange) --%>
            <i class="bi bi-arrow-left-right"></i>
        </span>
        <span class="title">
            Trả Tài Liệu
        </span>
    </a>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>