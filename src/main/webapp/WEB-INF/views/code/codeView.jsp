<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Code View</title>

    <style>
        /* 🚫 여백 완전 제거 */
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: none;
        }

        /* 코드뷰 전체 = 기타 이미지 */
        #codeView {
            position: relative;
            width: 100%;
        }

        #guitarImage {
            width: 100%;
            display: block;
        }

        /* 캔버스 */
        #fingerCanvas {
            position: absolute;
            left: 0;
            top: 0;
            pointer-events: none;
        }

        /* 코드 이름 */
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

        /* 우측 하단 패널 */
        .info-box {
            position: absolute;
            right: 14px;
            bottom: 20px;
            background: rgba(255,255,255,0.9);
            padding: 12px 14px;
            border-radius: 12px;
            font-size: 13px;
            text-align: center;
        }

        .info-box audio {
            width: 180px;
            margin-bottom: 10px;
        }

        .btn {
            display: block;
            margin: 6px 0;
            padding: 8px 14px;
            border-radius: 10px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .edit-btn {
            background: #2d7df6;
        }

        .delete-btn {
            background: #d9534f;
        }

        .back-btn {
            background: #555;
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

    <!-- 코드명 -->
    <div class="code-title">
        🎸 ${code.codeName}
    </div>

    <!-- 우측 하단 정보 -->
    <div class="info-box">

        <audio controls>
            <source src="${pageContext.request.contextPath}/${code.mp3Path}"
                    type="audio/mpeg">
        </audio>

        <a class="btn edit-btn"
           href="${pageContext.request.contextPath}/code/codeEdit/${code.codeId}">
            ✏️ Edit
        </a>

        <a class="btn delete-btn"
           href="${pageContext.request.contextPath}/code/delete/${code.codeId}"
           onclick="return confirm('정말 삭제하시겠습니까?');">
            🗑 Delete
        </a>

        <a class="btn back-btn"
           href="${pageContext.request.contextPath}/list">
            ← List
        </a>
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
            {x:${code.thumbX},  y:${code.thumbY}},
            {x:${code.indexX},  y:${code.indexY}},
            {x:${code.middleX}, y:${code.middleY}},
            {x:${code.ringX},   y:${code.ringY}},
            {x:${code.pinkyX}, y:${code.pinkyY}}
        ];

        points.forEach(p => {
            if (p.x > 0 && p.y > 0) draw(p.x, p.y);
        });

        function draw(xRatio, yRatio) {
            const realX = xRatio * canvas.width;
            const realY = yRatio * canvas.height;

            ctx.beginPath();
            ctx.arc(realX, realY, 16, 0, Math.PI * 2); // 🔴 크게
            ctx.fillStyle = "red";
            ctx.fill();
        }
    };
</script>

</body>
</html>
