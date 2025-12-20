<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

    /* 헤더 바 (sticky) */
    .topbar{
        position: sticky;
        top: 0;
        z-index: 999;
        background: rgba(246,247,251,.85);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(229,231,235,.8);
    }

    .header{
        max-width: 1100px;
        margin: 0 auto;
        padding: 12px 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
    }

    /* 왼쪽: 로고 + 메뉴 */
    .menu{
        display:flex;
        align-items:center;
        gap: 14px;
        flex-wrap: wrap;
    }

    .logo{
        display:inline-flex;
        align-items:center;
        gap:10px;
        font-size: 18px;
        font-weight: 900;
        letter-spacing: -0.2px;
        color: var(--text);
        text-decoration: none;

        padding: 10px 12px;
        border-radius: 12px;
        background: rgba(255,255,255,.92);
        border: 1px solid rgba(229,231,235,.9);
        box-shadow: var(--shadow);

        transition: transform .12s ease, background .12s ease, box-shadow .12s ease; /* ✅ 여기로 이동 */
    }
    .logo:hover{
        transform: translateY(-1px);
        background: #fff;
    }

    .navlink{
        text-decoration:none;
        color: var(--muted);
        font-weight: 800;
        padding: 10px 12px;
        border-radius: 12px;
        border: 1px solid transparent;
        transition: .12s;
    }
    .navlink:hover{
        background: #fff;
        color: var(--text);
        border-color: var(--line);
        box-shadow: 0 6px 18px rgba(15,23,42,.06);
    }

    .admin-badge{
        color: var(--primary);
        background: var(--primary-weak);
        border: 1px solid #cfe0ff;
    }

    /* 오른쪽: 인증 영역 */
    .auth{
        display:flex;
        align-items:center;
        gap: 10px;
        font-size: 14px;
        flex-wrap: wrap;
        justify-content: flex-end;
    }

    .who{
        color: var(--muted);
        font-weight: 800;
        padding: 8px 10px;
        border-radius: 999px;
        background: rgba(255,255,255,.92);
        border: 1px solid rgba(229,231,235,.9);
    }

    .btn-link{
        text-decoration:none;
        font-weight: 900;
        padding: 10px 12px;
        border-radius: 12px;
        border: 1px solid var(--line);
        background:#fff;
        color: var(--text);
        transition: transform .12s ease, background .12s ease, border-color .12s ease;
    }
    .btn-link:hover{
        transform: translateY(-1px);
        background: #fff;
        border-color: #dbe3f3;
    }

    .btn-ghost{
        background: transparent;
    }
    .btn-ghost:hover{
        background: #fff;
    }

    .btn-primary{
        background: var(--primary);
        border-color: var(--primary);
        color:#fff;
    }
    .btn-primary:hover{
        filter: brightness(0.98);
    }

    @media (max-width: 640px){
        .header{ padding: 10px 12px; }
        .logo{ font-size: 16px; }
    }
</style>

<div class="topbar">
    <div class="header">

        <!-- 왼쪽 -->
        <div class="menu">
            <a href="${pageContext.request.contextPath}/list" class="logo">
                🎸 <span>Guitar Guide</span>
            </a>

            <!-- ADMIN 전용 -->
            <c:if test="${not empty loginUser and loginUser.role eq 'ADMIN'}">
                <a class="navlink admin-badge" href="${pageContext.request.contextPath}/admin">관리자</a>
            </c:if>
        </div>

        <!-- 오른쪽 -->
        <div class="auth">
            <!-- 비회원 -->
            <c:if test="${empty loginUser}">
                <span class="who">비회원</span>
                <a class="btn-link btn-ghost" href="${pageContext.request.contextPath}/login/login">로그인</a>
                <a class="btn-link btn-primary" href="${pageContext.request.contextPath}/login/signup">회원가입</a>
            </c:if>

            <!-- 로그인 사용자 -->
            <c:if test="${not empty loginUser}">
                <span class="who">
                    <c:choose>
                        <c:when test="${not empty loginUser.username}">
                            <c:out value="${loginUser.username}"/>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${loginUser.userid}"/>
                        </c:otherwise>
                    </c:choose>
                    님 환영합니다
                    <c:if test="${loginUser.role eq 'ADMIN'}">
                        · <span style="color:#2563eb; font-weight:900;">관리자</span>
                    </c:if>
                </span>

                <a class="btn-link" href="${pageContext.request.contextPath}/login/logout">로그아웃</a>
            </c:if>
        </div>

    </div>
</div>
