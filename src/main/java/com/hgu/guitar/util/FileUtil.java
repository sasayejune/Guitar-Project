package com.hgu.guitar.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class FileUtil {

    /**
     * 업로드 파일을 webapp/upload/{folder} 아래에 저장한다.
     *
     * folder 예시:
     * - "code"  (mp3)
     * - "sheet" (jpg/png/pdf)
     *
     * DB에는 "/upload/{folder}/{filename}" 형태로 저장해두고,
     * JSP에서는 ${pageContext.request.contextPath}${dbValue} 로 붙여서 사용한다.
     */
    public static String saveFile(MultipartFile file,
                                  HttpServletRequest request,
                                  String folder) {

        if (file == null || file.isEmpty()) return null;
        if (request == null) throw new IllegalArgumentException("request is null");
        if (folder == null || folder.trim().isEmpty()) {
            throw new IllegalArgumentException("folder is null/empty");
        }

        // ✅ webapp 기준 실제 저장 경로 (Tomcat이 배포한 폴더 안)
        String relativeDir = "/upload/" + folder; // webapp 아래 경로
        String realPath = request.getServletContext().getRealPath(relativeDir);

        // realPath가 null이면 서버 환경/배포 방식 문제일 수 있음
        if (realPath == null) {
            throw new RuntimeException("realPath is null for: " + relativeDir
                    + " (WAR 배포/서버 설정을 확인하세요)");
        }

        // ✅ 폴더 없으면 생성
        File dir = new File(realPath);
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            if (!created) {
                throw new RuntimeException("Failed to create upload directory: " + realPath);
            }
        }

        // ✅ 확장자 추출
        String originalName = file.getOriginalFilename();
        String ext = "";
        if (originalName != null) {
            int dot = originalName.lastIndexOf('.');
            if (dot >= 0) ext = originalName.substring(dot);
        }

        // ✅ 파일명 UUID로 저장
        String newFileName = UUID.randomUUID().toString().replace("-", "") + ext;

        // ✅ 저장
        File saveFile = new File(dir, newFileName);
        try {
            file.transferTo(saveFile);
        } catch (IOException e) {
            throw new RuntimeException("File save failed: " + saveFile.getAbsolutePath(), e);
        }

        // ✅ DB에는 접근 경로 저장 (contextPath와 결합해서 사용)
        return "/upload/" + folder + "/" + newFileName;
    }

    /**
     * (선택) 서버 시작 전에 upload 폴더들을 미리 만들어두고 싶을 때 사용 가능
     * 컨트롤러에서 한 번 호출해도 됨.
     */
    public static void ensureUploadDirs(HttpServletRequest request) {
        ensureDir(request, "/upload");
        ensureDir(request, "/upload/code");
        ensureDir(request, "/upload/sheet");
    }

    private static void ensureDir(HttpServletRequest request, String relativePath) {
        String realPath = request.getServletContext().getRealPath(relativePath);
        if (realPath == null) return;

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();
    }
}
