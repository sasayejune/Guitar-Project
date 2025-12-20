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

import javax.servlet.http.HttpSession;
import com.hgu.guitar.vo.UserVO;


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


        UserVO loginUser = (UserVO) request.getSession().getAttribute("loginUser");
        if (loginUser != null) {
            vo.setWriterUserid(loginUser.getUserid());
        }

        sheetService.insertSheet(vo);
        return "redirect:/list";
    }

    // ======================
    // 상세 보기
    // ======================
    @GetMapping("/sheetView/{sheetId}")
    public String view(@PathVariable Integer sheetId, Model model, HttpSession session) {

        SheetVO sheet = sheetService.getSheetById(sheetId);
        model.addAttribute("sheet", sheet);

        List<CodeVO> linkedCodes = new ArrayList<>();

        if (sheet != null && sheet.getCodeIds() != null) {
            for (Integer codeId : sheet.getCodeIds()) {
                CodeVO code = codeService.getCodeById(codeId);
                if (code != null) {
                    linkedCodes.add(code);
                }
            }
        }

        model.addAttribute("linkedCodes", linkedCodes);

        // ✅ ADMIN or 작성자면 수정/삭제 가능
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boolean isAdmin = (loginUser != null && "ADMIN".equals(loginUser.getRole()));
        boolean isOwner = (loginUser != null && sheet != null
                && loginUser.getUserid().equals(sheet.getWriterUserid()));
        boolean canEdit = isAdmin || isOwner;

        model.addAttribute("canEdit", canEdit);

        return "sheet/sheetView";
    }

    // ======================
    // 수정 화면
    // ======================
    @GetMapping("/sheetEdit/{sheetId}")
    public String editForm(@PathVariable Integer sheetId, Model model, HttpSession session) {

        // ✅ 권한 체크 (URL 직접 접근 차단)
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boolean isAdmin = (loginUser != null && "ADMIN".equals(loginUser.getRole()));

        SheetVO sheet = sheetService.getSheetById(sheetId);
        boolean isOwner = (loginUser != null && sheet != null
                && loginUser.getUserid().equals(sheet.getWriterUserid()));

        if (!(isAdmin || isOwner)) return "redirect:/list";

        model.addAttribute("sheet", sheet);

        model.addAttribute("codeList", codeService.getAllCodes());

        // ✅ 다중 선택용
        model.addAttribute("selectedCodeIds",
                (sheet != null && sheet.getCodeIds() != null) ? sheet.getCodeIds() : Collections.emptyList());

        return "sheet/sheetEdit";
    }

    // ======================
    // 수정 처리
    // ======================
    @PostMapping("/sheetEdit")
    public String edit(SheetVO vo,
                       @RequestParam("sheetFileUpload") MultipartFile file,
                       @RequestParam(value = "codeIds", required = false) List<Integer> codeIds,
                       HttpServletRequest request,
                       HttpSession session) {

        // ✅ 권한 체크 (URL 직접 접근 차단)
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boolean isAdmin = (loginUser != null && "ADMIN".equals(loginUser.getRole()));

        SheetVO old = sheetService.getSheetById(vo.getSheetId());
        boolean isOwner = (loginUser != null && old != null
                && loginUser.getUserid().equals(old.getWriterUserid()));

        if (!(isAdmin || isOwner)) return "redirect:/list";

        if (file != null && !file.isEmpty()) {
            vo.setSheetFile(FileUtil.saveFile(file, request, "sheet"));
        } else {
            vo.setSheetFile(old != null ? old.getSheetFile() : null);
        }

        vo.setCodeIds(codeIds); // ✅ 여러 코드 그대로

        // ✅ 작성자 변경 방지(기존 작성자 유지)
        if (old != null) {
            vo.setWriterUserid(old.getWriterUserid());
        }

        sheetService.updateSheet(vo);
        return "redirect:/list";
    }

    // ======================
    // 삭제
    // ======================
    @GetMapping("/delete/{sheetId}")
    public String delete(@PathVariable Integer sheetId, HttpSession session) {

        // ✅ 권한 체크 (URL 직접 접근 차단)
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boolean isAdmin = (loginUser != null && "ADMIN".equals(loginUser.getRole()));

        SheetVO sheet = sheetService.getSheetById(sheetId);
        boolean isOwner = (loginUser != null && sheet != null
                && loginUser.getUserid().equals(sheet.getWriterUserid()));

        if (!(isAdmin || isOwner)) return "redirect:/list";

        sheetService.deleteSheet(sheetId);
        return "redirect:/list";
    }
}
