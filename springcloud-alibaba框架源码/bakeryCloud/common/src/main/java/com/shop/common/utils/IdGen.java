/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.shop.common.utils;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionIdGenerator;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.genid.GenId;

import java.io.Serializable;
import java.security.SecureRandom;
import java.util.Date;
import java.util.UUID;

/**
 * 封装各种生成唯一性ID算法的工具类.
 *
 * @author jeeplus
 * @version 2016-01-15
 */
@Service
@Lazy(false)
public class IdGen implements GenId<String>, SessionIdGenerator {

    private static final char[] BASE62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".toCharArray();

    private static SecureRandom random = new SecureRandom();

    /**
     * 封装JDK自带的UUID, 通过Random数字生成, 中间无-分割.
     */
    public static String uuid() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * 使用SecureRandom随机生成Long.
     */
    public static long randomLong() {
        return Math.abs(random.nextLong());
    }

    /**
     * 基于Base62编码的SecureRandom随机生成bytes.
     */
    public static String randomBase62(int length) {
        byte[] randomBytes = new byte[length];
        random.nextBytes(randomBytes);
        return Encodes.encodeBase62(randomBytes);
    }

    public static String getOrderNo() {
        // 防止订单号重复 start
        Long l = (Long) CacheUtils.get("demolition_order_on");
        Date date = new Date();
        if (l == null) {
            l = Long.valueOf(DateUtil.format(date, "yyyyMMddHHmmssSSS"));
        } else {
            long ll = Long.valueOf(DateUtil.format(date, "yyyyMMddHHmmssSSS"));
            l = (l < ll) ? (l = ll) : l + 1;
        }
        CacheUtils.put("demolition_order_on", l);
        return l + "";
    }

    public static void main(String[] args) {
        System.out.println(IdGen.uuid());
        System.out.println(IdGen.uuid().length());
        for (int i = 0; i < 1000; i++) {
            System.out.println(IdGen.randomLong() + "  " + IdGen.randomBase62(5));
        }
    }

    @Override
    public String genId(String table, String column) {
        return uuid();
    }

    @Override
    public Serializable generateId(Session session) {
        return IdGen.uuid();
    }

}
