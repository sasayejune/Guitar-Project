<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코드 수정</title>

    <style>
        html, body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        #editView {
            position: relative;
            width: 100%;
        }

        #guitarImage {
            width: 100%;
            display: block;
            position: relative;
            z-index: 1;
        }

        #canvas {
            position: absolute;
            left: 0;
            top: 0;
            z-index: 10;
            pointer-events: auto;
        }

        .panel {
            position: absolute;
            right: 14px;
            top: 20px;
            z-index: 20;
            background: rgba(255,255,255,0.92);
            padding: 12px;
            border-radius: 12px;
            font-size: 13px;
        }

        .panel button {
            display: block;
            width: 100%;
            margin-top: 6px;
        }
    </style>
</head>

<body>

<form action="${pageContext.request.contextPath}/code/codeEdit"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="codeId" value="${code.codeId}">
    <input type="hidden" name="codeName" value="${code.codeName}">

    <!-- 좌표 hidden -->
    <input type="hidden" name="thumbX" id="thumbX">
    <input type="hidden" name="thumbY" id="thumbY">
    <input type="hidden" name="indexX" id="indexX">
    <input type="hidden" name="indexY" id="indexY">
    <input type="hidden" name="middleX" id="middleX">
    <input type="hidden" name="middleY" id="middleY">
    <input type="hidden" name="ringX" id="ringX">
    <input type="hidden" name="ringY" id="ringY">
    <input type="hidden" name="pinkyX" id="pinkyX">
    <input type="hidden" name="pinkyY" id="pinkyY">

    <div id="editView">

        <img id="guitarImage"
             src="${pageContext.request.contextPath}/resources/img/guitar.png">

        <canvas id="canvas"></canvas>

        <div class="panel">
            <b>🎯 클릭 순서</b><br>
            엄지 → 검지 → 중지 → 약지 → 소지

            <button type="button" onclick="skip()">현재 손가락 없음</button>

            <hr>

            <audio controls style="width:180px;">
                <source src="${pageContext.request.contextPath}/${code.mp3Path}">
            </audio>

            <input type="file" name="mp3File" accept="audio/*">

            <hr>

            <button type="submit">수정 완료</button>
            <a href="${pageContext.request.contextPath}/list">← 목록</a>
        </div>

    </div>
</form>

<script>
    const img = document.getElementById("guitarImage");
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");

    const fingers = ["thumb","index","middle","ring","pinky"];
    let step = 0;

    const existing = {
        thumb:  {x:${code.thumbX},  y:${code.thumbY}},
        index:  {x:${code.indexX},  y:${code.indexY}},
        middle: {x:${code.middleX}, y:${code.middleY}},
        ring:   {x:${code.ringX},   y:${code.ringY}},
        pinky:  {x:${code.pinkyX},  y:${code.pinkyY}}
    };

    window.onload = () => {
        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;

        fingers.forEach(f => {
            const p = existing[f];
            if (p.x > 0 && p.y > 0) {
                draw(p.x, p.y);
                document.getElementById(f+"X").value = p.x;
                document.getElementById(f+"Y").value = p.y;
                step++;
            }
        });
    };

    canvas.addEventListener("click", e => {
        if (step >= fingers.length) return;

        const rect = canvas.getBoundingClientRect();
        const xRatio = (e.clientX - rect.left) / canvas.width;
        const yRatio = (e.clientY - rect.top) / canvas.height;

        const f = fingers[step];
        document.getElementById(f+"X").value = xRatio;
        document.getElementById(f+"Y").value = yRatio;

        draw(xRatio, yRatio);
        step++;
    });

    function skip() {
        if (step < fingers.length) step++;
    }

    function draw(xRatio, yRatio) {
        ctx.beginPath();
        ctx.arc(
            xRatio * canvas.width,
            yRatio * canvas.height,
            18, 0, Math.PI * 2
        );
        ctx.fillStyle = "red";
        ctx.fill();
    }
</script>

</body>
</html>
