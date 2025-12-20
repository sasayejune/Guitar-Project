package com.hgu.guitar.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class FileUtil {

    /**
     * 파일 업로드 처리
     *
     * @param file 업로드할 파일
     * @param request HttpServletRequest (실제 경로 얻기 위함)
     * @param folder 업로드 폴더 이름 ("code", "sheet")
     * @return 저장된 파일의 상대경로 (DB에 저장)
     */
    public static String saveFile(MultipartFile file,
                                  HttpServletRequest request,
                                  String folder) {

        if (file == null || file.isEmpty()) return null;

        // ✅ 외부 업로드 루트 (시스템 프로퍼티로 받기)
        // 예: -Dupload.root=/Users/gimgiu/guitar_upload
        String uploadRoot = System.getProperty("upload.root");

        // 프로퍼티 없으면(로컬 급한 경우) user.home 아래로 기본 설정
        if (uploadRoot == null || uploadRoot.trim().isEmpty()) {
            uploadRoot = System.getProperty("user.home") + "/guitar_upload";
        }


        String realPath = uploadRoot + "/" + folder + "/";

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        String originalName = file.getOriginalFilename();
        String ext = "";
        if (originalName != null && originalName.contains(".")) {
            ext = originalName.substring(originalName.lastIndexOf("."));
        }

        String uuid = UUID.randomUUID().toString().replace("-", "");
        String newFileName = uuid + ext;

        File saveFile = new File(realPath, newFileName);
        try {
            file.transferTo(saveFile);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // ✅ DB에는 "접근 URL" 저장 (/upload/ 아래)
        return "/upload/" + folder + "/" + newFileName;
    }

}
