<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드 수정</title>

    <style>
        body { font-family: Arial; margin: 20px; }
        table { border-collapse: collapse; width: 500px; margin-bottom: 20px; }
        th, td { padding: 8px; border: 1px solid #ccc; }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 5px;
        }
    </style>

</head>
<body>

<h2>🎸 코드 수정: ${code.codeName}</h2>

<form action="${pageContext.request.contextPath}/code/codeEdit"
      method="post"
      enctype="multipart/form-data">

    <!-- 수정에 필요: codeId hidden -->
    <input type="hidden" name="codeId" value="${code.codeId}">

    <table>
        <tr>
            <th>코드 이름</th>
            <td><input type="text" name="codeName" value="${code.codeName}" required></td>
        </tr>

        <tr>
            <th>엄지 X / Y</th>
            <td>
                <input type="number" name="thumbX" value="${code.thumbX}"> /
                <input type="number" name="thumbY" value="${code.thumbY}">
            </td>
        </tr>

        <tr>
            <th>검지 X / Y</th>
            <td>
                <input type="number" name="indexX" value="${code.indexX}"> /
                <input type="number" name="indexY" value="${code.indexY}">
            </td>
        </tr>

        <tr>
            <th>중지 X / Y</th>
            <td>
                <input type="number" name="middleX" value="${code.middleX}"> /
                <input type="number" name="middleY" value="${code.middleY}">
            </td>
        </tr>

        <tr>
            <th>약지 X / Y</th>
            <td>
                <input type="number" name="ringX" value="${code.ringX}"> /
                <input type="number" name="ringY" value="${code.ringY}">
            </td>
        </tr>

        <tr>
            <th>소지 X / Y</th>
            <td>
                <input type="number" name="pinkyX" value="${code.pinkyX}"> /
                <input type="number" name="pinkyY" value="${code.pinkyY}">
            </td>
        </tr>

        <tr>
            <th>엄지 열림/닫힘</th>
            <td>
                <select name="thumbOpen">
                    <option value="0" <c:if test="${code.thumbOpen == 0}">selected</c:if>>닫힘</option>
                    <option value="1" <c:if test="${code.thumbOpen == 1}">selected</c:if>>열림</option>
                </select>
            </td>
        </tr>

        <tr>
            <th>현재 MP3</th>
            <td>
                <audio controls>
                    <source src="${pageContext.request.contextPath}/${code.mp3Path}">
                </audio>
            </td>
        </tr>

        <tr>
            <th>새 MP3 파일 업로드</th>
            <td><input type="file" name="mp3File" accept="audio/*"></td>
        </tr>
    </table>

    <button type="submit">수정 완료</button>
    &nbsp;&nbsp;
    <a href="${pageContext.request.contextPath}/list">← 돌아가기</a>

</form>

</body>
</html>
