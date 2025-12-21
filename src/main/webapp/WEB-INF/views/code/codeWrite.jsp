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
            background: none;
            font-family: Arial, sans-serif;
        }

        /* ✅ 수정: 작은 화면 아래로 내려갈 수 있게 */
        body{
            overflow-x: hidden;
            overflow-y: auto; /* ✅ 수정 */
        }

        /* ✅ 수정: 기타/컨트롤 분리 레이아웃 */
        .layout {
            display: flex;
            gap: 18px;
            align-items: flex-start;
            padding: 14px;
            box-sizing: border-box;
        }

        #codeWrite {
            position: relative;
            width: 100%;
            flex: 1;          /* ✅ 수정 */
            min-width: 0;     /* ✅ 수정 */
        }

        #guitarImage {
            width: 100%;
            display: block;
            border-radius: 14px; /* ✅ 수정 */
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
            border-radius: 999px; /* ✅ 수정 */
            font-size: 16px;
            font-weight: 900;      /* ✅ 수정 */
            box-shadow: 0 10px 26px rgba(0,0,0,0.10); /* ✅ 수정 */
            backdrop-filter: blur(8px);               /* ✅ 수정 */
            white-space: nowrap;                       /* ✅ 수정 */
        }

        /* ✅ 수정: 오른쪽 패널형 control-box */
        .control-box {
            width: 360px;                 /* ✅ 수정 */
            max-width: 42vw;              /* ✅ 수정 */
            background: rgba(255,255,255,0.92);
            padding: 16px 16px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 12px 32px rgba(0,0,0,0.12);
            backdrop-filter: blur(10px);
            position: sticky;             /* ✅ 수정 */
            top: 14px;                    /* ✅ 수정 */
            align-self: flex-start;
        }

        .control-box .label {
            font-weight: 900;
            margin-bottom: 6px;
            color: #111;
        }

        .control-box input[type="text"],
        .control-box input[type="file"] {
            width: 100%;
            max-width: 320px;
            margin-top: 6px;
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            outline: none;
            box-sizing: border-box;
            background: #fff;
            font-weight: 700;
        }

        .control-box input[type="text"]:focus,
        .control-box input[type="file"]:focus {
            border-color: #cfe0ff;
            box-shadow: 0 0 0 3px rgba(37,99,235,.12);
        }

        .control-box button {
            padding: 10px 12px;
            margin: 6px 6px 0;
            font-size: 14px;
            cursor: pointer;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            font-weight: 900;
            background: #fff;
            transition: .15s;
            min-width: 92px;
        }

        .control-box button:hover{
            transform: translateY(-1px);
        }

        .control-box .btn-primary{
            background: #2563eb;
            border-color: #2563eb;
            color: #fff;
        }
        .control-box .btn-danger{
            background: #f3f4f6;
        }
        .control-box .btn-ghost{
            background: #111827;
            border-color: #111827;
            color: #fff;
        }

        /* ✅ 수정: 작은 화면에서는 control-box가 아래로 내려감 */
        @media (max-width: 980px) {
            .layout{
                flex-direction: column;
                padding: 10px;
            }
            .control-box{
                width: 100%;
                max-width: none;
                position: static;
                top: auto;
            }
        }
    </style>
</head>

<body>

<form action="${pageContext.request.contextPath}/code/codeWrite"
      method="post"
      enctype="multipart/form-data">

    <div class="layout"> <!-- ✅ 수정 -->

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

            <!-- hidden 좌표 필드 (그대로) -->
            <input type="hidden" name="thumbX"  id="thumbX"  value="0">
            <input type="hidden" name="thumbY"  id="thumbY"  value="0">

            <input type="hidden" name="indexX"  id="indexX"  value="0">
            <input type="hidden" name="indexY"  id="indexY"  value="0">

            <input type="hidden" name="middleX" id="middleX" value="0">
            <input type="hidden" name="middleY" id="middleY" value="0">

            <input type="hidden" name="ringX"   id="ringX"   value="0">
            <input type="hidden" name="ringY"   id="ringY"   value="0">

            <input type="hidden" name="pinkyX"  id="pinkyX"  value="0">
            <input type="hidden" name="pinkyY"  id="pinkyY"  value="0">

            <input type="hidden" name="thumbOpen" value="0">
        </div>

        <!-- 컨트롤 박스 -->
        <div class="control-box">

            <div>
                <div class="label">코드 이름</div>
                <input type="text" name="codeName" required>
            </div>

            <div style="margin-top:12px;">
                <div class="label">MP3 파일</div>
                <input type="file" name="mp3File" accept="audio/*">
            </div>

            <div style="margin-top:14px;">
                <button type="button" class="btn-danger" onclick="skipFinger()">없음</button>
                <button type="submit" class="btn-primary">등록</button>
                <button type="button" class="btn-ghost"
                        onclick="location.href='${pageContext.request.contextPath}/list'">
                    취소
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
    const fingerNums  = [1, 2, 3, 4, 5]; // ✅ 수정: 점 안에 넣을 번호

    let current = 0;

    function resizeCanvas() {
        canvas.width = img.clientWidth;
        canvas.height = img.clientHeight;
        redrawAll(); // 리사이즈되면 캔버스 초기화되므로 재그리기
    }

    // ✅ 수정: 전체 점 다시 그리기 (번호 포함)
    function redrawAll() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        fingers.forEach((f, idx) => {
            const x = parseFloat(document.getElementById(f + "X").value);
            const y = parseFloat(document.getElementById(f + "Y").value);

            if (!isNaN(x) && !isNaN(y) && x > 0 && y > 0) {
                drawDotWithNumber(x, y, fingerNums[idx]); // ✅ 수정
            }
        });
    }

    img.addEventListener("load", resizeCanvas);
    window.addEventListener("resize", resizeCanvas);

    window.addEventListener("load", () => {
        resizeCanvas();
        updateGuide();
    });

    img.addEventListener("click", (e) => {
        if (current >= fingers.length) return;

        const rect = img.getBoundingClientRect();
        const xRatio = (e.clientX - rect.left) / img.clientWidth;
        const yRatio = (e.clientY - rect.top) / img.clientHeight;

        document.getElementById(fingers[current] + "X").value = xRatio;
        document.getElementById(fingers[current] + "Y").value = yRatio;

        current++;
        updateGuide();
        redrawAll();
    });

    function skipFinger() {
        if (current >= fingers.length) return;

        document.getElementById(fingers[current] + "X").value = "0";
        document.getElementById(fingers[current] + "Y").value = "0";

        current++;
        updateGuide();
        redrawAll();
    }

    function updateGuide() {
        if (current < fingers.length) {
            guide.textContent = "👉 " + fingerNames[current] + " 손가락 위치를 클릭하세요";
        } else {
            guide.textContent = "✅ 모든 손가락 입력 완료";
        }
    }

    // ✅ 수정: 빨간 점 + 흰 테두리 + 숫자(흰색)까지 같이 그리기
    function drawDotWithNumber(xRatio, yRatio, num) {
        const x = xRatio * canvas.width;
        const y = yRatio * canvas.height;

        // 화면 크기에 따라 점 크기도 살짝 반응형
        const r = Math.max(10, Math.min(18, canvas.width * 0.018)); // ✅ 수정

        // 테두리(흰색)
        ctx.beginPath();
        ctx.arc(x, y, r + 2, 0, Math.PI * 2);
        ctx.fillStyle = "rgba(255,255,255,0.95)";
        ctx.fill();

        // 점(빨강)
        ctx.beginPath();
        ctx.arc(x, y, r, 0, Math.PI * 2);
        ctx.fillStyle = "red";
        ctx.fill();

        // 숫자(흰색)
        ctx.fillStyle = "#fff";
        ctx.font = "900 " + Math.max(12, Math.floor(r * 1.05)) + "px Arial"; // ✅ 수정: JSP/EL 충돌 방지(템플릿리터럴 X)
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.fillText(String(num), x, y + 0.5);
    }
</script>

</body>
</html>
