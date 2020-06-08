package com.shop.controller;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.nacos.api.config.annotation.NacosValue;
import com.shop.common.activemq.ActivemqConfig;
import com.shop.common.annotation.JwtCheck;
import com.shop.common.entity.ResultEntity;
import com.google.common.collect.Maps;
import com.shop.common.jwt.JwtUtil;
import com.shop.common.redis.RedisClient;
import com.shop.dto.UserDTO;
import com.shop.entity.User;
import com.shop.service.AccountService;
import com.shop.service.UserService;
import com.shop.service.feign.OrderFeignClient;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.HashMap;

@Api(value = "用户",tags = "用户想关接口")
@Slf4j
@RefreshScope  //支持Nacos动态刷新功能
@RestController
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private AccountService accountService;

    @Resource
    private OrderFeignClient orderFeignClient;

    @Autowired
    private RedisClient redisClient;

    @Autowired
    private JmsTemplate jmsTemplate;

    @Autowired
    private ActivemqConfig activemqConfig;

    @Value("${mysql.info}")
    private String configInfo;

    @Value("${database.info}")
    private String userInfo;

    /*@Value("${order.info}")
    private String orderInfo;*/

    @RequestMapping(value = "/login")
    public ResultEntity login(UserDTO userDTO) {
        String loginName = userDTO.getUserName();
        String passWord = userDTO.getPassword();
        HashMap<String, Object> map = Maps.newHashMap();
        if(userDTO.getUserName() == null || userDTO.getPassword() == null){
            return ResultEntity.error("请将用户名或者密码填写完整");
        }
        User user = userService.queryUserByName(loginName);
        if(user != null){
            if(!user.getPassword().equals(passWord)){
                return ResultEntity.error("请输入正确密码",ResultEntity.ERROR);
            }
            //返回token
            String token = null;
            try {
                token = JwtUtil.createJWT(user.getUserName(),passWord,user.getId());
            } catch (Exception e) {
                e.printStackTrace();
                return ResultEntity.error("用户信息错误联系管理员",ResultEntity.ERROR);
            }
            if (token != null) {
                //将用户信息保存在redis中方便二次读取  可设置用户信息缓存有效时长
                //user.setToken(token);
                redisClient.set(user.getId(),new JSONObject().toJSONString(user));
                map.put("token",token);
                map.put("user",user);
                //将消息发送给订单模块用户登录了
                jmsTemplate.convertAndSend(activemqConfig.queue(),token);
                return ResultEntity.ok("登录成功",ResultEntity.SUCCESS,map);
            }
        }
        return ResultEntity.error("请输入正确的用户名和密码",ResultEntity.ERROR);
    }

    @GetMapping("/publicPage/{userId}")
    public ResultEntity publicPage(@PathVariable("userId") String userId){
        HashMap<String, Object> map = Maps.newHashMap();
        map.put(userId,userService.findUserById(userId));
        return ResultEntity.ok("用户查询成功！",ResultEntity.SUCCESS,map);
    }

    @GetMapping(value = "/userOrder/{userId}")
    public ResultEntity queryUserOrder(@PathVariable("userId") String userId){
        HashMap<String, Object> map = Maps.newHashMap();
        map.put(userId,orderFeignClient.queryUserOrder(userId));
        return ResultEntity.ok("用户查询成功！",ResultEntity.SUCCESS,map);
    }

    /**
     * jwt 检查注解测试 测试
     * @return
     */
    @GetMapping("/testJwtCheck")
    @JwtCheck
    public ResultEntity testJwtCheck(@RequestHeader("Token")String token, @RequestParam("name") String name) {
        return ResultEntity.ok("请求成功咯" + name, ResultEntity.SUCCESS);
    }

    /**
     * 测试配置中心生效
     * @return
     */
    @GetMapping(value = "/config/info")
    public String getConfigInfo() {
        return configInfo + "/***/" + userInfo + "/***/" /*+ orderInfo*/;
    }

    @RequestMapping(value = "/balance")
    public ResultEntity decreaseUserBalance(@RequestParam("userId") Long userId,@RequestParam("money") BigDecimal money){
        try {
            accountService.decreaseUserBalance(userId, money);
            return ResultEntity.ok("账户消减成功",ResultEntity.SUCCESS);
        }catch (Exception e){
            return ResultEntity.error("账户消减失败",ResultEntity.ERROR);
        }
    }
}
