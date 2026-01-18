<%--
  Created by IntelliJ IDEA.
  User: ngotu
  Date: 21/10/2025
  Time: 21:52
  Trang Đăng nhập - LibMan (Enhanced & Refined)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - LibMan</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            height: 100%;
            width: 100%;
        }

        body {
            background: linear-gradient(135deg, #e6f2ff 0%, #f0f7ff 50%, #e8f4ff 100%);
            display: grid;
            place-items: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            padding: 1rem;
            min-height: 100vh;
        }

        .login-container {
            max-width: 950px;
            width: 100%;
        }

        .login-card {
            border: none;
            border-radius: 1.25rem;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 90, 156, 0.12),
            0 2px 8px rgba(0, 90, 156, 0.08);
            transition: box-shadow 0.3s ease;
        }

        .login-card:hover {
            box-shadow: 0 12px 48px rgba(0, 90, 156, 0.15),
            0 4px 12px rgba(0, 90, 156, 0.1);
        }

        /* --- CỘT ẢNH (Bên trái) --- */
        .login-image-col {
            background: linear-gradient(135deg, #005A9C 0%, #0073C6 100%);
            background-image:
                    linear-gradient(135deg, rgba(0, 90, 156, 0.85) 0%, rgba(0, 115, 198, 0.85) 100%),
                    url('https://i.pinimg.com/1200x/38/7b/78/387b78e83fc199a857c581a5ac53506d.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 500px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .login-image-col::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(255,255,255,0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .image-content {
            position: relative;
            z-index: 1;
        }

        .image-content i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.95;
        }

        .image-content h3 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .image-content p {
            font-size: 1rem;
            opacity: 0.9;
            line-height: 1.6;
            max-width: 300px;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        /* --- CỘT FORM (Bên phải) --- */
        .login-form-col {
            padding: 3.5rem;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-form-col h2 {
            color: #005A9C;
            font-weight: 700;
            margin-bottom: 0.5rem;
            font-size: 1.75rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .login-form-col h2 i {
            font-size: 1.75rem;
        }

        .form-subtitle {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }

        /* Alert Messages */
        .alert {
            border: none;
            border-radius: 0.75rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        /* Form Floating Labels */
        .form-floating > label {
            color: #6c757d;
            font-weight: 500;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 0.75rem;
            padding: 0.875rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-control:focus {
            border-color: #007bff;
            background-color: #ffffff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.15);
            outline: none;
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        /* Forgot Password Link */
        .forgot-password-link {
            font-size: 0.9rem;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-block;
        }

        .forgot-password-link:hover {
            color: #0056b3;
            text-decoration: underline;
            transform: translateX(2px);
        }

        .forgot-password-container {
            text-align: right;
            margin-bottom: 1.5rem;
        }

        /* Buttons */
        .btn-login, .btn-register {
            font-weight: 600;
            padding: 0.875rem 1.5rem;
            border-radius: 0.75rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            font-size: 1rem;
            cursor: pointer;
        }

        .btn-login {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .btn-login:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .btn-register {
            background-color: transparent;
            color: #6c757d;
            border-color: #dee2e6;
        }

        .btn-register:hover {
            background-color: #f8f9fa;
            border-color: #6c757d;
            color: #495057;
            transform: translateY(-2px);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        /* Responsive Design */
        @media (max-width: 767.98px) {
            .login-form-col {
                padding: 2rem 1.5rem;
            }

            .login-form-col h2 {
                font-size: 1.5rem;
            }

            .login-image-col {
                min-height: 250px;
                padding: 2rem;
            }

            .image-content i {
                font-size: 3rem;
            }

            .image-content h3 {
                font-size: 1.5rem;
            }

            body {
                padding: 0.5rem;
            }

            .login-card {
                border-radius: 1rem;
            }
        }

        @media (max-width: 575.98px) {
            .login-form-col {
                padding: 1.5rem 1rem;
            }

            .login-card {
                border-radius: 0.75rem;
                box-shadow: 0 4px 16px rgba(0, 90, 156, 0.1);
            }

            body {
                padding: 0;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="card login-card">
        <div class="row g-0">

            <!-- Cột ảnh (Ẩn trên mobile) -->
            <div class="col-lg-6 login-image-col d-none d-lg-flex">
                <div class="image-content">
                    <i class="bi bi-book-half"></i>
                    <h3>LibMan</h3>
                    <p>Chào mừng bạn đến với hệ thống quản lý thư viện!</p>
                </div>
            </div>

            <!-- Cột Form -->
            <div class="col-12 col-lg-6 login-form-col">

                <h2><i class="bi bi-lock-fill"></i> Đăng Nhập</h2>
                <p class="form-subtitle">Vui lòng nhập thông tin đăng nhập của bạn</p>

                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>

                <!-- Hiển thị thông báo thành công -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        <i class="bi bi-check-circle"></i> ${successMessage}
                    </div>
                </c:if>

                <!-- Form đăng nhập -->
                <form action="${pageContext.request.contextPath}/login" method="post" novalidate>

                    <!-- Username Input -->
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control"
                               id="username" name="username"
                               placeholder="Tên đăng nhập" required>
                        <label for="username"><i class="bi bi-person"></i> Tên đăng nhập</label>
                    </div>

                    <!-- Password Input -->
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control"
                               id="password" name="password"
                               placeholder="Mật khẩu" required>
                        <label for="password"><i class="bi bi-key"></i> Mật khẩu</label>
                    </div>

                    <!-- Forgot Password Link -->
                    <div class="forgot-password-container">
                        <a href="#" class="forgot-password-link">
                            <i class="bi bi-question-circle"></i> Quên mật khẩu?
                        </a>
                    </div>

                    <!-- Buttons -->
                    <div class="row g-2">
                        <div class="col-6">
                            <button type="button" class="btn btn-register w-100"
                                    onclick="location.href='${pageContext.request.contextPath}/register-redirect'">
                                <i class="bi bi-person-plus"></i> Đăng Ký
                            </button>
                        </div>
                        <div class="col-6">
                            <button type="submit" class="btn btn-login w-100">
                                <i class="bi bi-box-arrow-in-right"></i> Đăng Nhập
                            </button>
                        </div>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

<script>
    // Add smooth focus animations
    document.querySelectorAll('.form-control').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });
        input.addEventListener('blur', function() {
            this.parentElement.classList.remove('focused');
        });
    });
</script>

</body>
</html>
