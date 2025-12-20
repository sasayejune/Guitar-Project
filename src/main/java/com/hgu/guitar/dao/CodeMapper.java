package com.hgu.guitar.dao;

import com.hgu.guitar.vo.CodeVO;
import java.util.List;
import java.util.Map;

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

    // 검색 조건 반영한 전체 개수
    int countCodes(Map<String, Object> map);

    // 검색/정렬/페이징 목록

    List<CodeVO> getCodesPaged(Map<String, Object> map);

}
