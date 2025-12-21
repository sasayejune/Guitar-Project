package com.hgu.guitar.service;

import com.hgu.guitar.vo.CodeVO;
import java.util.List;

public interface CodeService {

    List<CodeVO> getAllCodes();

    CodeVO getCodeById(Integer codeId);

    void insertCode(CodeVO code);

    void updateCode(CodeVO code);

    void deleteCode(Integer codeId);

    int countCodes(String q);

    List<CodeVO> getCodes(String q, String sort, int size, int offset);
}
