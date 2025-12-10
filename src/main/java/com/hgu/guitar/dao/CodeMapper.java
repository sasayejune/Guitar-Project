package com.hgu.guitar.dao;

import com.hgu.guitar.vo.CodeVO;
import java.util.List;

public interface CodeMapper {

    // 전체 코드 목록
    List<CodeVO> getAllCodes();

    // 코드 하나 조회
    CodeVO getCodeById(Integer codeId);

    // 코드 등록
    void insertCode(CodeVO code);

    // 코드 수정
    void updateCode(CodeVO code);

    // 코드 삭제
    void deleteCode(Integer codeId);
}
