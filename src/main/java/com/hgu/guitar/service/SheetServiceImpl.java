package com.hgu.guitar.service;

import com.hgu.guitar.dao.SheetMapper;
import com.hgu.guitar.vo.SheetVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SheetServiceImpl implements SheetService {

    @Resource
    private SheetMapper sheetMapper;

    // ======================
    // 전체 목록
    // ======================
    @Override
    public List<SheetVO> getAllSheets() {
        return sheetMapper.getAllSheets();
    }

    // ======================
    // 단건 조회
    // ======================
    @Override
    public SheetVO getSheetById(Integer sheetId) {
        return sheetMapper.getSheetById(sheetId);
    }

    // ======================
    // 등록
    // ======================
    @Override
    public void insertSheet(SheetVO sheet) {
        // 👉 sheet.codeId 하나만 저장
        sheetMapper.insertSheet(sheet);
    }

    // ======================
    // 수정
    // ======================
    @Override
    public void updateSheet(SheetVO sheet) {
        sheetMapper.updateSheet(sheet);
    }

    // ======================
    // 삭제
    // ======================
    @Override
    public void deleteSheet(Integer sheetId) {
        sheetMapper.deleteSheet(sheetId);
    }
}
