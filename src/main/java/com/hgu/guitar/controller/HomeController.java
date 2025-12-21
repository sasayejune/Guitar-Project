package com.hgu.guitar.controller;

import com.hgu.guitar.service.CodeService;
import com.hgu.guitar.service.SheetService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;

@Controller
public class HomeController {

    @Resource
    private CodeService codeService;

    @Resource
    private SheetService sheetService;

    @GetMapping("/list")
    public String listPage(Model model) {

        model.addAttribute("codeList", codeService.getAllCodes());
        model.addAttribute("sheetList", sheetService.getAllSheets());

        return "list";  // /WEB-INF/views/list.jsp
    }
}
