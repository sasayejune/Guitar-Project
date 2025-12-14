<%--
  Created by IntelliJ IDEA.
  User: gimgiu
  Date: 2025. 12. 13.
  Time: PM 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>

    <style>
        body { font-family: Arial; margin: 20px; }
        .box {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            max-width: 700px;
        }
        .menu a {
            display: inline-block;
            margin-right: 12px;
            margin-top: 10px;
            padding: 10px 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            text-decoration: none;
            color: #333;
            background: #f7f7f7;
        }
        .menu a:hover { background: #eee; }
        .hint { color: gray; margin-top: 10px; }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/header.jsp"/>

<h2>🛠 관리자 페이지</h2>

<div class="box">
    <p><b>관리자 기능</b>은 ADMIN만 접근 가능합니다.</p>

    <div class="menu">
        <!-- 코드 등록/관리(ADMIN) -->
        <a href="${pageContext.request.contextPath}/code/codeWrite">코드 등록</a>

        <!-- (추후 구현 시 연결) -->
        <!-- <a href="${pageContext.request.contextPath}/code/manage">코드 관리</a> -->
        <!-- <a href="${pageContext.request.contextPath}/sheet/manage">악보 관리</a> -->
    </div>

    <p class="hint">
        ※ 이 페이지는 AuthInterceptor에서 /admin/** 를 ADMIN만 허용하도록 설정되어 있습니다.
    </p>
</div>

</body>
</html>