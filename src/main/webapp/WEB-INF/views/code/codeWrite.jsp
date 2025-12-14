<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코드 등록</title>

    <style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: none;
            font-family: Arial, sans-serif;
        }

        #codeWrite {
            position: relative;
            width: 100%;
        }

        #guitarImage {
            width: 100%;
            display: block;
        }

        #fingerCanvas {
            position: absolute;
            top: 0;
            left: 0;
            pointer-events: none;
        }

        .guide {
            position: absolute;
            top: 14px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255,255,255,0.85);
            padding: 8px 18px;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
        }

        .control-box {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255,255,255,0.9);
            padding: 14px 18px;
            border-radius: 12px;
            text-align: center;
        }

        .control-box button {
            padding: 6px 12px;
            margin: 4px;
            font-size: 13px;
            cursor: pointer;
        }

        .control-box input[type="text"],
        .control-box input[type="file"] {
            width: 200px;
            margin-top: 6px;
        }
    </style>
</head>

<body>

<form action="${pageContext.request.contextPath}/code/codeWrite"
      method="post"
      enctype="multipart/form-data">

    <div id="codeWrite">

        <!-- 기타 이미지 -->
        <img id="guitarImage"
             src="${pageContext.request.contextPath}/resources/img/guitar.png">

        <!-- 좌표 표시 캔버스 -->
        <canvas id="fingerCanvas"></canvas>

        <!-- 안내 문구 -->
        <div class="guide" id="guideText">
            👉 엄지 손가락 위치를 클릭하세요
        </div>

        <!-- 컨트롤 박스 -->
        <div class="control-box">

            <div>
                코드 이름<br>
                <input type="text" name="codeName" required>
            </div>

            <div style="margin-top:8px;">
                MP3 파일<br>
                <input type="file" name="mp3File" accept="audio/*">
            </div>

            <div style="margin-top:10px;">
                <button type="button" onclick="skipFinger()">없음</button>
                <button type="submit">등록</button>
                <button type="button"
                        onclick="location.href='${pageContext.request.contextPath}/list'">
                    취소
                </button>
            </div>
        </div>

        <!-- hidden 좌표 필드 -->
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

        <input type="hidden" name="thumbOpen" value="0">

    </div>
</form>

<script>
    const img = document.getElementById("guitarImage");
    const canvas = document.getElementById("fingerCanvas");
    const ctx = canvas.getContext("2d");
    const guide = document.getElementById("guideText");

    const fingers = ["thumb", "index", "middle", "ring", "pinky"];
    const fingerNames = ["엄지", "검지", "중지", "약지", "소지"];
    let current = 0;

    function resizeCanvas() {
        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;
    }

    window.onload = resizeCanvas;
    window.onresize = resizeCanvas;

    img.addEventListener("click", (e) => {
        if (current >= fingers.length) return;

        const rect = img.getBoundingClientRect();
        const xRatio = (e.clientX - rect.left) / img.clientWidth;
        const yRatio = (e.clientY - rect.top) / img.clientHeight;

        document.getElementById(fingers[current] + "X").value = xRatio;
        document.getElementById(fingers[current] + "Y").value = yRatio;

        drawCircle(xRatio, yRatio);

        current++;
        updateGuide();
    });

    function skipFinger() {
        if (current >= fingers.length) return;

        document.getElementById(fingers[current] + "X").value = "";
        document.getElementById(fingers[current] + "Y").value = "";

        current++;
        updateGuide();
    }

    function updateGuide() {
        if (current < fingers.length) {
            guide.textContent = "👉 " + fingerNames[current] + " 손가락 위치를 클릭하세요";
        } else {
            guide.textContent = "✅ 모든 손가락 입력 완료";
        }
    }

    function drawCircle(xRatio, yRatio) {
        const x = xRatio * canvas.width;
        const y = yRatio * canvas.height;

        ctx.beginPath();
        ctx.arc(x, y, 10, 0, Math.PI * 2);
        ctx.fillStyle = "red";
        ctx.fill();
    }
</script>

</body>
</html>
