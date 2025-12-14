<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>악보 수정</title>

    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 600px; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; }
        input, select, textarea { width: 100%; padding: 5px; }
        textarea { height: 80px; }
    </style>
</head>

<body>

<h2>🎼 악보 수정: ${sheet.title}</h2>

<form action="${pageContext.request.contextPath}/sheet/sheetEdit"
      method="post" enctype="multipart/form-data">

    <input type="hidden" name="sheetId" value="${sheet.sheetId}">

    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title"
                       value="${sheet.title}" required></td>
        </tr>

        <tr>
            <th>현재 악보</th>
            <td>
                <a href="${pageContext.request.contextPath}/${sheet.sheetFile}"
                   target="_blank">현재 파일 열기</a>
            </td>
        </tr>

        <tr>
            <th>새 파일</th>
            <td><input type="file" name="sheetFileUpload"
                       accept="image/*,application/pdf"></td>
        </tr>

        <tr>
            <th>키(Key)</th>
            <td>
                <select name="musicKey">
                    <c:forEach var="k" items="${['C','D','E','F','G','A','B']}">
                        <option value="${k}"
                                <c:if test="${sheet.musicKey == k}">selected</c:if>>
                                ${k}
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <th>코드 연결</th>
            <td>
                <select name="codeIds" multiple size="6">
                    <c:forEach var="c" items="${codeList}">
                        <option value="${c.codeId}"
                                <c:if test="${c.codeId == selectedCodeId}">
                                    selected
                                </c:if>
                        >
                                ${c.codeName}
                        </option>

                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <th>난이도</th>
            <td>
                <select name="difficulty">
                    <option value="하" ${sheet.difficulty=='하'?'selected':''}>하</option>
                    <option value="중" ${sheet.difficulty=='중'?'selected':''}>중</option>
                    <option value="상" ${sheet.difficulty=='상'?'selected':''}>상</option>
                </select>
            </td>
        </tr>

        <tr>
            <th>코멘트</th>
            <td><textarea name="commentText">${sheet.commentText}</textarea></td>
        </tr>

        <tr>
            <th>스트로크</th>
            <td><input type="text" name="stroke"
                       value="${sheet.stroke}"></td>
        </tr>
    </table>

    <br>
    <button type="submit">수정 완료</button>
    <a href="${pageContext.request.contextPath}/list">← 목록</a>

</form>

</body>
</html>
