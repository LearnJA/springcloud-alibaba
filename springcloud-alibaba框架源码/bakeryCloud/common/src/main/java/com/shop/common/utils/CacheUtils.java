package com.shop.common.utils;

import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.config.CacheConfiguration;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;

import java.net.URL;
import java.util.List;

@Slf4j
@PropertySource("classpath:constantConfig.properties")
public class CacheUtils {
    @Value("${cache_save_time}")
    private static Integer CACHE_TIME;

    public static Cache CACHE = null;

    static {
        URL url = CacheUtils.class.getResource("/ehcache.xml");
        CacheManager singletonmanager = CacheManager.create(url);
        CACHE = singletonmanager.getCache("users");
        CacheConfiguration cacheConfiguration = CACHE.getCacheConfiguration();
        //缓存存在时间
        long time = CACHE_TIME / 1000 / 1000;
        log.info("缓存存在时间" + time);
        cacheConfiguration.setTimeToIdleSeconds(time);
    }

    /**
     * 写入缓存
     *
     * @param key
     * @return
     */
    public static void put(String key, Object value) {
        Element element = new Element(key, value);
        CACHE.put(element);
    }

    /**
     * 从缓存中移除
     *
     * @param key
     * @return
     */
    public static void remove(String key) {
        CACHE.remove(key);
    }

    /**
     * 获取缓存
     *
     * @param key
     * @return
     */
    public static Object get(String key) {
        try {
            return CACHE.get(key).getObjectValue();
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return null;
    }

    /**
     * 获取所有缓存key
     *
     * @return
     */
    public static List getKeys() {
        List keys = CACHE.getKeys();
        return keys;
    }

    /**
     * 根据key模糊获取所有key
     *
     * @param key
     * @return
     */
    public static List<String> getKeys(String key) {
        List<String> list = Lists.newArrayList();
        if (StringUtils.isEmpty(key)) {
            return list;
        }
        for (Object o : getKeys()) {
            if (o.toString().indexOf(key) != -1) {
                list.add(o.toString());
            }
        }
        return list;
    }

}
