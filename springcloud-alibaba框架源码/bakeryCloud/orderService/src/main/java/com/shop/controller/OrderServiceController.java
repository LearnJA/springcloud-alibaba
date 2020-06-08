package com.shop.controller;

import com.shop.common.activemq.ActivemqConfig;
import com.shop.common.entity.ResultEntity;
import com.google.common.collect.Maps;
import com.shop.entity.OrderInfo;
import com.shop.service.OrderService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@RestController
@Slf4j
@Api(value = "订单",tags = "订单相关接口")
@RequestMapping(value = "/order")
public class OrderServiceController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private JmsTemplate jmsTemplate;

    @Autowired
    private ActivemqConfig activemqConfig;

    @GetMapping(value = "/queryOrder/{userId}")
    public ResultEntity queryUserOrder(@PathVariable("userId") String userId){
        HashMap<String, Object> map = Maps.newHashMap();
        map.put(userId,orderService.queryUserOrder(userId));
        log.info(Thread.currentThread().getName() + "\t" + userId);
        return ResultEntity.ok("用户订单查询成功",ResultEntity.SUCCESS,map);
    }

    @GetMapping(value = "/userToken")
    public ResultEntity queryQueue(){
        try {
            String token = (String) jmsTemplate.receiveAndConvert(activemqConfig.queue());
            //String token = msg.getText();
            return ResultEntity.ok(token);
        }catch (Exception e){
            return ResultEntity.error(e.getMessage());
        }
    }

    @GetMapping(value = "/create")
    public ResultEntity createOrder(OrderInfo orderInfo){
        orderService.save(orderInfo);
        return ResultEntity.ok("订单创建成功");
    }
}
