<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>악보 등록</title>

    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 600px; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; }
        input[type="text"], input[type="date"], select, textarea {
            width: 100%;
            padding: 5px;
        }
        textarea { height: 80px; }
    </style>
</head>

<body>

<h2>🎼 악보 등록</h2>

<form action="${pageContext.request.contextPath}/sheet/sheetWrite"
      method="post" enctype="multipart/form-data">

    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" required></td>
        </tr>

        <tr>
            <th>날짜</th>
            <td><input type="date" name="sheetDate" required></td>
        </tr>

        <tr>
            <th>악보 파일</th>
            <td><input type="file" name="sheetFileUpload" accept="image/*,application/pdf" required></td>
        </tr>

        <tr>
            <th>키(Key)</th>
            <td>
                <select name="musicKey" required>
                    <option value="">선택</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="E">E</option>
                    <option value="F">F</option>
                    <option value="G">G</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                </select>
            </td>
        </tr>

        <tr>
            <th>코드 연결</th>
            <td>
                <select name="codeId" required>
                    <option value="">연결할 코드 선택</option>
                    <c:forEach var="c" items="${codeList}">
                        <option value="${c.codeId}">${c.codeName}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>

        <tr>
            <th>난이도</th>
            <td>
                <select name="difficulty">
                    <option value="하">하</option>
                    <option value="중">중</option>
                    <option value="상">상</option>
                </select>
            </td>
        </tr>

        <tr>
            <th>코멘트</th>
            <td><textarea name="commentText"></textarea></td>
        </tr>

        <tr>
            <th>스트로크</th>
            <td><input type="text" name="stroke" placeholder="예: D D U U D U"></td>
        </tr>
    </table>

    <br>
    <button type="submit">등록하기</button>
    &nbsp;&nbsp;
    <a href="${pageContext.request.contextPath}/list">← 목록으로</a>

</form>

</body>
</html>
