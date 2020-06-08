package com.shop.common.utils;


import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by duanxq on 2016/11/14.
 */
@Slf4j
public class MapUtil {

    private MapUtil() {

    }

    /**
     * 将javabean实体类转为map类型，然后返回一个map类型的值
     *
     * @param obj
     * @return
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> beanToMap(Object obj) {
        if (obj == null) {
            return null;
        }
        if (obj instanceof Map) {
            return (Map) obj;
        }
        Map params = new HashMap();
        try {
            params = BeanUtils.describe(obj);
            params.remove("class");
        } catch (Exception e) {
            log.error("", e);
        }
        return params;
    }

    /**
     * 将map转为javaBean
     *
     * @param map
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T mapToBean(Map<String, ?> map, Class<T> clazz) {
        T bean = null;
        try {
            //处理时间格式
            DateConverter dateConverter = new DateConverter();
            //设置日期格式
            dateConverter.setPatterns(DateUtil.DEFAULT_FORMATS);
            //注册格式
            ConvertUtils.register(dateConverter, Date.class);
            bean = clazz.newInstance();
            BeanUtils.populate(bean, map);
        } catch (Exception e) {
            log.error("", e);
        }
        return bean;
    }

}
