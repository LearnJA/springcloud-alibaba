package com.shop.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@FeignClient(value = "userService")
public interface UserServiceFeignClient {

    /**
     * 扣减账户
     * @param userId
     * @param money
     * @return
     */
    @RequestMapping(value = "/user/balance")
    String decreaseUserBalance(@RequestParam("userId") Long userId,@RequestParam("money") BigDecimal money);
}
