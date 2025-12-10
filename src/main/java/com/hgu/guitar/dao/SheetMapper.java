package com.hgu.guitar.dao;

import com.hgu.guitar.vo.SheetVO;
import java.util.List;

public interface SheetMapper {

    // 전체 악보 목록
    List<SheetVO> getAllSheets();

    // 악보 1개 조회
    SheetVO getSheetById(Integer sheetId);

    // 악보 등록
    void insertSheet(SheetVO sheet);

    // 악보 수정
    void updateSheet(SheetVO sheet);

    // 악보 삭제
    void deleteSheet(Integer sheetId);
}
