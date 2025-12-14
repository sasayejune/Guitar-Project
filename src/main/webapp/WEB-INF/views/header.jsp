<%--
  Created by IntelliJ IDEA.
  User: gimgiu
  Date: 2025. 12. 13.
  Time: PM 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 20px;
        border-bottom: 1px solid #ddd;
        margin-bottom: 20px;
    }

    .menu a {
        margin-right: 15px;
        text-decoration: none;
        color: #333;
        font-weight: bold;
    }

    .menu a:hover {
        text-decoration: underline;
    }

    .auth {
        font-size: 14px;
    }

    .auth a {
        margin-left: 10px;
        text-decoration: none;
        color: #2c7be5;
    }
</style>

<div class="header">

    <!-- 왼쪽 메뉴 -->
    <div class="menu">
        <a href="${pageContext.request.contextPath}/list">홈</a>

        <!-- ADMIN 전용 메뉴 -->
        <c:if test="${not empty loginUser and loginUser.role eq 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin">관리자 페이지</a>
        </c:if>
    </div>

    <!-- 오른쪽 인증 영역 -->
    <div class="auth">

        <!-- 비회원 -->
        <c:if test="${empty loginUser}">
            <span>비회원</span>
            <a href="${pageContext.request.contextPath}/login/login">로그인</a>
            <!-- ✅ 여기 경로 수정: /login/signup 가 맞음 -->
            <a href="${pageContext.request.contextPath}/login/signup">회원가입</a>
        </c:if>

        <!-- 로그인 사용자 -->
        <c:if test="${not empty loginUser}">
            <span>
                <c:choose>
                    <c:when test="${not empty loginUser.username}">
                        <c:out value="${loginUser.username}"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${loginUser.userid}"/>
                    </c:otherwise>
                </c:choose>
                님 (<c:out value="${loginUser.role}"/>)
            </span>
            <a href="${pageContext.request.contextPath}/login/logout">로그아웃</a>
        </c:if>

    </div>
</div>