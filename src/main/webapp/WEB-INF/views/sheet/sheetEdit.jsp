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
        th, td { padding: 10px; border: 1px solid #ccc; vertical-align: top; }
        input, select, textarea { width: 100%; padding: 5px; }
        textarea { height: 80px; }
        .code-box label {
            display: block;
            margin-bottom: 4px;
        }
    </style>
</head>

<body>

<h2>🎼 악보 수정: ${sheet.title}</h2>

<form action="${pageContext.request.contextPath}/sheet/sheetEdit"
      method="post" enctype="multipart/form-data">

    <!-- sheetId -->
    <input type="hidden" name="sheetId" value="${sheet.sheetId}">

    <table>
        <!-- 제목 -->
        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="title"
                       value="${sheet.title}" required>
            </td>
        </tr>

        <!-- 현재 악보 -->
        <tr>
            <th>현재 악보</th>
            <td>
                <a href="${pageContext.request.contextPath}/${sheet.sheetFile}"
                   target="_blank">현재 파일 열기</a>
            </td>
        </tr>

        <!-- 새 파일 -->
        <tr>
            <th>새 파일</th>
            <td>
                <input type="file" name="sheetFileUpload"
                       accept="image/*,application/pdf">
            </td>
        </tr>

        <!-- Key -->
        <tr>
            <th>키(Key)</th>
            <td>
                <select name="musicKey">
                    <c:forEach var="k" items="${['C','D','E','F','G','A','B']}">
                        <option value="${k}"
                                <c:if test="${sheet.musicKey == k}">
                                    selected
                                </c:if>>
                                ${k}
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <!-- 코드 연결 (⭐ 핵심 수정 부분) -->
        <tr>
            <th>코드 연결</th>
            <td class="code-box">
                <c:forEach var="c" items="${codeList}">
                    <label>
                        <input type="checkbox"
                               name="codeIds"
                               value="${c.codeId}"
                        <c:forEach var="sid" items="${selectedCodeIds}">
                        <c:if test="${sid == c.codeId}">
                               checked
                        </c:if>
                        </c:forEach>
                        >
                            ${c.codeName}
                    </label>
                </c:forEach>
            </td>
        </tr>

        <!-- 난이도 -->
        <tr>
            <th>난이도</th>
            <td>
                <select name="difficulty">
                    <option value="하"
                            <c:if test="${sheet.difficulty == '하'}">selected</c:if>>
                        하
                    </option>
                    <option value="중"
                            <c:if test="${sheet.difficulty == '중'}">selected</c:if>>
                        중
                    </option>
                    <option value="상"
                            <c:if test="${sheet.difficulty == '상'}">selected</c:if>>
                        상
                    </option>
                </select>
            </td>
        </tr>

        <!-- 코멘트 -->
        <tr>
            <th>코멘트</th>
            <td>
                <textarea name="commentText">${sheet.commentText}</textarea>
            </td>
        </tr>

        <!-- 스트로크 -->
        <tr>
            <th>스트로크</th>
            <td>
                <input type="text" name="stroke"
                       value="${sheet.stroke}">
            </td>
        </tr>
    </table>

    <br>

    <button type="submit">수정 완료</button>
    <a href="${pageContext.request.contextPath}/list">← 목록</a>

</form>

</body>
</html>