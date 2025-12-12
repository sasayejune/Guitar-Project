package com.hgu.guitar.controller;

import com.hgu.guitar.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class TestAuthController {

    // 0) 아무나 접근 가능한 페이지
    @GetMapping("/test/public")
    @ResponseBody
    public String publicPage() {
        return "PUBLIC OK";
    }

    // 1) USER 세션 강제 주입
    @GetMapping("/test/set-user")
    @ResponseBody
    public String setUser(HttpSession session) {
        UserVO u = new UserVO();
        u.setUserid("user1");
        u.setRole("USER");

        session.setAttribute("loginUser", u);
        session.setAttribute("role", "USER");

        return "SESSION SET: USER";
    }

    // 2) ADMIN 세션 강제 주입
    @GetMapping("/test/set-admin")
    @ResponseBody
    public String setAdmin(HttpSession session) {
        UserVO u = new UserVO();
        u.setUserid("admin");
        u.setRole("ADMIN");

        session.setAttribute("loginUser", u);
        session.setAttribute("role", "ADMIN");

        return "SESSION SET: ADMIN";
    }

    // 3) 세션 초기화
    @GetMapping("/test/clear")
    @ResponseBody
    public String clear(HttpSession session) {
        session.invalidate();
        return "SESSION CLEARED";
    }

    // 4) 관리자 전용 URL (인터셉터가 막아야 함)
    @GetMapping("/admin/test")
    @ResponseBody
    public String adminOnly() {
        return "ADMIN PAGE OK";
    }
}
