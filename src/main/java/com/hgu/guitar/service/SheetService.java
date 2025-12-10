package com.hgu.guitar.service;

import com.hgu.guitar.vo.SheetVO;
import java.util.List;

public interface SheetService {

    List<SheetVO> getAllSheets();

    SheetVO getSheetById(Integer sheetId);

    void insertSheet(SheetVO sheet);

    void updateSheet(SheetVO sheet);

    void deleteSheet(Integer sheetId);
}
