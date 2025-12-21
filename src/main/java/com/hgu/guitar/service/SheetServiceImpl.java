package com.hgu.guitar.service;

import com.hgu.guitar.dao.SheetCodeMapper;
import com.hgu.guitar.dao.SheetMapper;
import com.hgu.guitar.vo.SheetVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service("sheetService")
public class SheetServiceImpl implements SheetService {

    @Resource
    private SheetMapper sheetMapper;

    @Resource
    private SheetCodeMapper sheetCodeMapper;

    // ======================
    // 전체 목록
    // ======================
    @Override
    public List<SheetVO> getAllSheets() {
        return sheetMapper.getAllSheets();
    }

    // ======================
    // 단건 조회 (⭐ 핵심)
    // ======================
    @Override
    public SheetVO getSheetById(Integer sheetId) {

        SheetVO sheet = sheetMapper.getSheetById(sheetId);
        if (sheet == null) return null; // ✅ NPE 방지

        // ⭐ N:M 코드 연결 조회
        List<Integer> codeIds = sheetCodeMapper.getCodeIdsBySheetId(sheetId);

        // ✅ null 방지 (JSP에서 contains/forEach 안전)
        sheet.setCodeIds(codeIds != null ? codeIds : Collections.emptyList());

        return sheet;
    }

    // ======================
    // 등록 (⭐ 핵심)
    // ======================
    @Override
    @Transactional
    public void insertSheet(SheetVO sheet) {

        // 1. 악보 저장
        sheetMapper.insertSheet(sheet);

        // ✅ sheetId가 생성되어 있어야 매핑 insert 가능
        // (SheetMapper.xml insert에 useGeneratedKeys/keyProperty 설정 필수)

        // 2. 코드 연결 저장
        if (sheet.getCodeIds() != null) {
            for (Integer codeId : sheet.getCodeIds()) {
                if (codeId == null) continue; // ✅ 방어적 처리
                sheetCodeMapper.insertSheetCode(sheet.getSheetId(), codeId);
            }
        }
    }

    // ======================
    // 수정 (⭐ 핵심)
    // ======================
    @Override
    @Transactional
    public void updateSheet(SheetVO sheet) {

        // 1. 악보 수정
        sheetMapper.updateSheet(sheet);

        // 2. 기존 코드 연결 전부 삭제
        sheetCodeMapper.deleteBySheetId(sheet.getSheetId());

        // 3. 새 코드 연결 삽입
        if (sheet.getCodeIds() != null) {
            for (Integer codeId : sheet.getCodeIds()) {
                if (codeId == null) continue; // ✅ 방어적 처리
                sheetCodeMapper.insertSheetCode(sheet.getSheetId(), codeId);
            }
        }
    }

    // ======================
    // 삭제
    // ======================
    @Override
    @Transactional
    public void deleteSheet(Integer sheetId) {

        // 코드 연결 먼저 삭제
        sheetCodeMapper.deleteBySheetId(sheetId);

        // 악보 삭제
        sheetMapper.deleteSheet(sheetId);
    }

    @Override
    public int countSheets() {
        return sheetMapper.countSheets();
    }
}
