package com.hgu.guitar.interceptor;

import com.hgu.guitar.vo.UserVO;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String ctx = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(ctx.length()); // 예: /code/codeWrite

        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
        String role = (session == null) ? null : (String) session.getAttribute("role");

        // 허용
        if (path.startsWith("/login/")
                || path.equals("/login")
                || path.startsWith("/resources/")
                || path.startsWith("/resources")
                || path.startsWith("/upload/")
        ) {
            return true;
        }

        //  홈/목록은 비회원 허용 명시해두면 더 안전
        if (path.equals("/") || path.startsWith("/list")) {
            return true;
        }

        // 1) ADMIN 전용 (관리자 페이지 + 코드 등록/관리)
        boolean adminOnly =
                path.startsWith("/admin")
                        || path.startsWith("/code/codeWrite")
                        || path.startsWith("/code/codeEdit")
                        || path.startsWith("/code/codeDelete");

        if (adminOnly) {
            // 비로그인
            if (loginUser == null) {
                response.sendRedirect(ctx + "/login/login");
                return false;
            }

            // 로그인했지만 ADMIN 아님
            if (!"ADMIN".equals(role)) {
                response.sendRedirect(ctx + "/list"); // 권한 없으면 목록으로
                return false;
            }

            return true;
        }

        // 2) 로그인(USER/ADMIN) 필요한 기능 (악보 등록/수정/삭제, 게시글 write/edit/delete도 여기)
        boolean loginRequired =
                path.startsWith("/sheet/sheetWrite")
                        || path.startsWith("/sheet/sheetEdit")
                        || path.startsWith("/sheet/delete");

        if (loginRequired) {
            if (loginUser == null) {
                response.sendRedirect(ctx + "/login/login");
                return false;
            }
            return true;
        }

        // 3) 나머지는 모두 허용 (목록/조회 등)
        return true;
    }
}