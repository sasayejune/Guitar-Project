<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드 등록</title>

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

<h2>🎸 코드 등록</h2>

<form action="${pageContext.request.contextPath}/code/codeWrite"
      method="post"
      enctype="multipart/form-data">

    <table>
        <tr>
            <th>코드 이름</th>
            <td><input type="text" name="codeName" required></td>
        </tr>

        <tr>
            <th>엄지 X / Y</th>
            <td>
                <input type="number" name="thumbX"> /
                <input type="number" name="thumbY">
            </td>
        </tr>

        <tr>
            <th>검지 X / Y</th>
            <td>
                <input type="number" name="indexX"> /
                <input type="number" name="indexY">
            </td>
        </tr>

        <tr>
            <th>중지 X / Y</th>
            <td>
                <input type="number" name="middleX"> /
                <input type="number" name="middleY">
            </td>
        </tr>

        <tr>
            <th>약지 X / Y</th>
            <td>
                <input type="number" name="ringX"> /
                <input type="number" name="ringY">
            </td>
        </tr>

        <tr>
            <th>소지 X / Y</th>
            <td>
                <input type="number" name="pinkyX"> /
                <input type="number" name="pinkyY">
            </td>
        </tr>

        <tr>
            <th>엄지 열림/닫힘</th>
            <td>
                <select name="thumbOpen">
                    <option value="0" selected>닫힘</option>
                    <option value="1">열림</option>
                </select>
            </td>
        </tr>

        <tr>
            <th>MP3 파일</th>
            <td><input type="file" name="mp3File" accept="audio/*"></td>
        </tr>
    </table>

    <button type="submit">등록하기</button>
    &nbsp;&nbsp;
    <a href="${pageContext.request.contextPath}/list">← 돌아가기</a>

</form>

</body>
</html>
