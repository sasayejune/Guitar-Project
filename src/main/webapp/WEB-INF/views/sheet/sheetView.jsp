<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>악보 보기</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f6f7f9;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 16px;
        }

        .card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
            padding: 20px;
        }

        h2 {
            margin: 0 0 10px 0;
            font-size: 24px;
        }

        .meta {
            display: flex;
            gap: 18px;
            font-size: 14px;
            color: #555;
            margin-bottom: 14px;
        }

        .section {
            margin-top: 18px;
        }

        .section b {
            display: block;
            margin-bottom: 6px;
        }

        ul {
            padding-left: 18px;
            margin: 6px 0 0 0;
        }

        ul li {
            margin-bottom: 4px;
        }

        ul li a {
            color: #2b6cb0;
            text-decoration: none;
        }

        ul li a:hover {
            text-decoration: underline;
        }

        .sheet-container {
            margin-top: 20px;
            text-align: center;
        }

        iframe {
            width: 100%;
            max-width: 900px;
            height: 600px;
            border: 1px solid #eee;
            border-radius: 10px;
        }

        img {
            width: 100%;
            max-width: 900px;
            border-radius: 10px;
            border: 1px solid #eee;
        }

        .actions {
            margin-top: 24px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .btn {
            padding: 9px 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            background: #fafafa;
            color: #222;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
        }

        .btn:hover {
            background: #eee;
        }

        .btn.primary {
            background: #222;
            border-color: #222;
            color: #fff;
        }

        .btn.danger {
            background: #fff1f1;
            border-color: #f2b8b8;
            color: #a40000;
        }


        /* 연결된 코드 리스트: 칩 형태 */
        .code-list {
            list-style: none;
            padding: 0;
            margin: 8px 0 0 0;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .code-list li { margin: 0; }

        .code-chip {
            display: inline-flex;
            align-items: center;
            padding: 8px 12px;
            border-radius: 999px;
            border: 1px solid #dcdcdc;
            background: #ffffff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            text-decoration: none;
            color: #222;
            font-weight: 700;
            font-size: 14px;
        }

        .code-chip:hover {
            background: #f2f2f2;
        }

    </style>
</head>

<body>

<div class="container">
    <div class="card">

        <h2>🎼 ${sheet.title}</h2>

        <div class="meta">
            <div><b>키:</b> ${sheet.musicKey}</div>
            <div><b>난이도:</b> ${sheet.difficulty}</div>
            <div><b>작성자:</b> ${empty sheet.writerUserid ? '-' : sheet.writerUserid}</div>
        </div>

        <div class="section">
            <b>연결된 코드</b>

            <ul class="code-list">
                <c:forEach var="c" items="${linkedCodes}">
                    <li>
                        <a class="code-chip" href="${pageContext.request.contextPath}/code/codeView/${c.codeId}">
                                ${c.codeName}
                        </a>
                    </li>
                </c:forEach>
            </ul>

        </div>

        <div class="section">
            <b>코멘트</b>
            <div>${sheet.commentText}</div>
        </div>

        <div class="section">
            <b>스트로크</b>
            <div>${sheet.stroke}</div>
        </div>

        <div class="sheet-container">
            <c:choose>
                <c:when test="${fn:endsWith(sheet.sheetFile, '.pdf')}">
                    <iframe src="${pageContext.request.contextPath}${sheet.sheetFile}"></iframe>
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}${sheet.sheetFile}">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="actions">
            <a class="btn" href="${pageContext.request.contextPath}/list">← 목록</a>

            <c:if test="${canEdit}">
                <a class="btn primary" href="${pageContext.request.contextPath}/sheet/sheetEdit/${sheet.sheetId}">수정</a>
                <a class="btn danger" href="${pageContext.request.contextPath}/sheet/delete/${sheet.sheetId}"
                   onclick="return confirm('정말 삭제할까요?');">삭제</a>
            </c:if>
        </div>

    </div>
</div>

</body>
</html>
