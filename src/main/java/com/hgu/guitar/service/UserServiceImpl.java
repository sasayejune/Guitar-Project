package com.hgu.guitar.service;

import com.hgu.guitar.dao.UserMapper;
import com.hgu.guitar.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserVO login(UserVO user) {
        return userMapper.login(user);
    }

    @Override
    public int signup(UserVO user) {

        // 1) 아이디 중복 체크
        int cnt = userMapper.countByUserid(user.getUserid());
        if (cnt > 0) {
            return 0; // 이미 존재하는 아이디 → 가입 실패
        }

        // 2) 중복 아니면 가입 진행
        return userMapper.signup(user);
    }
}