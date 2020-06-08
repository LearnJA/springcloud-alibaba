package com.shop.service;

import com.shop.common.service.BaseService;
import com.shop.entity.OrderInfo;
import com.shop.mapper.OrderMapper;
import com.shop.service.feign.StorageServiceFeignClient;
import com.shop.service.feign.UserServiceFeignClient;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.UUID;

@Slf4j
@Service
public class OrderService extends BaseService<OrderMapper,OrderInfo> {

    @Resource
    private StorageServiceFeignClient storageService;

    @Resource
    private UserServiceFeignClient userService;

    public String queryUserOrder(String userId){
        return "用户：" + userId + "的订单";
    }

    @GlobalTransactional(name = "create-order",rollbackFor = Exception.class)
    public void save(OrderInfo orderInfo){
        //创建订单
        log.info("----->开始新建订单");
        mapper.create(orderInfo);
        //远程调用库存扣减
        log.info("----->订单微服务开始调用库存,做扣减Count");
        storageService.decrease(orderInfo.getProductId(),orderInfo.getCount());
        log.info("----->订单微服务开始调用库存"+ orderInfo.getCount() +",做扣减End");
        //远程调用账户扣减
        log.info("----->订单微服务开始调用账户,做扣减Money");
        userService.decreaseUserBalance(orderInfo.getUserId(),orderInfo.getMoney());
        log.info("----->订单微服务开始调用账户"+ orderInfo.getMoney()+",做扣减End");
        //修改订单状态
        log.info("----->修改订单状态开始");
        mapper.updateOrderStatus(orderInfo.getId(),0);
        log.info("----->下订单结束了,O(∩_∩)O哈哈~");
    }

    @GlobalTransactional
    public void update(String id,Integer status){
        mapper.updateOrderStatus(id,status);

    }
}
