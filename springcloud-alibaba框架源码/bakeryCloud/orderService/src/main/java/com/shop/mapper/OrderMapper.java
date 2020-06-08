package com.shop.mapper;

import com.shop.common.mapper.MyMapper;
import com.shop.entity.OrderInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderMapper extends MyMapper<OrderInfo> {
    //新建订单
    void create(OrderInfo orderInfo);
    //修改订单状态 从0改为1
    void updateOrderStatus(@Param("id") String id,@Param("status") Integer status);

}
