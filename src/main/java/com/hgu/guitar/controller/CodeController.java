package com.hgu.guitar.controller;

import com.hgu.guitar.service.CodeService;
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

        // MP3 파일 저장
        String mp3Path = FileUtil.saveFile(mp3File, request, "code");

        if (mp3Path != null) {
            vo.setMp3Path(mp3Path);
        }

        // DB 저장
        codeService.insertCode(vo);

        return "redirect:/list";
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

        // 기존 코드 DB 값 가져오기
        CodeVO old = codeService.getCodeById(vo.getCodeId());

        // 새 파일이 있으면 교체
        if (mp3File != null && !mp3File.isEmpty()) {
            String newPath = FileUtil.saveFile(mp3File, request, "code");
            vo.setMp3Path(newPath);
        } else {
            // 새 파일이 없으면 기존 파일 유지
            vo.setMp3Path(old.getMp3Path());
        }

        codeService.updateCode(vo);

        return "redirect:/list";
    }

    // ================================
    // ⑥ 삭제
    // ================================
    @GetMapping("/delete/{codeId}")
    public String delete(@PathVariable Integer codeId) {
        codeService.deleteCode(codeId);
        return "redirect:/list";
    }
}
