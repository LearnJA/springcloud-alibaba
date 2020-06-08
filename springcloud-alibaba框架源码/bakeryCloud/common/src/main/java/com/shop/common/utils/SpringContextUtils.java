package com.shop.common.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

/**
 * Spring Context 工具类
 * 1.在使用此静态方法的类上加注解 @DependsOn("springContextUtils")
 * 2.确保在此之前 SpringContextUtils 类已加载
 */
@Component
@Lazy(false)
public class SpringContextUtils implements ApplicationContextAware, DisposableBean {

    private static ApplicationContext applicationContext;

    public static ApplicationContext getApplicationContext() {
        assertApplicationContext();
        return applicationContext;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringContextUtils.applicationContext = applicationContext;
    }

    public static Object getBean(String name) {
        assertApplicationContext();
        return applicationContext.getBean(name);
    }

    public static <T> T getBean(Class<T> requiredType) {
        assertApplicationContext();
        return applicationContext.getBean(requiredType);
    }

    public static <T> T getBean(String name, Class<T> requiredType) {
        assertApplicationContext();
        return applicationContext.getBean(name, requiredType);
    }

    public static boolean containsBean(String name) {
        assertApplicationContext();
        return applicationContext.containsBean(name);
    }

    public static boolean isSingleton(String name) {
        assertApplicationContext();
        return applicationContext.isSingleton(name);
    }

    public static Class<? extends Object> getType(String name) {
        assertApplicationContext();
        return applicationContext.getType(name);
    }

    private static void assertApplicationContext() {
        if (SpringContextUtils.applicationContext == null) {
            throw new RuntimeException("applicaitonContext属性为null,请检查是否注入了SpringContextUtils!");
        }
    }

    /**
     * 实现DisposableBean接口, 在Context关闭时清理静态变量.
     */
    @Override
    public void destroy() throws Exception {
        SpringContextUtils.applicationContext = null;
    }

}