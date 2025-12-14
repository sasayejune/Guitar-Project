package com.hgu.guitar.controller;

import com.hgu.guitar.service.UserService;
import com.hgu.guitar.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private UserService userService; // 아직 없으면 다음 단계에서 만들면 됨

    // 1) 로그인 폼
    @GetMapping("/login")
    public String loginForm() {
        return "login/login"; // /WEB-INF/views/login/login.jsp
    }

    // 2) 로그인 처리
    @PostMapping("/loginOk")
    public String loginOk(@RequestParam("userid") String userid,
                          @RequestParam("password") String password,
                          HttpSession session,
                          Model model) {

        UserVO param = new UserVO();
        param.setUserid(userid);
        param.setPassword(password);

        UserVO loginUser = userService.login(param);

        if (loginUser != null) {
            // 비번은 세션에 들고 있을 필요 없음(보안/깔끔)
            loginUser.setPassword(null);

            session.setAttribute("loginUser", loginUser);
            session.setAttribute("role", loginUser.getRole()); // ADMIN/USER 판단용(선택)

            return "redirect:/list"; // 원하는 기본 페이지로
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login/login";
        }
    }

    // 3) 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/list";
    }

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm() {
        return "login/signup";
    }

    // 회원가입 처리
    @PostMapping("/signupOk")
    public String signupOk(@RequestParam("userid") String userid,
                           @RequestParam("username") String username,
                           @RequestParam("password") String password,
                           Model model) {

        UserVO u = new UserVO();
        u.setUserid(userid);
        u.setUsername(username);
        u.setPassword(password);

        int result = userService.signup(u);

        if (result == 1) {
            return "redirect:/login/login";
        } else {
            model.addAttribute("error", "이미 존재하는 아이디입니다.");
            return "login/signup";
        }
    }



}