/*
 * 文 件 名 : DateJsonValueProcessor.java
 * 包： com.fsti.bst.json
 * 工程:portal
 * 创 建 人： zyb
 * 日   期： Dec 21, 2009
 * 修 改 人：
 * 日   期：
 * 描   述：
 * 版 本 号：
 * 福建邮科电信业务部厦门研发中心
 * http://www.fsti.com
 * CopyRright (c) 2009-xxxx:
 **********************************************************************/
package com.shop.common.utils;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <h3>概要:</h3> json日期格式转换器 <h3>履历:</h3>
 * <ol>
 * <li>2015-1-28[suxh] 新建</li>
 * </ol>
 *
 * @author suxh
 * @date 2015-1-28
 */
public class DateJsonValueProcessor implements JsonValueProcessor {

    public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
    private DateFormat dateFormat;

    /**
     * 构造方法.
     *
     * @param datePattern 日期格式
     */
    public DateJsonValueProcessor(String datePattern) {

        if (null == datePattern) {
            dateFormat = new SimpleDateFormat(DEFAULT_DATE_PATTERN);
        } else {
            dateFormat = new SimpleDateFormat(datePattern);
        }

    }

    @Override
    public Object processArrayValue(Object arg0, JsonConfig arg1) {
        return process(arg0);
    }

    @Override
    public Object processObjectValue(String arg0, Object arg1, JsonConfig arg2) {
        return process(arg1);
    }

    private Object process(Object value) {
        return dateFormat.format((Date) value);
    }

}
