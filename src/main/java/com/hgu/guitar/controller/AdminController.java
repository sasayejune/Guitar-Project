package com.hgu.guitar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("")
    public String adminHome() {
        // /admin 으로 들어오면 관리자 홈으로
        return "admin/index"; // /WEB-INF/views/admin/index.jsp
    }

    @GetMapping("/")
    public String adminHomeSlash() {
        return "redirect:/admin";
    }
}