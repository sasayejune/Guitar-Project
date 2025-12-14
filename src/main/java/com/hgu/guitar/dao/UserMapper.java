package com.hgu.guitar.dao;

import com.hgu.guitar.vo.UserVO;

public interface UserMapper {
    UserVO login(UserVO user);
    int signup(UserVO user);
    int countByUserid(String userid);
}