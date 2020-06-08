package com.shop.mapper;

import com.shop.common.mapper.MyMapper;
import com.shop.entity.Account;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

public interface AccountMapper extends MyMapper<Account> {

    void decrease(@Param("userId") Long userId, @Param("money")BigDecimal money);
}
