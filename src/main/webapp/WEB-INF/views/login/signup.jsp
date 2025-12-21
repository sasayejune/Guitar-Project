<%--
  Created by IntelliJ IDEA.
  User: gimgiu
  Date: 2025. 12. 12.
  Time: PM 5:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f5f5; }
        .box { width: 380px; margin: 100px auto; padding: 30px; background:#fff; border-radius:8px; box-shadow:0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align:center; margin-bottom: 20px; }
        .form-group { margin-bottom: 14px; }
        label { display:block; margin-bottom:6px; }
        input { width:100%; padding:8px; box-sizing:border-box; }
        button { width:100%; padding:10px; background:#2c7be5; color:#fff; border:0; border-radius:4px; cursor:pointer; }
        button:hover { background:#1a68d1; }
        .error { color:red; text-align:center; margin-bottom:10px; }
        .link { margin-top: 12px; text-align:center; }
    </style>
</head>
<body>
<div class="box">
    <h2>회원가입</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login/signupOk">

        <div class="form-group">
            <label for="username">닉네임</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="userid">아이디</label>
            <input type="text" id="userid" name="userid" required>
        </div>

        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button type="submit">가입하기</button>
    </form>

    <div class="link">
        <a href="${pageContext.request.contextPath}/login/login">로그인으로</a>
    </div>
</div>
</body>
</html>