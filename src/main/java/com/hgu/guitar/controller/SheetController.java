package com.hgu.guitar.controller;

import com.hgu.guitar.service.SheetService;
import com.hgu.guitar.service.CodeService;
import com.hgu.guitar.util.FileUtil;
import com.hgu.guitar.vo.SheetVO;
import com.hgu.guitar.vo.CodeVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/sheet")
public class SheetController {

    @Resource
    private SheetService sheetService;

    @Resource
    private CodeService codeService;

    // ======================
    // 등록 화면
    // ======================
    @GetMapping("/sheetWrite")
    public String writeForm(Model model) {
        model.addAttribute("codeList", codeService.getAllCodes());
        return "sheet/sheetWrite";
    }

    // ======================
    // 등록 처리
    // ======================
    @PostMapping("/sheetWrite")
    public String write(SheetVO vo,
                        @RequestParam("sheetFileUpload") MultipartFile file,
                        @RequestParam(value = "codeIds", required = false) List<Integer> codeIds,
                        HttpServletRequest request) {

        vo.setSheetFile(FileUtil.saveFile(file, request, "sheet"));

        // 👉 대표 코드 1개만 저장 (첫 번째)
        if (codeIds != null && !codeIds.isEmpty()) {
            vo.setCodeId(codeIds.get(0));
        }

        sheetService.insertSheet(vo);
        return "redirect:/list";
    }

    // ======================
    // 상세 보기 ⭐⭐⭐ (404 원인 해결)
    // ======================
    @GetMapping("/sheetView/{sheetId}")
    public String view(@PathVariable Integer sheetId, Model model) {

        SheetVO sheet = sheetService.getSheetById(sheetId);
        model.addAttribute("sheet", sheet);

        List<CodeVO> linkedCodes = new ArrayList<>();

        if (sheet.getCodeId() != null) {
            CodeVO code = codeService.getCodeById(sheet.getCodeId());
            if (code != null) {
                linkedCodes.add(code);
            }
        }

        model.addAttribute("linkedCodes", linkedCodes);

        return "sheet/sheetView";
    }

    // ======================
    // 수정 화면
    // ======================
    @GetMapping("/sheetEdit/{sheetId}")
    public String editForm(@PathVariable Integer sheetId, Model model) {

        SheetVO sheet = sheetService.getSheetById(sheetId);
        model.addAttribute("sheet", sheet);

        List<CodeVO> codeList = codeService.getAllCodes();
        model.addAttribute("codeList", codeList);

        // ⭐ 선택된 codeId (단일)
        Integer selectedCodeId = sheet.getCodeId();
        model.addAttribute("selectedCodeId", selectedCodeId);

        return "sheet/sheetEdit";
    }



    // ======================
    // 수정 처리
    // ======================
    @PostMapping("/sheetEdit")
    public String edit(SheetVO vo,
                       @RequestParam("sheetFileUpload") MultipartFile file,
                       @RequestParam(value = "codeIds", required = false) List<Integer> codeIds,
                       HttpServletRequest request) {

        SheetVO old = sheetService.getSheetById(vo.getSheetId());

        if (file != null && !file.isEmpty()) {
            vo.setSheetFile(FileUtil.saveFile(file, request, "sheet"));
        } else {
            vo.setSheetFile(old.getSheetFile());
        }

        // 대표 코드 하나만 저장
        if (codeIds != null && !codeIds.isEmpty()) {
            vo.setCodeId(codeIds.get(0));
        } else {
            vo.setCodeId(null);
        }

        sheetService.updateSheet(vo);
        return "redirect:/list";
    }

    // ======================
    // 삭제
    // ======================
    @GetMapping("/delete/{sheetId}")
    public String delete(@PathVariable Integer sheetId) {
        sheetService.deleteSheet(sheetId);
        return "redirect:/list";
    }
}
