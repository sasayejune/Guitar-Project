<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>

    <style>
        :root{
            --bg:#f6f7fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --line:#e5e7eb;
            --primary:#2563eb;
            --primary-weak:#e8f0ff;
            --shadow:0 8px 24px rgba(15, 23, 42, .08);
            --radius:16px;
        }

        body{
            margin:0;
            font-family: Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
        }

        .wrap{
            max-width: 1100px;
            margin: 0 auto;
            padding: 22px 16px 40px;
        }

        .title-row{
            display:flex;
            align-items:flex-end;
            justify-content: space-between;
            gap: 12px;
            margin: 10px 0 14px;
        }

        .title{
            margin:0;
            font-size: 28px;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        .subtitle{
            margin: 6px 0 0;
            color: var(--muted);
            font-weight: 700;
        }

        .card{
            background: var(--card);
            border: 1px solid rgba(229,231,235,.9);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 18px;
        }

        .info{
            display:flex;
            align-items:center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .pill{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding: 10px 12px;
            border-radius: 999px;
            background: rgba(255,255,255,.92);
            border: 1px solid rgba(229,231,235,.9);
            color: var(--muted);
            font-weight: 800;
        }

        .pill b{ color: var(--text); }

        .badge-admin{
            color: var(--primary);
            background: var(--primary-weak);
            border: 1px solid #cfe0ff;
            padding: 2px 10px;
            border-radius: 999px;
            font-weight: 900;
        }

        .grid{
            display:grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
            margin-top: 16px;
        }

        /* ✅ 통계 카드 */
        .stats{
            display:grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
            margin-top: 14px;
            margin-bottom: 14px;
        }

        .stat{
            background: #fff;
            border: 1px solid rgba(229,231,235,.9);
            border-radius: 14px;
            padding: 14px;
            box-shadow: 0 6px 18px rgba(15,23,42,.04);
        }

        .stat .label{
            color: var(--muted);
            font-weight: 800;
            font-size: 13px;
        }

        .stat .value{
            margin-top: 8px;
            font-size: 26px;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        .stat .sub{
            margin-top: 6px;
            color: var(--muted);
            font-weight: 700;
            font-size: 12px;
        }

        @media (max-width: 900px){
            .stats{ grid-template-columns: 1fr; }
        }



        .action{
            border: 1px solid rgba(229,231,235,.9);
            border-radius: 14px;
            padding: 14px;
            background: #fff;
            transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease;
        }
        .action:hover{
            transform: translateY(-1px);
            border-color: #dbe3f3;
            box-shadow: 0 10px 28px rgba(15,23,42,.10);
        }

        .action h3{
            margin: 0 0 6px;
            font-size: 16px;
            font-weight: 900;
        }
        .action p{
            margin:0 0 12px;
            color: var(--muted);
            font-weight: 700;
            font-size: 13px;
            line-height: 1.4;
        }

        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            text-decoration:none;
            font-weight: 900;
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid var(--line);
            background:#fff;
            color: var(--text);
            width: 100%;
            box-sizing: border-box;
        }
        .btn:hover{ border-color:#dbe3f3; }

        .btn-primary{
            background: var(--primary);
            border-color: var(--primary);
            color:#fff;
        }

        .hint{
            margin-top: 14px;
            color: var(--muted);
            font-weight: 700;
            font-size: 13px;
        }

        @media (max-width: 900px){
            .grid{ grid-template-columns: 1fr; }
            .title{ font-size: 24px; }
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="wrap">
    <div class="title-row">
        <div>
            <h1 class="title">🛠 관리자 페이지 <span class="badge-admin">ADMIN 전용</span></h1>
            <div class="subtitle">운영/관리 기능은 관리자 계정만 접근 가능합니다.</div>
        </div>
    </div>

    <div class="card">
        <div class="info">
            <div class="pill">현재 권한: <b><c:out value="${sessionScope.role}"/></b></div>
            <c:if test="${not empty sessionScope.loginUser}">
                <div class="pill">사용자ID: <b><c:out value="${sessionScope.loginUser.userid}"/></b></div>
            </c:if>
        </div>

        <div class="stats">
            <div class="stat">
                <div class="label">총 코드 수</div>
                <div class="value">${empty codeCount ? 0 : codeCount}</div>
                <div class="sub">등록된 코드(Chord) 개수</div>
            </div>

            <div class="stat">
                <div class="label">총 악보 수</div>
                <div class="value">${empty sheetCount ? 0 : sheetCount}</div>
                <div class="sub">등록된 악보(Sheet) 개수</div>
            </div>

            <div class="stat">
                <div class="label">현재 로그인</div>
                <div class="value"><c:out value="${sessionScope.loginUser.userid}"/></div>
                <div class="sub">관리자 계정으로 접속 중</div>
            </div>
        </div>




        <div class="grid">
            <div class="action">
                <h3>🎸 코드 등록</h3>
                <p>새로운 코드를 등록하고 운지 좌표를 설정합니다.</p>
                <a class="btn" href="${pageContext.request.contextPath}/code/codeWrite">코드 등록 바로가기</a>
            </div>

            <div class="action">
                <h3>📋 메인 목록</h3>
                <p>서비스 메인 목록(코드 목록)으로 이동합니다.</p>
                <a class="btn" href="${pageContext.request.contextPath}/list">메인 목록 바로가기</a>
            </div>

            <div class="action">
                <h3>🎼 악보 관리(등록)</h3>
                <p>악보(곡) 정보를 등록합니다.</p>
                <a class="btn" href="${pageContext.request.contextPath}/sheet/sheetWrite">악보 등록 바로가기</a>
            </div>
        </div>

        <div class="hint">
            ※ 이 페이지는 ADMIN만 허용하도록 설정되어 있습니다.
        </div>
    </div>
</div>

</body>
</html>
