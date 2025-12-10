<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Code View</title>

    <style>
        body { font-family: Arial; margin: 20px; text-align: center; }

        .container {
            position: relative;
            display: inline-block;
        }

        #guitarImage {
            width: 900px;       /* 이미지 크기 조정 가능 */
        }

        #fingerCanvas {
            position: absolute;
            left: 0;
            top: 0;
            pointer-events: none;   /* 마우스 이벤트 막기 */
        }

        .info-box {
            margin-top: 20px;
        }
    </style>

</head>
<body>

<h2>🎸 코드 보기: ${code.codeName}</h2>

<div class="container">
    <!-- 배경 기타 이미지 -->
    <img id="guitarImage" src="${pageContext.request.contextPath}/resources/img/guitar.png">

    <!-- 좌표(원) 표시용 캔버스 -->
    <canvas id="fingerCanvas"></canvas>
</div>

<div class="info-box">
    <h3>좌표 정보</h3>
    <p>Thumb: (${code.thumbX}, ${code.thumbY})</p>
    <p>Index: (${code.indexX}, ${code.indexY})</p>
    <p>Middle: (${code.middleX}, ${code.middleY})</p>
    <p>Ring: (${code.ringX}, ${code.ringY})</p>
    <p>Pinky: (${code.pinkyX}, ${code.pinkyY})</p>

    <h3>MP3 재생</h3>
    <audio controls>
        <source src="${pageContext.request.contextPath}/${code.mp3Path}" type="audio/mpeg">
        브라우저가 오디오 태그를 지원하지 않습니다.
    </audio>

    <br><br>
    <a href="${pageContext.request.contextPath}/list">← 목록으로 돌아가기</a>
</div>

<script>
    window.onload = function () {
        const img = document.getElementById("guitarImage");
        const canvas = document.getElementById("fingerCanvas");
        const ctx = canvas.getContext("2d");

        // 이미지 크기에 맞게 canvas 크기 조정
        canvas.width = img.width;
        canvas.height = img.height;

        // JSP에서 좌표 JS로 전달
        const points = [
            {x: ${code.thumbX}, y: ${code.thumbY}, color: "red"},
            {x: ${code.indexX}, y: ${code.indexY}, color: "red"},
            {x: ${code.middleX}, y: ${code.middleY}, color: "red"},
            {x: ${code.ringX}, y: ${code.ringY}, color: "red"},
            {x: ${code.pinkyX}, y: ${code.pinkyY}, color: "red"}
        ];

        drawPoints();

        function drawPoints() {
            points.forEach(p => {
                if (p.x !== 0 && p.y !== 0) {
                    drawCircle(p.x, p.y, p.color);
                }
            });
        }

        function drawCircle(x, y, color) {
            ctx.beginPath();
            ctx.arc(x, y, 10, 0, Math.PI * 2);  // 반지름 10px
            ctx.fillStyle = color;
            ctx.fill();
            ctx.closePath();
        }
    }
</script>

</body>
</html>
