package com.shop.service;

import com.shop.mapper.ProductStorageMapper;
import com.shop.common.service.BaseService;
import com.shop.entity.ProductStorage;
import org.springframework.stereotype.Service;

@Service
public class ProductStorageService extends BaseService<ProductStorageMapper,ProductStorage> {

    public void updateStorage(String productId,Integer count){
        mapper.decrease(productId, count);
    }
}
