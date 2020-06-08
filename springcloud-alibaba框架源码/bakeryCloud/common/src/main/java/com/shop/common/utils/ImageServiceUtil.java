package com.shop.common.utils;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
public class ImageServiceUtil {

    @Value("${image.service.path}")
    private String imageServicePath;

    /**
     * 图片上传到图片服务器
     *
     * @param pageName 包名
     * @param bytes    图片二进制
     * @param suffix   图片后缀
     * @return 图片请求地址
     */
    public String upload(String pageName, byte[] bytes, String suffix) {
        //实例化一个Jersey
        Client client = new Client();
        //保存图片服务器的请求路径
        String id = IdGen.uuid();
        String url = (imageServicePath.endsWith("/") ? imageServicePath : imageServicePath) + (pageName.endsWith("/") ? pageName : pageName + "/")
                + id + (StringUtils.isNotEmpty(suffix) ? (suffix.startsWith("\\.") ? suffix : "." + suffix) : ".png");
        //设置请求路径
        WebResource resource = client.resource(url);
        //发送post get put
        resource.put(String.class, bytes);
        return url;
    }

}
