package com.shop.common.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * 验证码生成器
 *
 * @author wgyi
 * @version $Id: Valicode.java, v 0.1 2015年3月22日 上午10:50:06 wgyi Exp $
 */

public class Valicode {

    private String code;
    private BufferedImage codeImg;

    public Valicode() throws IOException {
        String vcode = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        codeImg = new BufferedImage(74, 30, BufferedImage.TYPE_3BYTE_BGR);
        Graphics2D g = codeImg.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g.setColor(Color.white);
        g.fillRect(0, 0, 74, 30);
        for (int i = 0; i < 100; i++) {
            int x = (int) Math.round(Math.random() * 74);
            int y = (int) Math.round((Math.random() * 30));
            Color color = new Color((float) (Math.random() * 0.7) + 0.3F, (float) (Math.random() * 0.7) + 0.3F,
                    (float) (Math.random() * 0.7) + 0.3F);
            g.setColor(color);
            g.drawRect(x, y, 1, 1);
        }
        code = "";
        for (int i = 0; i < 4; i++) {
            int fontsize = (int) Math.round(Math.random() * 3 + 20);
            Font font = new Font("", (int) Math.round(Math.random() * 3), fontsize);
            Color color = new Color((float) (Math.random() * 0.7), (float) (Math.random() * 0.7), (float) (Math.random() * 0.7));
            g.setColor(color);
            g.setFont(font);
            Character c = vcode.charAt(Math.round((float) Math.random() * 35));
            code += c;
            g.drawString(c + "", 18 * i + (int) (Math.random() * 10 - 5) + 2, 24 + (int) (Math.random() * 10 - 5));
        }
    }

    public String getCode() {
        return code;
    }

    public BufferedImage getCodeImg() {
        return codeImg;
    }

}