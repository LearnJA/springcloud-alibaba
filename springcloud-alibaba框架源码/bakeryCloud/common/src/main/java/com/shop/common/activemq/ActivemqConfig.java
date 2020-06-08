package com.shop.common.activemq;

import org.apache.activemq.command.ActiveMQQueue;
import org.apache.activemq.command.ActiveMQTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.jms.Queue;
import javax.jms.Topic;

/**
 * 创建queue和topic对象，交由spring管理
 */
@Configuration
public class ActivemqConfig {

    /**
     * 点对点
     *
     * @return
     */
    @Bean
    public Queue queue(){
        return new ActiveMQQueue("jms-queue");//队列的名字
    }

    /**
     * 发布/订阅
     *
     * @return
     */
    @Bean
    public Topic topic(){
        return new ActiveMQTopic("jms-topic");
    }
}
