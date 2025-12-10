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

        if (file == null || file.isEmpty()) {
            return null;  // 업로드된 파일 없음
        }

        // 파일 저장 루트 : /resources/upload/{folder}/
        String uploadDir = "/resources/upload/" + folder + "/";

        // 실제 물리적 저장 경로 얻기
        String realPath = request.getServletContext().getRealPath(uploadDir);

        // 저장 폴더가 없으면 생성
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 원본 파일명과 확장자 추출
        String originalName = file.getOriginalFilename();
        String ext = "";
        if (originalName != null && originalName.contains(".")) {
            ext = originalName.substring(originalName.lastIndexOf("."));
        }

        // 새 파일명 생성
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String newFileName = uuid + ext;

        // 실제 파일 저장
        File saveFile = new File(realPath, newFileName);
        try {
            file.transferTo(saveFile);   // 파일 저장 수행
        } catch (IOException e) {
            e.printStackTrace();
        }

        // DB에 저장할 경로 (상대 경로)
        return uploadDir + newFileName;   // 예: /resources/upload/code/abcd1234.mp3
    }
}
