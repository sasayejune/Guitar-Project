package com.hgu.guitar.controller;

import com.hgu.guitar.service.SheetService;
import com.hgu.guitar.service.CodeService;
import com.hgu.guitar.util.FileUtil;
import com.hgu.guitar.vo.SheetVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/sheet")
public class SheetController {

    @Resource
    private SheetService sheetService;

    @Resource
    private CodeService codeService;

    // ================================
    // ① 악보 등록 화면
    // ================================
    @GetMapping("/sheetWrite")
    public String writeForm(Model model) {

        // 코드 선택용
        model.addAttribute("codeList", codeService.getAllCodes());

        return "sheet/sheetWrite";
    }

    // ================================
    // ② 악보 등록 처리
    // ================================
    @PostMapping("/sheetWrite")
    public String write(SheetVO vo,
                        @RequestParam("sheetFileUpload") MultipartFile sheetFileUpload,
                        HttpServletRequest request) {

        // 파일 저장
        String sheetPath = FileUtil.saveFile(sheetFileUpload, request, "sheet");

        if (sheetPath != null) {
            vo.setSheetFile(sheetPath); // DB 경로 저장
        }

        sheetService.insertSheet(vo);

        return "redirect:/list";
    }

    // ================================
    // ③ 상세 보기
    // ================================
    @GetMapping("/sheetView/{sheetId}")
    public String view(@PathVariable Integer sheetId, Model model) {

        SheetVO sheet = sheetService.getSheetById(sheetId);

        model.addAttribute("sheet", sheet);

        return "sheet/sheetView";
    }

    // ================================
    // ④ 수정 화면
    // ================================
    @GetMapping("/sheetEdit/{sheetId}")
    public String editForm(@PathVariable Integer sheetId, Model model) {

        model.addAttribute("sheet", sheetService.getSheetById(sheetId));
        model.addAttribute("codeList", codeService.getAllCodes());

        return "sheet/sheetEdit";
    }

    // ================================
    // ⑤ 수정 처리
    // ================================
    @PostMapping("/sheetEdit")
    public String edit(SheetVO vo,
                       @RequestParam("sheetFileUpload") MultipartFile sheetFileUpload,
                       HttpServletRequest request) {

        // 기존 DB에서 파일 정보 가져오기
        SheetVO old = sheetService.getSheetById(vo.getSheetId());

        // 새 파일 업로드 했는가?
        if (sheetFileUpload != null && !sheetFileUpload.isEmpty()) {

            String newPath = FileUtil.saveFile(sheetFileUpload, request, "sheet");
            vo.setSheetFile(newPath);

        } else {
            // 새 파일 없으면 기존 파일 유지
            vo.setSheetFile(old.getSheetFile());
        }

        // DB 업데이트
        sheetService.updateSheet(vo);

        return "redirect:/list";
    }

    // ================================
    // ⑥ 삭제
    // ================================
    @GetMapping("/delete/{sheetId}")
    public String delete(@PathVariable Integer sheetId) {
        sheetService.deleteSheet(sheetId);
        return "redirect:/list";
    }
}
