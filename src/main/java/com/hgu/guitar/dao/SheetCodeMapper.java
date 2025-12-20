package com.hgu.guitar.dao;

import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface SheetCodeMapper {

    void insertSheetCode(@Param("sheetId") int sheetId,
                         @Param("codeId") int codeId);

    List<Integer> getCodeIdsBySheetId(int sheetId);

    void deleteBySheetId(int sheetId);
}