<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>악보 등록</title>

    <style>
        :root{
            --bg:#f6f7fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --line:#e5e7eb;
            --primary:#2563eb;
            --primary-weak:#e8f0ff;
            --shadow:0 8px 24px rgba(15,23,42,.08);
            --radius:16px;
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: ui-sans-serif, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial,
            "Apple SD Gothic Neo","Noto Sans KR", sans-serif;
            background: var(--bg);
            color: var(--text);
        }

        /* 페이지 래핑 (구조는 그대로, 바깥 감싸는 스타일만) */
        .wrap{
            max-width: 900px;
            margin: 24px auto;
            padding: 0 16px 40px;
        }

        h2{
            margin: 0 0 14px 0;
            font-size: 26px;
            letter-spacing: -0.3px;
        }
        .sub{
            margin: 0 0 18px 0;
            color: var(--muted);
            font-size: 14px;
            line-height: 1.6;
        }

        form{
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 18px;
        }

        table{
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }
        th, td{
            padding: 14px 14px;
            border: 1px solid var(--line);
            vertical-align: top;
        }
        th{
            width: 170px;
            background: #fafafa;
            font-size: 14px;
            color: #374151;
            text-align: left;
            white-space: nowrap;
        }

        /* 입력 컴포넌트 통일 */
        input[type="text"], select, textarea{
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--line);
            border-radius: 12px;
            outline: none;
            font-size: 14px;
            font-weight: 700;
            background: #fff;
        }
        textarea{
            height: 92px;
            resize: vertical;
            font-weight: 600;
        }
        input[type="text"]:focus, select:focus, textarea:focus{
            border-color: #cfe0ff;
            box-shadow: 0 0 0 3px rgba(37,99,235,.12);
        }

        /* 파일 업로드: 버튼형(기본 구조 유지, input은 그대로 사용) */
        .file-row{
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }
        input[type="file"]{
            width: auto; /* 기본 파일 input 폭 너무 커서 */
            font-weight: 700;
        }
        .file-hint{
            color: var(--muted);
            font-size: 13px;
        }
        .file-name{
            padding: 8px 10px;
            border-radius: 12px;
            border: 1px dashed var(--line);
            background: #fafafa;
            color: var(--muted);
            font-size: 13px;
        }

        /* 키/난이도 두 개를 한 줄로 보여주는 래퍼(구조는 select 그대로) */
        .two-col{
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .two-col > div{
            flex: 1;
            min-width: 220px;
        }
        .mini-label{
            display:block;
            margin-bottom: 8px;
            color: var(--muted);
            font-size: 12px;
            font-weight: 800;
        }

        /* 코드 연결: 칩 형태 */
        .code-box{
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 4px 0;
        }
        .code-chip{
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            border-radius: 999px;
            border: 1px solid var(--line);
            background: #fff;
            font-weight: 800;
            cursor: pointer;
            user-select: none;
            transition: .15s;
        }
        .code-chip:hover{
            transform: translateY(-1px);
        }
        .code-chip input{
            width: 16px;
            height: 16px;
            accent-color: var(--primary);
        }
        /* 체크되면 색 변화 */
        .code-chip:has(input:checked){
            background: var(--primary-weak);
            border-color: var(--primary);
            color: var(--primary);
        }

        /* 하단 버튼 */
        .actions{
            margin-top: 16px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }
        .btn{
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid var(--line);
            background: #fff;
            color: var(--text);
            text-decoration: none;
            font-weight: 800;
            font-size: 14px;
            cursor: pointer;
            transition: .15s;
            white-space: nowrap;
        }
        .btn:hover{ transform: translateY(-1px); }
        .btn-primary{
            background: var(--primary);
            border-color: var(--primary);
            color: #fff;
        }
        .btn-ghost{
            background: #fafafa;
        }

        /* 작은 안내 박스 */
        .notice{
            margin-top: 12px;
            padding: 12px 14px;
            border-radius: 14px;
            background: #f9fafb;
            border: 1px dashed var(--line);
            color: var(--muted);
            font-size: 13px;
        }
    </style>

    <script>
        // 파일 선택 시 파일명 표시(기다릴 필요 없이 즉시)
        window.addEventListener("DOMContentLoaded", function () {
            var fileInput = document.getElementById("sheetFileUpload");
            var fileName = document.getElementById("fileName");

            if (!fileInput || !fileName) return;

            fileInput.addEventListener("change", function () {
                if (fileInput.files && fileInput.files.length > 0) {
                    fileName.textContent = fileInput.files[0].name;
                } else {
                    fileName.textContent = "선택된 파일 없음";
                }
            });
        });
    </script>

</head>

<body>
<div class="wrap">

    <h2>🎼 악보 등록</h2>
    <p class="sub">제목/파일/키를 입력하고, 이 곡에 사용되는 코드를 선택하세요.</p>

    <form action="${pageContext.request.contextPath}/sheet/sheetWrite"
          method="post" enctype="multipart/form-data">

        <table>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" placeholder="예: Korea Fantasy" required></td>
            </tr>

            <tr>
                <th>악보 파일</th>
                <td>
                    <div class="file-row">
                        <input id="sheetFileUpload" type="file" name="sheetFileUpload"
                               accept="image/*,application/pdf" required>
                        <span id="fileName" class="file-name">선택된 파일 없음</span>
                        <span class="file-hint">※ 이미지 또는 PDF 업로드 가능</span>
                    </div>
                </td>
            </tr>

            <tr>
                <th>키(Key) / 난이도</th>
                <td>
                    <div class="two-col">
                        <div>
                            <span class="mini-label">키(Key)</span>
                            <select name="musicKey" required>
                                <option value="">선택</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                                <option value="G">G</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                            </select>
                        </div>

                        <div>
                            <span class="mini-label">난이도</span>
                            <select name="difficulty">
                                <option value="하">하</option>
                                <option value="중">중</option>
                                <option value="상">상</option>
                            </select>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <th>코드 연결</th>
                <td class="code-box">
                    <c:forEach var="c" items="${codeList}">
                        <label class="code-chip">
                            <input type="checkbox" name="codeIds" value="${c.codeId}">
                                ${c.codeName}
                        </label>
                    </c:forEach>
                </td>
            </tr>

            <tr>
                <th>코멘트</th>
                <td><textarea name="commentText" placeholder="연습 팁, 주의할 점 등을 적어주세요."></textarea></td>
            </tr>

            <tr>
                <th>스트로크</th>
                <td>
                    <input type="text" name="stroke" placeholder="예: D D U U D U">
                    <div class="notice">※ 스트로크는 ‘D/U’ 형태로 입력하면 보기 좋습니다. (예: DDUU, D D U U)</div>
                </td>
            </tr>
        </table>

        <div class="actions">
            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/list">← 목록</a>
            <button class="btn btn-primary" type="submit">등록하기</button>
        </div>

    </form>

</div>

</body>
</html>