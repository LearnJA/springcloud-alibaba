package com.shop.common.utils;

import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.Java2DFrameConverter;

import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;

/**
 * 视频截图
 */
@Slf4j
public class FFmpegFrameGrabberUtils {

    /**
     * 视频截图
     *
     * @param videoPath 视频地址
     */
    public static byte[] splitVideo(String videoPath) {
        FFmpegFrameGrabber frameGrabber = null;
        try {
            frameGrabber = FFmpegFrameGrabber.createDefault(videoPath);
            frameGrabber.start();
            long frameTime = frameGrabber.getLengthInTime() / 1000000;
            int frameLength = frameGrabber.getLengthInFrames();
            List<Integer> list = random(frameTime, frameLength);
            for (int i = 0; i < frameLength; i++) {
                Frame frame = frameGrabber.grabImage();
                if (list.contains(i)) {
                    Java2DFrameConverter converter = new Java2DFrameConverter();
                    BufferedImage image = converter.getBufferedImage(frame);
                    return ImageUtil.imageToBytes(image, "png");
                }
            }
            log.info(String.format("视频总时长=%ss，总帧数=%s，抽取帧数=%s", frameTime, frameLength, list.size()));
        } catch (org.bytedeco.javacv.FrameGrabber.Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (frameGrabber != null) {
                try {
                    frameGrabber.stop();
                } catch (org.bytedeco.javacv.FrameGrabber.Exception e) {
                }
            }
        }
        return null;
    }

    private static List<Integer> random(long frameTime, int frameLength) {
        long count = 200;
        if (frameTime <= 100) {
            count = 10;
        } else if (frameTime <= 1800) {
            count = frameTime / 10;
        }
        List<Integer> list = new ArrayList<Integer>();
        if (frameLength < count) {
            for (int i = 0; i < frameLength; i++) {
                list.add(i);
            }
            return list;
        }

        long range = (frameLength - 5) / count;
        for (long i = range + 5; i < frameLength; i = i + range) {
            int rand = (int) ((i - range) + Math.random() * range);
            list.add(rand);
        }
        return Lists.newArrayList(list.get(0));
    }

}
