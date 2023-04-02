package com.bjpowernode.secondshop.settings.service;

import com.bjpowernode.secondshop.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    /**
     * 查询用户信息（验证用户登录）
     *
     * @param user
     * @return
     */
    User queryUserByUserEmailAndUserPwd(User user);

    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    int addToUser(User user);

    /**
     * 根据用户id查询用户的详细的信息
     *
     * @param userId
     * @return
     */
    User queryUserByUserId(String userId);

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    int editUserByConditions(User user);

    /**
     * 查询所有的用户的详细的信息
     *
     * @return
     */
    List<User> queryAllUserForAdmin();

    /**
     * 删除用户
     *
     * @param userId
     * @return
     */
    int moveUserById(String userId);

    /**
     * 禁用用户
     *
     * @param map
     * @return
     */
    int modifyUserState(Map<String, Object> map);

}

