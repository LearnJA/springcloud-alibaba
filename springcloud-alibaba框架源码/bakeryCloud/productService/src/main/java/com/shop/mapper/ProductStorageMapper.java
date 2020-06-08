package com.shop.mapper;

import com.shop.common.mapper.MyMapper;
import com.shop.entity.ProductStorage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductStorageMapper extends MyMapper<ProductStorage> {

    /**
     * 扣除库存
     * @param productId
     * @param count
     */
    void decrease(@Param("productId") String productId,@Param("count") Integer count);
}
