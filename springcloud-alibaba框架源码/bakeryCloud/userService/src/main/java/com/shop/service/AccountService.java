package com.shop.service;

import com.shop.common.service.BaseService;
import com.shop.entity.Account;
import com.shop.mapper.AccountMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Slf4j
@Service
public class AccountService extends BaseService<AccountMapper, Account> {

    public void decreaseUserBalance(Long userId, BigDecimal money){
        log.info("账户余额扣减开始----》");
        mapper.decrease(userId,money);
        log.info("账户余额扣减结束----》");
    }
}
