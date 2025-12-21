package com.hgu.guitar.controller;

import com.hgu.guitar.service.CodeService;
import com.hgu.guitar.service.SheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CodeService codeService;

    @Autowired
    private SheetService sheetService;

    @GetMapping("")
    public String adminHome(Model model) {

        //  통계용 데이터
        int codeCount = codeService.countCodes("");
        int sheetCount = sheetService.countSheets();

        //  JSP로 전달
        model.addAttribute("codeCount", codeCount);
        model.addAttribute("sheetCount", sheetCount);

        return "admin/index"; // /WEB-INF/views/admin/index.jsp
    }

    @GetMapping("/")
    public String adminHomeSlash() {
        return "redirect:/admin";
    }
}
