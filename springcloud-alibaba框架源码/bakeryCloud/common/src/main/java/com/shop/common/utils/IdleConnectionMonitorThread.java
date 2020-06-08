package com.shop.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.http.conn.HttpClientConnectionManager;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;

import java.util.concurrent.TimeUnit;


/**
 * 功能说明: httpclient连接回收器
 *
 * @author duanxq
 * @date 2018/01/23
 */
@Slf4j
public class IdleConnectionMonitorThread extends Thread {

    private final HttpClientConnectionManager connMgr;

    public IdleConnectionMonitorThread(PoolingHttpClientConnectionManager connMgr) {
        super();
        //设置为守护线程
        super.setDaemon(true);
        this.connMgr = connMgr;
    }

    @Override
    public void run() {
        try {
            while (true) {
                Thread.sleep(5000);
                // 关闭失效的连接
                connMgr.closeExpiredConnections();
                // 可选的, 关闭30秒内不活动的连接
                connMgr.closeIdleConnections(30, TimeUnit.SECONDS);
            }
        } catch (InterruptedException e) {
            log.error("", e);
            Thread.currentThread().interrupt();
        }
    }

}
