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
        vo.setCodeIds(codeIds); // ✅ 여러 코드 그대로 전달

        sheetService.insertSheet(vo);
        return "redirect:/list";
    }

    // ======================
    // 상세 보기
    // ======================
    @GetMapping("/sheetView/{sheetId}")
    public String view(@PathVariable Integer sheetId, Model model) {

        SheetVO sheet = sheetService.getSheetById(sheetId);
        model.addAttribute("sheet", sheet);

        List<CodeVO> linkedCodes = new ArrayList<>();

        if (sheet.getCodeIds() != null) {
            for (Integer codeId : sheet.getCodeIds()) {
                CodeVO code = codeService.getCodeById(codeId);
                if (code != null) {
                    linkedCodes.add(code);
                }
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

        model.addAttribute("codeList", codeService.getAllCodes());

        // ✅ 다중 선택용
        model.addAttribute("selectedCodeIds",
                sheet.getCodeIds() != null ? sheet.getCodeIds() : Collections.emptyList());

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

        vo.setCodeIds(codeIds); // ✅ 여러 코드 그대로

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
