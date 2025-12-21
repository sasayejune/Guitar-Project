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
            background: none;
            font-family: Arial, sans-serif;
        }

        /* ✅ 수정: 페이지 스크롤 가능 */
        body{
            overflow-x: hidden;
            overflow-y: auto;
        }

        /* ✅ 수정: 레이아웃 */
        .layout {
            display: flex;
            gap: 18px;
            align-items: flex-start;
            padding: 14px;
            box-sizing: border-box;
        }

        #editView {
            position: relative;
            width: 100%;
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
            top: 0;
            left: 0;
            z-index: 10;
            pointer-events: auto;
        }


        .panel {
            width: 360px;
            max-width: 42vw;
            background: rgba(255,255,255,0.92);
            padding: 16px;
            border-radius: 18px;
            font-size: 13px;
            box-shadow: 0 12px 32px rgba(0,0,0,0.12);
            backdrop-filter: blur(10px);
        }

        .panel .title {
            font-weight: 900;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .panel .hint {
            background: #f5f7ff;
            border: 1px solid #cfe0ff;
            border-radius: 14px;
            padding: 10px 12px;
        }

        #guideText {
            margin-top: 8px;
            font-weight: 900;
        }

        .panel button {
            display: block;
            width: 100%;
            margin-top: 8px;
            padding: 11px 12px;
            cursor: pointer;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            font-weight: 900 !important;
            font-size: 14px !important;     /* ✅ 수정 */
            color: #111827 !important;      /* ✅ 수정 */
            background: #fff;
            transition: .15s;
            appearance: none;
            -webkit-appearance: none;
        }
        .panel button:hover{ transform: translateY(-1px); }

        .btn-primary {
            background: #2563eb !important;
            border-color: #2563eb !important;
            color: #fff !important;
        }
        .btn-warn {
            background: #f3f4f6 !important;
            color: #111827 !important;
        }

        .panel hr {
            border: none;
            border-top: 1px solid #e5e7eb;
            margin: 12px 0;
        }

        .panel audio { width: 100%; }

        .panel input[type="file"]{
            width: 100%;
            margin-top: 8px;
        }

        /* ✅ 수정: 버튼 영역(항상 보이게) */
        .action-bar{
            margin-top: 12px;
            display: flex;
            gap: 10px;
        }
        .action-bar button{
            width: 100%;
            margin-top: 0; /* ✅ 수정 */
        }

        /* ✅ 수정: 작은 화면에서는 아래로 */
        @media (max-width: 980px) {
            .layout{
                flex-direction: column;
                padding: 10px;
            }
            .panel{
                width: 100%;
                max-width: none;
            }
        }
        .panel button.btn-primary {
            color: #ffffff !important;
        }


        .panel button.btn-primary *{
            color: #ffffff !important;
        }


    </style>
</head>

<body>

<form action="${pageContext.request.contextPath}/code/codeEdit"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="codeId" value="${code.codeId}">
    <input type="hidden" name="codeName" value="${code.codeName}">

    <!-- hidden 좌표 (기존 값 유지) -->
    <input type="hidden" name="thumbX"  id="thumbX"  value="${code.thumbX}">
    <input type="hidden" name="thumbY"  id="thumbY"  value="${code.thumbY}">

    <input type="hidden" name="indexX"  id="indexX"  value="${code.indexX}">
    <input type="hidden" name="indexY"  id="indexY"  value="${code.indexY}">

    <input type="hidden" name="middleX" id="middleX" value="${code.middleX}">
    <input type="hidden" name="middleY" id="middleY" value="${code.middleY}">

    <input type="hidden" name="ringX"   id="ringX"   value="${code.ringX}">
    <input type="hidden" name="ringY"   id="ringY"   value="${code.ringY}">

    <input type="hidden" name="pinkyX"  id="pinkyX"  value="${code.pinkyX}">
    <input type="hidden" name="pinkyY"  id="pinkyY"  value="${code.pinkyY}">

    <div class="layout">

        <div id="editView">
            <img id="guitarImage"
                 src="${pageContext.request.contextPath}/resources/img/guitar.png"
                 alt="guitar">
            <canvas id="fingerCanvas"></canvas>
        </div>

        <div class="panel">
            <div class="title">🛠 코드 수정: <span style="color:#2563eb;">${code.codeName}</span></div>

            <div class="hint">
                <b>🎯 클릭 순서</b><br>
                1(엄지) → 2(검지) → 3(중지) → 4(약지) → 5(소지)
                <div id="guideText">👉 엄지 손가락 위치를 클릭하세요</div>
            </div>

            <button type="button" class="btn-warn" onclick="skipFinger()">현재 손가락 없음</button>
            <button type="button" class="btn-warn" onclick="resetAll()">처음부터 다시찍기</button>

            <hr>

            <audio controls>
                <source src="${pageContext.request.contextPath}/${code.mp3Path}" type="audio/mpeg">
            </audio>

            <input type="file" name="mp3File" accept="audio/*">

            <hr>

            <!-- ✅ 수정: “수정 완료/목록” 버튼 -->
            <div class="action-bar">
                <button type="submit" class="btn-primary">수정 완료</button>
                <button type="button" class="btn-primary"
                        onclick="location.href='${pageContext.request.contextPath}/list'">
                    ← 목록
                </button>
            </div>
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
    const fingerNums  = [1, 2, 3, 4, 5];

    let step = 0;

    function resizeCanvas() {
        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;
        redrawAll();
    }

    function updateGuide() {
        if (step < fingers.length) {
            guide.textContent = "👉 " + fingerNames[step] + " 손가락 위치를 클릭하세요";
        } else {
            guide.textContent = "✅ 모든 손가락 입력 완료";
        }
    }

    function redrawAll() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        fingers.forEach((f, idx) => {
            const x = parseFloat(document.getElementById(f + "X").value);
            const y = parseFloat(document.getElementById(f + "Y").value);

            if (!isNaN(x) && !isNaN(y) && x > 0 && y > 0) {
                drawDotWithNumber(x, y, fingerNums[idx]);
            }
        });
    }

    function drawDotWithNumber(xRatio, yRatio, num) {
        const x = xRatio * canvas.width;
        const y = yRatio * canvas.height;

        const r = Math.max(12, Math.min(20, canvas.width * 0.018));

        ctx.beginPath();
        ctx.arc(x, y, r + 2, 0, Math.PI * 2);
        ctx.fillStyle = "rgba(255,255,255,0.95)";
        ctx.fill();

        ctx.beginPath();
        ctx.arc(x, y, r, 0, Math.PI * 2);
        ctx.fillStyle = "red";
        ctx.fill();

        ctx.fillStyle = "#fff";
        ctx.font = "900 " + Math.max(12, Math.floor(r * 1.05)) + "px Arial";
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.fillText(String(num), x, y + 0.5);
    }

    function clearHiddenAllToZero() {
        fingers.forEach(f => {
            document.getElementById(f + "X").value = "0";
            document.getElementById(f + "Y").value = "0";
        });
    }

    function detectNextStepFromExisting() {
        for (let i = 0; i < fingers.length; i++) {
            const f = fingers[i];
            const x = parseFloat(document.getElementById(f + "X").value);
            const y = parseFloat(document.getElementById(f + "Y").value);
            if (isNaN(x) || isNaN(y) || x <= 0 || y <= 0) {
                step = i;
                return;
            }
        }
        step = fingers.length;
    }

    window.addEventListener("load", () => {
        resizeCanvas();
        detectNextStepFromExisting();
        redrawAll();
        updateGuide();
    });

    window.addEventListener("resize", resizeCanvas);
    img.addEventListener("load", resizeCanvas);

    canvas.addEventListener("click", (e) => {
        if (step >= fingers.length) return;

        const rect = canvas.getBoundingClientRect();
        const xRatio = (e.clientX - rect.left) / canvas.width;
        const yRatio = (e.clientY - rect.top) / canvas.height;

        const f = fingers[step];
        document.getElementById(f + "X").value = xRatio;
        document.getElementById(f + "Y").value = yRatio;

        step++;
        redrawAll();
        updateGuide();
    });

    function skipFinger() {
        if (step >= fingers.length) return;

        const f = fingers[step];
        document.getElementById(f + "X").value = "0";
        document.getElementById(f + "Y").value = "0";

        step++;
        redrawAll();
        updateGuide();
    }

    function resetAll() {
        clearHiddenAllToZero();
        step = 0;
        redrawAll();
        updateGuide();
    }
</script>

</body>
</html>
