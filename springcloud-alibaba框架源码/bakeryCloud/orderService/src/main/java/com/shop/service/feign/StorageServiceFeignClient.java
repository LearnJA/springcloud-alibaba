package com.shop.service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(value = "productService")
public interface StorageServiceFeignClient {

    @GetMapping(value = "/storage/decrease")
    String decrease(@RequestParam("productId") Long productId,@RequestParam("count") Integer count);
}
