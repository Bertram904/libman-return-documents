<%--
  Created by IntelliJ IDEA.
  User: ngotu
  Date: 21/10/2025
  Trang Đăng ký Thẻ Bạn đọc (Reader Registration) - Giao diện đồng bộ
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Đăng ký Thẻ Bạn đọc</title>

    <%-- Import Bootstrap Icons cho các icon đẹp hơn --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* ===== BIẾN MÀU TỪ CÁC FILE TRƯỚC ===== */
        :root {
            --primary-color: #005A9C;
            --primary-light: #007bff;
            --primary-dark: #004078;
            --danger-color: #dc3545;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 15px rgba(0, 90, 156, 0.1);
        }

        /* ===== RESET & CƠ BẢN ===== */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* ===== CONTAINER VÀ CARD ===== */
        .container {
            width: 100%;
            max-width: 650px; /* Giới hạn chiều rộng */
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15); /* Đổ bóng chuyên nghiệp */
            padding: 40px;
        }

        h2 {
            font-weight: 700;
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-light);
            padding-bottom: 10px;
            margin-bottom: 30px;
            text-align: center;
            font-size: 1.8rem;
        }

        /* ===== FORM GROUPS (Sử dụng Grid) ===== */
        .form-group {
            margin-bottom: 15px;
            display: grid;
            /* Cột 1: Label (150px) | Cột 2: Input (lấy phần còn lại) */
            grid-template-columns: 150px 1fr;
            align-items: center;
            gap: 10px;
        }

        .form-group label {
            font-weight: 600;
            color: #555;
            text-align: right; /* Căn phải label */
            padding-right: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
            outline: none;
        }

        /* ===== MESSAGES ===== */
        .message {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .error {
            background-color: #f8d7da;
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        /* ===== BUTTONS ===== */
        .buttons {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .buttons button {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 700;
            text-transform: uppercase;
            /* Màu nền gradient đồng bộ */
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 90, 156, 0.3);
            transition: all 0.3s ease;
        }

        .buttons button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 90, 156, 0.4);
        }

        .buttons button i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="bi bi-person-lines-fill"></i> Đăng ký Thẻ Bạn đọc</h2>

    <c:if test="${not empty errorMessage}">
        <div class="message error">
            <i class="bi bi-exclamation-triangle-fill"></i>
                ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">

        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required value="${param.username}">
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Xác nhận Pass:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>

        <hr style="border-top: 1px dashed #ccc; margin: 25px 0;">

        <div class="form-group">
            <label for="fullName">Họ tên:</label>
            <input type="text" id="fullName" name="fullName" required value="${param.fullName}">
        </div>
        <div class="form-group">
            <label for="dateOfBith">Ngày sinh:</label>
            <input type="date" id="dateOfBith" name="dateOfBith" required value="${param.dateOfBith}">
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address" value="${param.address}">
        </div>
        <div class="form-group">
            <label for="tel">Điện thoại:</label>
            <input type="text" id="tel" name="tel" value="${param.tel}">
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required value="${param.email}">
        </div>
        <div class="buttons">
            <button type="submit">
                <i class="bi bi-person-add"></i> Đăng ký
            </button>
        </div>
    </form>
</div>
</body>
</html>