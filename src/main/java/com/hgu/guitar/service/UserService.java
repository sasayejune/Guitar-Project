package com.hgu.guitar.service;

import com.hgu.guitar.vo.UserVO;

public interface UserService {
    UserVO login(UserVO user);
    int signup(UserVO user);
}