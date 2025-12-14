<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guitar Guide List</title>

    <style>
        body { font-family: Arial; margin: 20px; }

        .tab-menu { margin-bottom: 20px; }

        .tab-btn {
            padding: 10px 20px;
            background: #eee;
            border: 1px solid #ccc;
            cursor: pointer;
            margin-right: 5px;
        }

        .tab-btn.active { background: #333; color: white; }

        .list-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .list-table th, .list-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .hidden { display: none; }
        .hint { color: gray; margin-top: 10px; }
    </style>

    <script>
        function showTab(tabName) {
            document.getElementById("codeListArea").classList.add("hidden");
            document.getElementById("sheetListArea").classList.add("hidden");

            document.getElementById(tabName).classList.remove("hidden");

            document.getElementById("codeBtn").classList.remove("active");
            document.getElementById("sheetBtn").classList.remove("active");

            if (tabName === "codeListArea") {
                document.getElementById("codeBtn").classList.add("active");
            } else {
                document.getElementById("sheetBtn").classList.add("active");
            }
        }
    </script>
</head>

<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<h2>🎸 Guitar Guide List</h2>

<div class="tab-menu">
    <button id="codeBtn" class="tab-btn active" onclick="showTab('codeListArea')">코드 목록</button>
    <button id="sheetBtn" class="tab-btn" onclick="showTab('sheetListArea')">악보 목록</button>
</div>

<!-- =========================== -->
<!-- ▼ 코드 리스트 영역          -->
<!-- =========================== -->
<div id="codeListArea">

    <h3>코드 목록</h3>
    <table class="list-table">
        <tr>
            <th>ID</th>
            <th>코드명</th>
            <th>MP3</th>
            <th>등록일</th>
            <th>보기</th>
        </tr>

        <c:forEach var="c" items="${codeList}">
            <tr>
                <td>${c.codeId}</td>
                <td>${c.codeName}</td>
                <td>${c.mp3Path}</td>
                <td>${c.createdAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/code/codeView/${c.codeId}">보기</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- ✅ 코드 등록: ADMIN만 -->
    <c:if test="${not empty loginUser and role eq 'ADMIN'}">
        <br>
        <a href="${pageContext.request.contextPath}/code/codeWrite">코드 등록하기</a>
    </c:if>

    <!-- ✅ 안내 문구 -->
    <c:if test="${empty loginUser}">
        <p class="hint">※ 코드 등록은 관리자 로그인 후 이용 가능합니다.</p>
    </c:if>

    <c:if test="${not empty loginUser and role ne 'ADMIN'}">
        <p class="hint">※ 코드 등록은 관리자만 가능합니다.</p>
    </c:if>

</div>

<!-- =========================== -->
<!-- ▼ 악보 리스트 영역          -->
<!-- =========================== -->
<div id="sheetListArea" class="hidden">

    <h3>악보 목록</h3>
    <table class="list-table">
        <tr>
            <th>ID</th>
            <th>제목</th>
            <th>키</th>
            <th>난이도</th>
            <th>등록일</th>
            <th>보기</th>
        </tr>

        <c:forEach var="s" items="${sheetList}">
            <tr>
                <td>${s.sheetId}</td>
                <td>${s.title}</td>
                <td>${s.musicKey}</td>
                <td>${s.difficulty}</td>
                <td>${s.createdAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/sheet/sheetView/${s.sheetId}">보기</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- ✅ 악보 등록: 로그인한 회원(USER/ADMIN)만 -->
    <c:if test="${not empty loginUser}">
        <br>
        <a href="${pageContext.request.contextPath}/sheet/sheetWrite">악보 등록하기</a>
    </c:if>

    <!-- ✅ 비회원 안내 문구 -->
    <c:if test="${empty loginUser}">
        <p class="hint">※ 악보 등록은 로그인한 회원만 가능합니다.</p>
    </c:if>

</div>

</body>
</html>