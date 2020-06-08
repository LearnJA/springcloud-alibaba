package com.shop.common.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Component
@PropertySource("classpath:constantConfig.properties")
public class QRCodeGenerator {

    private static ImageServiceUtil imageServiceUtil;

    /**
     * 用户邀请二维码图片保存路径
     */
    private static String QR_CODE_IMG_FILE_PATH;

    /**
     * 邀请码访问路径
     */
    private static String QR_CODE_VISIT_PATH;

    private static String generateQRCodeImage(String text, int width, int height) throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
        BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ImageIO.write(image, "png", out);
        byte[] b = out.toByteArray();
        return imageServiceUtil.upload(QR_CODE_IMG_FILE_PATH, b, null);
    }

    public static String generateCodeImg(String url, String userId) {
        String text = url + QR_CODE_VISIT_PATH + userId;
        //调用生成方法
        try {
            return generateQRCodeImage(text, 200, 200);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Autowired
    public void setImageServiceUtil(ImageServiceUtil imageServiceUtil) {
        this.imageServiceUtil = imageServiceUtil;
    }

    public String getQR_CODE_IMG_FILE_PATH() {
        return QR_CODE_IMG_FILE_PATH;
    }

    @Value("${QR-code-img-file-path}")
    public void setQR_CODE_IMG_FILE_PATH(String QR_CODE_IMG_FILE_PATH) {
        this.QR_CODE_IMG_FILE_PATH = QR_CODE_IMG_FILE_PATH;
    }

    public String getQR_CODE_VISIT_PATH() {
        return QR_CODE_VISIT_PATH;
    }

    @Value("${QR-code-visit-path}")
    public void setQR_CODE_VISIT_PATH(String QR_CODE_VISIT_PATH) {
        this.QR_CODE_VISIT_PATH = QR_CODE_VISIT_PATH;
    }
}