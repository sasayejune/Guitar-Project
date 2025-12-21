package com.hgu.guitar.controller;

import com.hgu.guitar.service.CodeService;
import com.hgu.guitar.service.SheetService;
import com.hgu.guitar.util.FileUtil;
import com.hgu.guitar.vo.CodeVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/code")
public class CodeController {

    @Resource
    private CodeService codeService;

    @Resource
    private SheetService sheetService;

    // ================================
    // 코드 목록 (검색/정렬/페이징)
    // URL: /code/list?q=&sort=&page=
    // ================================
    @GetMapping("/list")
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "latest") String sort,   // latest | nameAsc | nameDesc
            @RequestParam(defaultValue = "1") int page,
            Model model
    ) {
        int size = 10;                 // 한 페이지에 10개
        if (page < 1) page = 1;

        // 전체 개수 (검색 조건 반영)
        int total = codeService.countCodes(q);

        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) total / size);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        // SQL LIMIT/OFFSET 계산
        int offset = (page - 1) * size;

        // ✅ 코드 목록
        model.addAttribute("codeList", codeService.getCodes(q, sort, size, offset));

        // ✅ (중요) 악보 탭도 같이 보여야 하니까 sheetList도 항상 담아줌
        model.addAttribute("sheetList", sheetService.getAllSheets());

        // JSP에서 검색창/정렬/페이지네이션 UI 유지하려고 같이 전달
        model.addAttribute("q", q);
        model.addAttribute("sort", sort);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("total", total);

        return "list";
    }

    // ================================
    // ① 코드 등록 화면
    // ================================
    @GetMapping("/codeWrite")
    public String writeForm() {
        return "code/codeWrite";
    }

    // ================================
    // ② 코드 등록 처리
    // ================================
    @PostMapping("/codeWrite")
    public String write(CodeVO vo,
                        @RequestParam("mp3File") MultipartFile mp3File,
                        HttpServletRequest request) {

        String mp3Path = FileUtil.saveFile(mp3File, request, "code");
        if (mp3Path != null) vo.setMp3Path(mp3Path);

        codeService.insertCode(vo);

        // 등록 후 목록으로
        return "redirect:/code/list";
    }

    // ================================
    // ③ 코드 상세 보기
    // ================================
    @GetMapping("/codeView/{codeId}")
    public String view(@PathVariable Integer codeId, Model model) {
        model.addAttribute("code", codeService.getCodeById(codeId));
        return "code/codeView";
    }

    // ================================
    // ④ 수정 화면
    // ================================
    @GetMapping("/codeEdit/{codeId}")
    public String editForm(@PathVariable Integer codeId, Model model) {
        model.addAttribute("code", codeService.getCodeById(codeId));
        return "code/codeEdit";
    }

    // ================================
    // ⑤ 수정 처리
    // ================================
    @PostMapping("/codeEdit")
    public String edit(CodeVO vo,
                       @RequestParam("mp3File") MultipartFile mp3File,
                       HttpServletRequest request) {

        CodeVO old = codeService.getCodeById(vo.getCodeId());

        if (mp3File != null && !mp3File.isEmpty()) {
            String newPath = FileUtil.saveFile(mp3File, request, "code");
            vo.setMp3Path(newPath);
        } else {
            vo.setMp3Path(old.getMp3Path());
        }

        codeService.updateCode(vo);

        // 수정 후 목록으로
        return "redirect:/code/list";
    }

    // ================================
    // ⑥ 삭제
    // ================================
    @GetMapping("/delete/{codeId}")
    public String delete(@PathVariable Integer codeId) {
        codeService.deleteCode(codeId);

        // 삭제 후 목록으로
        return "redirect:/code/list";
    }
}
