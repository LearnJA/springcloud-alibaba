package com.shop.common.utils;

import cn.hutool.http.HttpUtil;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.util.Map;
import java.util.Random;

/**
 * 验证码工具
 */
@Slf4j
public class SmsUtil {

    public static final String PREFIX = "PHONE_";

    public static String getCode() {
        int code = new Random().nextInt(899999);
        code += 100000;
        return code + "";
    }

    public static void send(String mobile, String content) {
        if (StringUtils.isEmpty(mobile)) {
            return;
        }
        if (StringUtils.isEmpty(content)) {
            return;
        }
        Map<String, Object> params = Maps.newHashMap();
        params.put("ac", "send");
        params.put("uid", "cky168178");
        params.put("pwd", "3d5d630c0a964c784bb8306ab70e55e5");
        params.put("mobile", mobile);
        params.put("content", content);
        String string = HttpUtil.get("http://api.sms.cn/sms/", params);
        log.info(string);
    }

    public static void sendVerificationCode(String mobile, String code) {
        String str = "【名画珍藏馆】尊敬的用户,您的验证码为:" + code + ",10分钟内有效,若非本人操作请忽略";
        send(mobile, str);
    }

    public static void sendTips(String mobile) {
        String str = "【保利德商城】尊敬的用戶,您已成功搶購,120分鐘內有效,若非本人操作請忽略";
        send(mobile, str);
    }

}
