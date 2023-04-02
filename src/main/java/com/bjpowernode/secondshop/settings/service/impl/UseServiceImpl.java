package com.bjpowernode.secondshop.settings.service.impl;

import com.bjpowernode.secondshop.settings.domain.User;
import com.bjpowernode.secondshop.settings.mapper.UserMapper;
import com.bjpowernode.secondshop.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service  //处理与用户相关的业务
public class UseServiceImpl implements UserService {
    //注入mapper接口实现类
    @Autowired
    private UserMapper userMapper;


    @Override
    public User queryUserByUserEmailAndUserPwd(User user) {
        return userMapper.selectByUserEmailAndUserPwd(user);
    }

    @Override
    public int addToUser(User user) { //需要开启事务
        int i = userMapper.insertToUser(user);
        return i;
    }

    @Override
    public User queryUserByUserId(String userId) {
        User user = userMapper.selectUserByUserId(userId);
        return user;
    }

    @Override
    public int editUserByConditions(User user) {
        int i = userMapper.updateUserByConditions(user);
        return i;
    }

    @Override
    public List<User> queryAllUserForAdmin() {
        List<User> users = userMapper.selectAllUserForAdmin();
        return users;
    }

    @Override
    public int moveUserById(String userId) {
        int i = userMapper.deleteUserById(userId);
        return i;
    }

    @Override
    public int modifyUserState(Map<String, Object> map) {
        int i = userMapper.updateUserState(map);
        return i;
    }


}
