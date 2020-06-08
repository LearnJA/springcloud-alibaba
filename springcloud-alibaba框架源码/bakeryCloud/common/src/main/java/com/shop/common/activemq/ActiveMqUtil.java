package com.shop.common.activemq;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.command.ActiveMQTextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.jms.*;

/**
 * activemq工具类
 */
@Component
public class ActiveMqUtil {

    private static Logger logger = LoggerFactory.getLogger(ActiveMqUtil.class);
    @Autowired
    private JmsMessagingTemplate jsmMessagingTemplate;
    @Autowired
    private static JmsMessagingTemplate jsmMessagingTemplate1;

    @PostConstruct//静态方法中应用实例bean，这个是java中在servlet实例化是创建
    public void init() {
        jsmMessagingTemplate1 = jsmMessagingTemplate;
    }

    /**
     * 发送消息
     * @param contents
     * @param destination
     * @param <T>
     * @return
     */
    public <T> boolean sendMessage(T contents,Destination destination){
        try {
            jsmMessagingTemplate1.convertAndSend(destination, contents);
            logger.info("发送成功");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }
}
