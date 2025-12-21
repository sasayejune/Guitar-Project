<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Code View</title>

    <style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            background: none;
        }

        .layout {
            display: flex;
            gap: 18px;
            align-items: flex-start;
            padding: 14px;
            box-sizing: border-box;
        }

        #codeView {
            position: relative;
            flex: 1;
            min-width: 0;
        }

        #guitarImage {
            width: 100%;
            display: block;
            border-radius: 14px;
        }

        #fingerCanvas {
            position: absolute;
            left: 0;
            top: 0;
            pointer-events: none;
        }

        .code-title {
            position: absolute;
            top: 12px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 22px;
            font-weight: 900;
            background: rgba(255,255,255,0.78);
            padding: 8px 14px;
            border-radius: 999px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            backdrop-filter: blur(6px);
        }

        .side {
            width: 360px;
            max-width: 42vw;
            position: sticky;
            top: 14px;
        }

        .panel {
            background: rgba(255,255,255,0.92);
            border-radius: 18px;
            padding: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            backdrop-filter: blur(10px);
        }

        .panel audio {
            width: 100%;
            margin: 6px 0 12px;
        }

        .hint-title{
            font-weight: 900;
            color: #2d7df6;
            margin: 8px 0 10px;
            font-size: 14px;
        }
        .hint-row{
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            padding: 10px;
            border-radius: 14px;
            border: 2px solid rgba(45,125,246,0.25);
            background: rgba(45,125,246,0.06);
        }
        .chip{
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 10px;
            border-radius: 999px;
            background: #fff;
            border: 1px solid #e6e6e6;
            font-weight: 900;
            font-size: 13px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            white-space: nowrap;
        }
        .dot{
            width: 12px; height: 12px;
            border-radius: 50%;
            background: #e11;
            display: inline-block;
        }
        .num{
            font-weight: 1000;
            color: #1f4ed8;
        }

        .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 10px 0 0;
            padding: 12px 14px;
            border-radius: 14px;
            font-weight: 900;
            text-decoration: none;
            color: white;
            font-size: 15px;
            user-select: none;
        }
        .edit-btn { background: #2d7df6; }
        .delete-btn { background: #d9534f; }
        .back-btn { background: #555; }

        @media (max-width: 980px) {
            .layout {
                flex-direction: column;
                padding: 10px;
            }
            .side {
                width: 100%;
                max-width: none;
                position: static;
            }
        }
    </style>
</head>

<body>

<div class="layout">

    <div id="codeView">
        <img id="guitarImage"
             src="${pageContext.request.contextPath}/resources/img/guitar.png"
             alt="guitar">

        <canvas id="fingerCanvas"></canvas>

        <div class="code-title">
            🎸 ${code.codeName}
        </div>
    </div>

    <div class="side">
        <div class="panel">

            <audio controls>
                <source src="${pageContext.request.contextPath}/${code.mp3Path}" type="audio/mpeg">
            </audio>

            <div class="hint-title">손가락 번호 안내</div>
            <div class="hint-row">
                <div class="chip"><span class="dot"></span><span class="num">1</span> 엄지</div>
                <div class="chip"><span class="dot"></span><span class="num">2</span> 검지</div>
                <div class="chip"><span class="dot"></span><span class="num">3</span> 중지</div>
                <div class="chip"><span class="dot"></span><span class="num">4</span> 약지</div>
                <div class="chip"><span class="dot"></span><span class="num">5</span> 소지(새끼)</div>
            </div>

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

</div>

<script>
    window.addEventListener("load", () => {
        const img = document.getElementById("guitarImage");
        const canvas = document.getElementById("fingerCanvas");
        const ctx = canvas.getContext("2d");

        const points = [
            {n: 1, x: ${code.thumbX},  y: ${code.thumbY}},
            {n: 2, x: ${code.indexX},  y: ${code.indexY}},
            {n: 3, x: ${code.middleX}, y: ${code.middleY}},
            {n: 4, x: ${code.ringX},   y: ${code.ringY}},
            {n: 5, x: ${code.pinkyX},  y: ${code.pinkyY}}
        ];

        function resizeCanvasToImage() {
            canvas.width = img.clientWidth;
            canvas.height = img.clientHeight;
            canvas.style.width = img.clientWidth + "px";
            canvas.style.height = img.clientHeight + "px";
        }

        function drawAll() {
            resizeCanvasToImage();
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            points.forEach(p => {
                if (p.x > 0 && p.y > 0) drawDotWithNumber(p.n, p.x, p.y);
            });
        }

        function drawDotWithNumber(num, xRatio, yRatio) {
            const realX = xRatio * canvas.width;
            const realY = yRatio * canvas.height;

            const r = Math.max(12, Math.min(18, canvas.width * 0.018));

            ctx.beginPath();
            ctx.arc(realX, realY, r, 0, Math.PI * 2);
            ctx.fillStyle = "#e11";
            ctx.fill();
            ctx.lineWidth = Math.max(2, r * 0.18);
            ctx.strokeStyle = "rgba(255,255,255,0.92)";
            ctx.stroke();

            ctx.fillStyle = "#fff";

            ctx.font = "900 " + Math.max(12, r * 1.05) + "px Arial";

            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            ctx.fillText(String(num), realX, realY + 0.5);
        }

        if (img.complete) drawAll();
        else img.addEventListener("load", drawAll);

        window.addEventListener("resize", () => {
            window.requestAnimationFrame(drawAll);
        });

        setTimeout(drawAll, 150);
    });
</script>

</body>
</html>
