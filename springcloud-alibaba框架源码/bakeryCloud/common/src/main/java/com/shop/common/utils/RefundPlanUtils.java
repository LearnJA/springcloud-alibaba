package com.shop.common.utils;

import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.*;

/**
 * 制定还款计划的工具类
 *
 * @author jiangzihan
 * @version $$Id: com.xinge.demo.common.util, v 0.1 2017/9/13 16:47 jiangzihan Exp $$
 **/
public class RefundPlanUtils {

    private static Logger logger = LoggerFactory.getLogger(RefundPlanUtils.class);

    /**
     * @param staTime         还款计划生成时间
     * @param totalAmount     总金额 单位：分
     * @param repayTotalTimes 总期数
     * @param refundDay       每月还款日
     * @return 返回结果中 金额单位为分
     */
    public static String createRefundPlan(Long staTime, Long totalAmount, Integer repayTotalTimes, Integer refundDay) {
        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
        List<RepaymentPlanDetail> repaymentPlanDetails = generateRepaymentPlanList(staTime, totalAmount, repayTotalTimes, refundDay);
        map.put("repaymentPlan", repaymentPlanDetails);
        String json = gson.toJson(map);
        logger.info(json);
        return json;
    }

    /**
     * @param staTime         还款计划生成时间
     * @param totalAmount     总金额 单位：元
     * @param repayTotalTimes 总期数
     * @param refundDay       每月还款日
     * @return 返回结果中，金额单位为元
     */
    public static String createRefundPlan(Long staTime, Double totalAmount, Integer repayTotalTimes, Integer refundDay) {
        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
//        Long amountLong = (long)(totalAmount * 10 * 10);//输入单位转换为分，精确到小数点后两位
        Long amountLong = BigDecimal.valueOf(totalAmount).multiply(BigDecimal.valueOf(100)).longValue();
        List<RepaymentPlanDetail> repaymentPlanDetails = generateRepaymentPlanList(staTime, amountLong, repayTotalTimes, refundDay);
        for (RepaymentPlanDetail repaymentPlanDetail : repaymentPlanDetails) {
            Double amountDouble = Long.valueOf(repaymentPlanDetail.getAmount()) / 100.0;
            //格式化，精确到小数点后两位，且会进行四舍五入
            repaymentPlanDetail.setAmount(String.format("%.2f", amountDouble));//输出单位转换为元
        }
        map.put("repaymentPlan", repaymentPlanDetails);
        String json = gson.toJson(map);
        logger.info(json);
        return json;
    }

    /**
     * @param staTime         还款计划生成时间
     * @param totalAmount     总金额 单位：分
     * @param repayTotalTimes 总期数
     * @param refundDay       每月还款日
     * @return 返回结果中 金额单位为分
     */
    public static List<RepaymentPlanDetail> generateRepaymentPlanList(Long staTime, Long totalAmount, Integer repayTotalTimes, Integer refundDay) {
        List<RepaymentPlanDetail> resultList = new ArrayList<>();
        //求出余数
        Long rest = totalAmount % (100 * repayTotalTimes);
        Long amount = (totalAmount - rest) / repayTotalTimes;
        for (int a = 1; a <= repayTotalTimes; a++) {
            Calendar c = Calendar.getInstance();
            c.setTimeInMillis(staTime);
            c.add(Calendar.MONTH, a);
            //还款日
            c.set(Calendar.DAY_OF_MONTH, refundDay);
            String date = DateUtil.format(c.getTime(), DateUtil.DATE_FORMAT);
            if (a == repayTotalTimes) {
                //如果除不尽，将余数加在最后一期
                amount += rest;
            }
            RepaymentPlanDetail detail = new RepaymentPlanDetail();
            detail.setDate(date);
            detail.setAmount(String.valueOf((amount)));
            resultList.add(detail);
        }
        return resultList;
    }

    public static void main(String[] args) {
        String plan = RefundPlanUtils.createRefundPlan(System.currentTimeMillis(), 5000D, 12, 15);
        System.out.println(plan);
        String plan1 = RefundPlanUtils.createRefundPlan(System.currentTimeMillis(), 501234L, 12, 15);
        System.out.println(plan1);
        //精度丢失问题
        double b = 0.29 * 100;
        double c = 0.29 * 10 * 10;
        System.out.println("b:" + b);
        //格式化，显示9位有效数字，且会进行四舍五入
        System.out.println(String.format("%f", b));
        //格式化，精确到小数点后两位，且会进行四舍五入
        System.out.println(String.format("%.2f", 28.999));
        System.out.println("c:" + c);


    }

    public static class RepaymentPlanDetail {
        /**
         * 格式 yyyy-MM-dd
         */
        private String date;
        private String amount;

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public String getAmount() {
            return amount;
        }

        public void setAmount(String amount) {
            this.amount = amount;
        }
    }

}
