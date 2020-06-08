package com.shop.service;

import com.shop.common.service.BaseService;
import com.shop.entity.User;
import com.shop.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Slf4j
@Service
public class UserService extends BaseService<UserMapper, User> {

    public User queryUserByName(String userName){
       return mapper.queryUserByName(userName);
    }

    public User findUserById(String userId){
        return mapper.queryUser(userId);
    }

}
