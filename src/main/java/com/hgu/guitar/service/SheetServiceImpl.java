package com.hgu.guitar.service;

import com.hgu.guitar.dao.SheetMapper;
import com.hgu.guitar.vo.SheetVO;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service("sheetService")
public class SheetServiceImpl implements SheetService {

    @Resource
    private SheetMapper sheetMapper;

    @Override
    public List<SheetVO> getAllSheets() {
        return sheetMapper.getAllSheets();
    }

    @Override
    public SheetVO getSheetById(Integer sheetId) {
        return sheetMapper.getSheetById(sheetId);
    }

    @Override
    public void insertSheet(SheetVO sheet) {
        sheetMapper.insertSheet(sheet);
    }

    @Override
    public void updateSheet(SheetVO sheet) {
        sheetMapper.updateSheet(sheet);
    }

    @Override
    public void deleteSheet(Integer sheetId) {
        sheetMapper.deleteSheet(sheetId);
    }
}
