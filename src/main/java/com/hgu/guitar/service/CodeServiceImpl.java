package com.hgu.guitar.service;

import com.hgu.guitar.dao.CodeMapper;
import com.hgu.guitar.vo.CodeVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("codeService")
public class CodeServiceImpl implements CodeService {

    @Resource
    private CodeMapper codeMapper;

    @Override
    public List<CodeVO> getAllCodes() {
        return codeMapper.getAllCodes();
    }

    @Override
    public CodeVO getCodeById(Integer codeId) {
        return codeMapper.getCodeById(codeId);
    }

    @Override
    public void insertCode(CodeVO code) {
        codeMapper.insertCode(code);
    }

    @Override
    public void updateCode(CodeVO code) {
        codeMapper.updateCode(code);
    }

    @Override
    public void deleteCode(Integer codeId) {
        codeMapper.deleteCode(codeId);
    }

    @Override
    public int countCodes(String q) {
        Map<String, Object> map = new HashMap<>();
        map.put("q", q);
        return codeMapper.countCodes(map);
    }

    @Override
    public List<CodeVO> getCodes(String q, String sort, int size, int offset) {
        Map<String, Object> map = new HashMap<>();
        map.put("q", q);
        map.put("sort", sort);
        map.put("size", size);
        map.put("offset", offset);
        return codeMapper.getCodesPaged(map);
    }
}
