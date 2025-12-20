<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guitar Guide List</title>

    <style>
        :root{
            --bg:#f6f7fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --line:#e5e7eb;
            --primary:#2563eb;
            --primary-weak:#e8f0ff;
            --danger:#ef4444;
            --shadow:0 8px 24px rgba(15, 23, 42, .08);
            --radius:16px;
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: ui-sans-serif, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, "Apple SD Gothic Neo","Noto Sans KR", sans-serif;
            background:var(--bg);
            color:var(--text);
        }

        .wrap{
            max-width: 1100px;
            margin: 24px auto;
            padding: 0 16px 40px;
        }

        .hero{
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 18px 18px;
            margin: 8px 0 18px;
        }

        .page-head{
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:16px;
            margin: 0;
        }

        .title-box h2{
            margin:0;
            font-size: 26px;
            letter-spacing:-0.3px;
        }
        .title-box p{
            margin:0;
            color:var(--muted);
            font-size:15px;
            line-height:1.6;
        }

        .tabs{
            display:flex;
            gap:10px;
            background: var(--card);
            border:1px solid var(--line);
            border-radius: 999px;
            padding: 6px;
            box-shadow: var(--shadow);
            width: fit-content;
        }
        .tab-btn{
            border:0;
            cursor:pointer;
            padding: 10px 16px;
            border-radius: 999px;
            background: transparent;
            color: var(--muted);
            font-weight: 700;
            transition: .15s;
        }
        .tab-btn:hover{ background:#f3f4f6; color:var(--text); }
        .tab-btn.active{
            background: var(--primary-weak);
            color: var(--primary);
        }

        .card{
            background: var(--card);
            border:1px solid var(--line);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow:hidden;
        }
        .card-head{
            padding: 16px 18px;
            border-bottom:1px solid var(--line);
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            flex-wrap: wrap;
        }
        .card-head h3{
            margin:0;
            font-size: 16px;
            letter-spacing:-0.2px;
        }
        .sub{
            color: var(--muted);
            font-size: 13px;
            margin: 2px 0 0;
        }

        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            padding: 10px 14px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            border:1px solid var(--line);
            background:#fff;
            color: var(--text);
            text-decoration:none;
            transition:.15s;
            white-space: nowrap;
        }
        .btn:hover{ transform: translateY(-1px); }
        .btn-primary{
            background: var(--primary);
            border-color: var(--primary);
            color:#fff;
        }
        .input{
            padding:10px 12px;
            border:1px solid var(--line);
            border-radius:12px;
            outline:none;
            font-weight:700;
            font-size:14px;
            background:#fff;
        }
        .input:focus{
            border-color:#cfe0ff;
            box-shadow: 0 0 0 3px rgba(37,99,235,.12);
        }

        .table-wrap{ overflow:auto; }
        table{
            width:100%;
            border-collapse: collapse;
            min-width: 860px;
        }
        thead th{
            text-align:left;
            font-size: 12px;
            color: var(--muted);
            padding: 12px 16px;
            background: #fafafa;
            border-bottom:1px solid var(--line);
            letter-spacing: .2px;
        }
        tbody td{
            padding: 14px 16px;
            border-bottom:1px solid var(--line);
            vertical-align: middle;
        }
        tbody tr:hover{ background:#fbfdff; }

        .center{ text-align:center; }
        .right{ text-align:right; }

        .badge{
            display:inline-flex;
            align-items:center;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            background:#f3f4f6;
            color:#374151;
        }
        .badge-blue{ background: var(--primary-weak); color: var(--primary); }
        .badge-gray{ background:#f3f4f6; color:#374151; }

        .link-btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            padding: 9px 12px;
            border-radius: 12px;
            border:1px solid #cfe0ff;
            background:#fff;
            color: var(--primary);
            font-weight:800;
            text-decoration:none;
            white-space:nowrap;
            transition:.15s;
        }
        .link-btn:hover{ background: var(--primary-weak); }

        .notice{
            margin-top:12px;
            padding: 12px 14px;
            border-radius: 14px;
            background:#f9fafb;
            border:1px dashed var(--line);
            color: var(--muted);
            font-size: 13px;
        }

        .hidden{ display:none; }

        .pager{
            display:flex;
            gap:8px;
            justify-content:center;
            padding: 14px 18px 18px;
            flex-wrap: wrap;
        }

        @media (max-width: 640px){
            .page-head{ flex-direction:column; align-items:flex-start; }
            table{ min-width: 720px; }
        }
    </style>

    <script>
        function showTab(tabName) {
            document.getElementById("codeListArea").classList.add("hidden");
            document.getElementById("sheetListArea").classList.add("hidden");

            document.getElementById(tabName).classList.remove("hidden");

            document.getElementById("codeBtn").classList.remove("active");
            document.getElementById("sheetBtn").classList.remove("active");

            if (tabName === "codeListArea") {
                document.getElementById("codeBtn").classList.add("active");
            } else {
                document.getElementById("sheetBtn").classList.add("active");
            }
        }
    </script>
</head>

<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="wrap">

    <!-- ====== 기본값 안전 세팅 ====== -->
    <c:if test="${empty codePage}"><c:set var="codePage" value="1"/></c:if>
    <c:if test="${empty codePageSize}"><c:set var="codePageSize" value="10"/></c:if>
    <c:if test="${empty codeTotalPages}"><c:set var="codeTotalPages" value="1"/></c:if>

    <c:if test="${empty sheetPage}"><c:set var="sheetPage" value="1"/></c:if>
    <c:if test="${empty sheetPageSize}"><c:set var="sheetPageSize" value="10"/></c:if>
    <c:if test="${empty sheetTotalPages}"><c:set var="sheetTotalPages" value="1"/></c:if>

    <!-- ====== HERO ====== -->
    <div class="hero">
        <div class="page-head">
            <div class="title-box">
                <p>
                    기타 연습에 필요한 <b>코드 운지</b>와 <b>악보</b>를 한 곳에.<br>
                    찾고, 듣고, 바로 연습하세요.
                </p>
            </div>

            <div class="tabs">
                <button id="codeBtn" class="tab-btn active" onclick="showTab('codeListArea')">코드</button>
                <button id="sheetBtn" class="tab-btn" onclick="showTab('sheetListArea')">악보</button>
            </div>
        </div>
    </div>

    <!-- =========================== -->
    <!-- ▼ 코드 리스트 영역          -->
    <!-- =========================== -->
    <div id="codeListArea">

        <div class="card">
            <div class="card-head">
                <div>
                    <h3>코드 목록</h3>
                    <div class="sub">원하는 코드를 눌러 운지/소리를 확인하세요</div>
                </div>

                <form method="get" action="${pageContext.request.contextPath}/code/list"
                      style="display:flex; gap:10px; align-items:center; flex-wrap:wrap; justify-content:flex-end;">
                    <input class="input" name="q" value="${q}" placeholder="코드명 검색 (예: G, Am)"/>
                    <select class="input" name="sort">
                        <option value="latest"  ${sort=='latest' ? 'selected' : ''}>최신순</option>
                        <option value="nameAsc" ${sort=='nameAsc' ? 'selected' : ''}>이름 A→Z</option>
                        <option value="nameDesc" ${sort=='nameDesc' ? 'selected' : ''}>이름 Z→A</option>
                    </select>

                    <input type="hidden" name="codePage" value="1"/>

                    <button class="btn btn-primary" type="submit">검색</button>

                    <c:if test="${not empty loginUser and loginUser.role eq 'ADMIN'}">
                        <a class="btn" href="${pageContext.request.contextPath}/code/codeWrite">+ 코드 등록</a>
                    </c:if>
                </form>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th style="width:80px" class="center">No</th>
                        <th style="width:140px" class="center">코드명</th>
                        <th>MP3</th>
                        <th style="width:220px" class="center">등록일</th>
                        <th style="width:120px" class="right">보기</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty codeList}">
                        <tr>
                            <td colspan="5" class="center" style="padding:22px; color:#6b7280;">
                                등록된 코드가 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="c" items="${codeList}" varStatus="stC">
                        <tr>
                            <td class="center">${(codePage - 1) * codePageSize + stC.index + 1}</td>

                            <td class="center">
                                <span class="badge badge-blue">${c.codeName}</span>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${empty c.mp3Path}">
                                        <span class="badge badge-gray">없음</span>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="display:flex; align-items:center; gap:10px;">
                                            <span class="badge badge-blue">첨부됨</span>
                                            <audio controls preload="none" style="height:30px; max-width:240px;">
                                                <source src="${c.mp3Path}" type="audio/mp4"/>
                                            </audio>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- ✅ 등록일 포맷 -->
                            <td class="center">
                                <fmt:formatDate value="${c.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>

                            <td class="right">
                                <a class="link-btn" href="${pageContext.request.contextPath}/code/codeView/${c.codeId}">
                                    상세보기 →
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${codeTotalPages > 1}">
                <div class="pager">
                    <c:if test="${codePage > 1}">
                        <a class="link-btn"
                           href="?q=${q}&sort=${sort}&codePage=${codePage-1}&sheetPage=${sheetPage}">
                            이전
                        </a>
                    </c:if>

                    <c:forEach var="p" begin="1" end="${codeTotalPages}">
                        <a class="link-btn"
                           style="${p==codePage ? 'background:#e8f0ff;color:#2563eb;border-color:#2563eb;' : ''}"
                           href="?q=${q}&sort=${sort}&codePage=${p}&sheetPage=${sheetPage}">
                                ${p}
                        </a>
                    </c:forEach>

                    <c:if test="${codePage < codeTotalPages}">
                        <a class="link-btn"
                           href="?q=${q}&sort=${sort}&codePage=${codePage+1}&sheetPage=${sheetPage}">
                            다음
                        </a>
                    </c:if>
                </div>
            </c:if>

            <c:if test="${empty loginUser}">
                <div class="notice">※ 코드 등록은 관리자 로그인 후 이용 가능합니다.</div>
            </c:if>
            <c:if test="${not empty loginUser and loginUser.role ne 'ADMIN'}">
                <div class="notice">※ 코드 등록은 관리자만 가능합니다.</div>
            </c:if>
        </div>
    </div>

    <!-- =========================== -->
    <!-- ▼ 악보 리스트 영역          -->
    <!-- =========================== -->
    <div id="sheetListArea" class="hidden">

        <div class="card">
            <div class="card-head">
                <div>
                    <h3>악보 목록</h3>
                    <div class="sub">곡 정보와 난이도를 확인하고 학습을 시작하세요</div>
                </div>

                <c:if test="${not empty loginUser}">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/sheet/sheetWrite">+ 악보 등록</a>
                </c:if>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th style="width:80px" class="center">No</th>
                        <th>제목</th>
                        <th style="width:120px" class="center">키</th>
                        <th style="width:140px" class="center">난이도</th>
                        <th style="width:220px" class="center">등록일</th>
                        <th style="width:120px" class="right">보기</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty sheetList}">
                        <tr>
                            <td colspan="6" class="center" style="padding:22px; color:#6b7280;">
                                등록된 악보가 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="s" items="${sheetList}" varStatus="stS">
                        <tr>
                            <td class="center">${(sheetPage - 1) * sheetPageSize + stS.index + 1}</td>

                            <td style="font-weight:800;">${s.title}</td>
                            <td class="center"><span class="badge">${s.musicKey}</span></td>
                            <td class="center"><span class="badge badge-blue">${s.difficulty}</span></td>

                            <!-- ✅ 등록일 포맷 -->
                            <td class="center">
                                <fmt:formatDate value="${s.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>

                            <td class="right">
                                <a class="link-btn" href="${pageContext.request.contextPath}/sheet/sheetView/${s.sheetId}">
                                    상세보기 →
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${sheetTotalPages > 1}">
                <div class="pager">
                    <c:if test="${sheetPage > 1}">
                        <a class="link-btn"
                           href="?q=${q}&sort=${sort}&codePage=${codePage}&sheetPage=${sheetPage-1}">
                            이전
                        </a>
                    </c:if>

                    <c:forEach var="p" begin="1" end="${sheetTotalPages}">
                        <a class="link-btn"
                           style="${p==sheetPage ? 'background:#e8f0ff;color:#2563eb;border-color:#2563eb;' : ''}"
                           href="?q=${q}&sort=${sort}&codePage=${codePage}&sheetPage=${p}">
                                ${p}
                        </a>
                    </c:forEach>

                    <c:if test="${sheetPage < sheetTotalPages}">
                        <a class="link-btn"
                           href="?q=${q}&sort=${sort}&codePage=${codePage}&sheetPage=${sheetPage+1}">
                            다음
                        </a>
                    </c:if>
                </div>
            </c:if>

            <c:if test="${empty loginUser}">
                <div class="notice">※ 악보 등록은 로그인한 회원만 가능합니다.</div>
            </c:if>
        </div>
    </div>

</div>
</body>
</html>
