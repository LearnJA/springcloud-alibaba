package com.shop.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Service
@FeignClient(value = "orderService")
public interface OrderFeignClient {

    @GetMapping(value = "/order/queryOrder/{userId}")
    String queryUserOrder(@PathVariable("userId") String userId);

}
