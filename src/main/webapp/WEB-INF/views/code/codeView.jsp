<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Code View</title>

    <style>
        /* 🚫 어떤 여백도 허용하지 않음 */
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: none;
        }

        /* CodeView 전체 = 기타 이미지 영역 */
        #codeView {
            position: relative;
            width: 100%;          /* 기타 이미지 기준 폭 */
            height: auto;
            margin: 0 auto;
        }

        #guitarImage {
            width: 100%;
            display: block;
        }

        /* 좌표 캔버스 */
        #fingerCanvas {
            position: absolute;
            left: 0;
            top: 0;
            pointer-events: none;
        }

        /* 코드 이름 (이미지 위) */
        .code-title {
            position: absolute;
            top: 12px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 22px;
            font-weight: bold;
            background: rgba(255,255,255,0.75);
            padding: 6px 14px;
            border-radius: 20px;
        }

        /* 정보 패널 (이미지 위) */
        .info-box {
            position: absolute;
            right: 12px;
            bottom: 24px;
            background: rgba(255,255,255,0.85);
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13px;
            line-height: 1.5;
        }

        .info-box audio {
            width: 180px;
            margin-top: 6px;
        }
    </style>
</head>

<body>

<div id="codeView">

    <!-- 기타 이미지 -->
    <img id="guitarImage"
         src="${pageContext.request.contextPath}/resources/img/guitar.png">

    <!-- 좌표 캔버스 -->
    <canvas id="fingerCanvas"></canvas>

    <!-- 코드 이름 -->
    <div class="code-title">
        🎸 ${code.codeName}
    </div>

    <!-- 정보 (이미지 위) -->
    <div class="info-box">
        <audio controls>
            <source src="${pageContext.request.contextPath}/${code.mp3Path}"
                    type="audio/mpeg">
        </audio>
    </div>

</div>

<script>
    window.onload = () => {
        const img = document.getElementById("guitarImage");
        const canvas = document.getElementById("fingerCanvas");
        const ctx = canvas.getContext("2d");

        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;

        const points = [
            {x:${code.thumbX}, y:${code.thumbY}},
            {x:${code.indexX}, y:${code.indexY}},
            {x:${code.middleX}, y:${code.middleY}},
            {x:${code.ringX}, y:${code.ringY}},
            {x:${code.pinkyX}, y:${code.pinkyY}}
        ];

        points.forEach(p => {
            if (p.x > 0 && p.y > 0) draw(p.x, p.y);
        });

        function draw(x, y) {
            ctx.beginPath();
            ctx.arc(x, y, 10, 0, Math.PI * 2);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    };
</script>

</body>
</html>
