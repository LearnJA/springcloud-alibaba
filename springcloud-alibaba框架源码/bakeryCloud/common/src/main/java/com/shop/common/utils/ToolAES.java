package com.shop.common.utils;


import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.CharEncoding;
import org.apache.commons.lang3.StringUtils;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.Charset;


public class ToolAES {

    /**
     * AES java-javascript 只支持部填充摸索
     */
    public static final String format = "AES/CBC/NoPadding";
    /**
     * AES 加密key，必须为16位
     */
    public static final String key = "3c711ea814b04d9f";
    /**
     * AES 偏移量，必须为16位
     */
    public static final String iv = "814b04d9f57cc75e";

    /**
     * 使用AES加密
     *
     * @since 0.0.11
     */
    public static String encrypt(String data, String key) {
        return encrypt(data.getBytes(Charset.forName(CharEncoding.UTF_8)), key);
    }

    /**
     * 使用AES加密
     *
     * @since 0.0.11
     */
    public static String encrypt(byte[] dataBytes, String key) {
        if (dataBytes == null) {
            return null;
        }
        try {
            Cipher cipher = Cipher.getInstance(format);
            int blockSize = cipher.getBlockSize();

            int plaintextLength = dataBytes.length;
            if (plaintextLength % blockSize != 0) {
                plaintextLength = plaintextLength + (blockSize - (plaintextLength % blockSize));
            }

            byte[] plaintext = new byte[plaintextLength];
            System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

            SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
            IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

            cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
            byte[] encrypted = cipher.doFinal(plaintext);

            return Base64.encodeBase64String(encrypted);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 使用AES解密
     *
     * @since 0.0.11
     */
    public static String decrypt(String data, String key) {
        if (StringUtils.isEmpty(data)) {
            return null;
        }
        try {
            byte[] encrypted1 = Base64.decodeBase64(data);

            Cipher cipher = Cipher.getInstance(format);
            SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
            IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

            cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);

            byte[] original = cipher.doFinal(encrypted1);
            String originalString = new String(original, Charset.forName(CharEncoding.UTF_8));
            return StringUtils.trimToEmpty(originalString);
        } catch (Exception e) {
            System.out.println(String.format("数据解密异常[%s]", data));
            e.printStackTrace();
            return data;
        }
    }

    public static void main(String[] args) {
//    	String encrypt = ToolAES.encrypt("{\"code\":200,\"data\":{\"alarmJo\":{\"alarmType\":10,\"alarmColor\":\"green\"},\"attention\":false,\"bmdResultList\":[],\"checkResultList\":[{\"alarmData\":{\"$ref\":\"$.data.alarmJo\"},\"checkSource\":{\"checkType\":1,\"code\":\"qgrk\",\"errorMsg\":\"全国请求服务异常\",\"eval\":\"{\\\"qgrk\\\":[{\\\"idCard\\\":\\\"SFZH\\\"}]}\",\"fieldMapping\":\"[{\\\"field\\\":\\\"XM\\\",\\\"fieldname\\\":\\\"姓名\\\",\\\"shop\\\":1},{\\\"field\\\":\\\"XB\\\",\\\"fieldname\\\":\\\"性别\\\",\\\"shop\\\":2},{\\\"field\\\":\\\"CSRQ\\\",\\\"fieldname\\\":\\\"出生日期\\\",\\\"shop\\\":3},{\\\"field\\\":\\\"SFZH\\\",\\\"fieldname\\\":\\\"身份证号\\\",\\\"shop\\\":4},{\\\"field\\\":\\\"FWCS\\\",\\\"fieldname\\\":\\\"服务处所\\\",\\\"shop\\\":5},{\\\"field\\\":\\\"ZZXZ\\\",\\\"fieldname\\\":\\\"居住详址\\\",\\\"shop\\\":6}]\\n\",\"fieldMappingJson\":[{\"fieldname\":\"姓名\",\"field\":\"XM\",\"shop\":1},{\"fieldname\":\"性别\",\"field\":\"XB\",\"shop\":2},{\"fieldname\":\"出生日期\",\"field\":\"CSRQ\",\"shop\":3},{\"fieldname\":\"身份证号\",\"field\":\"SFZH\",\"shop\":4},{\"fieldname\":\"服务处所\",\"field\":\"FWCS\",\"shop\":5},{\"fieldname\":\"居住详址\",\"field\":\"ZZXZ\",\"shop\":6}],\"name\":\"常口(全国)\",\"orderNum\":1,\"prompt\":false,\"promptTemplateJson\":{},\"resultTranslate\":\"XB@XB,HYZK@HYZK,WHCD@WHCD,MZ@MZ,JGSSX@JG\",\"serverSourceType\":1},\"result\":[{\"FWCS\":\"\",\"CSDXZ\":\"\",\"HYZK\":\"20\",\"HKSZD\":\"511702\",\"SFZH\":\"513001198604040835\",\"ZZXZ\":\"四川省达州市通川区西外镇五里店村9组66号\",\"XB\":\"1\",\"MZ\":\"01\",\"BYQK\":\"1\",\"JGSSX\":\"511702\",\"CSRQ\":\"19860404\",\"XM\":\"王建康\",\"CSD\":\"511702\",\"CYM\":\"王必锦\",\"XP\":\"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\",\"WHCD\":\"60\"}],\"success\":true}],\"labelsJo\":[],\"paperno\":\"513001198604040835\",\"recordId\":\"47735e54-54e9-4581-82a0-74513c8ddf0b\",\"todayCheckNum\":0},\"msg\":\"成功\"}书基督教",ToolAES.key);
//    	System.out.println("1::"+encrypt);
        String decrypt = ToolAES.decrypt("lIzAhHhkI42afMEVXWUa5/8wDgecZAU3bLQFt01rSaY27S1t95X6MdDF+Ejpl0qPrG7F8tI2W6Y/8CSOdeG5ow==", ToolAES.key);
        System.out.println("2::" + decrypt);


        String str = "{\"data\": {" +
                "       \"ryId\": \"d6de29f64678415e84553efae60d89f1\"," +
                "       \"sqId\": \"6e190d7776634ae684996125bf2a30b3\"," +
                "       \"pageNo\": 1," +
                "       \"pageSize\": \"10\"" +
                "  }," +
                "  \"extend\": {" +
                "    \"userId\": \"d6de29f64678415e84553efae60d89f1\"," +
                "    \"deviceId\": \"131464\"," +
                "    \"requestor\": \"\"," +
                "    \"jd\": \"\"," +
                "    \"wd\": \"\"" +
                "  }" +
                "}";
        System.out.println(encrypt(str, key));
    }

}
