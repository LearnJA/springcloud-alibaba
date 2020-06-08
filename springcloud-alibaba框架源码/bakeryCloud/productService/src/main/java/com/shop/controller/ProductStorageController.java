package com.shop.controller;

import com.shop.common.entity.ResultEntity;
import com.shop.service.ProductStorageService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@Api(value = "订单",tags = "订单相关接口")
@RequestMapping(value = "/storage")
public class ProductStorageController {

    @Autowired
    private ProductStorageService productStorageService;

    @RequestMapping(value = "/decrease")
    public ResultEntity updateStorage(@RequestParam("productId") String productId,@RequestParam("count") Integer count){
        try {
            productStorageService.updateStorage(productId, count);
            return ResultEntity.ok("修改库存成功",ResultEntity.SUCCESS);
        }catch (Exception e){
            return ResultEntity.error("修改库存失败",ResultEntity.ERROR);
        }
    }
}
