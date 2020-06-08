package com.shop.mapper;

import com.shop.common.mapper.MyMapper;
import com.shop.entity.User;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper extends MyMapper<User> {

    /**
     * 根据用户信息查询用户
     * @param userName
     * @return
     */
    User queryUserByName(String userName);

    /**
     * 根据id查询用户信息
     * @param userId
     * @return
     */
    User queryUser(String userId);
}
