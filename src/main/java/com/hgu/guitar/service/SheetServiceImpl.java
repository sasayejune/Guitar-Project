package com.hgu.guitar.service;

import com.hgu.guitar.dao.SheetMapper;
import com.hgu.guitar.dao.SheetCodeMapper;
import com.hgu.guitar.vo.SheetVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
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

        // ⭐ N:M 코드 연결 조회
        List<Integer> codeIds =
                sheetCodeMapper.getCodeIdsBySheetId(sheetId);

        sheet.setCodeIds(codeIds);

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

        // 2. 코드 연결 저장
        if (sheet.getCodeIds() != null) {
            for (Integer codeId : sheet.getCodeIds()) {
                sheetCodeMapper.insertSheetCode(
                        sheet.getSheetId(),
                        codeId
                );
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
                sheetCodeMapper.insertSheetCode(
                        sheet.getSheetId(),
                        codeId
                );
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
}
