<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코드 수정</title>

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

        #editView {
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
            width: 220px;
        }

        .panel button {
            display: block;
            width: 100%;
            margin-top: 6px;
            padding: 8px 10px;
            cursor: pointer;
        }

        .panel a {
            display: inline-block;
            margin-top: 8px;
            text-decoration: none;
        }

        #guideText {
            margin-top: 8px;
            font-weight: bold;
        }
    </style>
</head>

<body>

<form action="${pageContext.request.contextPath}/code/codeEdit"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="codeId" value="${code.codeId}">
    <input type="hidden" name="codeName" value="${code.codeName}">

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

    <div id="editView">

        <!-- 기타 이미지 -->
        <img id="guitarImage"
             src="${pageContext.request.contextPath}/resources/img/guitar.png"
             alt="guitar">

        <!-- 캔버스 -->
        <canvas id="fingerCanvas"></canvas>

        <!-- 우측 패널 -->
        <div class="panel">
            <b>🎯 클릭 순서</b><br>
            엄지 → 검지 → 중지 → 약지 → 소지

            <div id="guideText">👉 엄지 손가락 위치를 클릭하세요</div>

            <button type="button" onclick="skipFinger()">현재 손가락 없음</button>
            <button type="button" onclick="resetAll()">처음부터 다시찍기</button>

            <hr>

            <audio controls style="width:200px;">
                <source src="${pageContext.request.contextPath}/${code.mp3Path}" type="audio/mpeg">
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
    const canvas = document.getElementById("fingerCanvas");
    const ctx = canvas.getContext("2d");
    const guide = document.getElementById("guideText");

    const fingers = ["thumb", "index", "middle", "ring", "pinky"];
    const fingerNames = ["엄지", "검지", "중지", "약지", "소지"];
    let step = 0;

    function resizeCanvas() {
        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;
        redrawAll();
    }

    function redrawAll() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        fingers.forEach(f => {
            const x = parseFloat(document.getElementById(f + "X").value);
            const y = parseFloat(document.getElementById(f + "Y").value);
            if (!isNaN(x) && !isNaN(y) && x > 0 && y > 0) {
                drawCircle(x, y);
            }
        });
    }

    function updateGuide() {
        if (step < fingers.length) {
            guide.textContent = "👉 " + fingerNames[step] + " 손가락 위치를 클릭하세요";
        } else {
            guide.textContent = "✅ 모든 손가락 입력 완료";
        }
    }

    function drawCircle(xRatio, yRatio) {
        const x = xRatio * canvas.width;
        const y = yRatio * canvas.height;

        ctx.beginPath();
        ctx.arc(x, y, 18, 0, Math.PI * 2);
        ctx.fillStyle = "red";
        ctx.fill();
    }

    // ✅ B 방식: 빈 값 대신 "0"을 넣어서 서버 바인딩 실패 방지
    function clearHiddenAll() {
        fingers.forEach(f => {
            document.getElementById(f + "X").value = "0";
            document.getElementById(f + "Y").value = "0";
        });
    }

    // ✅ edit 들어오면: 기존 점/값 모두 제거하고 새로 시작
    window.onload = () => {
        resizeCanvas();
        clearHiddenAll();      // ✅ 전부 0으로 초기화
        redrawAll();           // ✅ 점도 전부 제거(0은 안 그려짐)
        step = 0;
        updateGuide();
    };

    window.onresize = resizeCanvas;

    // ✅ 캔버스 클릭으로 좌표 입력
    canvas.addEventListener("click", (e) => {
        if (step >= fingers.length) return;

        const rect = canvas.getBoundingClientRect();
        const xRatio = (e.clientX - rect.left) / canvas.width;
        const yRatio = (e.clientY - rect.top) / canvas.height;

        const f = fingers[step];
        document.getElementById(f + "X").value = xRatio;
        document.getElementById(f + "Y").value = yRatio;

        redrawAll();
        step++;
        updateGuide();
    });

    // ✅ 현재 손가락 없음 (여기도 0으로!)
    function skipFinger() {
        if (step >= fingers.length) return;

        const f = fingers[step];
        document.getElementById(f + "X").value = "0";
        document.getElementById(f + "Y").value = "0";

        redrawAll();
        step++;
        updateGuide();
    }

    // ✅ 처음부터 다시찍기
    function resetAll() {
        clearHiddenAll(); // 전부 0
        redrawAll();
        step = 0;
        updateGuide();
    }
</script>

</body>
</html>
