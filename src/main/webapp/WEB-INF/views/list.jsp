<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guitar Guide List</title>

    <style>
        body { font-family: Arial; margin: 20px; }

        .tab-menu {
            margin-bottom: 20px;
        }

        .tab-btn {
            padding: 10px 20px;
            background: #eee;
            border: 1px solid #ccc;
            cursor: pointer;
            margin-right: 5px;
        }

        .tab-btn.active {
            background: #333;
            color: white;
        }

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

    <br>
    <a href="${pageContext.request.contextPath}/code/codeWrite">코드 등록하기</a>

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

    <br>
    <a href="${pageContext.request.contextPath}/sheet/sheetWrite">악보 등록하기</a>

</div>

</body>
</html>
