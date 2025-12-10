<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>악보 보기</title>

    <style>
        body { font-family: Arial; margin: 20px; }
        .sheet-container { margin-top: 20px; }
        iframe { width: 800px; height: 600px; border: none; }
        img { width: 800px; }
    </style>
</head>

<body>

<h2>🎼 ${sheet.title}</h2>

<p><b>키:</b> ${sheet.musicKey}</p>
<p><b>난이도:</b> ${sheet.difficulty}</p>

<p><b>코드 연결:</b>
    <a href="${pageContext.request.contextPath}/code/codeView/${sheet.codeId}">
        코드 보기 (${sheet.codeId})
    </a>
</p>

<p><b>코멘트:</b> ${sheet.commentText}</p>
<p><b>스트로크:</b> ${sheet.stroke}</p>

<div class="sheet-container">
    <c:choose>
        <!-- PDF 파일 -->
        <c:when test="${fn:endsWith(sheet.sheetFile, '.pdf')}">
            <iframe src="${pageContext.request.contextPath}/${sheet.sheetFile}"></iframe>
        </c:when>

        <!-- 이미지 파일 -->
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/${sheet.sheetFile}">
        </c:otherwise>
    </c:choose>
</div>

<br><br>

<a href="${pageContext.request.contextPath}/sheet/sheetEdit/${sheet.sheetId}">수정</a> |
<a href="${pageContext.request.contextPath}/sheet/delete/${sheet.sheetId}">삭제</a> |
<a href="${pageContext.request.contextPath}/list">← 목록</a>

</body>
</html>
